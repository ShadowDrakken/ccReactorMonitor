function GetBatteryStatus()
	local curBattery = 0

	if #batteries > 0 then
		for x=1,#batteries,1 do
			battery = peripheral.wrap(batteries[x])
			if battery then
				curBattery = curBattery + battery.getEUStored()
			end
		end
	end

	return curBattery
end

function GetBatteryMax()
	local maxBattery = 0

	if #batteries > 0 then
		for x=1,#batteries,1 do
			battery = peripheral.wrap(batteries[x])
			if battery then
				maxBattery = maxBattery + battery.getEUCapacity()
			end
		end
	end

	return maxBattery
end