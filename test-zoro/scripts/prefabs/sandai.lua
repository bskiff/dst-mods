local assets=
{
    Asset("ANIM", "anim/sandai.zip"),
    Asset("ANIM", "anim/swap_sandai.zip"),
  
    Asset("ATLAS", "images/inventoryimages/sandai.xml"),
    Asset("IMAGE", "images/inventoryimages/sandai.tex"),
}

local prefabs = 
{
	"zoro"
}

local function OnEquip(inst, owner)
    owner.AnimState:OverrideSymbol("swap_object", "swap_sandai", "swap_sandai")
    owner.AnimState:Show("ARM_carry")
    owner.AnimState:Hide("ARM_normal")
end
  
local function OnUnequip(inst, owner)
    owner.AnimState:Hide("ARM_carry")
    owner.AnimState:Show("ARM_normal")
end
 
local function fn()
  
    local inst = CreateEntity()
 
    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddNetwork()
     
    MakeInventoryPhysics(inst)   
      
    inst.AnimState:SetBank("sandai")
    inst.AnimState:SetBuild("sandai")
    inst.AnimState:PlayAnimation("idle")
 
    inst:AddTag("sharp")
 
    if not TheWorld.ismastersim then
        return inst
    end
 
    inst.entity:SetPristine()
     
    inst:AddComponent("weapon")
    inst.components.weapon:SetDamage(45)
	inst.components.weapon.blinking = true
	inst.components.weapon:SetRange(7, 2)
	
	inst:AddComponent("tool")
	inst.components.tool:SetAction(ACTIONS.CHOP, 1)
  
    inst:AddComponent("inspectable")
      
    inst:AddComponent("inventoryitem")
	inst.components.inventoryitem.keepondeath = true
    inst.components.inventoryitem.imagename = "sandai"
    inst.components.inventoryitem.atlasname = "images/inventoryimages/sandai.xml"
      
    inst:AddComponent("equippable")
    inst.components.equippable:SetOnEquip( OnEquip )
    inst.components.equippable:SetOnUnequip( OnUnequip )
	inst.components.inventoryitem.keepondeath = true
	
	if not inst.components.characterspecific then
    inst:AddComponent("characterspecific")
end
 
	inst.components.characterspecific:SetOwner("zoro")
	inst.components.characterspecific:SetStorable(true)
	inst.components.characterspecific:SetComment("These seem heavier than they look.") 
     
    return inst
end
return  Prefab("common/inventory/sandai", fn, assets, prefabs) 