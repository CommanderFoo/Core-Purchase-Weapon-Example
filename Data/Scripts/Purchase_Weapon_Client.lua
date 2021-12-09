local ui_container = script:GetCustomProperty("ui_container"):WaitForObject()

-- An index area of the weapon button and the cost.

local weapons = {

	{

		button = script:GetCustomProperty("rifle_button"):WaitForObject(),
		cost = 10

	},

	{

		button = script:GetCustomProperty("sword_button"):WaitForObject(),
		cost = 15

	},

	{

		button = script:GetCustomProperty("pistol_button"):WaitForObject(),
		cost = 20

	}

}

local local_player = Game.GetLocalPlayer()

-- A flag that will be true or false based on if the UI is open.
-- This allows the player to open and close the UI using a binding.

local ui_open = false

-- Hide the UI and cursor.

local function hide_ui()
	ui_container.visibility = Visibility.FORCE_OFF
	UI.SetCursorVisible(false)
	UI.SetCanCursorInteractWithUI(false)
	ui_open = false
end

-- Show the UI and the cursor.

local function show_ui()
	ui_container.visibility = Visibility.FORCE_ON
	UI.SetCursorVisible(true)
	UI.SetCanCursorInteractWithUI(true)
	ui_open = true
end

-- Hide and show the UI when the player presses the Q key.

local_player.bindingPressedEvent:Connect(function(player, binding)
	if(binding == "ability_extra_20") then
		if(ui_open) then
			hide_ui()
		else
			show_ui()
		end
	end
end)

-- Loop over the weapons array and set the clicked event for each button.
-- When the player clicks on the button, a resource check will be done to
-- make sure the player has enough gems. If they do, then a broadcast to
-- the server is done, it sends the index of the array.
-- Never send the cost, players might be able to exploit your game by
-- modifying the cost on the client.

for index, item in ipairs(weapons) do
	item.button.clickedEvent:Connect(function()
		if(local_player:GetResource("gems") >= item.cost) then
			Events.BroadcastToServer("purchase_weapon", index)
			hide_ui()
		end
	end)
end

-- Show the UI when the player joins.

show_ui()