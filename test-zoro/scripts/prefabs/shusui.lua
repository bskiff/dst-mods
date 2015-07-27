
local assets=
{
    Asset("ANIM", "anim/shusui.zip"),
    Asset("ANIM", "anim/swap_shusui.zip"),
 
    Asset("ATLAS", "images/inventoryimages/shusui.xml"),
    Asset("IMAGE", "images/inventoryimages/shusui.tex"),
}

local function onattack_shusui(inst, attacker, target)

    if attacker and attacker.components.hunger and attacker.components.health then
        attacker.components.hunger:DoDelta(-4)
		attacker.components.health:DoDelta(-1)
    end
end

local function fn()
	local inst = CreateEntity()
	inst.entity:AddTransform()
	inst.entity:AddAnimState()
    MakeInventoryPhysics(inst)

	inst.entity:AddTransform()
	inst.entity:AddAnimState()
	inst.entity:AddSoundEmitter()
    inst.entity:AddNetwork()
	
	inst.AnimState:SetBank("shusui")
    inst.AnimState:SetBuild("shusui")
    inst.AnimState:PlayAnimation("idle")
	
	if not TheWorld.ismastersim then
        return inst
    end
 
    local function OnEquip(inst, owner)
        owner.AnimState:OverrideSymbol("swap_object", "swap_shusui", "swap_shusui")
        owner.AnimState:Show("ARM_carry")
        owner.AnimState:Hide("ARM_normal")
    end
 
    local function OnUnequip(inst, owner)
        owner.AnimState:Hide("ARM_carry")
        owner.AnimState:Show("ARM_normal")
    end
 
    inst:AddComponent("inventoryitem")
	inst.components.inventoryitem.keepondeath = true
    inst.components.inventoryitem.imagename = "shusui"
    inst.components.inventoryitem.atlasname = "images/inventoryimages/shusui.xml"
     
    inst:AddComponent("equippable")
    inst.components.equippable:SetOnEquip( OnEquip )
    inst.components.equippable:SetOnUnequip( OnUnequip )
	inst.components.inventoryitem.keepondeath = true
	
	inst:AddComponent("inspectable")
		
	inst:AddTag("shadow")
 	inst:AddComponent("weapon")
	inst.components.weapon:SetOnAttack(onattack_shusui)
    inst.components.weapon:SetDamage(60)
    inst.components.weapon:SetRange(8, 10)
	inst.components.weapon:SetProjectile("zoro_projectile")

        
    if not inst.components.characterspecific then
    inst:AddComponent("characterspecific")
end
 
    inst.components.characterspecific:SetOwner("zoro")
    inst.components.characterspecific:SetStorable(true)
    inst.components.characterspecific:SetComment("These seem heavier than they look.") 
     

    return inst
	
end
	
return  Prefab("common/inventory/shusui", fn, assets)