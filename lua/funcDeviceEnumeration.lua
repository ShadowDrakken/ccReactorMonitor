bridges = {}
bridgeText = {}
monitors = {}
batteries = {}
redwires = {}
redbundles = {}
reactor = nil
storage = nil

displayLine = 0

meters = {}
indicators = {}

function ClearDeviceList()
	bridges = {}
	monitors = {}
	batteries = {}
	redwires = {}
	redbundles = {}
	reactor = nil
	storage = nil

	displayLine = 0

	bridgeText = {}
	meters = {}
	indicators = {}

	booting = true
end

function BuildDeviceList()
	ClearDeviceList()
	print("Detecting devices...")
	print()

	devices = peripheral.getNames()
	for name,value in pairs(devices) do
		AddDevice(value)
	end
end

function AddDevice(name)
	type = peripheral.getType(name)
	local exists = false

	if type == "monitor" then
		for x=1,#monitors,1 do
		   item = monitors[x]
		   if item == name then
				exists = true
				break
			end
		end
		
		if not exists then
			monitors[#monitors + 1] = name
		end
	elseif type == "glassesbridge" then
		for x=1,#bridges,1 do
		   item = bridges[x]
		   if item == name then
				exists = true
				break
			end
		end
		
		if not exists then
			bridges[#bridges + 1] = name
		end
	elseif type == "immibis_redlogic_wire_bundled" then
		for x=1,#redbundles,1 do
		   item = redbundles[x]
		   if item == name then
				exists = true
				break
			end
		end

		if not exists then
			redbundles[#redbundles + 1] = name
		end
	elseif type == "immibis_redlogic_wire_insulated" or type == "immibis_redlogic_wire_redalloy" then
		for x=1,#redwires,1 do
		   item = redwires[x]
		   if item == name then
				exists = true
				break
			end
		end

		if not exists then
			redwires[#redwires + 1] = name
		end
	elseif type == "batbox" or type == "mfe" or type == "mfsu" then
		for x=1,#batteries,1 do
		   item = batteries[x]
		   if item == name then
				exists = true
				break
			end
		end

		if not exists then
			batteries[#batteries + 1] = name
		end
	elseif type == "nuclear_reactor" and reactor == nil then
		reactor = peripheral.wrap(name)
	elseif type == "me_interface" and storage == nil then
		storage = peripheral.wrap(name)
	end
end

function RemoveDevice(name)
	type = peripheral.getType(name)

	if type == "monitor" then
		for x=1,#monitors,1 do
		   item = monitors[x]
		   if item == name then
    			monitors.remove(x)
				break
			end
		end
		print("Monitors: "..monitors.maxn())
	elseif type == "glassesbridge" then
		for x=1,#bridges,1 do
		   item = bridges[x]
		   if item == name then
				bridges.remove(x)
				break
			end
		end
	elseif type == "immibis_redlogic_wire_bundled" then
		for x=1,#redbundles,1 do
		   item = redbundles[x]
		   if item == name then
				redbundles.remove(x)
				break
			end
		end
	elseif type == "immibis_redlogic_wire_insulated" or type == "immibis_redlogic_wire_redalloy" then
		for x=1,#redwires,1 do
		   item = redwires[x]
		   if item == name then
				redwires.remove(x)
				break
			end
		end
	elseif type == "batbox" or type == "mfe" or type == "mfsu" then
		for x=1,#batteries,1 do
		   item = batteries[x]
		   if item == name then
				batteries.remove(x)
				break
			end
		end
	elseif type == "nuclear_reactor" then
		reactor = nil
	elseif type == "me_interface" then
		storage = nil
	end
end