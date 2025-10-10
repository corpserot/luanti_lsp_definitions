---@meta _
-- Inventory reference
-- luanti/doc/lua_api.md: Class reference > `InvRef`

--[[
Inventory reference. It's assumed that this is a valid inventory. List names
cannot contain spaces, and is assumed to be valid.

* @see [luanti/doc/lua_api.md > Class reference > `InvRef`](https://github.com/luanti-org/luanti/blob/5.14.0/doc/lua_api.md#invref)
* @see [luanti/src/script/lua_api/l_inventory.cpp](https://github.com/luanti-org/luanti/blob/5.14.0/src/script/lua_api/l_inventory.cpp)
]]
---@class core.InvRef
local InvRef = {}

--[[
Whether `list` in this inventory is empty.

Undefined behaviour:
- Invalid `list` name.

* @see [luanti/doc/lua_api.md > Class reference > `InvRef`](https://github.com/luanti-org/luanti/blob/5.14.0/doc/lua_api.md#invref)
* @see [luanti/src/script/lua_api/l_inventory.cpp](https://github.com/luanti-org/luanti/blob/5.14.0/src/script/lua_api/l_inventory.cpp)
]]
---@nodiscard
---@param list core.InventoryList
---@return boolean
function InvRef:is_empty(list) end

--[[
Return `list` size in this inventory, if it exists.

Returns `false` for invalid `list` name.

* @see [luanti/doc/lua_api.md > Class reference > `InvRef`](https://github.com/luanti-org/luanti/blob/5.14.0/doc/lua_api.md#invref)
* @see [luanti/src/script/lua_api/l_inventory.cpp](https://github.com/luanti-org/luanti/blob/5.14.0/src/script/lua_api/l_inventory.cpp)
]]
---@nodiscard
---@param list core.InventoryList
---@return int size
function InvRef:get_size(list) end

--[[
Set `list` size in this inventory, if it exists. Otherwise, creates a new list
with given `size`. If `size` is 0, `list` is deleted.

Returns `false` for invalid `list` name or `size`. Otherwise, returns `true`.

* @see [luanti/doc/lua_api.md > Class reference > `InvRef`](https://github.com/luanti-org/luanti/blob/5.14.0/doc/lua_api.md#invref)
* @see [luanti/src/script/lua_api/l_inventory.cpp](https://github.com/luanti-org/luanti/blob/5.14.0/src/script/lua_api/l_inventory.cpp)
]]
---@param list core.InventoryList
---@param size int
---@return boolean success
function InvRef:set_size(list, size) end

--[[
Returns `list` width in this inventory, if it exists. Relevant for crafting.

Undefined behaviour
- invalid `list` name.

* @see [luanti/doc/lua_api.md > Class reference > `InvRef`](https://github.com/luanti-org/luanti/blob/5.14.0/doc/lua_api.md#invref)
* @see [luanti/src/script/lua_api/l_inventory.cpp](https://github.com/luanti-org/luanti/blob/5.14.0/src/script/lua_api/l_inventory.cpp)
]]
---@nodiscard
---@param list core.InventoryList
---@return int width
function InvRef:get_width(list) end

--[[
Set `list` width in this inventory, if it exists. Relevant for crafting.

Returns `false` for invalid `list` name or `width`. Otherwise, returns `true`.

* @see [luanti/doc/lua_api.md > Class reference > `InvRef`](https://github.com/luanti-org/luanti/blob/5.14.0/doc/lua_api.md#invref)
* @see [luanti/src/script/lua_api/l_inventory.cpp](https://github.com/luanti-org/luanti/blob/5.14.0/src/script/lua_api/l_inventory.cpp)
]]
---@param list core.InventoryList
---@param width int
---@return boolean success
function InvRef:set_width(list, width) end

--[[
Returns a copy of `item` in slot `index` in `list` in this inventory, if `list` exists.
An empty slot yields an empty `item`.

Undefined behaviour:
- Invalid `list` name
- `index` is out of `list` size bounds.

* @see [luanti/doc/lua_api.md > Class reference > `InvRef`](https://github.com/luanti-org/luanti/blob/5.14.0/doc/lua_api.md#invref)
* @see [luanti/src/script/lua_api/l_inventory.cpp](https://github.com/luanti-org/luanti/blob/5.14.0/src/script/lua_api/l_inventory.cpp)
]]
---@nodiscard
---@param list core.InventoryList
---@param index int
---@return core.ItemStack item
function InvRef:get_stack(list, index) end

--[[
Sets or Overwrites item in slot `index` in `list` in this inventory with a copy
of `item`, if `list` exists.

Undefined behaviour:
- Invalid `list` name
- `index` is out of `list` size bounds.

* @see [`InvRef:add_item()`](lua://core.InvRef.add_item)
* @see [luanti/doc/lua_api.md > Class reference > `InvRef`](https://github.com/luanti-org/luanti/blob/5.14.0/doc/lua_api.md#invref)
* @see [luanti/src/script/lua_api/l_inventory.cpp](https://github.com/luanti-org/luanti/blob/5.14.0/src/script/lua_api/l_inventory.cpp)
]]
---@param list core.InventoryList
---@param index int
---@param item core.Item
---@return boolean success
function InvRef:set_stack(list, index, item) end

--[[
Returns the contents of `list` in this inventory, if `list` exists.

Returns `nil` for invalid `list` name or non-existent `list`.

* @see [luanti/doc/lua_api.md > Class reference > `InvRef`](https://github.com/luanti-org/luanti/blob/5.14.0/doc/lua_api.md#invref)
* @see [luanti/src/script/lua_api/l_inventory.cpp](https://github.com/luanti-org/luanti/blob/5.14.0/src/script/lua_api/l_inventory.cpp)
]]
---@nodiscard
---@param list core.InventoryList
---@return core.ItemStack[]? list
function InvRef:get_list(list) end

--[[
Set or overwrite the contents of given list in this inventory. For existing
lists, ignores `list_contents` slot indices larger than list size. If the list
doesn't exist, a new list is created with size determined from the last slot
index in `list_contents`

Undefined behaviour:
- Invalid `list` name.

* @see [luanti/doc/lua_api.md > Class reference > `InvRef`](https://github.com/luanti-org/luanti/blob/5.14.0/doc/lua_api.md#invref)
* @see [luanti/src/script/lua_api/l_inventory.cpp](https://github.com/luanti-org/luanti/blob/5.14.0/src/script/lua_api/l_inventory.cpp)
]]
---@param list_name core.InventoryList
---@param list_contents SparseList<core.Item>
function InvRef:set_list(list_name, list_contents) end

--[[
Returns a table mapping list names to their contents.

* @see [luanti/doc/lua_api.md > Class reference > `InvRef`](https://github.com/luanti-org/luanti/blob/5.14.0/doc/lua_api.md#invref)
* @see [luanti/src/script/lua_api/l_inventory.cpp](https://github.com/luanti-org/luanti/blob/5.14.0/src/script/lua_api/l_inventory.cpp)
]]
---@nodiscard
---@return core.InventoryTable.ItemStack inventory_table
function InvRef:get_lists() end

--[[
Replaces lists in this inventory from a table mapping list names to their contents.

Undefined behaviour:
- Invalid list names.

* @see [luanti/doc/lua_api.md > Class reference > `InvRef`](https://github.com/luanti-org/luanti/blob/5.14.0/doc/lua_api.md#invref)
* @see [luanti/src/script/lua_api/l_inventory.cpp](https://github.com/luanti-org/luanti/blob/5.14.0/src/script/lua_api/l_inventory.cpp)
]]
---@param lists core.InventoryTable
function InvRef:set_lists(lists) end

--[[
Adds copy of `item` into `list` in this inventory, if `list` exist. Tries to
fill slots first to last. Can merge with existing items in `list`. Returns a
copy of `item` with leftover or 0 count.

Undefined behaviour:
- Invalid `list` name.

* @see [`InvRef:set_stack()`](lua://core.InvRef.set_stack)
* @see [`InvRef:room_for_item()`](lua://core.InvRef.room_for_item)
* @see [luanti/doc/lua_api.md > Class reference > `InvRef`](https://github.com/luanti-org/luanti/blob/5.14.0/doc/lua_api.md#invref)
* @see [luanti/src/script/lua_api/l_inventory.cpp](https://github.com/luanti-org/luanti/blob/5.14.0/src/script/lua_api/l_inventory.cpp)
]]
---@param list core.InventoryList
---@param item core.Item
---@return core.ItemStack leftover
function InvRef:add_item(list, item) end

--[[
Whether `item` can be added to `list` in this inventory without leftovers, if
`list` exists. Tries to fill slots first to last. Can merge with existing items
in `list`.

Undefined behaviour:
- Invalid `list` name.

* @see [`InvRef:add_item()`](lua://core.InvRef.add_item)
* @see [luanti/doc/lua_api.md > Class reference > `InvRef`](https://github.com/luanti-org/luanti/blob/5.14.0/doc/lua_api.md#invref)
* @see [luanti/src/script/lua_api/l_inventory.cpp](https://github.com/luanti-org/luanti/blob/5.14.0/src/script/lua_api/l_inventory.cpp)
]]
---@nodiscard
---@param list core.InventoryList
---@param item core.Item
---@return boolean
function InvRef:room_for_item(list, item) end

--[[
Whether `item` with equal count can be taken from `list` in this inventory, if
`list` exists. Tries taking from slots last to first. Can collect from many
slots. Matching only considers item names.

If `match_meta` is `true`, matching also considers item meta.

Undefined behaviour:
- Invalid `list` name.
- `item` with larger count than its maximum stack size.

* @see [`InvRef:remove_item`](lua://core.InvRef.remove_item)
* @see [luanti/doc/lua_api.md > Class reference > `InvRef`](https://github.com/luanti-org/luanti/blob/5.14.0/doc/lua_api.md#invref)
* @see [luanti/src/script/lua_api/l_inventory.cpp](https://github.com/luanti-org/luanti/blob/5.14.0/src/script/lua_api/l_inventory.cpp)
]]
---@nodiscard
---@param list core.InventoryList
---@param item core.Item
---@param match_meta boolean? #@default(`false`)
---@return boolean
function InvRef:contains_item(list, item, match_meta) end

--[[
Returns `item` with at most equal count taken from `list` in this inventory, if
`list` exists. Takes from slots last to first. Can collect from many slots.
Matching only considers item names.

If `match_meta` is `true`, matching also considers item meta.

Undefined behaviour:
- Invalid `list` name.
- `item` with larger count than its maximum stack size.

* @added 5.12.0 [`remove_item_match_meta` feature](lua://core.FeatureFlags.remove_item_match_meta) `match_meta` parameter added.
* @see [`InvRef:contains_item`](lua://core.InvRef.contains_item)
* @see [luanti/doc/lua_api.md > Class reference > `InvRef`](https://github.com/luanti-org/luanti/blob/5.14.0/doc/lua_api.md#invref)
* @see [luanti/src/script/lua_api/l_inventory.cpp](https://github.com/luanti-org/luanti/blob/5.14.0/src/script/lua_api/l_inventory.cpp)
]]
---@param list core.InventoryList
---@param item core.Item
---@param match_meta boolean? #@default(`false`)
---@return core.ItemStack taken
function InvRef:remove_item(list, item, match_meta) end

--[[
Returns this inventory's location. If unknown, returns
[`core.InventoryLocation.undefined`](lua://core.InventoryLocation.undefined)

* @see [luanti/doc/lua_api.md > Class reference > `InvRef`](https://github.com/luanti-org/luanti/blob/5.14.0/doc/lua_api.md#invref)
* @see [luanti/src/script/lua_api/l_inventory.cpp](https://github.com/luanti-org/luanti/blob/5.14.0/src/script/lua_api/l_inventory.cpp)
]]
---@nodiscard
---@return core.InventoryLocation|core.InventoryLocation.undefined
function InvRef:get_location() end
