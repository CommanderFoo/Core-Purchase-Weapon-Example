-- The UI text object to display the players total gems amount.
local gems_amount = script:GetCustomProperty("GemsAmount"):WaitForObject()

local local_player = Game.GetLocalPlayer()

-- Update the gems by passing in the amount.
local function update_gems_amount(amount)
	gems_amount.text = tostring(amount)
end

-- When the players resource changes, we check if it is "gems" and update.
local_player.resourceChangedEvent:Connect(function(player, resource, amount)
	if(resource == "gems") then
		update_gems_amount(amount)
	end
end)

-- Sometimes things may not be ready, this may be a local preview issue
-- so I wait 1 frame before updating the ui.

Task.Wait()

-- Sometimes the server can set the player's resource before the
-- resource change event has been connected, so a manual call is
-- a good idea, otherwise the UI won't update until the player
-- makes a purchase.

update_gems_amount(local_player:GetResource("gems"))