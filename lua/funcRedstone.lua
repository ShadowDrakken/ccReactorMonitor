function RedstoneOutput(state)
	if #redwires > 0 then
		for x=1,#redwires,1 do
			wire = redstone.setOutput(redwires[x], state)
		end
	end
end