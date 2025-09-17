---@meta _
-- DRAFT 1 DONE
-- lua_api.md: HUD
-- lua_api.md: Definition tables > HUD Definition

-- TODO further split this based on direction value

--[[
WIPDOC
]]
---@class core.HUDDef.compass : _.HUDDef.__base, _.HUDDef.position, _.HUDDef.alignment
--[[
WIPDOC
]]
---@field  type "compass"
--[[
* `direction`: How the image is rotated/translated:
  * 0 - Rotate as heading direction
  * 1 - Rotate in reverse direction
  * 2 - Translate as landscape direction
  * 3 - Translate in reverse direction

If translation is chosen, texture is repeated horizontally to fill the whole element.
]]
---@field direction 0|1|2|3?
--[[
WIPDOC
]]
---@field scale vec2.xy?
--[[
WIPDOC
]]
---@field text string
--[[
WIPDOC
]]
---@field size vec2.xy
