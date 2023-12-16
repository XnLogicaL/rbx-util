--[[

	Author: @XnLogicaL (@CE0_OfTrolling)
	Licensed under the MIT License.
	
	This is the GitHub version of Utils pack by @XnLogicaL
	
	This massive utility pack consists mostly of back-end modules/packages/components.
	Can be used for Frameworks, Large Modules and Expansive Systems.
	If you're only using a single component, I would recommend just using the component by itself.
	
	Recommended to be stored in game.ReplicatedStorage
	Should be safe to use for both Server and Client environments. 
	
	You can report any issues you encounter on my GitHub page: https://github.com/XnLogicaL
	
	Credits:
	
	<HashLib>
	 @Egor Skriptunoff
	 @boatbomber
	 @howmanysmall
	
	<MathV4>
	 @DoorsPro_Bacon
		
	<Promise>
	 Unknown Author
		
	<Random>
	 @XnLogicaL (@CE0_OfTrolling)
		
	<Exceptions>
	 @XnLogicaL (@CE0_OfTrolling)
		
	<TableUtils>
	 @XnLogicaL (@CE0_OfTrolling)
		
	<StateMachine>
	 @proheckcp
		
	<Trove>
	 @sleitnick
		
	<InstanceToData>
	 @XnLogicaL (@CE0_OfTrolling)
		
	<BetterSignal>
	 @XnLogicaL (@CE0_OfTrolling)
	 
	<Signal>
	 @stravant
	 @sleitnick
		
	<Enum>
	 Originally by @TheGamer01
	 Edited by @CE0_OfTrolling and @EtiTheSpirit
		
	<HierarchyUtil>
	 @XnLogicaL (@CE0_OfTrolling)
		
	<BanService>
	 BanService has been discontinued/deprecated. If any issues are present, please do not report them to the author.
	 @XnLogicaL (@CE0_OfTrolling)
		
	<Bin>
	 @XnLogicaL (@CE0_OfTrolling)
		
	<LocationService>
	 Unknown Author
	
]]--

_index = script.Parent.lib:GetChildren()
_index.exceptions.init.new_exception("FeatureNotActivated")
_index.exceptions.init.new_exception("IndexError")

return setmetatable({}, {
	__index = function(tbl, index)
		if _index[index] ~= nil then
			return require(_index[index].init)
		else
			_index.exceptions.init.raise("IndexError", "Could not index requested utility package")
		end
	end;

	__newindex = function(tbl, index, value)
		_index.exceptions.init.raise("IndexError", "Please edit the source code to add more util packages instead.")
		index = nil
	end;
})
