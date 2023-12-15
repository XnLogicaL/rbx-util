return function(encodedInstance)
	if encodedInstance._type == "Part" then
		local _properties = encodedInstance._properties
		local _instance = Instance.new("Part")
		_instance.Name = _properties.Name
		_instance.CFrame = _properties.CFrame
		_instance.Color = _properties.Color
		_instance.BrickColor = _properties.BrickColor
		_instance.Size = _properties.Size
		_instance.Anchored = _properties.Anchored
		_instance.Transparency = _properties.Transparency
		_instance.Material = _properties.Material
		_instance.CanCollide = _properties.CanCollide
		_instance.CanTouch = _properties.CanTouch
		_instance.CanQuery = _properties.CanQuery
		_instance.Shape = _properties.Shape
		
		return _instance
	elseif encodedInstance._type == "Mesh" then
		local _properties = encodedInstance._properties
		local _instance = Instance.new("Part")
		_instance.Name = _properties.Name
		_instance.CFrame = _properties.CFrame
		_instance.Color = _properties.Color
		_instance.BrickColor = _properties.BrickColor
		_instance.Size = _properties.Size
		_instance.Anchored = _properties.Anchored
		_instance.Transparency = _properties.Transparency
		_instance.Material = _properties.Material
		_instance.CanCollide = _properties.CanCollide
		_instance.CanTouch = _properties.CanTouch
		_instance.CanQuery = _properties.CanQuery
		_instance.MeshId = _properties.MeshId
		_instance.RenderFidelity = _properties.RF

		return _instance
	end
end
