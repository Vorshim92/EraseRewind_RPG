require "ISUI/ISInventoryPaneContextMenu"
local characterManagement = require("CharacterManagement")

local eraseRewindJournal = "EraseRewindJournal"
local contextER = {}

--- **Add Save Context**
---@param character IsoGameCharacter
---@param context ISInventoryPaneContextMenu
---@param items InventoryItem
---@return void
--- - IsoGameCharacter : zombie.characters.IsoGameCharacter
function contextER.addSaveContext(character, context, items)

    for _, v in ipairs(items) do

        local character = getPlayer()
        -- check per item annidato
		local item = v

        if not instanceof(v, "InventoryItem") then
			item = v.items[1]
		end

        -- check per item giusto
		if item:getType() == eraseRewindJournal then
            context:addOption("Trascrivi", item, contextER.onSavePlayer, character)
        end
    end
end

--- **Save player**
---@param item InventoryItem
---@param character IsoGameCharacter
---@return void
--- - IsoGameCharacter : zombie.characters.IsoGameCharacter
--- - InventoryItem : zombie.inventory.InventoryItem
function contextER.onSavePlayer(item, character)
    character:playSound("OpenBook")
    -- qua il salvataggio moddata
    characterManagement.writeBook(character)

    item:setName(eraseRewindJournal .. " - " .. character:getDisplayName() )
    character:Say("Libro scritto")

    character:playSound("CloseBook")
end

Events.OnPreFillInventoryObjectContextMenu.Add(contextER.addSaveContext)