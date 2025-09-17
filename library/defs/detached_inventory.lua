---@meta _
-- DRAFT 1 DONE
-- lua_api.md: Definition tables > Detached inventory callbacks

--[[
WIPDOC
]]
---@class core.DetachedInventoryCallbacks
--[[
WIPDOC
]]
---@field allow_move? fun(inv:core.InvRef, from_list:core.InvList, from_index:number, to_list:core.InvList, to_index:number, count:number, player:core.PlayerRef):integer?
--[[
WIPDOC
]]
---@field allow_put? fun(inv:core.InvRef, listname:string, index:number, stack:core.ItemStack, player:core.PlayerRef):integer?
--[[
WIPDOC
]]
---@field allow_take? fun(inv:core.InvRef, listname:string, index:number, stack:core.ItemStack, player:core.PlayerRef):integer?
--[[
WIPDOC
]]
---@field on_move? fun(inv:core.InvRef, from_list:core.InvList, from_index:number, to_list:core.InvList, to_index:number, count:number, player:core.PlayerRef)
--[[
WIPDOC
]]
---@field on_put? fun(inv:core.InvRef, listname:string, index:number, stack:core.ItemStack, player:core.PlayerRef)
--[[
WIPDOC
]]
---@field on_take? fun(inv:core.InvRef, listname:string, index:number, stack:core.ItemStack, player:core.PlayerRef)
