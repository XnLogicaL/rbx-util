return function(object: Part)
	if object:IsA("Part") then
		return {
			Name = object.Name,
			CFrame = object.CFrame,
			Color = object.Color,
			BrickColor = object.BrickColor,
			Size = object.Size,
			Anchored = object.Anchored,
			Transparency = object.Transparency,
			Material = object.Material,
			CanCollide = object.CanCollide,
			CanTouch = object.CanTouch,
			CanQuery = object.CanQuery,
			Shape = object.Shape
		}
	elseif object:IsA("MeshPart") then
		return {
			Name = object.Name,
			CFrame = object.CFrame,
			Color = object.Color,
			BrickColor = object.BrickColor,
			Size = object.Size,
			Anchored = object.Anchored,
			Transparency = object.Transparency,
			Material = object.Material,
			CanCollide = object.CanCollide,
			CanTouch = object.CanTouch,
			CanQuery = object.CanQuery,
			MeshId = object.MeshId,
			RF = object.RenderFidelity
		}
	end
end
