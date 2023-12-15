-- Enum

-- This module is a basic module which allows for adding custom enums.
-- Also provides some metatable proxying to prevent undetected errors.

-- Originally written by TheGamer101
-- Modified by EtiTheSpirit 18406183 to make custom enum objects behave identicaly to Roblox enum items.

-- To register custom enums, add ModuleScripts as children to this script. The ModuleScript should return a table of enum items where the enum name is the index and the value is a number (an example is included)
-- When requiring this module, you are expected to override the existing enum value: local Enum = require(this script). This will look for custom enums first and then will look at roblox enums.

local RobloxEnum = Enum

local CustomEnums = {}
for idx, obj in ipairs(script:GetChildren()) do
	if obj:IsA("ModuleScript") then
		CustomEnums[obj.Name] = require(obj)
	end
end

-- According to lua specs the actual *function* running __eq has to be the same. So that's why this static function was made.
local function CheckEnumEquality(a, b)
	return a.Path == b.Path
end

-- Set up the enum objects so that they have a "Name" and "Value" property. This makes custom enums function identically to Roblox enums.
local function SetupEnumObjects()
	for containerName, customEnumItemContainer in pairs(CustomEnums) do
		for name, value in pairs(customEnumItemContainer) do
			local newEnumObject = {Path = string.format("Enum.%s.%s", containerName, name)}
			local metaData = {
				__index = function (tbl, idx)
					if idx == "Name" then
						return name
					elseif idx == "Value" then
						return value
					elseif idx == "Path" then
						return rawget(tbl, idx)
					end
				end;
				
				__newindex = function ()
					error("can't set value")
				end;
				
				__tostring = function ()
					return newEnumObject.Path
				end;
				
				__eq = CheckEnumEquality
			}
			setmetatable(newEnumObject, metaData)
			CustomEnums[containerName][name] = newEnumObject
		end
	end
end

local EnumProxies = {}
function GetProxyForEnum(index)
	if not EnumProxies[index] then
		EnumProxies[index] = setmetatable({
				EnumName = index			
			},
			-- Metatable
			{
				__index = function(tbl, index)
					if CustomEnums[tbl.EnumName][index] == nil then
						error(string.format("EnumItem %s does not exist!", index))
					end
					return CustomEnums[tbl.EnumName][index]
				end,
			
				__newindex = function(tbl, index, value)
					error("You can not add EnumItems at run time!")
				end
			})
	end
	return EnumProxies[index]
end

local EnumsProxyTable = setmetatable({}, 
-- Metatable
{
	__index = function(tbl, index)
		if CustomEnums[index] ~= nil then
			return GetProxyForEnum(index)	
		else
			return RobloxEnum[index]
		end
	end,

	__newindex = function(tbl, index, value)
		error("You can not add Enums at run time!")
	end
})

SetupEnumObjects()
return EnumsProxyTable

