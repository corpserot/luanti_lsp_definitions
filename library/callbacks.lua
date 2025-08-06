---@meta

-- * Called every server step, usually interval of 0.1s.
-- * `dtime` is the time since last execution in seconds.
---@param f fun(dtime:number):nil
---@return nil
function core.register_globalstep(f) end

-- * Called after mods have finished loading and before the media is cached or the
--   aliases handled.
---@param f fun():nil
---@return nil
function core.register_on_mods_loaded(f) end

-- * Called before server shutdown
-- * Players that were kicked by the shutdown procedure are still fully accessible
--  in `core.get_connected_players()`.
-- * **Warning**: If the server terminates abnormally (i.e. crashes), the
--   registered callbacks **will likely not be run**. Data should be saved at
--   semi-frequent intervals as well as on server shutdown.
---@param f fun():nil
---@return nil
function core.register_on_shutdown(f) end

-- * `core.register_on_placenode(function(pos, newnode, placer, oldnode, itemstack, pointed_thing))`
--     * Called when a node has been placed
--     * If return `true` no item is taken from `itemstack`
--     * `placer` may be any valid ObjectRef or nil.
--     * **Not recommended**; use `on_construct` or `after_place_node` in node
--       definition whenever possible.
---@param f fun(pos:vector, newnode:MapNode, placer:ObjectRef, oldnode:MapNode, itemstack:ItemStack, pointed_thing:pointed_thing):boolean?
---@return nil
function core.register_on_placenode(f) end

-- * `core.register_on_dignode(function(pos, oldnode, digger))`
--     * Called when a node has been dug.
--     * **Not recommended**; Use `on_destruct` or `after_dig_node` in node
--       definition whenever possible.
---@param f fun(pos:vector, oldnode:MapNode, digger:ObjectRef):nil
---@return nil
function core.register_on_dignode(f) end

-- * `core.register_on_punchnode(function(pos, node, puncher, pointed_thing))`
--     * Called when a node is punched
---@param f fun(pos:vector, node:MapNode, puncher:ObjectRef, pointed_thing:pointed_thing):nil
---@return nil
function core.register_on_punchnode(f) end

--- Unofficial note: not actually deprecated but PLEASE use the mapgen env, use this only for prototyping/when you absolutely need to
---@deprecated
---@param f fun(minp:vector, maxp:vector, blockseed:number):nil
function core.register_on_generated(f) end

---@param f fun(ObjectRef: ObjectRef):nil
function core.register_on_newplayer(f) end

-- * `core.register_on_punchplayer(function(player, hitter, time_from_last_punch, tool_capabilities, dir, damage))`
--     * Called when a player is punched
--     * Note: This callback is invoked even if the punched player is dead.
--     * `player`: ObjectRef - Player that was punched
--     * `hitter`: ObjectRef - Player that hit. Can be nil.
--     * `time_from_last_punch`: Meant for disallowing spamming of clicks
--       (can be nil).
--     * `tool_capabilities`: Capability table of used item (can be nil)
--     * `dir`: Unit vector of direction of punch. Always defined. Points from
--       the puncher to the punched.
--     * `damage`: Number that represents the damage calculated by the engine
--     * should return `true` to prevent the default damage mechanism
---@param f fun(player:ObjectRef, hitter:ObjectRef, time_from_last_punch: number?, tool_capabilities: tool_capabilities?, dir:vector, damage: number):boolean?
function core.register_on_punchplayer(f) end

-- * `core.register_on_rightclickplayer(function(player, clicker))`
--     * Called when the 'place/use' key was used while pointing a player
--       (not necessarily an actual rightclick)
--     * `player`: ObjectRef - Player that is acted upon
--     * `clicker`: ObjectRef - Object that acted upon `player`, may or may not be a player
---@param f fun(player:ObjectRef, clicker:ObjectRef)
function core.register_on_rightclickplayer(f) end

---@class PlayerHPChangeReason: table
---@field type "set_hp"|"punch"|"fall"|"node_damage"|"drown"|"respawn"
---@field from "mod"|"engine"
---@field node MapNode?
---@field node_pos vector?

-- * `core.register_on_player_hpchange(function(player, hp_change, reason), modifier)`
--     * Called when the player gets damaged or healed
--     * When `hp == 0`, damage doesn't trigger this callback.
--     * When `hp == hp_max`, healing does still trigger this callback.
--     * `player`: ObjectRef of the player
--     * `hp_change`: the amount of change. Negative when it is damage.
--       * Historically, the new HP value was clamped to [0, 65535] before
--         calculating the HP change. This clamping has been removed as of
--         version 5.10.0
--     * `reason`: a PlayerHPChangeReason table.
--         * The `type` field will have one of the following values:
--             * `set_hp`: A mod or the engine called `set_hp` without
--                         giving a type - use this for custom damage types.
--             * `punch`: Was punched. `reason.object` will hold the puncher, or nil if none.
--             * `fall`
--             * `node_damage`: `damage_per_second` from a neighboring node.
--                              `reason.node` will hold the node name or nil.
--                              `reason.node_pos` will hold the position of the node
--             * `drown`
--             * `respawn`
--         * Any of the above types may have additional fields from mods.
--         * `reason.from` will be `mod` or `engine`.
--     * `modifier`: when true, the function should return the actual `hp_change`.
--        Note: modifiers only get a temporary `hp_change` that can be modified by later modifiers.
--        Modifiers can return true as a second argument to stop the execution of further functions.
--        Non-modifiers receive the final HP change calculated by the modifiers.
---@param f fun(player:ObjectRef, hp_change:number, reason: PlayerHPChangeReason):number?
---@param modifier boolean?
function core.register_on_player_hpchange(f, modifier) end

-- * `core.register_on_dieplayer(function(ObjectRef, reason))`
--     * Called when a player dies
--     * `reason`: a PlayerHPChangeReason table, see register_on_player_hpchange
--     * For customizing the death screen, see `core.show_death_screen`.
---@param f fun(ObjectRef:ObjectRef, reason:PlayerHPChangeReason)
function core.register_on_dieplayer(f) end

---@param f fun(ObjectRef:ObjectRef)
function core.register_on_respawnplayer(f) end

---@param f fun(name:string, ip:string)
function core.register_on_prejoinplayer(f) end

---@param f fun(ObjectRef:ObjectRef, last_login:string)
function core.register_on_joinplayer(f) end

---@param f fun(ObjectRef:ObjectRef, timed_out:string)
function core.register_on_leaveplayer(f) end

-- * `core.register_on_authplayer(function(name, ip, is_success))`
--     * Called when a client attempts to log into an account.
--     * `name`: The name of the account being authenticated.
--     * `ip`: The IP address of the client
--     * `is_success`: Whether the client was successfully authenticated
--     * For newly registered accounts, `is_success` will always be true
---@param f fun(name:string, ip:string, is_success: boolean)
function core.register_on_authplayer(f) end

-- * Deprecated: use `core.register_on_authplayer(name, ip, is_success)` instead.
---@deprecatred
---@param f fun(name:string, ip:string)
function core.register_on_auth_fail(f) end

---@class cheat_type: table
---@field type string|"moved_too_fast"|"interacted_too_far"|"interacted_with_self"|"interacted_while_dead"|"finished_unknown_dig"|"dug_unbreakable"|"dug_too_fast"

-- * `core.register_on_cheat(function(ObjectRef, cheat))`
--     * Called when a player cheats
--     * `cheat`: `{type=<cheat_type>}`, where `<cheat_type>` is one of:
--         * `moved_too_fast`
--         * `interacted_too_far`
--         * `interacted_with_self`
--         * `interacted_while_dead`
--         * `finished_unknown_dig`
--         * `dug_unbreakable`
--         * `dug_too_fast`
---@param f fun(ObjectRef:ObjectRef, cheat: cheat_type)
function core.register_on_cheat(f) end

-- * `core.register_on_chat_message(function(name, message))`
--     * Called always when a player says something
--     * Return `true` to mark the message as handled, which means that it will
--       not be sent to other players.
---@param f fun(name:string, message:string): boolean?
function core.register_on_chat_message(f) end

-- * `core.register_on_chatcommand(function(name, command, params))`
--     * Called always when a chatcommand is triggered, before `core.registered_chatcommands`
--       is checked to see if the command exists, but after the input is parsed.
--     * Return `true` to mark the command as handled, which means that the default
--       handlers will be prevented.
---@param f fun(name:string, command:string, params:string)
function core.register_on_chatcommand(f) end

---@class formspec_fields: table<string,string>

-- * `core.register_on_player_receive_fields(function(player, formname, fields))`
-- * Called when the server received input from `player`.
--   Specifically, this is called on any of the
--   following events:
--       * a button was pressed,
--       * Enter was pressed while the focus was on a text field
--       * a checkbox was toggled,
--       * something was selected in a dropdown list,
--       * a different tab was selected,
--       * selection was changed in a textlist or table,
--       * an entry was double-clicked in a textlist or table,
--       * a scrollbar was moved, or
--       * the form was actively closed by the player.
-- * `formname` is the name passed to `core.show_formspec`.
--   Special case: The empty string refers to the player inventory
--   (the formspec set by the `set_inventory_formspec` player method).
-- * Fields are sent for formspec elements which define a field. `fields`
--   is a table containing each formspecs element value (as string), with
--   the `name` parameter as index for each. The value depends on the
--   formspec element type:
--     * `animated_image`: Returns the index of the current frame.
--     * `button` and variants: If pressed, contains the user-facing button
--       text as value. If not pressed, is `nil`
--     * `field`, `textarea` and variants: Text in the field
--     * `dropdown`: Either the index or value, depending on the `index event`
--       dropdown argument.
--     * `tabheader`: Tab index, starting with `"1"` (only if tab changed)
--     * `checkbox`: `"true"` if checked, `"false"` if unchecked
--     * `textlist`: See `core.explode_textlist_event`
--     * `table`: See `core.explode_table_event`
--     * `scrollbar`: See `core.explode_scrollbar_event`
--     * Special case: `["quit"]="true"` is sent when the user actively
--       closed the form by mouse click, keypress or through a `button_exit[]`
--       element.
--     * Special case: `["try_quit"]="true"` is sent when the user tries to
--       close the formspec, but the formspec used `allow_close[false]`.
--     * Special case: `["key_enter"]="true"` is sent when the user pressed
--       the Enter key and the focus was either nowhere (causing the formspec
--       to be closed) or on a button. If the focus was on a text field,
--       additionally, the index `key_enter_field` contains the name of the
--       text field. See also: `field_close_on_enter`.
-- * Newest functions are called first
-- * If function returns `true`, remaining functions are not called
---@param f fun(player:PlayerRef, formname:string, fields:formspec_fields):boolean?
function core.register_on_player_receive_fields(f) end

-- * `core.register_on_craft(function(itemstack, player, old_craft_grid, craft_inv))`
--     * Called when `player` crafts something
--     * `itemstack` is the output
--     * `old_craft_grid` contains the recipe (Note: the one in the inventory is
--       cleared).
--     * `craft_inv` is the inventory with the crafting grid
--     * Return either an `ItemStack`, to replace the output, or `nil`, to not
--       modify it.
---@param f fun(itemstack:ItemStack, player:PlayerRef, old_crafting_grid:table, craft_inv:InvRef):ItemStack?
function core.register_on_craft(f) end

-- * `core.register_craft_predict(function(itemstack, player, old_craft_grid, craft_inv))`
--     * The same as before, except that it is called before the player crafts, to
--       make craft prediction, and it should not change anything.
---@param f fun(itemstack:ItemStack, player:PlayerRef, old_crafting_grid:table, craft_inv:InvRef):ItemStack?
function core.register_craft_predict(f) end

---@class inventory_info: table
---@field move {from_list:string, to_list:string, from_index:number, to_index:number, count:number}?
---@field put {listname:string, index:string, stack:ItemStack}
---@field take {listname:string, index:string, stack:ItemStack}

-- * `core.register_allow_player_inventory_action(function(player, action, inventory, inventory_info))`
--     * Determines how much of a stack may be taken, put or moved to a
--       player inventory.
--     * Function arguments: see `core.register_on_player_inventory_action`
--     * Return a numeric value to limit the amount of items to be taken, put or
--       moved. A value of `-1` for `take` will make the source stack infinite.
---@param f fun(player:PlayerRef, action:"move"|"put"|"take", inventory:InvRef, inventory_info: inventory_info):number
function core.register_allow_player_inventory_action(f) end

---@param f fun(player:PlayerRef, action:"move"|"put"|"take", inventory:InvRef, inventory_info: inventory_info):nil
function core.register_on_player_inventory_action(f) end

-- * `core.register_on_protection_violation(function(pos, name))`
--     * Called by `builtin` and mods when a player violates protection at a
--       position (eg, digs a node or punches a protected entity).
--     * The registered functions can be called using
--       `core.record_protection_violation`.
--     * The provided function should check that the position is protected by the
--       mod calling this function before it prints a message, if it does, to
--       allow for multiple protection mods.
---@param f fun(pos:vector, name: string)
function core.register_on_protection_violation(f) end

-- * `core.register_on_item_eat(function(hp_change, replace_with_item, itemstack, user, pointed_thing))`
--     * Called when an item is eaten, by `core.item_eat`
--     * Return `itemstack` to cancel the default item eat response (i.e.: hp increase).
---@param f fun(hp_change:number, replace_with_item:ItemStack?, itemstack:ItemStack, user:PlayerRef, pointed_thing:pointed_thing):ItemStack?
function core.register_on_item_eat(f) end

-- * `core.register_on_item_pickup(function(itemstack, picker, pointed_thing, time_from_last_punch,  ...))`
--     * Called by `core.item_pickup` before an item is picked up.
--     * Function is added to `core.registered_on_item_pickups`.
--     * Oldest functions are called first.
--     * Parameters are the same as in the `on_pickup` callback.
--     * Return an itemstack to cancel the default item pick-up response (i.e.: adding
--       the item into inventory).
---@param f fun(itemstack:ItemStack, picker:PlayerRef, pointed_thing:pointed_thing, time_from_last_punch:number, ...):ItemStack?
function core.register_on_item_pickup(f) end

-- * `core.register_on_priv_grant(function(name, granter, priv))`
--     * Called when `granter` grants the priv `priv` to `name`.
--     * Note that the callback will be called twice if it's done by a player,
--       once with granter being the player name, and again with granter being nil.
---@param f fun(name:string, granter:PlayerRef?, priv:string)
function core.register_on_priv_grant(f) end

-- * `core.register_on_priv_revoke(function(name, revoker, priv))`
--     * Called when `revoker` revokes the priv `priv` from `name`.
--     * Note that the callback will be called twice if it's done by a player,
--       once with revoker being the player name, and again with revoker being nil.
---@param f fun(name:string, revoker:PlayerRef?, priv:string)
function core.register_on_priv_revoke(f) end

-- * `core.register_can_bypass_userlimit(function(name, ip))`
--     * Called when `name` user connects with `ip`.
--     * Return `true` to by pass the player limit
---@param f fun(name:string, ip:string)
function core.register_can_bypass_userlimit(f) end

---@param f fun(channel_name:string, sender:PlayerRef|string, message:string)
function core.register_on_modchannel_message(f) end

-- * `core.register_on_liquid_transformed(function(pos_list, node_list))`
--     * Called after liquid nodes (`liquidtype ~= "none"`) are modified by the
--       engine's liquid transformation process.
--     * `pos_list` is an array of all modified positions.
--     * `node_list` is an array of the old node that was previously at the position
--       with the corresponding index in pos_list.
---@param f fun(pos_list: vector[], node_list: MapNode[])
function core.register_on_liquid_transformed(f) end

-- * `core.register_on_mapblocks_changed(function(modified_blocks, modified_block_count))`
--     * Called soon after any nodes or node metadata have been modified. No
--       modifications will be missed, but there may be false positives.
--     * Will never be called more than once per server step.
--     * `modified_blocks` is the set of modified mapblock position hashes. These
--       are in the same format as those produced by `core.hash_node_position`,
--       and can be converted to positions with `core.get_position_from_hash`.
--       The set is a table where the keys are hashes and the values are `true`.
--     * `modified_block_count` is the number of entries in the set.
--     * Note: callbacks must be registered at mod load time.
---@param f fun(modified_blocks: table<number, boolean>, modified_block_count: number)
function core.register_on_mapblocks_changed(f) end
