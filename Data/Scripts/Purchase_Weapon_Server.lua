-- Index array of the weapons, this time is is the template, and the cost.

local weapons = {

	{

		template = script:GetCustomProperty("Rifle"),
		cost = 10

	},

	{

		template = script:GetCustomProperty("Sword"),
		cost = 15

	}, 

	{

		template = script:GetCustomProperty("Pistol"),
		cost = 20

	}

}

-- Remove the current weapon the player may have equipped, otherwise
-- the player will have multiple weapons. In this case, a loop is done
-- over all the equipment and destroying them.

local function remove_current_weapon(player)
	for i, equipment in ipairs(player:GetEquipment()) do
		equipment:Destroy()
	end
end

-- Equip the weapon the on the player. We spawn it and make it networked.

local function equip_weapon(player, weapon)
	local asset = World.SpawnAsset(weapon, { networkContext = NetworkContextType.NETWORKED })

	asset:Equip(player)
end

-- Check the weapon index is valid and the player has enough gems.
-- Remove the cost from the players resource amount.

local function purchase_weapon(player, weapon_index)
	if(weapons[weapon_index] ~= nil and player:GetResource("gems") >= weapons[weapon_index].cost) then
		remove_current_weapon(player)
		equip_weapon(player, weapons[weapon_index].template)
		player:RemoveResource("gems", weapons[weapon_index].cost)
	end
end

-- Connect the event which will connect for the player who broadcasted it.

Events.ConnectForPlayer("purchase_weapon", purchase_weapon)