function ShowMenuMain()
	if not booting then
		term.clear()
	end
	
	if #attached["reactors"] == 0 then
		print("Reactor: [!] MISSING [!]")
	else
		local slot = GetFirstComponentSlot(attached["reactors"][1])
		if slot == nil then
		   print("Reactor: [!] EMPTY [!]")
		else
			print("Reactor: Ok")
		end
	end
	
	print("Storage: " .. #attached["storage"])
	print("Batteries: " .. #attached["batteries"])
	print("Monitors: " .. #attached["monitors"])
	print("Bridges: " .. #attached["bridges"])
	print("Control Wires: " .. #attached["redwires"])
	
	print()
	print("[S]hutdown  [C]onfigure  [R]eboot")
end