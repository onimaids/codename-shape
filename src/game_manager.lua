local GameManager = {
	song_position = 0,
}

setmetatable(GameManager, {
	__newindex = function ()
		error("Cannot set a new value in the GameManager table.")
	end
})

return GameManager
