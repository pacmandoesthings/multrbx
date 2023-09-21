local ActionType = require(script.Parent.ActionType)

return function(categoryIndex)
	return
	{
		type = ActionType.SelectCategory,
		categoryIndex = categoryIndex,
	}
end
