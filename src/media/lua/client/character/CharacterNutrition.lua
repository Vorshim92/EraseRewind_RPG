---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by lele.
--- DateTime: 24/04/23 09:17
---

---@class CharacterNutrition

local CharacterNutrition = {}

local errHandler = require("lib/ErrHandler")
local isoPlayerPZ = require("lib/IsoPlayerPZ")
-- local pageBook = require("book/PageBook")
local modDataManager = require("lib/ModDataManager")

local convertToTable = {}

--- **Read Weight From Hd**
---@return table double
local function readWeightFromHd(modData_name)
    return modDataManager.read(modData_name.WEIGHT)
end

--- **Read Calories From Hd**
---@return table float
local function readCaloriesFromHd(modData_name)
    return modDataManager.read(modData_name.CALORIES)
end

--- **Write Weight From Hd**
local function writeWeightFromHd(modData_name)
    table.insert(convertToTable, isoPlayerPZ.getWeight_PZ())

    --- **Save Weight in mod-data**
    modDataManager.save(modData_name.WEIGHT,convertToTable )
    convertToTable = {}
end

    --- **Write Calories From Hd**
local function writeCaloriesFromHd(modData_name)
    table.insert(convertToTable, isoPlayerPZ.getCalories_PZ())

    --- **Save Calories to mod-data**
    modDataManager.save(modData_name.CALORIES, convertToTable)
    convertToTable = {}
end

--- **Create Character Nutrition**
function CharacterNutrition.readBook(modData_name)
    --- **Check if mod-data weight is exits**
    if not modDataManager.isExists(modData_name.WEIGHT) then
        errHandler.errMsg("CharacterNutrition.readBook()",
                " mod-data " .. modData_name.WEIGHT .. " not exists")
        return nil
    end

    ---@type table
    ---@return table double ( weight )
    local weight = readWeightFromHd(modData_name)

    isoPlayerPZ.setWeight_PZ(weight[1])

    --- **Check if mod-data calories is exits**
    if not modDataManager.isExists(modData_name.CALORIES) then
        errHandler.errMsg("CharacterNutrition.readBook()",
                " mod-data " .. modData_name.CALORIES .. " not exists")
        return nil
    end

    ---@type table
    ---@return table float ( calories )
    local calories = readCaloriesFromHd(modData_name)

    isoPlayerPZ.setCalories_PZ(calories[1])
end

--- **Write Character Nutrition**
function CharacterNutrition.writeBook(modData_name)
    --- **Remove Weight and Calories form mod-data**
    modDataManager.remove(modData_name.WEIGHT)
    modDataManager.remove(modData_name.CALORIES)

    writeWeightFromHd(modData_name)
    writeCaloriesFromHd(modData_name)
end

return CharacterNutrition