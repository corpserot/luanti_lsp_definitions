---@meta _
-- DRAFT 1 DONE
-- lua_api.md: Ores
-- lua_api.md: Definition tables > Ore Definition

-- ------------------------------ OreDef.__base ----------------------------- --

---@class _.OreDef.__base
--[[
WIPDOC
]]
---@field name string?
--[[
Ore node to place
]]
---@field  ore string
--[[
Param2 to set for ore (e.g. facedir rotation)
]]
---@field ore_param2 integer?
--[[
Node to place ore in. Multiple are possible by passing a list.
]]
---@field  wherein string[]|string
--[[
WIPDOC
]]
---@field y_min number?
--[[
WIPDOC
]]
---@field y_max number?
--[[
List of biomes in which this ore occurs.
Occurs in all biomes if this is omitted, and ignored if the Mapgen
being used does not support biomes.
Can be a list of (or a single) biome names, IDs, or definitions.
]]
---@field biomes string[]|string?

-- --------------------------------- OreDef --------------------------------- --

--[[
WIPDOC
]]
---@alias core.OreDef
--- | core.OreDef.scatter.uniform
--- | core.OreDef.scatter.nonuniform
--- | core.OreDef.sheet
--- | core.OreDef.puff
--- | core.OreDef.blob
--- | core.OreDef.vein
--- | core.OreDef.stratum