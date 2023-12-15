local LocationService = {}

local RunService = game:GetService("RunService")
local HttpService = game:GetService("HttpService")

local URL = "http://ip-api.com/json/"

local function assert<v>(value: v, callback: () -> ()): v?
	if not value then
		callback()
		return nil
	end
	return value
end

function LocationService.GetServerLocation(parameters: {("city" | "as" | "countryCode" | "country" | "isp" | "lat" | "lon" | "org" | "query" | "region" | "regionName" | "timezone" | "zip")?}): {[number]: string}
	assert(parameters, function()
		error("Location parameters cannot be nil.")
	end)
	
	if RunService:IsClient() then
		error("Cannot get location of server on client.")
	end
	
	local Info = { }
	local success, err
	
	repeat success, err = pcall(function()
		local GetRequest = HttpService:GetAsync(URL)
		local DecodedJSON = HttpService:JSONDecode(GetRequest)
			
		for index, value in ipairs(parameters) do
			Info[index] = DecodedJSON[value]
		end
	end)
	until success
	
	return Info
end

return LocationService
