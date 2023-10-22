---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by lele.
--- DateTime: 27/03/23 09:38
---

---@class DebugDiagnostics

local DebugDiagnostics = {}
local characterPz = require("lib/CharacterPZ")
local isoPlayerPZ = require("lib/IsoPlayerPZ")
local characterLib = require("CharacterLib")
local perkFactoryPZ = require("lib/PerkFactoryPZ")

-- -----------------------------------------------------------

local results = {
    ---@field int
    passed = 0,
    ---@field int
    notPassed = 0,
    ---@field int
    testVerified = 0
}

---@type string
local test_ = "Test - "

---@type string
local fail_ = " >>>>>>>>>>>>>> FAIL"

---@type string
local ok_ = " >>>>>>>>>>>>>> PASSED"

---@type boolean
local advancedTest

--- **Show more info about test**
---@param advancedTest_ boolean
---
function DebugDiagnostics.setVerbose(advancedTest_)
    advancedTest = advancedTest_
end

--- **PrintTestResult** if **true** test passed, if **false** not passed
---@param nameTest string
---@param flag boolean
---@return void
local function printTestResult(nameTest, flag)
    if (flag) then
        print(test_ .. nameTest .. ok_)
        return
    end

    print(test_ .. nameTest .. fail_)
end

--- **Show all Result**
---@param expectedValue
---@param currentValue
---@param nameTest string
---@return boolean
function DebugDiagnostics.showAllResult(expectedValue, currentValue, nameTest)
    if expectedValue == currentValue then
        printTestResult(nameTest, true)
        return true
    end

    printTestResult(nameTest, false)
    return false
end

--- **Show Only False Results**
---@param expectedValue
---@param currentValue
---@param nameTest string
---@return boolean
function DebugDiagnostics.showOnlyFalseResult(expectedValue, currentValue, nameTest)
    if expectedValue ~= currentValue then
        DebugDiagnostics.showAllResult(expectedValue, currentValue, nameTest)
        return false
    end

    return true
end

--- **Unit Lua, check methods**
---@param expectedValue
---@param currentValue
---@param nameTest string
---@return void
function DebugDiagnostics.checkTest(expectedValue, currentValue, nameTest)
    results.testVerified = results.testVerified + 1

    if advancedTest then
        if DebugDiagnostics.showAllResult(expectedValue, currentValue, nameTest) then
            results.passed = results.passed + 1
        else
            results.notPassed = results.notPassed + 1
        end
    else
        if DebugDiagnostics.showOnlyFalseResult(expectedValue, currentValue, nameTest) then
            results.passed = results.passed + 1
        else
            results.notPassed = results.notPassed + 1
        end
    end
end

--- **Show all method tested**
---@return void
function DebugDiagnostics.displayTest()
    DebugDiagnostics.printLine()
    print("------------------CHECK TEST------------------")
    print("TEST VERIFIED: >>>>>>>> ", results.testVerified .. " of " .. (results.passed + results.notPassed))
    print("PASSED: >>>>>>>>>>>>>>> ", results.passed)
    print("NOT PASSED:  >>>>>>>>>> ", results.notPassed)

    results.testVerified = 0
    results.passed = 0
    results.notPassed = 0
    DebugDiagnostics.printLine()
end

--- **Get Profession ENUM**
---@return string
DebugDiagnostics.Profession = {
    UNEMPLOYED = "",
    BURGER_FLIPPER = "burgerflipper",
    BURGLAR = "burglar",
    CARPENTER = "carpenter",
    CHEF = "chef",
    CONSTRUCTION_WORKER = "constructionworker",
    DOCTOR = "doctor",
    ELECTRICIAN = "electrician",
    ENGINEER = "engineer",
    FARMER = "farmer",
    FISHERMAN = "fisherman",
    FIRE_OFFICER = "fireofficer",
    FITNESS_INSTRUCTOR = "fitnessInstructor",
    LUMBERJACK = "lumberjack",
    MECHANICS = "mechanics",
    METAL_WORKER = "metalworker",
    NURSE = "nurse",
    PARK_RANGER = "parkranger",
    POLICE_OFFICER = "policeofficer",
    REPAIRMAN = "repairman",
    SECURITY_GUARD = "securityguard",
    VETERAN = "veteran"
}

--- **Get Perk ENUM**
---@return PerkFactory.Perk perk
--- - PerkFactory.Perk : zombie.characters.skills.PerkFactory.Perk
DebugDiagnostics.Perks = {
    ---@type PerkFactory.Perk
    AGILITY = Perks.Agility,
    ---@type PerkFactory.Perk
    AIMING = Perks.Aiming,
    ---@type PerkFactory.Perk
    AXE = Perks.Axe,
    ---@type PerkFactory.Perk
    BLACKSMITH = Perks.Blacksmith,
    ---@type PerkFactory.Perk
    COMBAT = Perks.Combat,
    ---@type PerkFactory.Perk
    COOKING = Perks.Cooking,
    ---@type PerkFactory.Perk
    CRAFTING = Perks.Crafting,
    ---@type PerkFactory.Perk
    DOCTOR = Perks.Doctor,
    ---@type PerkFactory.Perk
    ELECTRICITY = Perks.Electricity,
    ---@type PerkFactory.Perk
    FARMING = Perks.Farming,
    ---@type PerkFactory.Perk
    FIREARM = Perks.Firearm,
    ---@type PerkFactory.Perk
    FISHING = Perks.Fishing,
    ---@type PerkFactory.Perk
    FITNESS = Perks.Fitness,
    ---@type PerkFactory.Perk
    LIGHTFOOT = Perks.Lightfoot,
    ---@type PerkFactory.Perk
    LONGBLADE = Perks.LongBlade,
    ---@type PerkFactory.Perk
    LONGBLUNT = Perks.Blunt,
    ---@type PerkFactory.Perk
    MAINTENANCE = Perks.Maintenance,
    ---@type PerkFactory.Perk
    MECHANICS = Perks.Mechanics,
    ---@type PerkFactory.Perk
    MELEE = Perks.Melee,
    ---@type PerkFactory.Perk
    MELTING = Perks.Melting,
    ---@type PerkFactory.Perk
    METALWELDING = Perks.MetalWelding,
    ---@type PerkFactory.Perk
    NIMBLE = Perks.Nimble,
    ---@type PerkFactory.Perk
    NONE = Perks.None,
    ---@type PerkFactory.Perk
    PASSIV = Perks.Passiv,
    ---@type PerkFactory.Perk
    PLANTSCAVENGING = Perks.PlantScavenging,
    ---@type PerkFactory.Perk
    RELOADING = Perks.Reloading,
    ---@type PerkFactory.Perk
    SMALLBLADE = Perks.SmallBlade,
    ---@type PerkFactory.Perk
    SMALLBLUNT = Perks.SmallBlunt,
    ---@type PerkFactory.Perk
    SNEAK = Perks.Sneak,
    ---@type PerkFactory.Perk
    SPEAR = Perks.Spear,
    ---@type PerkFactory.Perk
    SPRINTING = Perks.Sprinting,
    ---@type PerkFactory.Perk
    STRENGTH = Perks.Strength,
    ---@type PerkFactory.Perk
    SURVIVALIST = Perks.Survivalist,
    ---@type PerkFactory.Perk
    TAILORING = Perks.Tailoring,
    ---@type PerkFactory.Perk
    TRAPPING = Perks.Trapping,
    ---@type PerkFactory.Perk
    WOODWORK = Perks.Woodwork,
}

--- **Create a line**
---@return void
function DebugDiagnostics.printLine()
    print("---------------------------------------------------------------------")
end

--- **Set Perk Level**
---@param character IsoGameCharacter
---@param perk PerkFactory.Perk
---@param level int
---@return void
--- - IsoGameCharacter : zombie.characters.IsoGameCharacter
--- - PerkFactory.Perk : zombie.characters.skills.PerkFactory.Perk
--- - IsoGameCharacter.XP : zombie.characters.IsoGameCharacter.XP
function DebugDiagnostics.setPerkLevel(character, perk, level)
    characterPz.removePerkLevel(character, perk)

    local convertLevelToXp = 0.0

    for level_ = 1, level do
        convertLevelToXp = convertLevelToXp +
                perkFactoryPZ.convertLevelToXp(perk, level_)
    end

    characterPz.addXP_PZ(character, perk, convertLevelToXp, false, false, true)
end

--- **Display**
---@param displayName
---@param i
---@param perk
---@param level
---@param xp
---@return void
function DebugDiagnostics.display(displayName, i, perk, level, xp)
    local dbg1 = perk
    local dbg2 = level
    local dbg3 = xp
    print(displayName .. " " ..
        tostring(i) .. " >> " .. tostring(perk) .. " - " ..
        tostring(level) .. " - " .. tostring(xp) )
    local dbg
end

--- **Display Advanced**
---@param displayName
---@param i
---@param perk
---@param level
---@param xp
---@return void
function DebugDiagnostics.displayAdvanced(displayName, i, perk, level, xp)
    local dbg1 = perk
    local dbg2 = level
    local dbg3 = xp

    print(displayName .. " " ..
        tostring(i) .. " >> " ..
        type(perk) .. " " .. tostring(perk) .. " - " ..
        type(level) .. " " .. tostring(level) .. " - " ..
        type(xp) .. " " .. tostring(xp) )
    local dbg
end

--- **Check Perk**
---@param displayName string
---@param perk_ PerkFactory.Perk
---@param perk PerkFactory.Perk
---@return void
--- - PerkFactory.Perk : zombie.characters.skills.PerkFactory.Perk
function DebugDiagnostics.checkPerk(displayName, perk, perk_ )
    -- Perks.Maintenance
    local dbg1 = perk
    local dbg2 = perk_

    if perk == perk_ then
        DebugDiagnostics.printLine()
        DebugDiagnostics.display(displayName, nil, perk, perk_, nil)
        DebugDiagnostics.printLine()
        local dbg
    end
end

--- **Display CharacterObj**
---@param displayName string
---@param CharacterBaseObj CharacterBaseObj
---@return void
function DebugDiagnostics.displayCharacterObj(displayName, CharacterBaseObj)
    DebugDiagnostics.printLine()
    for i, v in pairs(CharacterBaseObj) do
        DebugDiagnostics.display(displayName, i,
                v:getPerk(), v:getLevel(), v:getXp())
        --DbgLeleLib.displayAdvanced(displayName, i,
        --        v:getPerk(), v:getLevel(), v:getXp())
    end
    DebugDiagnostics.printLine()
end

--- **displayListPerks**
---@param displayName string
---@param perks_list
---@return void
function DebugDiagnostics.displayListPerks(displayName, perks_list)
    DebugDiagnostics.printLine()
    for i, v in pairs(perks_list) do
        DebugDiagnostics.display(displayName, i, v.perk, v.level, nil)
        -- DbgLeleLib.displayAdvanced(displayName, i, v.perk, v.level, nil)
        -- DBG_GetCheckPerk("DBG_GetCheckPerk", v.perk_, v.perk, _ )
    end
    DebugDiagnostics.printLine()
end

--- **Times Count**
---@param count int
---@param count2 int
---@return boolean
function DebugDiagnostics.timesCount(count, count2)
    if count == count2 then
        return true
    end

    return false
end

--- **Delete Character**
---@return void
function DebugDiagnostics.deleteCharacter()
    local character = DebugDiagnostics.characterUpdate()
    local zero = 0.0
    local CharacterDeleteObj = CharacterBaseObj:new()

    -- remove all Perk Boosts
    CharacterDeleteObj = characterLib.getAllPerks(character)

    for _, v in pairs(CharacterDeleteObj:getPerkDetails()) do
        characterPz.removePerkBoost(character, v:getPerk())
    end

    -- remove Zombie Kills
    characterPz.setZombieKills_PZ(character, characterPz.EnumNumbers.ZERO)

    -- remove Hours Survived
    isoPlayerPZ.setHoursSurvived_PZ(zero)

    -- remove Multiplier
    for _, v in pairs(CharacterDeleteObj:getPerkDetails()) do
        characterPz.removeMultiplier(character, v:getPerk())
    end

    -- remove Calories
    isoPlayerPZ.setCalories_PZ(zero)

    -- remove Weight
    isoPlayerPZ.setWeight_PZ(zero)

    -- remove Perk Level
    for _, v in pairs(CharacterDeleteObj:getPerkDetails()) do
        characterPz.removePerkLevel(character, v:getPerk())
    end

    -- remove Profession
    characterPz.removeProfession(character)

    -- remove Know Recipe
    CharacterDeleteObj = characterLib.getKnownRecipes(character)

    for _, v in pairs(CharacterDeleteObj:getRecipes()) do
        characterPz.removeKnowRecipe_PZ(character, v)
    end

    -- remove All Traits
    characterPz.removeAllTraits_PZ(character)

    character = DebugDiagnostics.characterUpdate()
end

--- **Create Character**
---@return void
--- - IsoGameCharacter : zombie.characters.IsoGameCharacter
--- - PerkFactory.Perk : zombie.characters.skills.PerkFactory.Perk
--- - IsoGameCharacter.XP : zombie.characters.IsoGameCharacter.XP
function DebugDiagnostics.createCharacter()
    local character = DebugDiagnostics.characterUpdate()

    -- set profession
    characterPz.setProfession_PZ(character, DebugDiagnostics.Profession.CARPENTER)

    -- set level
    characterPz.setPerkLevelFromXp(character, Perks.Fitness, 37500)
    characterPz.setPerkLevelFromXp(character, Perks.Strength, 37500)
    characterPz.setPerkLevelFromXp(character, Perks.Woodwork, 1275)
    characterPz.setPerkLevelFromXp(character, Perks.Maintenance, 75)
    characterPz.setPerkLevelFromXp(character, Perks.SmallBlunt, 75)

    -- set boost
    characterPz.setPerkBoost_PZ(character, Perks.Fitness, 3)
    characterPz.setPerkBoost_PZ(character, Perks.Strength, 3)
    characterPz.setPerkBoost_PZ(character, Perks.Woodwork, 3)

    -- set trait
    characterPz.setTraitsPerk_PZ(character,"HardOfHearing" )
    characterPz.setTraitsPerk_PZ(character,"SlowReader" )
    characterPz.setTraitsPerk_PZ(character,"Handy" )

    -- set zombie kills
    characterPz.setZombieKills_PZ(character, 15)

    -- set multiplier
    characterPz.addXpMultiplier_PZ(character, Perks.Cooking, 1.0,
            characterPz.EnumNumbers.ONE, characterPz.EnumNumbers.ONE)

    -- set recipe
    local recipe = "Make Pizza"
    characterPz.addKnownRecipe(character, recipe)

    -- set Hours Survived
    isoPlayerPZ.setHoursSurvived_PZ(10)

    -- set Calories
    isoPlayerPZ.setCalories_PZ(1500)

    -- set Weight
    isoPlayerPZ.setWeight_PZ(92)

    character = DebugDiagnostics.characterUpdate()
end

--- **Create basic Character**
---@return void
--- - IsoGameCharacter : zombie.characters.IsoGameCharacter
--- - PerkFactory.Perk : zombie.characters.skills.PerkFactory.Perk
function DebugDiagnostics.createBasicCharacter()
    local character = DebugDiagnostics.characterUpdate()
    characterPz.setPerkLevelFromXp(character, Perks.Fitness, 37500)
    characterPz.setPerkLevelFromXp(character, Perks.Strength, 37500)
    isoPlayerPZ.setWeight_PZ(85.0)
end

--- **Update all the characteristics of the character**
function DebugDiagnostics.characterUpdate()
    return getPlayer()
end

return DebugDiagnostics



