---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by lele.
--- DateTime: 15/04/23 18:54
---

---@class CharacterTrait

local CharacterTrait = {}

require("lib/CharacterBaseObj")

local characterLib = require("CharacterLib")
local characterPz = require("lib/CharacterPZ")
local errHandler = require("lib/ErrHandler")
-- local pageBook = require("book/PageBook")
local modDataManager = require("lib/ModDataManager")




---Read Trait From Hd
---@return table - string
local function readTraitFromHd(modData_name)
    return modDataManager.read(modData_name.TRAITS)
end

--- **Create Trait**
---@param character IsoGameCharacter
--- - IsoGameCharacter : zombie.characters.IsoGameCharacter
function CharacterTrait.readBook(character, modData_name)
    --- **Check if character is null**
    if not character then
        errHandler.errMsg("CharacterTrait.readBook(character)",
                errHandler.err.IS_NULL_CHARACTERS)
        return nil
        --- **Check if mod-data traits is exits**
    elseif not modDataManager.isExists(modData_name.TRAITS) then
        errHandler.errMsg("CharacterTrait.readBook(character)",
                " mod-data " .. modData_name.TRAITS .. " not exists")
        return nil
    end

    ---@type table - string
    ---@return string
    local traits = readTraitFromHd(modData_name)

    if not traits then
        return nil
    end

    --- **Delete Traits**
    characterPz.removeAllTraits_PZ(character)

    for _, v in pairs(traits) do
        -- @param character IsoGameCharacter
        -- @param trait string
        characterPz.setTraitsPerk_PZ(character, v)
    end
end

--- **Write Trait To Hd**
---@param character IsoGameCharacter
--- - IsoGameCharacter : zombie.characters.IsoGameCharacter
function CharacterTrait.writeBook(character, modData_name)
    --- **Check if character is null**
    if not character then
        errHandler.errMsg("CharacterTrait.writeBook(character)",
                errHandler.err.IS_NULL_CHARACTERS)
        return nil
    end

    --- **Remove Traits form mod-data**
    modDataManager.remove(modData_name.TRAITS)

    ---@type CharacterBaseObj
    local trait = characterLib.getTraitsPerk(character)

    --- **Save Traits to mod-data**
    modDataManager.save(modData_name.TRAITS,
            trait:getTraits())
            -- save backup on server
    -- local args = {
    --     name = modData_name.TRAITS,
    --     data = trait:getTraits()
    -- }
    -- sendClientCommand(character, "Vorshim", "saveBackup", args)
    -- -- end backup on server
end

return CharacterTrait