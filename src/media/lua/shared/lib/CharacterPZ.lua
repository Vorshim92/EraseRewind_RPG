---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by lele.
--- DateTime: 07/05/23 10:42
---

---@class CharacterPZ

--[[
    not tested
--remove all previous profession, traits [..] (incldues XpBoost removal)
character:getDescriptor():setProfession("unemployed");
character:getTraits():clear();

Great, level0 is ideal
    if curLevel > 0 then
        player:level0(pk);
    end;
]]


local CharacterPz = {}

local dataValidator = require("lib/DataValidator")
local errHandler = require("lib/ErrHandler")

--- **Add XP**
---@param character IsoGameCharacter
---@param perk PerkFactory.Perk
---@param xp float
---@param flag1 boolean true Event.AddXP(value) function will be triggered. Cooking is bugged api 41.78
---@param flag2 boolean XP boosts from skills & multipliers
---@param flag3 boolean sendAddXp is called (if it's a player on the client)
---@return void
--- - In the documentation these are named callLua, doXPBoost, and remote
--- - IsoGameCharacter : zombie.characters.IsoGameCharacter
--- - PerkFactory.Perk : zombie.characters.skills.PerkFactory.Perk
--- - IsoGameCharacter.XP : zombie.characters.IsoGameCharacter.XP
function CharacterPz.addXP_PZ(character, perk, xp, flag1, flag2, flag3)
    --- **Check if character is nil**
    if not character then
        errHandler.errMsg("CharacterPz.addXP_PZ(character, perk, xp, flag1, flag2, flag3)",
                errHandler.err.IS_NULL_CHARACTERS)
        return nil

    --- **Check if character is IsoGameCharacter**
    elseif not dataValidator.isCharacter(character) then
        errHandler.errMsg("CharacterPz.addXP_PZ(character, perk, xp, flag1, flag2, flag3)",
                errHandler.err.IS_NOT_CHARACTERS)
        return nil

    --- **Check if perk is nil**
    elseif not perk then
        errHandler.errMsg("CharacterPz.addXP_PZ(character, perk, xp, flag1, flag2, flag3)",
                errHandler.err.IS_NULL_PERK)
        return nil
    --- **Check if xp is nil**
    elseif not xp then
        errHandler.errMsg("CharacterPz.addXP_PZ(character, perk, xp, flag1, flag2, flag3)",
                errHandler.err.IS_NULL_XP)
        return nil
    end

    flag1 = flag1 or true -- is the default
    flag2 = flag2 or false -- is the default
    flag3 = flag3 or false -- is the default
    character:getXp():AddXP(perk, xp, flag1, flag2, flag3);
end

--- **Get XP perk with truncate to two decimal place**
---@param character IsoGameCharacter
---@param perk PerkFactory.Perk
---@return float xp
--- - IsoGameCharacter : zombie.characters.IsoGameCharacter
--- - PerkFactory.Perk : zombie.characters.skills.PerkFactory.Perk
--- - IsoGameCharacter.XP : zombie.characters.IsoGameCharacter.XP
function CharacterPz.getXp(character, perk)
    --- **Check if character is nil**
    if not character then
        errHandler.errMsg("CharacterPz.getXp(character, perk)",
                errHandler.err.IS_NULL_CHARACTERS)
        return nil

    --- **Check if character is IsoGameCharacter**
    elseif not dataValidator.isCharacter(character) then
        errHandler.errMsg("CharacterPz.getXp(character, perk)",
                errHandler.err.IS_NOT_CHARACTERS)
        return nil

    --- **Check if perk is nil**
    elseif not perk then
        errHandler.errMsg("CharacterPz.getXp(character, perk)",
                errHandler.err.IS_NULL_PERK)
        return nil
    end

    ---@type float
    local xp = CharacterPz.getXp_PZ(character, perk)
    return dataValidator.trunkFloatTo2Decimal(xp) -- Perks.Maintenance
end

--- **Get XP perk**
---@param character IsoGameCharacter
---@param perk PerkFactory.Perk
---@return float xp
--- - IsoGameCharacter : zombie.characters.IsoGameCharacter
--- - PerkFactory.Perk : zombie.characters.skills.PerkFactory.Perk
--- - IsoGameCharacter.XP : zombie.characters.IsoGameCharacter.XP
function CharacterPz.getXp_PZ(character, perk)
    --- **Check if character is nil**
    if not character then -- or not perk then
        errHandler.errMsg("CharacterPz.getXp_PZ(character, perk)",
                errHandler.err.IS_NULL_CHARACTERS)
        return nil

    --- **Check if character is IsoGameCharacter**
    elseif not dataValidator.isCharacter(character) then
        errHandler.errMsg("CharacterPz.getXp_PZ(character, perk)",
                errHandler.err.IS_NOT_CHARACTERS)
        return nil

    --- **Check if perk is nil**
    elseif not perk then
        errHandler.errMsg("CharacterPz.getXp_PZ(character, perk)",
                errHandler.err.IS_NULL_PERK)
        return nil
    end

    return character:getXp():getXP(perk) -- Perks.Maintenance
end

--- **Trunk Float To 2 Decimal**
---@param value double
---@return double
function CharacterPz.trunkFloatTo2Decimal(value)
    --- **Check if value is nil**
    if not value then
        errHandler.errMsg("CharacterPz.trunkFloatTo2Decimal(value)",
                errHandler.err.IS_NULL)
        return nil
    end

    return tonumber(string.format("%.2f", value)) + 0.0
end

--- **Get Character profession**
---@param character IsoGameCharacter
---@param profession String
---@return void
--- - IsoGameCharacter : zombie.characters.IsoGameCharacter
--- - SurvivorDesc : zombie.characters.SurvivorDesc
function CharacterPz.setProfession_PZ(character, profession)
    --- **Check if character is nil**
    if not character then
        errHandler.errMsg("CharacterPz.setProfession_PZ(character, profession)",
                errHandler.err.IS_NULL_CHARACTERS)
        return nil

    --- **Check if character is IsoGameCharacter**
    elseif not dataValidator.isCharacter(character) then
        errHandler.errMsg("CharacterPz.setProfession_PZ(character, profession)",
                errHandler.err.IS_NOT_CHARACTERS)
        return nil

    --- **Check if profession is nil**
    elseif not profession then
        errHandler.errMsg("CharacterPz.setProfession_PZ(character, profession)",
                errHandler.err.IS_NULL_PROFESSION)
        return nil
    end

    character:getDescriptor():setProfession(profession)
end

--- **Get Character profession**
---@param character IsoGameCharacter
---@return String
--- - IsoGameCharacter : zombie.characters.IsoGameCharacter
--- - SurvivorDesc : zombie.characters.SurvivorDesc
function CharacterPz.getProfession_PZ(character)
    --- **Check if character is nil**
    if not character then
        errHandler.errMsg("CharacterPz.getProfession_PZ(character)",
                errHandler.err.IS_NULL_CHARACTERS)
        return nil
    end

    return character:getDescriptor():getProfession()
end

--- **Remove Character profession**
---@param character IsoGameCharacter
---@return String
---@return void
--- - IsoGameCharacter : zombie.characters.IsoGameCharacter
function CharacterPz.removeProfession(character)
    --- **Check if character is nil**
    if not character then
        errHandler.errMsg("CharacterPz.removeProfession(character)",
                errHandler.err.IS_NULL_CHARACTERS)
        return nil

    --- **Check if character is IsoGameCharacter**
    elseif not dataValidator.isCharacter(character) then
        errHandler.errMsg("CharacterPz.removeProfession(character)",
                errHandler.err.IS_NOT_CHARACTERS)
        return nil
    end

    local unemployed = "unemployed"
    CharacterPz.setProfession_PZ(character, unemployed)
end

--- **Enum Numbers**
---@return int
CharacterPz.EnumNumbers = {
    ---@type int
    ZERO = 0,
    ---@type int
    ONE = 1,
    ---@type int
    TWO = 2,
    ---@type int
    THREE = 3,
    ---@type int
    FOUR = 4,
    ---@type int
    FIVE = 5,
    ---@type int
    SIX = 6,
    ---@type int
    SEVEN = 7,
    ---@type int
    EIGHT = 8,
    ---@type int
    NINE = 9,
    ---@type int
    TEN = 10,
}

--- **Set Perk Level from XP 75 - 150 ......**
---@param character IsoGameCharacter
---@param perk PerkFactory.Perk
---@param xp float
---@return void
--- - IsoGameCharacter : zombie.characters.IsoGameCharacter
--- - PerkFactory.Perk : zombie.characters.skills.PerkFactory.Perk
--- - IsoGameCharacter.XP : zombie.characters.IsoGameCharacter.XP
function CharacterPz.setPerkLevelFromXp(character, perk, xp)
    --- **Check if character is nil**
    if not character then -- or not perk then
        errHandler.errMsg("CharacterPz.setPerkLevelFromXp(character, perk, xp)",
                errHandler.err.IS_NULL_CHARACTERS)
        return nil

    --- **Check if character is IsoGameCharacter**
    elseif not dataValidator.isCharacter(character) then
        errHandler.errMsg("CharacterPz.setPerkLevelFromXp(character, perk, xp)",
                errHandler.err.IS_NOT_CHARACTERS)
        return nil

    --- **Check if perk is nil**
    elseif not perk then
        errHandler.errMsg("CharacterPz.setPerkLevelFromXp(character, perk, xp)",
                errHandler.err.IS_NULL_PERK)
        return nil

    --- **Check if xp is nil**
    elseif not xp then
        errHandler.errMsg("CharacterPz.setPerkLevelFromXp(character, perk, xp)",
                errHandler.err.IS_NULL_XP)
        return nil
    end

    if xp == 0 then
        return
    end

    CharacterPz.addXP_PZ(character, perk, xp,
            true,false, false )

end

--- **Get Perk Level**
---@param character IsoGameCharacter
---@param perk PerkFactory.Perk
---@return int
--- - IsoGameCharacter : zombie.characters.IsoGameCharacter
--- - PerkFactory.Perk : zombie.characters.skills.PerkFactory.Perk
function CharacterPz.getPerkLevel_PZ(character, perk)
    --- **Check if character is nil**
    if not character then -- or not perk then
        errHandler.errMsg("CharacterPz.getPerkLevel_PZ(character, perk)",
                errHandler.err.IS_NULL_CHARACTERS)
        return nil

    --- **Check if character is IsoGameCharacter**
    elseif not dataValidator.isCharacter(character) then
        errHandler.errMsg("CharacterPz.getPerkLevel_PZ(character, perk)",
                errHandler.err.IS_NOT_CHARACTERS)
        return nil

    --- **Check if perk is nil**
    elseif not perk then
        errHandler.errMsg("CharacterPz.getPerkLevel_PZ(character, perk)",
                errHandler.err.IS_NULL_PERK)
        return nil
    end

    return character:getPerkLevel(perk)
end

--- **Set Perk Level and level**
---@param character IsoGameCharacter
---@param perk PerkFactory.Perk
---@return void
--- ISPlayerStatsUI.lua 635
--- - IsoGameCharacter : zombie.characters.IsoGameCharacter
--- - PerkFactory.Perk : zombie.characters.skills.PerkFactory.Perk
--- - IsoGameCharacter.XP : zombie.characters.IsoGameCharacter.XP
function CharacterPz.removePerkLevel(character, perk)
    --- **Check if character is nil**
    if not character then -- or not perk then
        errHandler.errMsg("CharacterPz.removePerkLevel(character, perk)",
                errHandler.err.IS_NULL_CHARACTERS )
        return nil

    --- **Check if character is IsoGameCharacter**
    elseif not dataValidator.isCharacter(character) then
        errHandler.errMsg("CharacterPz.removePerkLevel(character, perk)",
                errHandler.err.IS_NOT_CHARACTERS)
        return nil

    --- **Check if perk is nil**
    elseif not perk then
        errHandler.errMsg("CharacterPz.removePerkLevel(character, perk)",
                errHandler.err.IS_NULL_PERK )
        return nil
    end

    ---@type int
    local currentLevelPerk = CharacterPz.getPerkLevel_PZ(character, perk)

    for _ = 0, currentLevelPerk  do
        character:LoseLevel(perk)
    end

    ---@type float
    local xpPerk = CharacterPz.getXp(character, perk)
    xpPerk = -xpPerk

    if xpPerk == 0 then
        return
    end

    CharacterPz.addXP_PZ(character, perk, xpPerk,
            true,false, false )

end

-- TODO : add errHandler
--- **Set Zombies Killed**
---@param character IsoGameCharacter
---@param killedZombies int
---@return void
--- - IsoGameCharacter : zombie.characters.IsoGameCharacter
function CharacterPz.setZombieKills_PZ(character, killedZombies)
    if not character or type(killedZombies) ~= "number" or
            math.floor(killedZombies) ~= killedZombies then
        return nil
    end

    character:setZombieKills(killedZombies)
end

--- **Get Zombies Killed**
---@param character IsoGameCharacter
---return int
--- - IsoGameCharacter : zombie.characters.IsoGameCharacter
function CharacterPz.getZombieKills_PZ(character)
    --- **Check if character is nil**
    if not character then
        errHandler.errMsg("CharacterPz.getZombieKills_PZ(character)",
                errHandler.err.IS_NULL_CHARACTERS)
        return nil

    --- **Check if character is IsoGameCharacter**
    elseif not dataValidator.isCharacter(character) then
        errHandler.errMsg("CharacterPz.getZombieKills_PZ(character)",
                errHandler.err.IS_NOT_CHARACTERS)
        return nil
    end

    return character:getZombieKills()
end

--- **Learn a Recipe_PZ**
---@param character IsoGameCharacter
---@param nameRecipe String
---@return boolean
--- - IsoGameCharacter : zombie.characters.IsoGameCharacter
function CharacterPz.learnRecipe_PZ(character, nameRecipe)
    --- **Check if character is nil**
    if not character then
        errHandler.errMsg("CharacterPz.learnRecipe_PZ(character, nameRecipe)",
                errHandler.err.IS_NULL_CHARACTERS )
        return nil

    --- **Check if character is IsoGameCharacter**
    elseif not dataValidator.isCharacter(character) then
        errHandler.errMsg("CharacterPz.learnRecipe_PZ(character, nameRecipe)",
                errHandler.err.IS_NOT_CHARACTERS)
        return nil

    --- **Check if nameRecipe is nil**
    elseif not nameRecipe then
        errHandler.errMsg("CharacterPz.learnRecipe_PZ(character, nameRecipe)",
                "nameRecipe " .. errHandler.err.IS_NULL)
        return nil
    end

    -- TODO : add return value
    return character:learnRecipe(nameRecipe)
end

--- **Set Trait**
---@param character IsoGameCharacter
---@param trait string
---@return void
--- - IsoGameCharacter : zombie.characters.IsoGameCharacter
--- - TraitCollection.TraitSlot : zombie.characters.traits.TraitCollection.TraitSlot
function CharacterPz.setTraitsPerk_PZ(character, trait)
    --- **Check if character is nil**
    if not character then
        errHandler.errMsg("CharacterPz.setTraitsPerk_PZ(character, trait)",
                errHandler.err.IS_NULL_CHARACTERS )
        return nil

    --- **Check if character is IsoGameCharacter**
    elseif not dataValidator.isCharacter(character) then
        errHandler.errMsg("CharacterPz.setTraitsPerk_PZ(character, trait)",
                errHandler.err.IS_NOT_CHARACTERS)
        return nil

    --- **Check if trait is nil**
    elseif not trait then
        errHandler.errMsg("CharacterPz.setTraitsPerk_PZ(character, trait)",
                "trait " .. errHandler.err.IS_NULL)
        return nil
    end

    character:getTraits():add(trait)
end

--- **Get all Traits and Perk**
---@param character IsoGameCharacter
---@return List | TraitCollection
--- - IsoGameCharacter : zombie.characters.IsoGameCharacter
--- - TraitCollection : zombie.characters.traits.TraitCollection
function CharacterPz.getTraitsPerk_PZ(character)
    --- **Check if character is nil**
    if not character then
        errHandler.errMsg("CharacterPz.getTraitsPerk_PZ(character)",
                errHandler.err.IS_NULL_CHARACTERS)
        return nil

    --- **Check if character is IsoGameCharacter**
    elseif not dataValidator.isCharacter(character) then
        errHandler.errMsg("CharacterPz.getTraitsPerk_PZ(character)",
                errHandler.err.IS_NOT_CHARACTERS)
        return nil
    end

    return character:getTraits()
end

----- **Get Character Traits**
-- ---@param character IsoGameCharacter
-----@return List | TraitCollection
----- - IsoGameCharacter : zombie.characters.IsoGameCharacter
----- - IsoGameCharacter.CharacterTraits : zombie.characters.IsoGameCharacter.CharacterTraits
--function CharacterPz.getTraits_PZ(character)
--    if not character then
--        return nil
--    end
--
--    return character:getCharacterTraits()
--end

--- **Remove Trait**
---@param character IsoGameCharacter
---@param trait String
--- - IsoGameCharacter : zombie.characters.IsoGameCharacter
--- - TraitCollection.TraitSlot : zombie.characters.traits.TraitCollection.TraitSlot
function CharacterPz.removeTrait_PZ(character, trait)
    --- **Check if character is nil**
    if not character then
        errHandler.errMsg("CharacterPz.removeTrait_PZ(character, trait)",
                errHandler.err.IS_NULL_CHARACTERS)
        return nil

    --- **Check if character is IsoGameCharacter**
    elseif not dataValidator.isCharacter(character) then
        errHandler.errMsg("CharacterPz.removeTrait_PZ(character, trait)",
                errHandler.err.IS_NOT_CHARACTERS)
        return nil

    --- **Check if trait is nil**
    elseif not trait then
        errHandler.errMsg("CharacterPz.removeTrait_PZ(character, trait)",
                "trait " .. errHandler.err.IS_NULL)
        return nil
    end

    -- TODO : add return value
    character:getTraits():remove(trait)
end

--- **Clear all Traits**
---@param character IsoGameCharacter
---@return void
--- - IsoGameCharacter : zombie.characters.IsoGameCharacter
--- - TraitCollection.TraitSlot : zombie.characters.traits.TraitCollection.TraitSlot
function CharacterPz.removeAllTraits_PZ(character)
    --- **Check if character is nil**
    if not character then
        errHandler.errMsg("CharacterPz.removeAllTraits_PZ(character)",
                errHandler.err.IS_NULL_CHARACTERS)
        return nil

    --- **Check if character is IsoGameCharacter**
    elseif not dataValidator.isCharacter(character) then
        errHandler.errMsg("CharacterPz.removeAllTraits_PZ(character)",
                errHandler.err.IS_NOT_CHARACTERS)
        return nil
    end

    character:getTraits():clear()
end

-- TODO : add errHandler
--- **Add Xp Multiplier**
---@param character IsoGameCharacter
---@param perk PerkFactory.Perk
---@param multiplier float The multiplier value to apply to the XP gain of the specified perk.
---@param minLevel int
---@param maxLevel int
---@return void
--- - IsoGameCharacter : zombie.characters.IsoGameCharacter
--- - PerkFactory.Perk : zombie.characters.skills.PerkFactory.Perk
function CharacterPz.addXpMultiplier_PZ(character, perk, multiplier, minLevel, maxLevel)
    --- **Check if character is nil**
    if not character then
        errHandler.errMsg("CharacterPz.addXpMultiplier_PZ(character, perk, multiplier, minLevel, maxLevel)",
                errHandler.err.IS_NULL_CHARACTERS)
        return nil

    --- **Check if character is IsoGameCharacter**
    elseif not dataValidator.isCharacter(character) then
        errHandler.errMsg("CharacterPz.addXpMultiplier_PZ(character, perk, multiplier, minLevel, maxLevel)",
                errHandler.err.IS_NOT_CHARACTERS)
        return nil

    --- **Check if perk is nil**
    elseif not perk then
        errHandler.errMsg("CharacterPz.addXpMultiplier_PZ(character, perk, multiplier, minLevel, maxLevel)",
                errHandler.err.IS_NULL_PERK)
        return nil

    --- **Check if multiplier is nil**
    elseif not multiplier then
        errHandler.errMsg("CharacterPz.addXpMultiplier_PZ(character, perk, multiplier, minLevel, maxLevel)",
                "multiplier " .. errHandler.err.IS_NULL)
        return nil

    --- **Check if minLevel is nil**
    elseif not minLevel then
        errHandler.errMsg("CharacterPz.addXpMultiplier_PZ(character, perk, multiplier, minLevel, maxLevel)",
                "minLevel " .. errHandler.err.IS_NULL)
        return nil

    --- **Check if maxLevel is nil**
    elseif not maxLevel then
        errHandler.errMsg("CharacterPz.addXpMultiplier_PZ(character, perk, multiplier, minLevel, maxLevel)",
                "maxLevel " .. errHandler.err.IS_NULL)
        return nil
    end

    character:getXp():addXpMultiplier(perk, multiplier, minLevel, maxLevel)

    --[[
    The addXpMultiplier() function is a method of the Xp class in the Project Zomboid Lua API.
    It adds a multiplier to the XP gain of a specific perk for a set period of time.

    The parameters of the function are:

    perk (string): The name of the perk to apply the XP multiplier to.
    value1 (float): The multiplier value to apply to the XP gain of the specified perk.
    value2 (int, optional): The number of in-game minutes to apply the multiplier for. If not specified, the multiplier
    will be applied indefinitely until removed.
    value3 (boolean, optional): Whether to override existing multipliers for the specified perk. Defaults to false.
    Here's an example of how to use the function:

    css
    Copy code
    character:getXp():addXpMultiplier("Farming", 2.0, 60, true)
    This would apply a 2x multiplier to the XP gain of the Farming perk for 60 in-game minutes,
    and override any existing multipliers for that perk.
    ]]
end

--- **Get Multiplier**
---@param character IsoGameCharacter
---@param perk PerkFactory.Perk
---@return float
--- - IsoGameCharacter : zombie.characters.IsoGameCharacter
--- - PerkFactory.Perk : zombie.characters.skills.PerkFactory.Perk
function CharacterPz.getMultiplier_PZ(character, perk)
    --- **Check if character is nil**
    if not character then
        errHandler.errMsg("CharacterPz.getMultiplier_PZ(character, perk)",
                errHandler.err.IS_NULL_CHARACTERS)
        return nil

    --- **Check if character is IsoGameCharacter**
    elseif not dataValidator.isCharacter(character) then
        errHandler.errMsg("CharacterPz.getMultiplier_PZ(character, perk)",
                errHandler.err.IS_NOT_CHARACTERS)
        return nil

    --- **Check if perk is nil**
    elseif not perk then
        errHandler.errMsg("CharacterPz.getMultiplier_PZ(character, perk)",
                errHandler.err.IS_NULL_PERK)
        return nil
    end

    return character:getXp():getMultiplier(perk)
end

--- **Remove Multiplier**
---@param character IsoGameCharacter
---@param perk PerkFactory.Perk
---@return void
--- - IsoGameCharacter : zombie.characters.IsoGameCharacter
--- - PerkFactory.Perk : zombie.characters.skills.PerkFactory.Perk
function CharacterPz.removeMultiplier(character, perk)
    --- **Check if character is nil**
    if not character then
        errHandler.errMsg("CharacterPz.removeMultiplier(character, perk)",
                errHandler.err.IS_NULL_CHARACTERS )
        return nil

    --- **Check if character is IsoGameCharacter**
    elseif not dataValidator.isCharacter(character) then
        errHandler.errMsg("CharacterPz.removeMultiplier(character, perk)",
                errHandler.err.IS_NOT_CHARACTERS)
        return nil

    --- **Check if perk is nil**
    elseif not perk then
        errHandler.errMsg("CharacterPz.removeMultiplier(character, perk)",
                errHandler.err.IS_NULL_PERK)
        return nil
    end

    CharacterPz.addXpMultiplier_PZ(character, perk, CharacterPz.EnumNumbers.ZERO,
            CharacterPz.EnumNumbers.ONE, CharacterPz.EnumNumbers.ONE)

end

-- TODO : FIX
--- **Set XP Boost 1 - 75%, 2 - 100%, 3 - 125%, default 0 ?? - 50%**
---@param character IsoGameCharacter
---@param perk PerkFactory.Perk
---@param levelBoost int
---@return void
--- - IsoGameCharacter : zombie.characters.IsoGameCharacter
--- - PerkFactory.Perk : zombie.characters.skills.PerkFactory.Perk
function CharacterPz.setXPBoost(character, perk, levelBoost)
    --- **Check if character is nil**
    if not character then
        errHandler.errMsg("CharacterPz.setXPBoost(character, perk, levelBoost)",
                errHandler.err.IS_NULL_CHARACTERS)
        return nil

    --- **Check if character is IsoGameCharacter**
    elseif not dataValidator.isCharacter(character) then
        errHandler.errMsg("CharacterPz.setXPBoost(character, perk, levelBoost)",
                errHandler.err.IS_NOT_CHARACTERS)
        return nil

    --- **Check if perk is nil**
    elseif not perk then
        errHandler.errMsg("CharacterPz.setXPBoost(character, perk, levelBoost)",
                errHandler.err.IS_NULL_PERK)
        return nil

    --- **Check if levelBoost is nil**
    elseif not levelBoost then
        errHandler.errMsg("CharacterPz.setXPBoost(character, perk, levelBoost)",
                "levelBoost " .. errHandler.err.IS_NULL)
        return nil
    end

    CharacterPz.setPerkBoost_PZ(character, perk, levelBoost)
end

--- **Set XP Boost 1 - 75%, 2 - 100%, 3 - 125%, default 0 ?? - 50%**
---@param character IsoGameCharacter
---@param perk PerkFactory.Perk
---@param levelBoost int
---@return void
--- - IsoGameCharacter : zombie.characters.IsoGameCharacter
--- - PerkFactory.Perk : zombie.characters.skills.PerkFactory.Perk
function CharacterPz.setPerkBoost_PZ(character, perk, levelBoost)
    --- **Check if character is nil**
    if not character then
        errHandler.errMsg("CharacterPz.setPerkBoost_PZ(character, perk, levelBoost)",
                errHandler.err.IS_NULL_CHARACTERS)
        return nil

    --- **Check if character is IsoGameCharacter**
    elseif not dataValidator.isCharacter(character) then
        errHandler.errMsg("CharacterPz.setPerkBoost_PZ(character, perk, levelBoost)",
                errHandler.err.IS_NOT_CHARACTERS)
        return nil

    --- **Check if perk is nil**
    elseif not perk then
        errHandler.errMsg("CharacterPz.setPerkBoost_PZ(character, perk, levelBoost)",
                errHandler.err.IS_NULL_PERK)
        return nil

    --- **Check if levelBoost is nil**
    elseif not levelBoost then
        errHandler.errMsg("CharacterPz.setPerkBoost_PZ(character, perk, levelBoost)",
                "levelBoost " .. errHandler.err.IS_NULL)
        return nil
    end

    character:getXp():setPerkBoost(perk, levelBoost)
end

--- **Get Perk Boost**
---@param character IsoGameCharacter
---@param perk PerkFactory.Perk
---@return int perkBoost
--- - IsoGameCharacter : zombie.characters.IsoGameCharacter
--- - PerkFactory.Perk : zombie.characters.skills.PerkFactory.Perk
function CharacterPz.getXPBoost(character, perk)
    --- **Check if character is nil**
    if not character then
        errHandler.errMsg("CharacterPz.getXPBoost(character, perk)",
                errHandler.err.IS_NULL_CHARACTERS)
        return nil

    --- **Check if character is IsoGameCharacter**
    elseif not dataValidator.isCharacter(character) then
        errHandler.errMsg("CharacterPz.getXPBoost(character, perk)",
                errHandler.err.IS_NOT_CHARACTERS)
        return nil

    --- **Check if perk is nil**
    elseif not perk then
        errHandler.errMsg("CharacterPz.getXPBoost(character, perk)",
                errHandler.err.IS_NULL_PERK)
        return nil
    end

    return CharacterPz.getPerkBoost_PZ(character, perk)
end

--- **Get Perk Boost**
---@param character IsoGameCharacter
---@param perk PerkFactory.Perk
---@return int perkBoost
--- - IsoGameCharacter : zombie.characters.IsoGameCharacter
--- - PerkFactory.Perk : zombie.characters.skills.PerkFactory.Perk
function CharacterPz.getPerkBoost_PZ(character, perk)
    --- **Check if character is nil**
    if not character then
        errHandler.errMsg("CharacterPz.getPerkBoost_PZ(character, perk)",
                errHandler.err.IS_NULL_CHARACTERS)
        return nil

    --- **Check if character is IsoGameCharacter**
    elseif not dataValidator.isCharacter(character) then
        errHandler.errMsg("CharacterPz.getPerkBoost_PZ(character, perk)",
                errHandler.err.IS_NOT_CHARACTERS)
        return nil

    --- **Check if perk is nil**
    elseif not perk then
        errHandler.errMsg("CharacterPz.getPerkBoost_PZ(character, perk)",
                errHandler.err.IS_NULL_PERK)
        return nil
    end

    return character:getXp():getPerkBoost(perk)
end

--- **Remove Perk Boost**
---@param character IsoGameCharacter
---@param perk PerkFactory.Perk
---@return void
--- - IsoGameCharacter : zombie.characters.IsoGameCharacter
--- - PerkFactory.Perk : zombie.characters.skills.PerkFactory.Perk
function CharacterPz.removeXPBoost(character, perk)
    --- **Check if character is nil**
    if not character then
        errHandler.errMsg("CharacterPz.removeXPBoost(character, perk)",
                errHandler.err.IS_NULL_CHARACTERS)
        return nil

    --- **Check if character is IsoGameCharacter**
    elseif not dataValidator.isCharacter(character) then
        errHandler.errMsg("CharacterPz.removeXPBoost(character, perk)",
                errHandler.err.IS_NOT_CHARACTERS)
        return nil

    --- **Check if perk is nil**
    elseif not perk then
        errHandler.errMsg("CharacterPz.removeXPBoost(character, perk)",
                errHandler.err.IS_NULL_PERK)
        return nil
    end

    CharacterPz.removePerkBoost(character, perk)
end

--- **Remove Perk Boost**
---@param character IsoGameCharacter
---@param perk PerkFactory.Perk
---@return void
--- - IsoGameCharacter : zombie.characters.IsoGameCharacter
--- - PerkFactory.Perk : zombie.characters.skills.PerkFactory.Perk
function CharacterPz.removePerkBoost(character, perk)
    --- **Check if character is nil**
    if not character then
        errHandler.errMsg("CharacterPz.removePerkBoost(character, perk)",
                errHandler.err.IS_NULL_CHARACTERS)
        return nil

    --- **Check if character is IsoGameCharacter**
    elseif not dataValidator.isCharacter(character) then
        errHandler.errMsg("CharacterPz.removePerkBoost(character, perk)",
                errHandler.err.IS_NOT_CHARACTERS)
        return nil

    --- **Check if perk is nil**
    elseif not perk then
        errHandler.errMsg("CharacterPz.removePerkBoost(character, perk)",
                errHandler.err.IS_NULL_PERK)
        return nil
    end

    character:getXp():setPerkBoost(perk, CharacterPz.EnumNumbers.ZERO )
end

--- **Add a single Recipe ( wrapper )**
---@param character IsoGameCharacter
---@param recipe string
--- - IsoGameCharacter : zombie.characters.IsoGameCharacter
function CharacterPz.addKnownRecipe(character, recipe)
    --- **Check if character is nil**
    if not character then
        errHandler.errMsg("CharacterPz.addKnownRecipe(character, recipe)",
                errHandler.err.IS_NULL_CHARACTERS)
        return nil

    --- **Check if character is IsoGameCharacter**
    elseif not dataValidator.isCharacter(character) then
        errHandler.errMsg("CharacterPz.addKnownRecipe(character, recipe)",
                errHandler.err.IS_NOT_CHARACTERS)
        return nil

    --- **Check if recipe is nil**
    elseif not recipe then
        errHandler.errMsg("CharacterPz.addKnownRecipe(character, recipe)",
                "recipe " .. errHandler.err.IS_NULL)
        return nil
    end

    -- TODO : add return value
    CharacterPz.learnRecipe_PZ(character, recipe)
end

--- **Get Known Recipes**
---@param character IsoGameCharacter
---@return List
--- - IsoGameCharacter : zombie.characters.IsoGameCharacter
function CharacterPz.getKnownRecipes_PZ(character)
    --- **Check if character is nil**
    if not character then
        errHandler.errMsg("CharacterPz.getKnownRecipes_PZ(character)",
                errHandler.err.IS_NULL_CHARACTERS)
        return nil

    --- **Check if character is IsoGameCharacter**
    elseif not dataValidator.isCharacter(character) then
        errHandler.errMsg("CharacterPz.getKnownRecipes_PZ(character)",
                errHandler.err.IS_NOT_CHARACTERS)
        return nil
    end

    return character:getKnownRecipes()
end

--- **Get remove Known Recipe**
---@param character IsoGameCharacter
---@param recipe string
---@return void
--- - IsoGameCharacter : zombie.characters.IsoGameCharacter
function CharacterPz.removeKnowRecipe_PZ(character, recipe)
    --- **Check if character is nil**
    if not character then
        errHandler.errMsg("CharacterPz.removeKnowRecipe_PZ(character, recipe)",
                errHandler.err.IS_NULL_CHARACTERS)
        return nil

    --- **Check if character is IsoGameCharacter**
    elseif not dataValidator.isCharacter(character) then
        errHandler.errMsg("CharacterPz.removeKnowRecipe_PZ(character, recipe)",
                errHandler.err.IS_NOT_CHARACTERS)
        return nil

    --- **Check if recipe is nil**
    elseif not recipe then
        errHandler.errMsg("CharacterPz.removeKnowRecipe_PZ(character, recipe)",
                "recipe " .. errHandler.err.IS_NULL)
        return nil
    end

    character:getKnownRecipes():remove(recipe)
end

--- **Learn (add) Recipe**
---@param character IsoGameCharacter
---@param recipe string
--- - IsoGameCharacter : zombie.characters.IsoGameCharacter
function CharacterPz.learnRecipe_PZ(character, recipe)
    --- **Check if character is nil**
    if not character then
        errHandler.errMsg("CharacterPz.learnRecipe_PZ(character, recipe)",
                errHandler.err.IS_NULL_CHARACTERS)
        return nil

    --- **Check if character is IsoGameCharacter**
    elseif not dataValidator.isCharacter(character) then
        errHandler.errMsg("CharacterPz.learnRecipe_PZ(character, recipe)",
                errHandler.err.IS_NOT_CHARACTERS)
        return nil

    --- **Check if recipe is nil**
    elseif not recipe then
        errHandler.errMsg("CharacterPz.learnRecipe_PZ(character, recipe)",
                "recipe " .. errHandler.err.IS_NULL)
        return nil
    end

    -- TODO : add return value
    character:learnRecipe(recipe)
end

return CharacterPz