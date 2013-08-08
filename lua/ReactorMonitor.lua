dofile "funcDeviceEnumeration.lua"
dofile "funcDisplay.lua"
dofile "funcBattery.lua"
dofile "funcRedstone.lua"
dofile "funcReactor.lua"
dofile "funcMenus.lua"
dofile "funcEvent.lua"

booting = true
disconnected = true
terminate = false

term.clear()
BuildDeviceList()
ResetDisplays()

STATUS_OUTPUT = 1
STATUS_TEMP = 2
STATUS_EU = 4
STATUS_EUPERCENT = 5

local overheat = false

function main()
	ShowMenuMain()
	booting = false
	
	repeat
		if terminate then
			RedstoneOutput(false)
			RedbundleOutput(colors.black, false)
			ResetDisplays()

			DisplayInfo("-- Monitor Offline --",1)
			print()
			print("Shutting down reactor monitor.")

		   break
		end
		
	   if disconnected then
			ResetDisplays()
			
	   	MeterAdd("Heat", 1, 0xFF0000)
			IndicatorAdd("Status",1)
			MeterAdd("Charge", STATUS_EU, 0x008000)
			
			disconnected = false
		end

		if (#attached["reactors"] == 0) then
			disconnected = true

		   RedstoneOutput(false)
			RedbundleOutput(colors.black, false)
		   ResetDisplays()
			DisplayInfo("-- Reactor Offline --")
		else
		   reactor = peripheral.wrap(attached["reactors"][1])
			curOutput = reactor.getEUOutput()
			maxOutput = reactor.getMaxEUOutput()

			curHeat = reactor.getHeat()
			maxHeat = reactor.getMaxHeat()

			if curOutput > 0 then
				outText = curOutput .. "/" .. maxOutput .. " EU/t"
			else
				outText = "Inactive"
			end
			DisplayInfo("Output: " .. outText, STATUS_OUTPUT)
			DisplayInfo("Heat: " .. curHeat .. "/" .. maxHeat, STATUS_TEMP)

			local heatLevel = curHeat/maxHeat

			MeterUpdate("Heat",math.floor((curHeat/maxHeat)*100))

			if heatLevel >= HEAT_EXPLODE then
			   MeterColor("Heat",0x000000)
			elseif heatLevel >= HEAT_LAVA then
			   MeterColor("Heat",0xFF0000)
			elseif heatLevel >= HEAT_RADIATION then
			   MeterColor("Heat",0xF08000)
			elseif heatLevel >= HEAT_EVAPORATE then
			   MeterColor("Heat",0xF0F000)
			elseif heatLevel >= HEAT_FLAMABLE then
			   MeterColor("Heat",0x80F000)
			else
			   MeterColor("Heat",0x008000)
			end

			curEU = GetBatteryStatus()
			maxEU = GetBatteryMax()
			DisplayInfo("Charge: " .. curEU .. "/" .. maxEU, STATUS_EU)
			DisplayInfo("Fill: " .. math.floor((curEU/maxEU)*100) .. "%", STATUS_EUPERCENT)
			MeterUpdate("Charge", math.floor((curEU/maxEU)*100))

			if heatLevel >= HEAT_FLAMABLE then
			   overheat = true
			elseif heatLevel == 0 then
			   overheat = false
			end

			--Overheating preceeds all other statuses.
		   if overheat == true then
				IndicatorUpdate("Status",STATUS_WARNING)
				RedstoneOutput(false)
				RedbundleOutput(colors.black, false)
			else
				if curEU/maxEU >= 1 then
					IndicatorUpdate("Status",STATUS_OFF)
					RedstoneOutput(false)
					RedbundleOutput(colors.black, false)
			elseif curEU/maxEU <= 0.5 then
					IndicatorUpdate("Status",STATUS_OK)
					RedstoneOutput(true)
					RedbundleOutput(colors.black, true)
				end
			end
		end

		sleep(0.1)
	until 1==0
end

parallel.waitForAll(main, EventHandler)
