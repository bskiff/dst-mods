local function MapPostConstruct(inst)
 
    inst._OnBecomeActive = inst.OnBecomeActive
    function inst:OnBecomeActive()   
    if ThePlayer.prefab == "zoro" then return end
 
        inst:_OnBecomeActive()
    end
 
    inst._OnBecomeInactive = inst.OnBecomeInactive
    function inst:OnBecomeInactive()
        if ThePlayer.prefab == "zoro" then return end
 
        inst:_OnBecomeInactive()
    end
 
    return inst
end
 
AddClassPostConstruct("screens/mapscreen", MapPostConstruct) 