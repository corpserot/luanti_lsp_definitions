---@meta _
-- DRAFT 1 DONE
-- luanti/doc/lua_api.md: Inventory
-- luanti/doc/lua_api.md: Class reference > `InvRef`
-- luanti/doc/lua_api.md: Class reference > `MetaDataRef`

-- ------------------------------ InventoryList ----------------------------- --

--[[
WIPDOC
]]
---@alias core.InventoryList
--- | "main"
--- | "craft"
--- | "craftpreview"
--- | "craftresult"
--- | "hand"
--- | string

-- -------------------------------- InventoryTable -------------------------------- --

--[[
WIPDOC
]]
---@alias core.InventoryTable.stringfmt table<core.InventoryList, SparseList<core.Item.stringfmt>>

--[[
WIPDOC
]]
---@alias core.InventoryTable.ItemStack table<core.InventoryList, SparseList<core.ItemStack>>

--[[
WIPDOC
]]
---@alias core.InventoryTable table<core.InventoryList, SparseList<core.Item>>