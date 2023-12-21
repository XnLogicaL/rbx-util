-- Trashes all elements in the provided table
return function(tbl)
	for _, v in tbl do
		if typeof(v) == "thread" then
			task.cancel(v)
		elseif typeof(v) == "RBXScriptConnection" then
			v:Disconnect()
		elseif typeof(v) == "Instance" then
			v:Destroy()
		end
	end
	table.clear(tbl)
end
