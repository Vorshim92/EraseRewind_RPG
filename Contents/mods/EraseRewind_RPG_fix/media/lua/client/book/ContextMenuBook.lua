---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by lele.
--- DateTime: 12/10/23 20:51
---

require "ISUI/ISInventoryPaneContextMenu"

local activityCalendar = require("lib/ActivityCalendar")
local debugDiagnostics = require("lib/DebugDiagnostics")
local readOnceBook = require("book/ReadOnceBook")
local timedBook = require("book/TimedBook")
local chooseBook = require("book/ChooseBook")

---@type string
local translation

--- **Save player**
---@param item InventoryItem
---@param character IsoGameCharacter
---@return void
--- - InventoryItem : zombie.inventory.InventoryItem
--- - IsoGameCharacter : zombie.characters.IsoGameCharacter
local function onSavePlayer(item, character)
    ---@type string
    local openBook = "OpenBook"

    ---@type string
    local closeBook = "CloseBook"

    --- **Translate to selected language**
    translation = getText( "ContextMenu_WrittenBook")

    --- **Play sound**
    character:playSound(openBook)

    ---@type boolean
    local flag01 = false

    if chooseBook.isCorrectBook(item, "ReadOnceBook") then
            --- **Check if the book can be write mod-data**
            if isClient() then
                sendClientCommand(character, "Vorshim", "checkWriteBook", {bookType = "READ_ONCE_BOOK", item = item})
                character:Say("Checking book on Server")
                return
            end
            if readOnceBook.writeBook(character) then
                flag01 = true
            else
                translation = getText("ContextMenu_AlreadyWrite")
                flag01 = false
            end
    elseif chooseBook.isCorrectBook(item, "TimedBook") then
        if isClient() then
            sendClientCommand(character, "Vorshim", "checkWriteBook", {bookType = "TIMED_BOOK", item = item})
            character:Say("Checking book on Server")
            return
        end
        --- **Write mod-data - Write book**
        if timedBook.writeBook(character) then
            flag01 = true
        else
            --- **You can't transcribe this book yet**
            local expectedDateInSecond =  activityCalendar.getExpectedDateInSecond()
            local expectedDate = activityCalendar.fromSecondToDate(expectedDateInSecond)
            local extra = " - " .. tostring(expectedDate)
            translation = (getText( "ContextMenu_ToEarly") .. extra)
            flag01 = false
        end
    end

    --- **If true add player name to read Once Book journal**
    if flag01 then
        local extra = ""

        --- **If TimedBook get expected date**
        if chooseBook.isCorrectBook(item, "TimedBook") then
            local expectedDateInSecond =  activityCalendar.getExpectedDateInSecond()
            local expectedDate = activityCalendar.fromSecondToDate(expectedDateInSecond)
            extra = " - " .. tostring(expectedDate)
        end

        --- extract name of the book "ReadOnceBook" or "TimedBook"
        local type = item:getName():match("^[^ -]* - [^ -]*")
        type:sub(1, type:find(" ") - 1)

        --- **Set name of the book**
        item:setName(type .. " - " .. character:getFullName() .. extra )
    end

    --- **Say message**
    character:Say(translation)

    --- **Play sound**
    character:playSound(closeBook)
end

--- **Write book**
---@param character IsoGameCharacter
---@param context ISInventoryPaneContextMenu
---@param items InventoryItem
---@return void
--- - IsoGameCharacter : zombie.characters.IsoGameCharacter
--- - ISInventoryPaneContextMenu : zombie.ui.ISInventoryPaneContextMenu
--- - InventoryItem : zombie.inventory.InventoryItem
local function addSaveContext(character, context, items)
    --- **Translate to selected language**
    translation = getText("ContextMenu_TranscribeBook")

    --- **Update all the characteristics of the character**
    character = debugDiagnostics.characterUpdate()

    local item

    for _, v in ipairs(items) do
        ---@type InventoryItem
        item = v

        --- **Retrive the selected item from the GUI inventory**
        if not instanceof(v, "InventoryItem") then
            item = v.items[1]
        end

        --- **If a book create a context menu**
        if chooseBook.isBook(item)  then
            context:addOption(translation, item, onSavePlayer, character)
            break
        end
    end
end

Events.OnPreFillInventoryObjectContextMenu.Add(addSaveContext)