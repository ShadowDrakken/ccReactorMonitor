currentMenu = nil

MENU_MAIN = 1
MENU_CONFIG = 2

function clear()
	term.clear()
	term.setCursorPos(1,1)
end

function DoMenuMain()
	currentMenu = MENU_MAIN

	clear()

	term.setBackgroundColor(colors.yellow)	
	term.setTextColor(colors.black)	
	term.clearLine()

	print("[S]hutdown  [C]onfigure  [R]eboot")

	term.setBackgroundColor(colors.black)	
	term.setTextColor(colors.white)
	
	term.setCursorPos(1,3)

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
end

function DoMenuConfigure()
	currentMenu = MENU_CONFIG

	clear()

	term.setBackgroundColor(colors.yellow)	
	term.setTextColor(colors.black)	
	term.clearLine()

	print("[M]ain Menu")

	term.setTextColor(colors.white)	
	term.setBackgroundColor(colors.black)	

	term.setCursorPos(1,3)
end