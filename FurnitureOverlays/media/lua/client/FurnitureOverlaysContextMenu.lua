function FurnitureOverlays.resetOverlay(player,overlay,furnitureObject)
    furnitureObject:setOverlaySprite(overlay)
    furnitureObject:transmitUpdatedSpriteToServer()
end
function FurnitureOverlays.addOverlay(player,furnitureObject,overlay)
    
    furnitureObject:getModData().hasItem = true
    furnitureObject:setOverlaySprite(overlay)
    furnitureObject:transmitModData()
    furnitureObject:transmitUpdatedSpriteToServer()
end
function FurnitureOverlays.removeOverlay(player,furnitureObject,overlay)
    furnitureObject:setOverlaySprite(nil)
    furnitureObject:getModData().hasItem = false
    furnitureObject:transmitModData()
end



function FurnitureOverlays.OnPreFillWorldObjectContextMenu(player, context, worldobjects,test)
    if test and ISWorldObjectContextMenu.Test then return true end
    local overlayMenu = nil
    local furnitureObject = furnitureObject
    local spriteChoice = {}
    if not furnitureObject then 
        for _,wo in ipairs(worldobjects) do
			for name,spriteTable in pairs(FurnitureOverlays.SpriteSort) do
                if(wo:getTextureName() == name)then
                    furnitureObject = wo
                    spriteChoice = spriteTable
                end	 
			end
		end
    end
    if furnitureObject and not overlayMenu then
            overlayMenu = context:getNew(context)
            context:addSubMenu(context:addOption(getText("Set Furniture Item")), overlayMenu)
                if not furnitureObject:getModData().hasItem then
                        for i,choice in pairs(spriteChoice) do
                            if string.find(i,"pillow")
                            overlayMenu:addOption(getText(i), getSpecificPlayer(player), FurnitureOverlays.addOverlay,furnitureObject,choice)
                        end
                elseif furnitureObject:getOverlaySprite() == nil then
                    for i,choice in pairs(spriteChoice) do
                        overlayMenu:addOption(getText("Replace " .. i), getSpecificPlayer(player), FurnitureOverlays.resetOverlay,choice,furnitureObject)
                    end
                    
                   
                 end
                if furnitureObject:getOverlaySprite() ~= nil then
                    overlayMenu:addOption(getText("Remove Overlay"), getSpecificPlayer(player), FurnitureOverlays.removeOverlay,furnitureObject,choice)
                end
    end
end
Events.OnFillWorldObjectContextMenu.Add(FurnitureOverlays.OnPreFillWorldObjectContextMenu)