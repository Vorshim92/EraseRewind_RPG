---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by lele.
--- DateTime: 15/04/23 18:54
---

---@class CharacterRecipe

local CharacterRecipe = {}

require("lib/CharacterBaseObj")

local characterLib = require("CharacterLib")
local characterPz = require("lib/CharacterPZ")
local errHandler = require("lib/ErrHandler")
-- local pageBook = require("book/PageBook")
local modDataManager = require("lib/ModDataManager")

--- **Read Recipe From Hd**
---@return CharacterBaseObj getRecipes table string
local function readRecipeFromHd(modData_name)
    local characterKnowRecipe =
        modDataManager.readOrCreate(modData_name.RECIPES)

    local CharacterObj01 = CharacterBaseObj:new()

    -- @param recipe string
    for _, v in pairs(characterKnowRecipe) do
        CharacterObj01:addRecipe(v)
    end

    return CharacterObj01
end

--- **Delete Recipe**
---@param character IsoGameCharacter
--- - IsoGameCharacter : zombie.characters.IsoGameCharacter
local function deleteRecipe(character)

    local characterKnowRecipe = characterLib.getKnownRecipes(character)

    for _, v in pairs(characterKnowRecipe:getRecipes()) do

        -- @param character IsoGameCharacter
        -- @param recipe string
        characterPz.removeKnowRecipe_PZ(character, v)
    end
end

--- **Create Recipe**
---@param character IsoGameCharacter
--- - IsoGameCharacter : zombie.characters.IsoGameCharacter
function CharacterRecipe.readBook(character, modData_name)
    if not character then
        errHandler.errMsg("CharacterRecipe.readBook(character)",
                errHandler.err.IS_NULL_CHARACTERS)
        return nil
    end

    --- **Check if mod-data recipes is exits**
    if not modDataManager.isExists(modData_name.RECIPES) then
        errHandler.errMsg("CharacterRecipe.readBook(character)",
                " mod-data " .. modData_name.RECIPES .. " not exists")
        return nil
    end

    ---@type table
    ---@return CharacterBaseObj getRecipes table string
    local recipesObj = readRecipeFromHd(modData_name)

    deleteRecipe(character)

    for _, v in pairs(recipesObj:getRecipes()) do
        -- @param character IsoGameCharacter
        -- @param recipe string
        characterPz.addKnownRecipe(character, v)
    end
end

--- **Write Recipe To Hd**
---@param character IsoGameCharacter
--- - IsoGameCharacter : zombie.characters.IsoGameCharacter
function CharacterRecipe.writeBook(character, modData_name)
    --- **Check if character is null**
    if not character then
        errHandler.errMsg("CharacterRecipe.writeBook(character)",
                errHandler.err.IS_NULL_CHARACTERS)
        return nil
    end

    --- **Remove Recipes form mod-data**
    -- modDataManager.remove(modData_name.RECIPES)

    -- @type CharacterBaseObj
    local knownRecipesObj =  characterLib.getKnownRecipes(character)

    ---@type table
    local lines = {}

    for _, v in pairs(knownRecipesObj:getRecipes()) do
        -- @param lines table
        -- @param v string
        table.insert(lines, v)
    end

    if modData_name then
        modData_name["RECIPES"] = lines
    end
    lines = {}
end

return CharacterRecipe