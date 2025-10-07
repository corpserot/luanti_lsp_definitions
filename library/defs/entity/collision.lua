---@meta _
-- DRAFT 1 DONE
-- luanti/doc/lua_api.md: Registered entities

-- ------------------------- Entity.collision.__base ------------------------ --

---@class _.Entity.collision.__base
--[[
WIPDOC
]]
---@field  axis "x"|"y"|"z"
--[[
WIPDOC
]]
---@field  new_pos vec
--[[
WIPDOC
]]
---@field  old_velocity vec
--[[
WIPDOC
]]
---@field  new_velocity vec

-- -------------------------- Entity.collision.node ------------------------- --

--[[
WIPDOC
]]
---@class core.Entity.collision.node : _.Entity.collision.__base
--[[
WIPDOC
]]
---@field  type "node"
--[[
WIPDOC
]]
---@field  node_pos ivec

-- ------------------------- Entity.collision.object ------------------------ --

--[[
WIPDOC
]]
---@class core.Entity.collision.object : _.Entity.collision.__base
--[[
WIPDOC
]]
---@field  type "object"
--[[
WIPDOC
]]
---@field  object core.ObjectRef

-- ---------------------------- Entity.collision ---------------------------- --

--[[
WIPDOC
]]
---@alias core.Entity.collision core.Entity.collision.node | core.Entity.collision.object