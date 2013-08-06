function EventHandler()
	repeat
		local event, param = os.pullEvent()

		if event == "char" and param == "s" then
			terminate = true
		elseif event == "peripheral" then
			AddDevice(param)
		elseif event == "peripheral_detach" then
			RemoveDevice(param)
		end
	until terminate
end