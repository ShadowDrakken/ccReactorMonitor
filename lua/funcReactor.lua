HEAT_OK = 0
HEAT_FLAMABLE = 0.4
HEAT_EVAPORATE = 0.5
HEAT_RADIATION = 0.7
HEAT_LAVA = 0.85
HEAT_EXPLODE = 1

function GetBreederSlots()
	return nil
end

function GetFuelSlots()
	return nil
end

function GetFirstComponentSlot()
	local count = reactor.getInventorySize()
	local x = 0
	
	for x=1,count,1 do
	   item = reactor.getStackInSlot(x)
	   if item then
	   	break
	   end
	end
	
	if item then
	   return x
	else
	   return nil
	end
end

function GetFirstComponent()
	local count = reactor.getInventorySize()
	local item = nil

	for x=1,count,1 do
	   item = reactor.getStackInSlot(x)
	   if item then
	   	break
	   end
	end

	if item then
		return item
	else
	   return nil
	end
end