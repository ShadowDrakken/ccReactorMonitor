function GetBatteryStatus()
	local curBattery = 0

	if #attached["batteries"] > 0 then
		for x=1,#attached["batteries"],1 do
			battery = peripheral.wrap(attached["batteries"][x])
			if battery then
				curBattery = curBattery + battery.getEUStored()
			end
		end
	end

	return curBattery
end

function GetBatteryMax()
	local maxBattery = 0

	if #attached["batteries"] > 0 then
		for x=1,#attached["batteries"],1 do
			battery = peripheral.wrap(attached["batteries"][x])
			if battery then
				maxBattery = maxBattery + battery.getEUCapacity()
			end
		end
	end

	return maxBattery
end