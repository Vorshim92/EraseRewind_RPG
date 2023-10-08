---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by lele.
--- DateTime: 27/06/23 10:28
---

---@class PatchSurvivalRewards

local PatchSurvivalRewards = {}

local modDataManager = require("lib/ModDataManager")

local kilMilReached = "kilMilReachedX"
local milReached = "milReachedX"

--- **Read kilMilReached From Hd
local function readKilMilReachedFromHd()
    return modDataManager.read(kilMilReached)
end

--- **Read MilReached From Hd**
local function readMilReachedFromHd()
    return modDataManager.read(milReached)
end

--- **Write kilMilReached From Hd**
---@param character IsoGameCharacter
--- - IsoGameCharacter : zombie.characters.IsoGameCharacter
local function writeKilMilReachedtoFromHd(character)
    modDataManager.save(kilMilReached, character:getModData().milReached )
end

--- **Write milReached From Hd**
---@param character IsoGameCharacter
--- - IsoGameCharacter : zombie.characters.IsoGameCharacter
local function writeMilReachedFromHd(character)
    modDataManager.save(milReached, character:getModData().kilMilReached )
end

--- **Create Mil_kill_Reached**
---@param character IsoGameCharacter
--- - IsoGameCharacter : zombie.characters.IsoGameCharacter
function PatchSurvivalRewards.createMil_kill_Reached(character)
    if not modDataManager.isExists(kilMilReached) then
        return nil
    end

    ---@type table
    local kilMilReaches = readKilMilReachedFromHd()

    for _, v in pairs(kilMilReaches) do
         character:getModData().milReached = toInt(v)
    end

    if not modDataManager.isExists(milReached) then
        return nil
    end

    ---@type table
    local milReaches = readMilReachedFromHd()

    for _, v in pairs(milReaches) do
        character:getModData().kilMilReached = toInt(v)
    end
end

--- **Write Mil_kill_Reached**
---@param character IsoGameCharacter
--- - IsoGameCharacter : zombie.characters.IsoGameCharacter
function PatchSurvivalRewards.writeMil_kill_ReachedToHd(character)
    PatchSurvivalRewards.removeMil_kill_Reached()

    writeKilMilReachedtoFromHd(character)
    writeMilReachedFromHd(character)
end

--- **Remove Mil_kill_Reached**
function PatchSurvivalRewards.removeMil_kill_Reached()
    modDataManager.remove(kilMilReached)
    modDataManager.remove(milReached)
end

--- **Is Mod Active**
---@param nameMod string
---@return boolean
function PatchSurvivalRewards.isModActive()
    -- TODO Il metodo isModActive funziona ma qualcosa nei nella scrittura dei dati non va
    -----@type string
    --local activeMod = "SurvivalRewards"
    --
    -----@type List - string
    --local activeMods = getActivatedMods();
    --
    --for i = 0, activeMods:size() - 1 do
    --    if activeMods:get(i) == activeMod then
    --        return true
    --    end
    --end

    return false
end

return PatchSurvivalRewards