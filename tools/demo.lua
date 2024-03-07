console.clear()
memory.usememorydomain("System Bus")

local addr = {
    ["CurrArea"]          = 0x0300002C,
    ["PrevDoor"]          = 0x0300002E,
    ["SecurityLevel"]     = 0x0300131D,
    ["MapDownloads"]      = 0x0300131E,
    ["BeamUpgrades"]      = 0x0300131A,
    ["ExplosiveUpgrades"] = 0x0300131B,
    ["SuitUpgrades"]      = 0x0300131C,
    ["StoryFlags"]        = 0x030006B8,
    ["MaxEnergy"]         = 0x03001312,
    ["CurrEnergy"]        = 0x03001310,
    ["MaxMissiles"]       = 0x03001316,
    ["CurrMissiles"]      = 0x03001314,
    ["MaxPowerBombs"]     = 0x03001319,
    ["CurrPowerBombs"]    = 0x03001318,
    ["SamusDirection"]    = 0x03001256,
    ["SamusXPos"]         = 0x0300125A,
    ["SamusYPos"]         = 0x0300125C,
    ["GameMode"]          = 0x03000BDE,
    ["SubGameMode"]       = 0x03000BE0,
    ["CurrInput"]         = 0x030011E8,
    ["RNG_8"]             = 0x03000BE5,
    ["RNG_16"]            = 0x03000002,
}


local function LoadDemoMemory()
    CurrArea          = memory.read_u8(addr["CurrArea"])
    PrevDoor          = memory.read_u8(addr["PrevDoor"])
    SecurityLevel     = memory.read_u8(addr["SecurityLevel"])
    MapDownloads      = memory.read_u8(addr["MapDownloads"])
    BeamUpgrades      = memory.read_u8(addr["BeamUpgrades"])
    ExplosiveUpgrades = memory.read_u8(addr["ExplosiveUpgrades"])
    SuitUpgrades      = memory.read_u8(addr["SuitUpgrades"])
    StoryFlags        = memory.read_u16_le(addr["StoryFlags"])
    MaxEnergy         = memory.read_u16_le(addr["MaxEnergy"])
    CurrEnergy        = memory.read_u16_le(addr["CurrEnergy"])
    MaxMissiles       = memory.read_u16_le(addr["MaxMissiles"])
    CurrMissiles      = memory.read_u16_le(addr["CurrMissiles"])
    MaxPowerBombs     = memory.read_u8(addr["MaxPowerBombs"])
    CurrPowerBombs    = memory.read_u8(addr["CurrPowerBombs"])
    SamusDirection    = memory.read_u16_le(addr["SamusDirection"])
    SamusXPos         = memory.read_u16_le(addr["SamusXPos"])
    SamusYPos         = memory.read_u16_le(addr["SamusYPos"])
end


function Init()
    console.clear()
    InputQueue = {}
    FrameQueue = {}
    PrevInput = 0
    PrevFrames = 0
    SubGameMode = memory.read_u16_le(addr["SubGameMode"])
end


---This this is used to ensure consistent RNG between recording and playback of demos
function ResetRNG()
    memory.write_u8(addr["RNG_8"], 0)
    memory.write_u16_le(addr["RNG_16"], 0)
end


function OnExit(DemoFinished)
    gui.clearGraphics()
    if not DemoFinished then
        return
    end

    local DemoInputDataStr = [[
.org DemoInputData
    .dw	DemoInputs
    .dh	%d
    .skip 2
    .dw	DemoFrames
    .dh	%d
    .skip 2
]]

    local DemoMemoryStr = [[
.org DemoMemory
    .db	%02Xh, %02Xh
    .db	%02Xh, %02Xh
    .db	%02Xh, %02Xh, %02Xh
    .skip 1
    .dh	%04Xh
    .dh	%d, %d
    .dh	%d, %d
    .db	%d, %d
    .dh	%04Xh, %04Xh, %04Xh
]]

    print(
        string.format(
            DemoMemoryStr,
            CurrArea, PrevDoor,
            SecurityLevel, MapDownloads,
            BeamUpgrades, ExplosiveUpgrades, SuitUpgrades,
            StoryFlags,
            MaxEnergy, CurrEnergy,
            MaxMissiles, CurrMissiles,
            MaxPowerBombs, CurrPowerBombs,
            SamusDirection, SamusXPos, SamusYPos
        )
    )

    local inputStr = ".org DemoInputs\n\t.dh\t"
    local frameStr = ".org DemoFrames\n\t.dh\t"
    table.insert(InputQueue, PrevInput)
    table.insert(FrameQueue, PrevFrames)

    for i = 1, #InputQueue - 1 do
        inputStr = inputStr .. string.format("%04Xh, ", InputQueue[i])
        frameStr = frameStr .. string.format("%d, ", FrameQueue[i])
    end

    inputStr = inputStr .. string.format("%04Xh", InputQueue[#InputQueue])
    frameStr = frameStr .. string.format("%d", FrameQueue[#FrameQueue])
    print(inputStr.."\n")
    -- print(#InputQueue)
    print(frameStr.."\n")
    -- print(#FrameQueue)
    print(
        string.format(
            DemoInputDataStr,
            #InputQueue * 2,
            #FrameQueue * 2
        )
  )
end


-- Don't start Recording if game is already unpaused
::WaitForInitialPause::
GameMode = memory.read_u8(addr["GameMode"])
if GameMode ~= 3 then
    gui.pixelText(
        0, 70,
        "       Game must be paused before      \n"..
        "        a recording can start",
        "white",
        "red",
        "fceux"
    )
    emu.frameadvance()
    goto WaitForInitialPause
end
gui.clearGraphics()


while true do
    GameMode = memory.read_u8(addr["GameMode"])
    if GameMode ~= 1 then
        gui.pixelText(
            0, 70,
            "          Unpause the game to          \n"..
            "         begin recording a demo",
            "white",
            "red",
            "fceux"
        )
        emu.frameadvance()
    else
        break
    end
end
gui.clearGraphics()


Init()
LoadDemoMemory()
print("The Demo recording has started. Pause the game to stop the demo recording.")
gui.pixelText(
    168, 5,
    " Recording\nin progress",
    "white",
    "red"
)

--[[
    This behavior mimics transitioning from title screen to demo playback.
    Demo Playback resets RNG to 0 before playing each demo. Here we reset RNG
    to 0 so that if a new room loads, RNG should be consistent during playback
    of the new recording.
]]
while true do
    SubGameMode = memory.read_u16_le(addr["SubGameMode"])
    if SubGameMode ~= 1 then
        emu.frameadvance()
        ResetRNG()
    else
        break
    end
end

DemoFinished = false
while #InputQueue < 254 do
    local currInput
    emu.frameadvance()
    currInput = memory.read_u16_le(addr["CurrInput"])
    if SubGameMode == 2 then
        if currInput ~= PrevInput then
            if PrevFrames == 0 then
                PrevFrames = 1
            end
            table.insert(InputQueue, PrevInput)
            table.insert(FrameQueue, PrevFrames)
            PrevInput = currInput
            PrevFrames = 1
        else
            PrevFrames = PrevFrames + 1
        end
    end
    SubGameMode = memory.read_u16_le(addr["SubGameMode"])

    if currInput & 0x8 == 0x8 then -- Check for Start Button to end demo
        DemoFinished = true
        break
    end
end

if not DemoFinished then
    print("Demo uses too many inputs. This demo was not saved.")
    goto WaitForInitialPause
end

event.onexit(function () OnExit(DemoFinished) end)
