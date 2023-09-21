local ActionType = require(script.Parent.ActionType)

return function(categoryIndex, tabIndex, position, firstVisibleTabIndex)
	return
	{
		type = ActionType.SelectCategoryTab,
		categoryIndex = categoryIndex,
		tabIndex = tabIndex,
		position = position,
		firstVisibleTabIndex = firstVisibleTabIndex
	}
end
