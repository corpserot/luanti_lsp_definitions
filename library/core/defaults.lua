---@meta _
-- DRAFT 1 WIP
-- lua_api.md: 'core' namespace reference > Defaults for the `on_place` and `on_drop` item definition functions
-- lua_api.md: 'core' namespace reference > Defaults for the `on_punch` and `on_dig` node definition callbacks

-- * `core.item_place_node(itemstack, placer, pointed_thing[, param2, prevent_after_place])`
--     * Place item as a node
--     * `param2` overrides `facedir` and wallmounted `param2`
--     * `prevent_after_place`: if set to `true`, `after_place_node` is not called
--       for the newly placed node to prevent a callback and placement loop
--     * returns `itemstack, position`
--       * `position`: the location the node was placed to. `nil` if nothing was placed.
---@param itemstack ItemStack
---@param placer PlayerRef
---@param pointed_thing pointed_thing
---@param param2 number?
---@param prevent_after_place boolean?
---@return ItemStack, vector?
function core.item_place_node(itemstack, placer, pointed_thing, param2, prevent_after_place) end

-- * `core.item_place_object(itemstack, placer, pointed_thing)`
--     * Place item as-is
--     * returns the leftover itemstack
--     * **Note**: This function is deprecated and will never be called.
---@deprecated
function core.item_place_object(itemstack, placer, pointed_thing) end

-- * `core.item_place(itemstack, placer, pointed_thing[, param2])`
--     * Wrapper that calls `core.item_place_node` if appropriate
--     * Calls `on_rightclick` of `pointed_thing.under` if defined instead
--     * **Note**: is not called when wielded item overrides `on_place`
--     * `param2` overrides facedir and wallmounted `param2`
--     * returns `itemstack, position`
--       * `position`: the location the node was placed to. `nil` if nothing was placed.
---@param itemstack ItemStack
---@param placer PlayerRef
---@param pointed_thing pointed_thing
---@param param2 number?
---@return ItemStack, vector?
function core.item_place(itemstack, placer, pointed_thing, param2) end

-- * `core.item_pickup(itemstack, picker, pointed_thing, time_from_last_punch, ...)`
--     * Runs callbacks registered by `core.register_on_item_pickup` and adds
--       the item to the picker's `"main"` inventory list.
--     * Parameters are the same as in `on_pickup`.
--     * Returns the leftover itemstack.
---@param itemstack ItemStack
---@param picker PlayerRef
---@param pointed_thing pointed_thing
---@param time_from_last_punch number
---@return ItemStack
function core.item_pickup(itemstack, picker, pointed_thing, time_from_last_punch, ...) end

-- * `core.item_drop(itemstack, dropper, pos)`
--     * Converts `itemstack` to an in-world Lua entity.
--     * `itemstack` (`ItemStack`) is modified (cleared) on success.
--       * In versions < 5.12.0, `itemstack` was cleared in all cases.
--     * `dropper` (`ObjectRef`) is optional.
--     * Returned values on success:
--       1. leftover itemstack
--       2. `ObjectRef` of the spawned object (provided since 5.12.0)
---@param itemstack ItemStack
---@param dropper PlayerRef?
---@param pos vector
function core.item_drop(itemstack, dropper, pos) end

-- * `core.item_eat(hp_change[, replace_with_item])`
--     * Returns `function(itemstack, user, pointed_thing)` as a
--       function wrapper for `core.do_item_eat`.
--     * `replace_with_item` is the itemstring which is added to the inventory.
--       If the player is eating a stack and `replace_with_item` doesn't fit onto
--       the eaten stack, then the remaining go to a different spot, or are dropped.
---@param hp_change number
---@param replace_with_item ItemStackAny?
function core.item_eat(hp_change, replace_with_item) end

-- * `core.node_punch(pos, node, puncher, pointed_thing)`
--     * Calls functions registered by `core.register_on_punchnode()`
---@param pos vector
---@param node MapNode
---@param puncher PlayerRef
---@param pointed_thing pointed_thing
function core.node_punch(pos, node, puncher, pointed_thing) end
-- * `core.node_dig(pos, node, digger)`
--     * Checks if node can be dug, puts item into inventory, removes node
--     * Calls functions registered by `core.registered_on_dignodes()`
---@param pos vector
---@param node MapNode
---@param digger PlayerRef
function core.node_dig(pos, node, digger) end