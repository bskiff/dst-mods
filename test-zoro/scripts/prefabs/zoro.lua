
local MakePlayerCharacter = require "prefabs/player_common"


local assets = {

        Asset( "ANIM", "anim/player_basic.zip" ),
        Asset( "ANIM", "anim/player_idles_shiver.zip" ),
        Asset( "ANIM", "anim/player_actions.zip" ),
        Asset( "ANIM", "anim/player_actions_axe.zip" ),
        Asset( "ANIM", "anim/player_actions_pickaxe.zip" ),
        Asset( "ANIM", "anim/player_actions_shovel.zip" ),
        Asset( "ANIM", "anim/player_actions_blowdart.zip" ),
        Asset( "ANIM", "anim/player_actions_eat.zip" ),
        Asset( "ANIM", "anim/player_actions_item.zip" ),
        Asset( "ANIM", "anim/player_actions_uniqueitem.zip" ),
        Asset( "ANIM", "anim/player_actions_bugnet.zip" ),
        Asset( "ANIM", "anim/player_actions_fishing.zip" ),
        Asset( "ANIM", "anim/player_actions_boomerang.zip" ),
        Asset( "ANIM", "anim/player_bush_hat.zip" ),
        Asset( "ANIM", "anim/player_attacks.zip" ),
        Asset( "ANIM", "anim/player_idles.zip" ),
        Asset( "ANIM", "anim/player_rebirth.zip" ),
        Asset( "ANIM", "anim/player_jump.zip" ),
        Asset( "ANIM", "anim/player_amulet_resurrect.zip" ),
        Asset( "ANIM", "anim/player_teleport.zip" ),
        Asset( "ANIM", "anim/wilson_fx.zip" ),
        Asset( "ANIM", "anim/player_one_man_band.zip" ),
        Asset( "ANIM", "anim/shadow_hands.zip" ),
        Asset( "SOUND", "sound/sfx.fsb" ),
        Asset( "SOUND", "sound/wilson.fsb" ),
        Asset( "ANIM", "anim/beard.zip" ),

        Asset( "ANIM", "anim/zoro.zip" ),
        Asset( "ANIM", "anim/ghost_zoro_build.zip" ),
}
local prefabs = {}
local start_inv = {
	-- Custom starting items
	"zorosheath",
	"zoroswordmouth",
	"shusui",
	"sandai",	
}

local untouchables = {
    crow = true,
    robin = true,
    robin_winter = true,
	babybeefalo = true, 
	penguin = true, 
	butterfly = true,
	smallbird = true,
	catcoon = true,
	chester = true,
	mosquito = true
}    
 
-- This initializes for both clients and the host
local common_postinit = function(inst) 
	-- Minimap icon
	inst.MiniMapEntity:SetIcon( "zoro.tex" )
	
	inst:DoTaskInTime(0, function()
		local old = inst.replica.combat.IsValidTarget
		inst.replica.combat.IsValidTarget = function(self, target)
			if target and untouchables[target.prefab] then
				return false
			end
			return old(self, target)
		end
	end)
end

-- This initializes for the host only
local master_postinit = function(inst)
	-- choose which sounds this character will play
	inst.soundsname = "wolfgang"
	-- Stats	
	inst.components.health:SetMaxHealth(200)
	inst.components.hunger:SetMax(200)
	inst.components.sanity:SetMax(175)
end

return MakePlayerCharacter("zoro", prefabs, assets, common_postinit, master_postinit, start_inv)
