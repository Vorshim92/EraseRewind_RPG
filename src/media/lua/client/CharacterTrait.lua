---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by lele.
--- DateTime: 15/04/23 18:54
---

---@class CharacterTrait

local CharacterTrait = {}

local characterLib = require("CharacterLib")
local characterPz = require("lib/CharacterPZ")
local errHandler = require("lib/ErrHandler")
local pageBook = require("PageBook")
local modDataManager = require("lib/ModDataManager")

require("lib/CharacterBaseObj")
---Read Trait From Hd
---@return table - string
local function readTraitFromHd()
    return modDataManager.read(pageBook.Character.TRAITS)
end

--- **Create Trait**
---@param character IsoGameCharacter
--- - IsoGameCharacter : zombie.characters.IsoGameCharacter
function CharacterTrait.readBook(character)
    --- **Check if character is null**
    if not character then
        errHandler.errMsg("CharacterTrait.readBook(character)",
                errHandler.err.IS_NULL_CHARACTERS)
        return nil
        --- **Check if moddata traits is exits**
    elseif not modDataManager.isExists(pageBook.Character.TRAITS) then
        errHandler.errMsg("CharacterTrait.readBook(character)",
                " moddata " .. pageBook.Character.TRAITS .. " not exists")
        return nil
    end

    ---@type table - string
    ---@return string
    local traits = readTraitFromHd(character)

    if not traits then
        return nil
    end

    --- **Delete Traits**
    characterPz.removeAllTraits_PZ(character)

    for _, v in pairs(traits) do
        ---@param character IsoGameCharacter
        ---@param trait string
        characterPz.setTraitsPerk_PZ(character, v)
    end
end

--- **Write Trait To Hd**
---@param character IsoGameCharacter
--- - IsoGameCharacter : zombie.characters.IsoGameCharacter
function CharacterTrait.writeBook(character)
    --- **Check if character is null**
    if not character then
        errHandler.errMsg("CharacterTrait.writeBook(character)",
                errHandler.err.IS_NULL_CHARACTERS)
        return nil
    end

    --- **Remove Traits form moddata**
    modDataManager.remove(pageBook.Character.TRAITS)

    ---@type CharacterBaseObj
    local trait = characterLib.getTraitsPerk(character)

    --- **Save Traits to moddata**
    modDataManager.save(pageBook.Character.TRAITS,
            trait:getTraits())
end

return CharacterTrait