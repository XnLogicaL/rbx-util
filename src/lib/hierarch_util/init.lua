-- @XnLogicaL 23/10/2023
local module = {}

function module.FindFirstDescendant(Parent: Instance, Name: string)
	for _, v in pairs(Parent:GetDescendants()) do
		if v.Name == Name then
			return v
		end
	end
	return nil
end

function module.WaitForDescendant(Parent: Instance, Name: string)
	while true do 
		local newDesc = Parent.DescendantAdded:Wait()
		if newDesc.Name == Name then
			return newDesc
		end
		task.wait()
	end
end

function module.WaitForChildWhichIsA(Parent: Instance, ClassName: string)
	while true do 
		local newChild = Parent.ChildAdded:Wait()
		if newChild.ClassName == ClassName then
			return newChild
		end
		task.wait()
	end
end

function module.FindFirstDescendantWhichIsA(Parent: Instance, ClassName: string)
	for _, v in pairs(Parent:GetDescendants()) do
		if v.ClassName == ClassName then
			return v
			
		end
	end
	return nil
end

function module.GetDescendantsWhichAreA(Parent: Instance, ClassName: string)
	local t = {}
	for _, v in pairs(Parent:GetDescendants()) do
		if v.ClassName == ClassName then
			table.insert(t, v)
		end
	end
	return t
end

function module.GetChildrenWhichAreA(Parent: Instance, ClassName: string)
	local t = {}
	for _, v in pairs(Parent:GetChildren()) do
		if v.ClassName == ClassName then
			table.insert(t, v)
		end
	end
	return t
end

function module.GetChildrenWithTag(Parent: Instance, Tag: string)
	local t = {}
	for _, v in pairs(Parent:GetChildren()) do
		if v:HasTag(Tag) then
			table.insert(t, v)
		end
	end
	return t
end

function module.GetDescendantsWithTag(Parent: Instance, Tag: string)
	local t = {}
	for _, v in pairs(Parent:GetDescendants()) do
		if v:HasTag(Tag) then
			table.insert(t, v)
		end
	end
	return t
end

return module
