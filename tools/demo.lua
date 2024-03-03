memory.usememorydomain("IWRAM")

local CurrArea = memory.read_u8(0x002C)
local PrevDoor = memory.read_u8(0x002E)
local SecurityLevel = memory.read_u8(0x131D)
local MapDownloads = memory.read_u8(0x131E)
local BeamUpgrades = memory.read_u8(0x131A)
local ExplosiveUpgrades = memory.read_u8(0x131B)
local SuitUpgrades = memory.read_u8(0x131C)
local StoryFlags = memory.read_u16_le(0x06B8)
local MaxEnergy = memory.read_u16_le(0x1312)
local CurrEnergy = memory.read_u16_le(0x1310)
local MaxMissiles = memory.read_u16_le(0x1316)
local CurrMissiles = memory.read_u16_le(0x1314)
local MaxPowerBombs = memory.read_u8(0x1319)
local CurrPowerBombs = memory.read_u8(0x1318)
local SamusDirection = memory.read_u16_le(0x1256)
local SamusXPos = memory.read_u16_le(0x125A)
local SamusYPos = memory.read_u16_le(0x125C)

print(string.format(".org DemoMemory"))
print(string.format("\t.db\t%02Xh, %02Xh", CurrArea, PrevDoor))
print(string.format("\t.db\t%02Xh, %02Xh", SecurityLevel, MapDownloads))
print(string.format("\t.db\t%02Xh, %02Xh, %02Xh", BeamUpgrades, ExplosiveUpgrades, SuitUpgrades))
print("\t.skip 1")
print(string.format("\t.dh\t%04Xh", StoryFlags))
print(string.format("\t.dh\t%d, %d", MaxEnergy, CurrEnergy))
print(string.format("\t.dh\t%d, %d", MaxMissiles, CurrMissiles))
print(string.format("\t.db\t%d, %d", MaxPowerBombs, CurrPowerBombs))
print(string.format("\t.dh\t%04Xh, %04Xh, %04Xh", SamusDirection, SamusXPos, SamusYPos))

memory.usememorydomain("System Bus")

local inputQueue = {}
local frameQueue = {}
local prevInput = 0
local prevFrames = 0
local subGameMode = memory.read_u16_le(0x03000BE0)

event.onexit(function ()
	if #inputQueue > 254 then
		return
	end
	local inputStr = ".org DemoInputs\n\t.dh\t"
	local frameStr = ".org DemoFrames\n\t.dh\t"
	table.insert(inputQueue, prevInput)
	table.insert(frameQueue, prevFrames)
	for i = 1, #inputQueue - 1 do
		inputStr = inputStr .. string.format("%04Xh, ", inputQueue[i])
		frameStr = frameStr .. string.format("%d, ", frameQueue[i])
	end
	inputStr = inputStr .. string.format("%04Xh", inputQueue[#inputQueue])
	frameStr = frameStr .. string.format("%d", frameQueue[#frameQueue])
	print(inputStr)
	print(#inputQueue)
	print(frameStr)
	print(#frameQueue)
	print(".org DemoInputData")
	print(string.format("\t.dw\tDemoInputs\n\t.dh\t%d\n\t.skip 2", #inputQueue * 2))
	print(string.format("\t.dw\tDemoFrames\n\t.dh\t%d\n\t.skip 2", #frameQueue * 2))
end)

while #inputQueue < 254 do
	emu.frameadvance()
	if subGameMode == 2 then
		local currInput = memory.read_u16_le(0x030011E8)
		if currInput ~= prevInput then
			if prevFrames == 0 then
				prevFrames = 1
			end
			table.insert(inputQueue, prevInput)
			table.insert(frameQueue, prevFrames)
			prevInput = currInput
			prevFrames = 1
		else
			prevFrames = prevFrames + 1
		end
	end
	subGameMode = memory.read_u16_le(0x03000BE0)
end

print("Demo uses too many inputs. Exiting")
