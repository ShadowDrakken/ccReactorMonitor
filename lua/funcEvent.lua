function EventHandler()
	repeat
		local event, param = os.pullEvent()

		if event == "char" then
			HandleChar(param)
		elseif event == "peripheral" then
			AddDevice(param)
		elseif event == "peripheral_detach" then
			RemoveDevice(param)
		end
	until terminate
end

function HandleChar(param)
	if currentMenu == MENU_MAIN then
		if param == "s" then -- shutdown
			terminate = true
		elseif param == "c" then -- configure
			DoMenuConfigure()
		elseif param == "r" then -- reboot
		end
	elseif currentMenu == MENU_CONFIG then
		if param == "m" then -- return to main menu
			DoMenuMain()
		end
	end
end