---@meta _
-- DRAFT 1 DONE
-- lua_api.md: Items

--[[
WIPDOC
]]
---@class core.Item.tablefmt
--[[
WIPDOC
]]
---@field name string
--[[
WIPDOC
]]
---@field count integer?
--[[
WIPDOC
]]
---@field wear integer?
--[[
WIPDOC
]]
---@field metadata string?

--[[
WIPDOC
]]
---@class core.Item.stringfmt : string

--[[
WIPDOC
]]
---@alias core.Item.simple
--- | core.Item.tablefmt
--- | core.Item.stringfmt

--[[
WIPDOC
]]
---@alias core.Item
--- | core.Item.simple
--- | core.ItemStack