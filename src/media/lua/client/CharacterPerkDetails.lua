---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by lele.
--- DateTime: 15/04/23 13:52
---

---@class CharacterPerkDetails

local CharacterPerkDetails = {}

local characterLib = require("CharacterLib")
local characterPz = require("lib/CharacterPZ")
local errHandler = require("lib/ErrHandler")
local pageBook = require("PageBook")
local modDataManager = require("lib/ModDataManager")
local perkFactoryPZ = require("lib/PerkFactoryPZ")

require("lib/CharacterBaseObj")

--- **Read Character Perk Details From Hd**
---@return CharacterBaseObj PerkFactory.Perk perk, int level, float xp, boolean flag
local function readCharacterPerkDetailsFromHd()

    ---@type table
    ---@return table perk, level ( int ), xp ( float )
    local characterPerkDetails =
        modDataManager.read(pageBook.Character.PERK_DETAILS)

    -- @type CharacterBaseObj
    local CharacterObj01 = CharacterBaseObj:new()

    ---@type table
    local lines_ = {}

    for _, v in pairs(characterPerkDetails) do
        -- Format value1-value2-value3
        for s in v:gmatch("[^\r-]+") do
            table.insert(lines_, s)
        end

        ---@param perk PerkFactory.Perk
        ---@param level int
        ---@param xp float
        CharacterObj01:addPerkDetails(perkFactoryPZ.getPerkByName_PZ(lines_[1]),
                tonumber(lines_[2]),
                tonumber(lines_[3]) + 0.0)

        lines_ = {}
    end

    return CharacterObj01
end

--- **Delete  all skills Character**
---@param character IsoGameCharacter
--- - IsoGameCharacter : zombie.characters.IsoGameCharacter
local function deleteCharacter(character)

    -- @type CharacterBaseObj
    local characterAllSkills = characterLib.getAllPerks(character)

    ---@param character IsoGameCharacter
    ---@param perk PerkFactory.Perk
    --- - PerkFactory.Perk : zombie.characters.skills.PerkFactory
    for _, v in pairs(characterAllSkills:getPerkDetails()) do
        characterPz.removePerkLevel(character, v:getPerk())
    end

    characterPz.removeProfession(character)
end

--- **Copy Character Skill**
---@param character IsoGameCharacter
--- - IsoGameCharacter : zombie.characters.IsoGameCharacter
function CharacterPerkDetails.readBook(character)
    --- **check if moddata perkDetails and profession are exits**
    if not character then
        errHandler.errMsg("CharacterPerkDetails.readBook(character)",
                " character " .. errHandler.err.IS_NULL_CHARACTERS)
        return nil
        --- **check if moddata profession are exits**
    elseif not modDataManager.isExists(pageBook.Character.PROFESSION) then
        errHandler.errMsg("CharacterPerkDetails.readBook(character)",
                " moddata " .. pageBook.Character.PROFESSION .. " not exists")
        return nil
        --- **check if moddata perkDetails are exits**
    elseif not modDataManager.isExists(pageBook.Character.PERK_DETAILS) then
        errHandler.errMsg("CharacterPerkDetails.readBook(character)",
                " moddata " .. pageBook.Character.PERK_DETAILS .. " not exists")
        return nil
    end

    -- @type CharacterBaseObj
    ---@return CharacterBaseObj PerkFactory.Perk perk, int level, float xp, boolean flag
    local characterSkills = readCharacterPerkDetailsFromHd()

    deleteCharacter(character)

    ---@param character IsoGameCharacter
    ---@param perk PerkFactory.Perk
    ---@param xp float
    for _, v in pairs(characterSkills:getPerkDetails()) do
        characterPz.setPerkLevelFromXp(character, v:getPerk(), v:getXp())
    end

    ---@type table
    ---@return table string ( profession )
    local profession = modDataManager.read(pageBook.Character.PROFESSION)

    characterPz.setProfession_PZ(character,
            profession[1])
end

--- **Write Character Perk Details To Hd**
---@param character IsoGameCharacter
--- - IsoGameCharacter : zombie.characters.IsoGameCharacter
function CharacterPerkDetails.writeBook(character)
    --- **Remove perkDetails and profession from moddata**
    modDataManager.remove(pageBook.Character.PERK_DETAILS)
    modDataManager.remove(pageBook.Character.PROFESSION)

    ---@type table
    local lines = {}

    -- @type CharacterBaseObj
    local characterAllSkills = characterLib.getAllPerks(character)

    -- Format value1-value2-value3
    ---@param perk PerkFactory.Perk
    ---@param level int
    ---@param xp float
    for _, v in pairs(characterAllSkills:getPerkDetails()) do
        local value = ( v.perk:getName() .. "-" ..
                tostring(v:getLevel())  .. "-" ..
                tostring(v:getXp()) )

        table.insert(lines, value)
    end

    --- **Save Character Perk Details to moddata**
    modDataManager.save(pageBook.Character.PERK_DETAILS, lines)

    lines = {}
    table.insert(lines, characterAllSkills:getProfession())

    --- **Save Character Profession to moddata**
    modDataManager.save(pageBook.Character.PROFESSION,
            lines )

    lines = {}
end

return CharacterPerkDetails