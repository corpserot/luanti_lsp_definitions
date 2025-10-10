---@meta _
-- DRAFT 1 DONE
-- luanti/doc/lua_api.md: Nodes
-- luanti/doc/lua_api.md: Nodes > Node paramtypes

--[[
WIPDOC
]]
---@alias core.Node.name
--- | "unknown"
--- | "air"
--- | "ignore"
--- | string

--[[
WIPDOC
]]
---@alias core.Node.namelike
--- | core.Groups.node
--- | core.Node.name

-- ------------------------------- Node.param1 ------------------------------ --

--[[
WIPDOC
]]
---@alias core.Light int

--[[
WIPDOC
]]
---@alias core.Light.part int

--[[
WIPDOC
]]
---@alias core.Light.source int

--[[
WIPDOC
]]
---@alias core.Param1 int

-- ------------------------------- Node.param2 ------------------------------ --

--[[
WIPDOC
]]
---@alias core.Param2.wallmounted int

--[[
WIPDOC
]]
---@alias core.Param2.facedir int

--[[
WIPDOC
]]
---@alias core.Param2.4dir int

--[[
WIPDOC
]]
---@alias core.Param2.leveled int

--[[
WIPDOC
]]
---@alias core.Param2.leveled.rooted_plantlike int

--[[
WIPDOC
]]
---@alias core.Param2.degrotate int

--[[
WIPDOC
]]
---@alias core.Param2.meshoptions.plantlike int

--[[
WIPDOC
]]
---@alias core.Param2.facedir.color int

--[[
WIPDOC
]]
---@alias core.Param2.4dir.color int

--[[
WIPDOC
]]
---@alias core.Param2.wallmounted.color int

--[[
WIPDOC
]]
---@alias core.Param2.glasslikeliquidlevel.liquid int

--[[
WIPDOC
]]
---@alias core.Param2.glasslikeliquidlevel.frame int

--[[
WIPDOC
]]
---@alias core.Param2.glasslikeliquidlevel int

--[[
WIPDOC
]]
---@alias core.Param2.degrotate.color int

--[[
WIPDOC
]]
---@alias core.Param2 int

-- ---------------------------------- Node ---------------------------------- --

--[[
WIPDOC
]]
---@class core.Node.get
--[[
WIPDOC
]]
---@field name string
--[[
WIPDOC
]]
---@field param1 core.Param1
--[[
WIPDOC
]]
---@field param2 core.Param2

--[[
WIPDOC
]]
---@alias core.Node.set
--- | core.Node.get
--- | _.Node.set

---@class _.Node.set
--[[
WIPDOC
]]
---@field name string
--[[
WIPDOC
]]
---@field param1 core.Param1?
--[[
WIPDOC
]]
---@field param2 core.Param2?
