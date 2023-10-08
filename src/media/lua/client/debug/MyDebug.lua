---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by lele.
--- DateTime: 27/06/23 11:33
---

local characterLifeTime = require("CharacterLifeTime")
local characterBoost = require("CharacterBoost")
local debugDiagnostics = require("lib/DebugDiagnostics")
local modDataManager = require("lib/ModDataManager")
local characterPz = require("lib/CharacterPZ")
local perkFactoryPZPz = require("lib/PerkFactoryPZ")
local isoPlayerPZ = require("lib/IsoPlayerPZ")
local characterLib = require("CharacterLib")
local dataValidator = require("lib/DataValidator")


-- project zomboid, get mods activeMods

--- **Is Mod Active**
---@param nameMod string
local function isModActive(nameMod)
    --
    local actmods = getActivatedMods();

    for i=0, actmods:size(), 1 do
        if actmods:get(i) == "nameMod" then
            return true
        end
    end

    return false
end

---@param character IsoGameCharacter
local function key34(character, key)
    if key == 34 then -- <<<< g
        print("Key = g > CharacterBoost \n")

        local activeMods = getActivatedMods();

        for i = 0, activeMods:size() - 1 do
            print("Mod Active: " .. activeMods:get(i) .. "\n")
        end
        --
        --for i = 0, activeMods:size(), 1 do
        --    if activeMods:get(i) == activeMod then
        --        print("Mod Active: " .. activeMod .. "\n")
        --        return true
        --    end
        --end


    end
end

---@param character IsoGameCharacter
local function key35(character, key)
    if key == 35 then -- <<< h
        print("Key = h > checkTest  \n")

    end
end

---@param character IsoGameCharacter
local function key36(character, key)
    if key == 36 then -- <<<< j
        print("Key = j >  \n")

    end
end

---@param character IsoGameCharacter
local function key37(character, key)
    if key == 37 then -- <<<< k
        print("Key = k >  \n")

    end
end

---@param character IsoGameCharacter
local function key16(character, key)
    if key == 16 then -- <<<< q
        print("Key = q > kill Character \n")
        character:die()
    end
end

---@param character IsoGameCharacter
local function key17(character, key)
    if key == 17 then -- <<<< w
        print("Key = w >   \n")

    end
end

---@param character IsoGameCharacter
local function key18(character, key)
    if key == 18 then -- <<<< e
        print("Key = e >  \n")

    end
end

local function onCustomUIKeyPressed(key)
    local character = getPlayer()

    key16(character, key) -- q kill character
    key17(character, key) -- w
    key18(character, key) -- e
    key34(character, key) -- g
    key35(character, key) -- h
    key36(character, key) -- j
    key37(character, key) -- k
end

--Events.OnCustomUIKeyPressed.Add(onCustomUIKeyPressed)
