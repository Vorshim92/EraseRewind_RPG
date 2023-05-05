---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by lele.
--- DateTime: 15/04/23 18:54
---
require("media.lua.client.EnumModData")

---Read Trait From Hd
---@return table
local function readTraitFromHd()
    local values = {}
    values = ModData.get(EnumModData.CHARACTER_TRAITS)

   return values
end

---Create Trait
---@param character IsoGameCharacter
--- - zombie.characters.IsoGameCharacter
function createTrait(character)
    if not modDataIsExist(EnumModData.CHARACTER_TRAITS) then
        return nil
    end

    local trait = {}
    trait = readTraitFromHd(character)

    if not trait then
        return nil
    end

    removeAllTraits_PZ(character)

    for _, v in pairs(trait) do
        setTrait_PZ(character, v)
    end
end

---Write Trait To Hd
---@param character IsoGameCharacter
--- - zombie.characters.IsoGameCharacter
function writeTraitToHd(character)
    ModData.remove(EnumModData.CHARACTER_TRAITS)

    local trait = CharacterObj:new()
    trait = getCharacterTraitsPerk(character)

    modDataInsertMultipleValue(EnumModData.CHARACTER_TRAITS, trait:getTraits())
end