---@meta _
-- DRAFT 1 DONE
-- lua_api.md: Class reference > `InvRef`

-- --------------------------------- InvList -------------------------------- --

--[[
WIPDOC
]]
---@alias core.InvList core.ItemStack[]

-- -------------------------------- InvTable -------------------------------- --

--[[
* inventory table keys are inventory list names
* inventory table values are item tables
* item table keys are slot IDs (starting with 1)
* item table values are ItemStacks
]]
---@class core.InvTable : {[string]:core.InvList}


-- --------------------------------- InvRef --------------------------------- --

--[[
WIPDOC
]]
---@class core.InvRef
local InvRef = {}

--[[
* `is_empty(listname)`: return `true` if list is empty
]]
---@param listname string
---@return  boolean
function InvRef:is_empty(listname) end

--[[
* `get_size(listname)`: get size of a list
]]
---@param listname string
---@return number
function InvRef:get_size(listname) end

--[[
* `set_size(listname, size)`: set size of a list
    * If `listname` is not known, a new list will be created
    * Setting `size` to 0 deletes a list
    * returns `false` on error (e.g. invalid `listname` or `size`
]]
---@param listname string
---@param size integer
---@return boolean
function InvRef:set_size(listname, size) end

--[[
* `get_width(listname)`: get width of a list
]]
---@param listname string
---@return integer
function InvRef:get_width(listname) end

--[[
* `set_width(listname, width)`: set width of list; currently used for crafting
    * returns `false` on error (e.g. invalid `listname` or `width`
]]
---@param listname string
---@param width integer
function InvRef:set_width(listname, width) end

--[[
* `get_stack(listname, i)`: get a copy of stack index `i` in list
]]
---@param listname string
---@param i integer
function InvRef:get_stack(listname, i) end

--[[
* `set_stack(listname, i, stack)`: copy `stack` to index `i` in list
]]
---@param listname string
---@param i integer
---@param stack core.Item
function InvRef:set_stack(listname, i, stack) end

--[[
* `get_list(listname)`: returns full list (list of `ItemStack`s
                        or `nil` if list doesn't exist (size 0
]]
---@param listname string
---@return core.InvList
function InvRef:get_list(listname) end

--[[
* `set_list(listname, list)`: set full list (size will not change
]]
---@param listname string
---@param list core.InvList
function InvRef:set_list(listname, list) end

--[[
* `get_lists()`: returns table that maps listnames to inventory lists
]]
---@return table<string, core.InvList>
function InvRef:get_lists() end

--[[
* `set_lists(lists)`: sets inventory lists (size will not change
]]
---@param lists table<string, core.InvList>
function InvRef:set_lists(lists) end

--[[
* `add_item(listname, stack)`: add item somewhere in list, returns leftover
  `ItemStack`.
]]
---@param listname string
---@param stack core.Item
function InvRef:add_item(listname, stack) end

--[[
* `room_for_item(listname, stack):` returns `true` if the stack of items
  can be fully added to the list
]]
---@param listname string
---@param stack core.Item
---@return boolean
function InvRef:room_for_item(listname, stack) end

--[[
* `contains_item(listname, stack, [match_meta])`: returns `true` if
  the stack of items can be fully taken from the list.
    * If `match_meta` is `true`, item metadata is also considered when comparing
      items. Otherwise, only the items names are compared. Default: `false`
    * The method ignores wear.
]]
---@param listname string
---@param stack core.Item
---@param match_meta boolean?
function InvRef:contains_item(listname, stack, match_meta) end

--[[
* `remove_item(listname, stack, [match_meta])`: take as many items as specified from the
  list, returns the items that were actually removed (as an `ItemStack`).
    * If `match_meta` is `true` (available since feature `remove_item_match_meta`),
      item metadata is also considered when comparing items. Otherwise, only the
      items names are compared. Default: `false`
    * The method ignores wear.
]]
---@param listname string
---@param stack core.Item
---@param match_meta boolean?
function InvRef:remove_item(listname, stack, match_meta) end

--[[
* `get_location()`: returns a location compatible to
  `core.get_inventory(location)`.
    * returns `{type="undefined"}` in case location is not known
]]
---@return core.InventoryLocation|core.InventoryLocation.undefined
function InvRef:get_location() end
