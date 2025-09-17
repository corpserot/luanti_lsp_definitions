---@meta _
-- DRAFT 1 DONE
-- lua_api.md: Tool Capabilities

-- -------------------------- ToolCapabilities.item ------------------------- --

--[[
WIPDOC
]]
---@class core.ToolCapabilities.item
--[[
WIPDOC
]]
---@field full_punch_interval number?
--[[
WIPDOC
]]
---@field max_drop_level integer?
--[[
WIPDOC
]]
---@field maxlevel integer?
--[[
WIPDOC
]]
---@field times table<integer,number>?
--[[
WIPDOC
]]
---@field groupcaps table<string, {times:number[]?, uses:number?, maxlevel:number?}>?
--[[
WIPDOC
]]
---@field damage_groups core.Groups.ObjectRef?

-- -------------------------- ToolCapabilities.tool ------------------------- --

--[[
WIPDOC
]]
---@class core.ToolCapabilities.tool : core.ToolCapabilities.item
--[[
WIPDOC
]]
---@field uses integer?
--[[
Amount of uses this tool has for attacking players and entities
by punching them (0 = infinite uses).
For compatibility, this is automatically set from the first
suitable groupcap using the formula "uses * 3^(maxlevel - 1)".
It is recommend to set this explicitly instead of relying on the
fallback behavior.
]]
---@field punch_attack_uses integer?

-- ---------------------------- ToolCapabilities ---------------------------- --

--[[
WIPDOC
]]
---@alias core.ToolCapabilities
--- | core.ToolCapabilities.item
--- | core.ToolCapabilities.tool