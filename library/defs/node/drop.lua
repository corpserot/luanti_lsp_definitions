---@meta _
-- DRAFT 1 DONE
-- lua_api.md: Nodes
-- lua_api.md: Definition tables > Node definition

-- --------------------- NodeDef.drop.items.tool_groups --------------------- --

--[[
WIPDOC
]]
---@class core.NodeDef.drop.item.tool_groups : {[integer]:string|{[integer]:string}}

-- --------------------------- NodeDef.drop.items --------------------------- --

--[[
WIPDOC
]]
---@class core.NodeDef.drop.item
--[[
WIPDOC
]]
---@field rarity integer?
--[[
WIPDOC
]]
---@field items string[]?
--[[
WIPDOC
]]
---@field tools string[]?
--[[
WIPDOC
]]
---@field tool_groups core.NodeDef.drop.item.tool_groups?
--[[
WIPDOC
]]
---@field inherit_color boolean?

-- ------------------------------ NodeDef.drop ------------------------------ --

--[[
WIPDOC
]]
---@class core.NodeDef.drop.tablefmt
--[[
WIPDOC
]]
---@field max_items integer?
--[[
WIPDOC
]]
---@field items integer?

--[[
WIPDOC
]]
---@class core.NodeDef.drop.stringfmt : string

--[[
WIPDOC
]]
---@alias core.NodeDef.drop
--- | core.NodeDef.drop.tablefmt
--- | core.NodeDef.drop.stringfmt

-- ----------------------------- NodeDef fields ----------------------------- --

---@class core.NodeDef
--[[
WIPDOC
]]
---@field drop core.NodeDef.drop
