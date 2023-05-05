---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by lele.
--- DateTime: 27/03/23 09:38
---

---@class DbgLeleLib

EnumProfession = {
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

--- Not tested, check the names
EnumPerk = {
--    UNEMPLOYED = "",
--    NONE = "none",
--    FITNESS = "Fitness",
--    STRENGTH = "Strength",
--    SPRINTING = "Sprinting",
--    LIGHTFOOT = "Lightfoot",
--    NIMBLE = "Nimble",
--    SNEAK = "Sneak",
--    AXE = "Axe",
--    BLUNT = "Blunt",
--    SMALL_BLUNT = "SmallBlunt",
--    LONG_BLADE = "LongBlade",
--    SMALL_BLADE = "SmallBlade",
--    SPEAR = "Spear",
--    MAINTENANCE = "Maintenance",
--    WOODWORK = "Woodwork",
--    COOKING = "Cooking",
--    FARMING = "Farming",
--    DOCTOR = "Doctor",
--    ELECTRICITY = "Electricity",
--    METAL_WELDING = "MetalWelding",
--    MECHANICS = "Mechanics",
--    TAILORING = "Tailoring",
--    AIMING = "Aiming",
--    RELOADING = "Reloading",
--    FISHING = "Fishing",
--    TRAPPING = "Trapping",
--    PLANT_SCAVENGING = "PlantScavenging"
}

---display
---@param index
---@param perk
---@param level
---@param xp
local function display(displayName, i, perk, level, xp)
    print("DGB\n")
    print(displayName .. " " ..
            tostring(i) .. " >> " ..
            type(perk) .. " " .. tostring(perk) .. " - " ..
            type(level) .. " " .. tostring(level) .. " - " ..
            type(xp) .. " " .. tostring(xp) )
end

---@param displayName string
---@param perk
---@param level
function DBG_displayPerk(displayName, perk, level, xp)
    local dbg1 = perk
    local dbg2 = level
    local dbg3 = xp
    print("--------------------------------")
    display(displayName, nil, perk, level, xp)
    print("--------------------------------")
    local dbg
end

---@param displayName string
---@param perk_ PerkFactory.Perk
---@param perk PerkFactory.Perk
---@param level int
function DBG_GetCheckPerk(displayName, perk_, perk, level )
    -- Perks.Maintenance
    local dbg1
    local dbg2
    local dbg3 = perk
    local dbg4 = perk_
    local dbg5 = level
    if perk_ == perk then
        dbg1 = perk_
        dbg2 = level
        print("--------------------------------")
        display(displayName, nil, perk, level, nil)
        print("--------------------------------")

        local dbg
    end

    local dbg
end

---@param displayName string
---@param table
function DBG_displayListPerks(displayName, perks_list)
    print("--------------------------------")
    for i, v in pairs(perks_list) do
        display(displayName, i, v.perk, v.level, nil)
        -- DBG_GetCheckPerk("DBG_GetCheckPerk", v.perk_, v.perk, _ )
    end
    print("--------------------------------")
end





