---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by lele.
--- DateTime: 15/04/23 18:54
---

local modDataX = require("lib/ModDataX")
local characterPz = require("lib/CharacterPZ")

require("EnumModData")

---Read Zombies Killed From Hd
---@return int
local function readZombieKillsFromHd()
    return modDataX.readModata(EnumModData.CHARACTER_ZOMBIE_KILLS)
end

---Create Zombies Kills
---@param character IsoGameCharacter
--- - zombie.characters.IsoGameCharacter
function createZombieKills(character)
    if not modDataX.isExists(EnumModData.CHARACTER_ZOMBIE_KILLS) then
        return nil
    end

    local zombieKills = {}
    zombieKills = readZombieKillsFromHd()

    for i, v in pairs(zombieKills) do
        characterPz.setZombieKills_PZ(character, v)
    end

end

---Write Zombies Kills To Hd
---@param character IsoGameCharacter
--- - zombie.characters.IsoGameCharacter
function writeZombieKillsToHd(character)
    modDataX.remove(EnumModData.CHARACTER_ZOMBIE_KILLS)

    modDataX.saveModata(EnumModData.CHARACTER_ZOMBIE_KILLS,
            characterPz.getZombieKills_PZ(character) )
end