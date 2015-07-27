 -- Import the lib use.
modimport("libs/env.lua")
 
-- Disable the map screen.
use "data/screens/mapscreen" 

-- Actions Initialization.
use "data/actions/init"

-- Component Initialization.
use "data/components/init"

PrefabFiles = {
	"zoro", "zoroswordmouth", "sandai", "shusui", "zoro_projectile", "zorosheath"
}

Assets = {
    Asset( "IMAGE", "images/saveslot_portraits/zoro.tex" ),
    Asset( "ATLAS", "images/saveslot_portraits/zoro.xml" ),

    Asset( "IMAGE", "images/selectscreen_portraits/zoro.tex" ),
    Asset( "ATLAS", "images/selectscreen_portraits/zoro.xml" ),
	
    Asset( "IMAGE", "images/selectscreen_portraits/zoro_silho.tex" ),
    Asset( "ATLAS", "images/selectscreen_portraits/zoro_silho.xml" ),

    Asset( "IMAGE", "bigportraits/zoro.tex" ),
    Asset( "ATLAS", "bigportraits/zoro.xml" ),
	
	Asset( "IMAGE", "images/map_icons/zoro.tex" ),
	Asset( "ATLAS", "images/map_icons/zoro.xml" ),
	
	Asset( "IMAGE", "images/avatars/avatar_zoro.tex" ),
    Asset( "ATLAS", "images/avatars/avatar_zoro.xml" ),
	
	Asset( "IMAGE", "images/avatars/avatar_ghost_zoro.tex" ),
    Asset( "ATLAS", "images/avatars/avatar_ghost_zoro.xml" ),

}

local STRINGS = GLOBAL.STRINGS
local require = GLOBAL.require
local SpawnPrefab = GLOBAL.SpawnPrefab

AddPlayerPostInit(function(inst)
   if inst.components.combat == nil then
        return
    end
	if GLOBAL.TheWorld.ismastersim then
		local old_start = inst.components.combat.StartAttack
		inst.components.combat.StartAttack = function(self)
			old_start(self)
			if self.target then
				local weapon = self:GetWeapon()
				if weapon and weapon.components.weapon and weapon.components.weapon.blinking then
					local distance = math.sqrt(self.inst:GetDistanceSqToInst(self.target))
					local hitrange = weapon.components.weapon.hitrange
					if distance > hitrange then
						local smoke1 = SpawnPrefab("maxwell_smoke")
						local smoke2 = SpawnPrefab("maxwell_smoke")
						local sx, sy, sz = self.inst.Transform:GetWorldPosition()
						smoke1.Transform:SetPosition(sx, sy, sz)
						local fx, fy, fz = self.target.Transform:GetWorldPosition()
						local q = (distance - hitrange + 0.2) / distance
						local dx = sx - q * (sx - fx)
						local dy = sy - q * (sy - fy)
						local dz = sz - q * (sz - fz)
						inst.Transform:SetPosition(dx, dy, dz)
						smoke2.Transform:SetPosition(dx, dy, dz)
					end
				end
			end
		end
	end
end)



 function _G.IsDontStarveTogether()
return kleifileexists("scripts/networking.lua") and true or false
end


local containers = require("containers")
 
local oldwidgetsetup = containers.widgetsetup
containers.widgetsetup = function(container, prefab)
    if not prefab and container.inst.prefab == "zorosheath" then
        prefab = "backpack"
    end
    oldwidgetsetup(container, prefab)
end 

STRINGS.NAMES.ZOROSWORDMOUTH = "Wado Ichimonji"
STRINGS.NAMES.SANDAI = "Sandai Kitetsu"
STRINGS.NAMES.SHUSUI = "Shusui"
STRINGS.NAMES.ZOROSHEATH = "Zoro's Katana Sheaths"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.ZOROSWORDMOUTH= "A sword that has a lot of sentimental value to a certain swordsman."
STRINGS.CHARACTERS.GENERIC.DESCRIBE.SHUSUI= "Only legendary wielders can hold such a sword."
STRINGS.CHARACTERS.GENERIC.DESCRIBE.SANDAI= "Only few have overcame the curse and lived."
STRINGS.CHARACTERS.GENERIC.DESCRIBE.ZOROSHEATH= "It holds three special swords with each uniqueness all their own."


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

AddComponentPostInit("playeractionpicker", function(self)
    local old = self.SortActionList
    function self:SortActionList(actions, target, useitem)
        if #actions == 0 then
            return actions
        end
        local c = 0
        for k, v in pairs(actions) do
            if v == GLOBAL.ACTIONS.ATTACK and
            self.inst.prefab == "zoro" and
            untouchables[target.prefab] then
                c = 1
                break
            end
        end
        if c == 1 then
            return {}
        else
            return old(self, actions, target, useitem)
        end
    end
end)

-- The character select screen lines
STRINGS.CHARACTER_TITLES.zoro = "The World's Greatest Swordsman"
STRINGS.CHARACTER_NAMES.zoro = "Zoro"
STRINGS.CHARACTER_DESCRIPTIONS.zoro = "*Strong Attacks\n*Swords have multiple uses\n*No Sense of Direction"
STRINGS.CHARACTER_QUOTES.zoro = "\"Scars on the back are a Swordsman's Shame\""

-- Custom speech strings
STRINGS.CHARACTERS.ZORO = require "speech_zoro"

-- The character's name as appears in-game 
STRINGS.NAMES.ZORO = "Zoro"

-- The default responses of examining the character
STRINGS.CHARACTERS.GENERIC.DESCRIBE.ZORO = 
{
	GENERIC = "It's Zoro!",
	ATTACKER = "That Zoro looks shifty...",
	MURDERER = "Murderer!",
	REVIVER = "Zoro, friend of ghosts.",
	GHOST = "Zoro could use a heart.",
}

-- Let the game know character is male, female, or robot
table.insert(GLOBAL.CHARACTER_GENDERS.MALE, "zoro")


AddMinimapAtlas("images/map_icons/zoro.xml")
AddModCharacter("zoro")
