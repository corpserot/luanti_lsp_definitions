---@meta _
-- DRAFT 1 DONE
-- lua_api.md: HUD
-- lua_api.md: Definition tables > HUD Definition

-- ---------------------------------- HUDID --------------------------------- --

--[[
WIPDOC
]]
---@class core.HUDID : integer

-- ------------------------------ HUDDef.__base ----------------------------- --

---@class _.HUDDef.__base
--[[
WIPDOC
]]
---@field  type "image"
--[[
WIPDOC
]]
---@field  name string
--[[
WIPDOC
]]
---@field offset vec2i.xy?
--[[
WIPDOC
]]
---@field  z_index number

-- ----------------------------- HUDDef partials ---------------------------- --

---@class _.HUDDef.position
--[[
Top left corner position of element
]]
---@field position vec2.xy

---@class _.HUDDef.direction
--[[
WIPDOC
]]
---@field direction 0|1|2|3?

---@class _.HUDDef.alignment
--[[
WIPDOC
]]
---@field alignment vec2.xy?

---@class _.HUDDef.world_pos
--[[
WIPDOC
]]
---@field world_pos vec3.xyz?

-- --------------------------------- HUDDef --------------------------------- --

--[[
WIPDOC
]]
---@alias core.HUDDef
--- | core.HUDDef.image
--- | core.HUDDef.text
--- | core.HUDDef.statbar
--- | core.HUDDef.inventory
--- | core.HUDDef.hotbar
--- | core.HUDDef.waypoint
--- | core.HUDDef.image_waypoint
--- | core.HUDDef.compass
--- | core.HUDDef.minimap