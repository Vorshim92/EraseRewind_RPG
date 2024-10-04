---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by lele.
--- DateTime: 30/09/23 19:22
---

--- LAST UPDATE 05-09-2023

-- PATCH SKILL LIMITER
local isSkillLimiter = false
local characterSkillLimit = {}
if getActivatedMods():contains("SkillLimiter_fix") then
    isSkillLimiter = true
    characterSkillLimit = require("patch/skillLimiter/CharacterSkillLimit")
end
local isEraseBKP = false
local playerBKP = {}
if getActivatedMods():contains("Erase&Rewind_BKP") then
    isEraseBKP = true
end


---@class CharacterManagement

local CharacterManagement = {}

local characterBoost = require("character/CharacterBoost")
local characterKilledZombies = require("character/CharacterKilledZombies")
local characterLifeTime = require("character/CharacterLifeTime")
local characterMultiplier = require("character/CharacterMultiplier")
local characterNutrition = require("character/CharacterNutrition")
local characterPerkDetails = require("character/CharacterPerkDetails")
local characterRecipe = require("character/CharacterRecipe")
local characterTrait = require("character/CharacterTrait")
local errHandler = require("lib/ErrHandler")
local pageBook = require("book/PageBook")
local modDataManager = require("lib/ModDataManager")
local patchSurvivalRewards = require("patch/survivalRewards/PatchSurvivalRewards")

local ModDataKey = "Erase_Rewind"

-- Function to request backup data from the server
function CharacterManagement.requestBackupData(tableName)
    sendClientCommand(getPlayer(),"Vorshim", "requestData", { tableName = tableName })
end

--- **Remove all Mod Data**
---@return void
function CharacterManagement.removeAllModData(modData_table)
    --- **Remove ModData**
    -- Rimuovi tutti i dati associati alle chiavi specifiche del libro
    local temp = modDataManager.readOrCreate(ModDataKey)
    if temp[modData_table] ~= nil then
        temp[modData_table] = nil
    end
    if modData_table == pageBook.TimedBook then
        modDataManager.remove(pageBook.TIMED_BOOK)
    elseif modData_table == pageBook.ReadOnceBook then
        modDataManager.remove(pageBook.READ_ONCE_BOOK)
    end

    modDataManager.save(ModDataKey, temp)
    --------------------------
end




--- **Read Book**
---@param character IsoGameCharacter
---@return void
--- - IsoGameCharacter : zombie.characters.IsoGameCharacter
function CharacterManagement.readBook(character, modData_table)
    --- **Check if character is null**
    if not character then
        errHandler.errMsg("CharacterManagement.readBook(character)",
                errHandler.err.IS_NULL_CHARACTERS)
        return nil
    end

    --- **Check if modData_table is exists**
    if not modData_table then
        errHandler.errMsg("CharacterManagement.readBook(character)",
                " modData_table is not exists")
        return nil
    end

    characterTrait.readBook(character, modData_table)
    -- PATCH SKILL LIMITER
    if isSkillLimiter then
        characterSkillLimit.readBook(modData_table)
    end
    characterPerkDetails.readBook(character, modData_table)
    characterKilledZombies.readBook(character, modData_table)
    characterLifeTime.readBook(modData_table)
    characterNutrition.readBook(modData_table)
    characterRecipe.readBook(character, modData_table)
    characterBoost.readBook(character, modData_table)
    characterMultiplier.readBook(character, modData_table)

    ------- PATCH ------------
    --- survivalRewards 2797671069
    --- https://steamcommunity.com/sharedfiles/filedetails/?id=2797671069&searchtext=2797671069

    if patchSurvivalRewards.isModActive() then
        patchSurvivalRewards.createMil_kill_Reached(character, modData_table)
    end
    --------------------------

    -- CharacterManagement.removeAllModData(modData_table)
end


--- **Write Book**
---@param character IsoGameCharacter
---@param modData_table table
---@return void
--- - IsoGameCharacter : zombie.characters.IsoGameCharacter
function CharacterManagement.writeBook(character, modData_table, modData_name)
    --- **Check if character is null**
    if not character then
        errHandler.errMsg("CharacterManagement.writeBook(character)",
                errHandler.err.IS_NULL_CHARACTERS)
        return nil
    end

    --- **Check if modData_name is exists**
    if not modData_table then
        errHandler.errMsg("CharacterManagement.writeBook(character)",
                " modData_table is not exists")
        return nil
    end

    if not modData_name then
        errHandler.errMsg("CharacterManagement.writeBook(character)",
                " modData_name is not exists")
    end
    
    
    
    characterPerkDetails.writeBook(character, modData_table)
    characterKilledZombies.writeBook(character, modData_table)
    characterLifeTime.writeBook(modData_table)
    characterNutrition.writeBook(modData_table)
    characterTrait.writeBook(character, modData_table)

    -- PATCH SKILL LIMITER
    if isSkillLimiter then
        characterSkillLimit.writeBook(modData_table)
    end
    characterRecipe.writeBook(character, modData_table)
    characterBoost.writeBook(character, modData_table)
    characterMultiplier.writeBook(character, modData_table)

    ------- PATCH ------------
    --- survivalRewards 2797671069
    --- https://steamcommunity.com/sharedfiles/filedetails/?id=2797671069&searchtext=2797671069

    if patchSurvivalRewards.isModActive() then
        patchSurvivalRewards.writeMil_kill_ReachedToHd(character, modData_table)
    end

    local temp = modDataManager.readOrCreate(ModDataKey)
    temp[modData_name] = modData_table
    
    ---------------------------
    ---SEND BACKUP TO SERVER---
    
    -- local backup = prepareBkpServer(modData_table)
    local bookType = ""
    if modData_name == "ReadOnceBook" then
        bookType = "READ_ONCE_BOOK"
    elseif modData_name == "TimedBook" then
        bookType = "TIMED_BOOK"
    end
    if isEraseBKP then
        if modData_name == "BKP_1" then
            bookType = "BKP_MOD_1"
        elseif modData_name == "BKP_2" then
            bookType = "BKP_MOD_2"
        end
    end
    
    if isClient() then
        local backup = {}
        backup[modData_name] = modData_table -- BKP_1, BKP_2, ReadOnceBook, TimedBook
        sendClientCommand(getPlayer(), "Vorshim", "saveBackup", { backup = backup, bookType = bookType })
        print("[Commands.saveBackup] Backup per PlayerBKP_" .. character:getUsername() .. "_" .. modData_name .. "  inviato con successo!")
        -- poiché client (modalità multiplayer) non vogliamo che il client abbia una versione in locale
        modDataManager.remove(ModDataKey)
    else
        print("[Commands.saveBackup] Nessun backup da inviare al server")
        modDataManager.save(ModDataKey, temp)
        print("Dati salvati correttamente in locale")
    end
    
end




return CharacterManagement