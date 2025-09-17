---@meta _
-- DRAFT 1 DONE
-- lua_api.md: Class reference > `ItemStackMetaRef`

--[[
WIPDOC
]]
---@class core.ItemStackMetaRef: core.MetaDataRef
local ItemStackMetaRef = {}

--[[
WIPDOC
]]
---@param tool_capabilities core.ToolCapabilities?
function ItemStackMetaRef:set_tool_capabilities(tool_capabilities) end

--[[
WIPDOC
]]
---@param wear_bar_params core.WearBarColor?
function ItemStackMetaRef:set_wear_bar_params(wear_bar_params) end
