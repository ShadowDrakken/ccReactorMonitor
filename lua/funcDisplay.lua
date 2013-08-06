STATUS_IDLE = -1
STATUS_OFF = 0
STATUS_OK = 1
STATUS_ALERT = 2
STATUS_WARNING = 3
STATUS_CRITICAL = 4

function ResetDisplays()
	if #monitors > 0 then
		for x=1,#monitors,1 do
			monitor = peripheral.wrap(monitors[x])
			if monitor then
				monitor.clear()
			end
		end
	end

	if #bridges > 0 then
		for x=1,#bridges,1 do
			bridge = peripheral.wrap(bridges[x])
			if bridge then
				bridge.clear()
			end
		end
	end

	displayLine = 0
	bridgeText = {}
	meters = {}
	indicators = {}
end

function DisplayInfo(text, line)
	if line == nil then
		displayLine = displayLine + 1
	end

	line = line or displayLine

	if #monitors > 0 then
		for x=1,#monitors,1 do
			monitor = peripheral.wrap(monitors[x])
			if monitor then
				monitor.setCursorPos(1,line)
				monitor.clearLine()
				monitor.write(text)
			end
		end
	end

	if #bridges > 0 then
		for x=1,#bridges,1 do
			bridge = peripheral.wrap(bridges[x])

			if bridge then
				if bridgeText[x] == nil then
				    bridgeText[x] = {}
				end

				if bridgeText[x][line] == nil then
					bridgeText[x][line] = bridge.addText(10,line*5,text,0xFFFFFF)
					bridgeText[x][line].setScale(0.5)
				else
				  bridgeText[x][line].setText(text)
				end
			end
		end
	end

	if (#monitors==0 and #bridges==0) or booting then
		print(text)
 	end
end

function DisplaySkipLine()
	displayLine = displayLine + 1
	print()
end

function MeterAdd(name, line, color)
	if #bridges > 0 then
		meters[name] = {}
		for x=1,#bridges,1 do
			bridge = peripheral.wrap(bridges[x])
			if bridge then
			   meters[name][x] = {}
				meters[name][x]["back"] = bridge.addBox(6,(5*line)-1,2,10,color,0.75)
				meters[name][x]["fore"] = bridge.addBox(6,(5*line)-1,2,10,0xFFFFFF,0.75)
			end
		end
	end
end

function MeterUpdate(name, percent)
	if #bridges > 0 then
		for x=1,#bridges,1 do
			if meters[name][x] then
				meters[name][x]["fore"].setHeight(10-(percent/10))
				meters[name][x]["back"].setHeight(10 - meters[name][x]["fore"].getHeight())
				meters[name][x]["back"].setY(meters[name][x]["fore"].getHeight() + meters[name][x]["fore"].getY())
			end
		end
	end
end

function MeterColor(name, color)
	if #bridges > 0 then
		for x=1,#bridges,1 do
			if meters[name][x] then
				meters[name][x]["back"].setColor(color)
			end
		end
	end
end

function MeterRemove(name)
	if not meters[name] == nil then
		meters[name] = nil
	end
end

function IndicatorAdd(name, line)
	if #bridges > 0 then
		indicators[name] = {}
		for x=1,#bridges,1 do
			bridge = peripheral.wrap(bridges[x])
			if bridge then
				indicators[name][x] = bridge.addBox(1,(5*line),3,3,0xFFFFFF,0.75)
			end
		end
	end
end

function IndicatorUpdate(name, state)
	if #bridges > 0 then
		for x=1,#bridges,1 do
			if indicators[name][x] then
				if state == STATUS_IDLE then
					indicators[name][x].setColor(0x0080FF)
			   elseif state == STATUS_OK then
					indicators[name][x].setColor(0x008000)
				elseif state == STATUS_ALERT then
					indicators[name][x].setColor(0xFFFF00)
				elseif state == STATUS_WARNING then
					indicators[name][x].setColor(0xFF8000)
				elseif state == STATUS_CRITICAL then
					indicators[name][x].setColor(0xFF0000)
				else
					indicators[name][x].setColor(0xFFFFFF)
				end
			end
		end
	end
end
