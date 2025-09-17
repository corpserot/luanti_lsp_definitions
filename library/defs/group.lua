---@meta _
-- DRAFT 1 DONE
-- lua_api.md: Groups

-- -------------------------- node and item groups -------------------------- --

--[[
WIPDOC
]]
---@class core.Groups.item : {[string]:integer}, _.Groups.item.__partial

---@class _.Groups.item.__partial
--[[
WIPDOC
]]
---@field not_in_creative_inventory integer?

-- ---------------------------- node-only groups ---------------------------- --

--[[
WIPDOC
]]
---@class core.Groups.node : core.Groups.item, _.Groups.node.__partial

---@class _.Groups.node.__partial
--[[
WIPDOC
]]
---@field attached_node 0|1|2|3|4?
--[[
WIPDOC
]]
---@field bouncy integer?
--[[
WIPDOC
]]
---@field connect_to_raillike integer?
--[[
WIPDOC
]]
---@field dig_immediate 0|1|2|3?
--[[
WIPDOC
]]
---@field disable_jump 0|1?
--[[
WIPDOC
]]
---@field disabled_descend 0|1?
--[[
WIPDOC
]]
---@field fall_damage_add_percent integer?
--[[
WIPDOC
]]
---@field falling_node 0|1?
--[[
WIPDOC
]]
---@field float 0|1?
--[[
WIPDOC
]]
---@field level integer?
--[[
WIPDOC
]]
---@field slippery integer?

-- ---------------------------- tool-only groups ---------------------------- --

--[[
WIPDOC
]]
---@class core.Groups.tool : core.Groups.item, _.Groups.tool.__partial

---@class _.Groups.tool.__partial
--[[
WIPDOC
]]
---@field disable_repair 0|1?


-- ---------------------------- ObjectRef groups ---------------------------- --

--[[
WIPDOC
]]
---@class core.Groups.ObjectRef : {[string]:integer}
--[[
WIPDOC
]]
---@field immortal 0|1?
--[[
WIPDOC
]]
---@field fall_damage_add_percent integer?
--[[
WIPDOC
]]
---@field punch_operable 0|1?