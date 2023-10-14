---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by lele.
--- DateTime: 12/10/23 15:22
---

require "ISUI/ISInventoryPaneContextMenu"
local characterManagement = require("CharacterManagement")
local debugDiagnostics = require("lib/DebugDiagnostics")

local ReadOnceBookJournal = {}
---@type string
local readBook = "ReadOnceBookJournal"
---@type string
local translation

--- **Write book**
--- --The variable character is a **REQUIRED** parameter of the addSaveContext() method
---@param character IsoGameCharacter
---@param context ISInventoryPaneContextMenu
---@param items InventoryItem
---@return void
--- - IsoGameCharacter : zombie.characters.IsoGameCharacter
--- - ISInventoryPaneContextMenu : zombie.ui.ISInventoryPaneContextMenu
--- - InventoryItem : zombie.inventory.InventoryItem
---
function ReadOnceBookJournal.addSaveContext(character, context, items)
    --- **Translate to selected language**
    translation = getText("ContextMenu_TranscribeBook")

    ---@type InventoryItem
    local item

    --- **Update all the characteristics of the character**
    ---@type IsoGameCharacter
    local character = debugDiagnostics.characterUpdate()

    for _, v in ipairs(items) do
        if not instanceof(v, "InventoryItem") then
            item = v.items[1]
        end

        if item:getType() == readBook then
            -- **Add option ( text ) to context**
            context:addOption(translation, item, ReadOnceBookJournal.onSavePlayer, character)
        end
    end
end

--- **Save player**
---@param item InventoryItem
---@param character IsoGameCharacter
---@return void
--- - InventoryItem : zombie.inventory.InventoryItem
--- - IsoGameCharacter : zombie.characters.IsoGameCharacter
function ReadOnceBookJournal.onSavePlayer(item, character)
    ---@type string
    local openBook = "OpenBook"

    ---@type string
    local closeBook = "CloseBook"

    --- **Translate to selected language**
    translation = getText( "ContextMenu_WrittenBook") .. " - " ..
            getText("ContextMenu_RebootClient")

    --- **Play sound**
    character:playSound(openBook)

    --- **Write moddata - Character stats**
    characterManagement.writeBook(character)

    --- **Add player name to read Once Book journal**
    ---@type string
    local itemName = item:getName()
    item:setName("" )
    item:setName( itemName .. " - " .. character:getFullName() )

    --- **Say message**
    character:Say(translation)

    --- **Play sound**
    character:playSound(closeBook)
end

Events.OnPreFillInventoryObjectContextMenu.Add(ReadOnceBookJournal.addSaveContext)

return ReadOnceBookJournal


