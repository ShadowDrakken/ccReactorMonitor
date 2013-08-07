function RedstoneOutput(state)
	if #attached["redwires"] > 0 then
		for x=1,#attached["redwires"],1 do
			redstone.setOutput(attached["redwires"][x], state)
		end
	end
end

function RedbundleOutput(color, state)
	if #attached["redbundles"] > 0 then
		for x=1,#attached["redbundles"],1 do
			local curState = redstone.getBundledOutput(attached["redbundles"][x])
			if state then
				curState = bit.bor(curState, color)
			else
				curState = bit.band(curState, bit.bnot(color))
			end
			redstone.setBundledOutput(attached["redbundles"][x], curState)
		end
	end
end