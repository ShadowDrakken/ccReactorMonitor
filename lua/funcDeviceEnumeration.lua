attached = {}
attached["bridges"] = {}
attached["monitors"] = {}
attached["batteries"] = {}
attached["redwires"] = {}
attached["redbundles"] = {}
attached["reactors"] = {}
attached["storage"] = {}

displayLine = 0

bridgeText = {}
meters = {}
indicators = {}

function ClearDeviceList()
	attached = {}
	attached["bridges"] = {}
	attached["monitors"] = {}
	attached["batteries"] = {}
	attached["redwires"] = {}
	attached["redbundles"] = {}
	attached["reactors"] = {}
	attached["storage"] = {}

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
	pType = peripheral.getType(name)
	local exists = false

	if pType == "monitor" then
		for x=1,#attached["monitors"],1 do
		   item = attached["monitors"][x]
		   if item == name then
				exists = true
				break
			end
		end
		
		if not exists then
			table.insert(attached["monitors"],name)
		end
	elseif pType == "glassesbridge" then
		for x=1,#attached["bridges"],1 do
		   item = attached["bridges"][x]
		   if item == name then
				exists = true
				break
			end
		end
		
		if not exists then
			table.insert(attached["bridges"],name)
		end
	elseif pType == "immibis_redlogic_wire_bundled" then
		for x=1,#attached["redbundles"],1 do
		   item = attached["redbundles"][x]
		   if item == name then
				exists = true
				break
			end
		end

		if not exists then
			table.insert(attached["redbundles"],name)
		end
	elseif pType == "immibis_redlogic_wire_insulated" or pType == "immibis_redlogic_wire_redalloy" then
		for x=1,#attached["redwires"],1 do
		   item = attached["redwires"][x]
		   if item == name then
				exists = true
				break
			end
		end

		if not exists then
			table.insert(attached["redwires"],name)
		end
	elseif pType == "batbox" or pType == "mfe" or pType == "mfsu" then
		for x=1,#attached["batteries"],1 do
		   item = attached["batteries"][x]
		   if item == name then
				exists = true
				break
			end
		end

		if not exists then
			table.insert(attached["batteries"],name)
		end
	elseif pType == "nuclear_reactor" then
		for x=1,#attached["reactors"],1 do
		   item = attached["reactors"][x]
		   if item == name then
				exists = true
				break
			end
		end

		if not exists then
			table.insert(attached["reactors"],name)
		end
	elseif pType == "me_interface" then
		for x=1,#attached["storage"],1 do
		   item = attached["storage"][x]
		   if item == name then
				exists = true
				break
			end
		end

		if not exists then
			table.insert(attached["storage"],name)
		end
	end
end

function RemoveDevice(name)
	for pType in pairs(attached) do
		for x=1,#attached[pType],1 do
		   item = attached[pType][x]
		   if item == name then
    			table.remove(attached[pType],x)
				break
			end
		end
	end
end