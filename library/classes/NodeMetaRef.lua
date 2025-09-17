---@meta _
-- DRAFT 1 DONE
-- lua_api.md: Class reference > `NodeMetaRef`

-- ----------------------------- metadata table ----------------------------- --

--[[
WIPDOC
]]
---@class core.NodeMetaDataTable : core.MetaDataTable
--[[
WIPDOC
]]
---@field inventory table<string, table<integer, core.ItemStack>>


-- ------------------------------- NodeMetaRef ------------------------------ --

--[[
WIPDOC
]]
---@class core.NodeMetaRef : core.MetaDataRef
local NodeMetaRef = {}

--[[
WIPDOC
]]
---@param data core.NodeMetaDataTable?
function NodeMetaRef:from_table(data) end

--[[
WIPDOC
]]
---@return core.NodeMetaDataTable
function NodeMetaRef:to_table() end

--[[
WIPDOC
]]
---@return core.InvRef
function NodeMetaRef:get_inventory() end

--[[
* `mark_as_private(name or {name1, name2, ...})`: Mark specific vars as private
  This will prevent them from being sent to the client. Note that the "private"
  status will only be remembered if an associated key-value pair exists,
  meaning it's best to call this when initializing all other meta (e.g.
  `on_construct`).
]]
---@param fields string|string[]
function NodeMetaRef:mark_as_private(fields) end
