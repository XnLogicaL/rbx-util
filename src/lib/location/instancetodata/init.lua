--[[

	Author: @XnLogicaL (@CE0_OfTrolling)
	This module and all of it's components are licensed under the MIT License.
	
	This module encodes parts into a saveable form, decoding included.
	Currently only works for parts.
	
	Planned features:
	- Model support
	- Mesh support

]]--
export type _type = "Mesh" | "Part"
export type EncodedPart = {
	_type: _type,
	_properties: {
		Name: string,
		CFrame: CFrame,
		Color: Color3,
		BrickColor: BrickColor,
		Size: Vector3,
		Anchored: boolean,
		Transparency: number,
		Material: Enum.Material,
		CanCollide: boolean,
		CanTouch: boolean,
		CanQuery: boolean,
		Shape: Enum.PartType
	},
	tags: {string},
	attributes: {[string]: any},
	parentName: string,
}
export type EncodedMeshPart = {
	_type: _type,
	_properties: {
		Name: string,
		CFrame: CFrame,
		Color: Color3,
		BrickColor: BrickColor,
		Size: Vector3,
		Anchored: boolean,
		Transparency: number,
		Material: Enum.Material,
		CanCollide: boolean,
		CanTouch: boolean,
		CanQuery: boolean,
		MeshId: number,
		RF: Enum.RenderFidelity,
	},
	tags: {string},
	attributes: {[string]: any},
	parentName: string,
}
export type EncodedInstance = EncodedMeshPart | EncodedPart

local loader = require(script.Parent.lib.Loader)
local saver = require(script.Parent.lib.Saver)
local attribute = require(script.Parent.lib.Attribute)

local module = {}
module.__index = {}

function module.Encode(Object: Instance): EncodedPart | EncodedMeshPart
	assert(Object:IsA("Part") and Object:IsA("MeshPart"), ("Class %s is not supported by InstanceToData"):format(Object.ClassName))
	
	if Object:IsA("Part") then
		local attributes = attribute.getAttributes(Object)
		local tags = Object:GetTags()
		local properties = saver(Object)
		local parentName = Object.Parent.Name
		
		return {
			_type = "Part",
			_properties = properties,
			tags = tags,
			attributes = attributes,
			parentName = parentName
		}
	elseif Object:IsA("MeshPart") then
		local attributes = attribute.getAttributes(Object)
		local tags = Object:GetTags()
		local properties = saver(Object)
		local parentName = Object.Parent.Name

		return {
			_type = "Mesh",
			_properties = properties,
			tags = tags,
			attributes = attributes,
			parentName = parentName
		}
	end
end

function module.Decode(EncodedInstance: EncodedInstance)
	local instance: Instance = loader(EncodedInstance)
	instance.Parent = game:FindFirstChild(EncodedInstance.parentName, true) or workspace
	
	attribute.applyAttributes(instance, EncodedInstance.attributes)
	for _, v in EncodedInstance.tags do
		instance:AddTag(v)
	end
	
	return instance
end

return module
