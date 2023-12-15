local module = {}

function module.applyAttributes(object: Instance, attributes: {[string]: any})
	for i, v in pairs(attributes) do
		object:SetAttribute(i, v)
	end
end

function module.getAttributes(object: Instance)
	local attributes = {}
	for i, v in pairs(object:GetAttributes()) do
		attributes[i] = v
	end
	return attributes
end

return module
