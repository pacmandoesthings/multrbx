local Reducers = script.Parent

local FullView = require(Reducers.FullView)
local Character = require(Reducers.Character)
local Category = require(Reducers.Category)

return function(state, action)
	state = state or {}

	return {
		FullView = FullView(state.FullView, action);
		Character = Character(state.Character, action);
		Category = Category(state.Category, action);
	}
end
