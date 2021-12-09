local starting_gems = script:GetCustomProperty("starting_gems")


-- Give gems to the player when they join the game.
-- Ideally you would load this from player storage, but for testing
-- we are giving the player a starting amount by reading the custom 
-- property "starting_gems".

Game.playerJoinedEvent:Connect(function(player)
	player:SetResource("gems", starting_gems)
end)
