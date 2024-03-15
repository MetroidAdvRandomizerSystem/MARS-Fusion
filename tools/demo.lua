console.clear()
memory.usememorydomain("System Bus")
CWD = io.popen("cd"):read()
MARS_DIR = CWD:gsub("tools$", "")

if string.match(CWD, "(MARS[-]Fusion[\\|/]tools)$") == nil then
    print([[
This script is expected to run inside of the MARS-Fusion/tools directory.
Demos will not be saved if the script is not loaded from the correct location.
    ]])
end

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


---Turns an table of u16le into table of u8
---@param u16le_table table
---@return table
function table:u16le_to_u8(u16le_table)
    local u8_table = {}
    for n=1,(#u16le_table) do
        u8_table[n*2], u8_table[(n*2) - 1] = u16le_table[n] >> 8, (u16le_table[n]) & 0xFF
    end
    return u8_table
end


---Loads relevant memory for saving to a demo
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


---Initializes the script
function Init()
    console.clear()
    InputQueue = {}
    FrameQueue = {}
    PrevInput = 0
    PrevFrames = 0
    SubGameMode = memory.read_u16_le(addr["SubGameMode"])
    DemoNumber = 0
    DemoFolderExists, _, _ = os.rename(MARS_DIR.."data\\demos", MARS_DIR.."data\\demos") -- Hack to check for existing directory
    AsmFolderExists, _, _  = os.rename(MARS_DIR.."src\\demos", MARS_DIR.."src\\demos") -- Hack to check for existing directory

    -- check for existing asm files, if found increment demo number and try again
    while DemoNumber < 0xC do
        -- break early if no demo folder
        if DemoFolderExists == nil then
            print("Could not find the demos data folder.")
            break
        elseif AsmFolderExists == nil then
            print("Could not find the demos asm folder.")
            break
        end


        local filename = io.open(string.format(MARS_DIR.."src\\demos\\demo-%X.s", DemoNumber), "r+")
        if type(filename) == "userdata" then  -- bizhawk calls files "userdata" for some reason
            DemoNumber = DemoNumber + 1
            ---@diagnostic disable-next-line: undefined-field
            filename:close()
        else
            print(string.format([[
Demo files will be saved at ...
* Inputs & Durations: %sdata\demos\
* ASM: %ssrc\demos\]], MARS_DIR,MARS_DIR)
            )
            break
        end
    end

end


---This this is used to ensure consistent RNG between recording and playback of demos
function ResetRNG()
    memory.write_u8(addr["RNG_8"], 0)
    memory.write_u16_le(addr["RNG_16"], 0)
end


function OnExit(DemoFinished)
    gui.clearGraphics()
    if not DemoFinished then
        print("This recording was not saved.")
        return

    -- If demo data storage has been expanded/repointed this can be modified
    elseif DemoNumber == 0xD then
        print("The maximum number of recordings has been reached. This recording was not saved.")
        return

        -- Demo or Asm folder was not found
    elseif DemoFolderExists == nil or AsmFolderExists == nil then
        return
    end

    local demoasmfile      = assert(io.open(string.format(MARS_DIR.."src\\demos\\demo-%X.s", DemoNumber), "wb"))
    local demoinputfile    = assert(io.open(string.format(MARS_DIR.."data\\demos\\demo-%X-inputs.bin", DemoNumber), "wb"))
    local demodurationfile = assert(io.open(string.format(MARS_DIR.."data\\demos\\demo-%X-durations.bin", DemoNumber), "wb"))

    local DemoAsmStr = [[
.autoregion
.align 2
@Demo]]..DemoNumber..[[Inputs:
.incbin "data/demos/demo-]]..DemoNumber..[[-inputs.bin"
.endautoregion

.autoregion
.align 2
@Demo]]..DemoNumber..[[Durations:
.incbin "data/demos/demo-]]..DemoNumber..[[-durations.bin"
.endautoregion

.org DemoInputData + ]]..DemoNumber..[[ * 10h
.area 10h
    .dw  @Demo]]..DemoNumber..[[Inputs
    .dh  %04Xh
    .skip 2
    .dw  @Demo]]..DemoNumber..[[Durations
    .dh  %04Xh
    .skip 2
.endarea

.org DemoMemory + ]]..DemoNumber..[[ * 1Ch
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

    table.insert(InputQueue, PrevInput)
    table.insert(FrameQueue, PrevFrames)

    local demoinputs = table:u16le_to_u8(InputQueue)
    local demodurations = table:u16le_to_u8(FrameQueue)


    print("Writing Input file ...")
    demoinputfile:write(string.char(table.unpack(demoinputs)))
    demoinputfile:flush()
    demoinputfile:close()
    print("Done!")

    print("Writing Duration file ...")
    demodurationfile:write(string.char(table.unpack(demodurations)))
    demodurationfile:flush()
    demodurationfile:close()
    print("Done!")

    print("Writing asm file ...")
    demoasmfile:write(string.format(
        DemoAsmStr,
        #demoinputs, #demodurations,
        CurrArea, PrevDoor,
        SecurityLevel, MapDownloads,
        BeamUpgrades, ExplosiveUpgrades, SuitUpgrades,
        StoryFlags,
        MaxEnergy, CurrEnergy,
        MaxMissiles, CurrMissiles,
        MaxPowerBombs, CurrPowerBombs,
        SamusDirection, SamusXPos, SamusYPos
    ))
    demoasmfile:flush()
    demoasmfile:close()
    print("Done!")
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

if DemoFolderExists ~= nil and AsmFolderExists ~= nil then -- no errors
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
