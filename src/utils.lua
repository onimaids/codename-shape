local Utils = {}

function Utils.table_has(t, v)
	for _, val in ipairs(t) do
		if type(val) == type(v) and val == v then return true end
	end

	return false
end

return Utils
