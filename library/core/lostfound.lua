-- --------------------------- Mysterious section --------------------------- --

-- * `core.get_mod_storage()`:
--     * returns reference to mod private `StorageRef`
--     * must be called during mod load time
---@return StorageRef
function core.get_mod_storage() end

-- --------------------------- Mysterious section --------------------------- --

--- "Oh hell no what are these types... man..."
--- Anyway i omit the deprecated stuff, you shouldn't use it :)

--- Unofficial note: Prefer not doing 100 000 particles in a single globalstep
--- Because that will make the network scream, with no way to debug it
--- Instead, invest time into particlespawners, invest time into creating an issue on luanti github, invest time into creating a client side mod
---@param particle_def Particle
function core.add_particle(particle_def) end

-- * Add a `ParticleSpawner`, an object that spawns an amount of particles
--   over `time` seconds.
-- * Returns an `id`, and -1 if adding didn't succeed
---@param particlespawner_def ParticleSpawner
---@return ParticleSpawner_id|-1
function core.add_particlespawner(particlespawner_def) end

-- * `core.delete_particlespawner(id, player)`
--     * Delete `ParticleSpawner` with `id` (return value from
--       `core.add_particlespawner`).
--     * If playername is specified, only deletes on the player's client,
--       otherwise on all clients.
---@param id ParticleSpawner_id
---@param player PlayerRef?
function core.delete_particlespawner(id, player) end

-- --------------------------- Mysterious section --------------------------- --



---@param channel_name string
---@return ModChannel
function core.mod_channel_join(channel_name) end

-- Formspec
-----------

-- * `core.show_formspec(playername, formname, formspec)`
--     * `playername`: name of player to show formspec
--     * `formname`: name passed to `on_player_receive_fields` callbacks.
--         * It should follow the `"modname:<whatever>"` naming convention.
--         * If empty: Shows a custom, temporary inventory formspec.
--             * An inventory formspec shown this way will also be updated if
--               `ObjectRef:set_inventory_formspec` is called.
--             * Use `ObjectRef:set_inventory_formspec` to change the player's
--               inventory formspec for future opens.
--             * Supported if server AND client are both of version >= 5.13.0.
--     * `formspec`: formspec to display
--     * See also: `core.register_on_player_receive_fields`
---@param playername string
---@param formname string
---@param formspec string
---@return nil
function core.show_formspec(playername, formname, formspec) end

-- * `core.close_formspec(playername, formname)`
--     * `playername`: name of player to close formspec
--     * `formname`: has to exactly match the one given in `show_formspec`, or the
--       formspec will not close.
--     * calling `show_formspec(playername, formname, "")` is equal to this
--       expression.
--     * to close a formspec regardless of the formname, call
--       `core.close_formspec(playername, "")`.
--       **USE THIS ONLY WHEN ABSOLUTELY NECESSARY!**
---@param playername string
---@param formname string
---@return nil
function core.close_formspec(playername, formname) end

-- * `core.hypertext_escape(string)`: returns a string
--     * escapes the characters "\", "<", and ">" to show text in a hypertext element.
--     * not safe for use with tag attributes.
--     * this function does not do formspec escaping, you will likely need to do
--       `core.formspec_escape(core.hypertext_escape(string))` if the hypertext is
--       not already being formspec escaped.
---@param string string
---@return string
function core.hypertext_escape(string) end

-- * `core.explode_table_event(string)`: returns a table
--     * returns e.g. `{type="CHG", row=1, column=2}`
--     * `type` is one of:
--         * `"INV"`: no row selected
--         * `"CHG"`: selected
--         * `"DCL"`: double-click
---@param string string
---@return {type: "INV"|"CHG"|"DCL", row:number?, column:number?}
function core.explode_table_event(string) end

-- * `core.explode_table_event(string)`: returns a table
--     * returns e.g. `{type="CHG", row=1, column=2}`
--     * `type` is one of:
--         * `"INV"`: no row selected
--         * `"CHG"`: selected
--         * `"DCL"`: double-click
---@param string string
---@return {type:"INV"|"CHG"|"DCL", index:number?}
function core.explode_textlist_event(string) end

---@param string string
---@return {type:"INV"|"CHG"|"DCL", value:number?}
function core.explode_scrollbar_event(string) end

-- * `core.show_death_screen(player, reason)`
--     * Called when the death screen should be shown.
--     * `player` is an ObjectRef, `reason` is a PlayerHPChangeReason table or nil.
--     * By default, this shows a simple formspec with the option to respawn.
--       Respawning is done via `ObjectRef:respawn`.
--     * You can override this to show a custom death screen.
--     * For general death handling, use `core.register_on_dieplayer` instead.
---@param reason PlayerHPChangeReason
---@param player PlayerRef
function core.show_death_screen(player, reason) end

-- :music: This file is getting too large :music:
-- But who cares, it's just write-only
-- It's not like anybody will touch it
-- wait so nobody will read even read this, oh, oh bye

-- Anyway the "Item handling" section

---@nodiscard
---@param img1 string
---@param img2 string
---@param img3 string
---@return string
function core.inventorycube(img1, img2, img3) end

-- * `core.get_pointed_thing_position(pointed_thing, above)`
--     * Returns the position of a `pointed_thing` or `nil` if the `pointed_thing`
--       does not refer to a node or entity.
--     * If the optional `above` parameter is true and the `pointed_thing` refers
--       to a node, then it will return the `above` position of the `pointed_thing`.
---@param pointed_thing pointed_thing
---@param above boolean?
---@return vector
function core.get_pointed_thing_position(pointed_thing, above) end

---@param dir vector
---@param is6d boolean?
---@return number
function core.dir_to_facedir(dir, is6d) end

---@param facedir number
---@return vector
function core.facedir_to_dir(facedir) end

---@param dir vector
---@return number
function core.dir_to_fourdir(dir) end

---@param fourdir number
---@return vector
function core.fourdir_to_dir(fourdir) end

---@param dir vector
---@return number
function core.dir_to_wallmounted(dir) end

---@param wallmounted number
---@return vector
function core.wallmounted_to_dir(wallmounted) end

---@param dir vector
---@return number
function core.dir_to_yaw(dir) end

---@param yaw number
---@return vector
function core.yaw_to_dir(yaw) end

---@param param2 number
---@param paramtype2 string
---@return number?
function core.strip_param2_color(param2, paramtype2) end

---@param node MapNodeOpt|string
---@param toolname string?
---@param tool ItemStack?
---@param digger ObjectRef?
---@param pos vector?
---@return string[]
function core.get_node_drops(node, toolname, tool, digger, pos) end

-- * `core.get_craft_result(input)`: returns `output, decremented_input`
--     * `input.method` = `"normal"` or `"cooking"` or `"fuel"`
--     * `input.width` = for example `3`
--     * `input.items` = for example
--       `{stack1, stack2, stack3, stack4, stack 5, stack 6, stack 7, stack 8, stack 9}`
--     * `output.item` = `ItemStack`, if unsuccessful: empty `ItemStack`
--     * `output.time` = a number, if unsuccessful: `0`
--     * `output.replacements` = List of replacement `ItemStack`s that couldn't be
--       placed in `decremented_input.items`. Replacements can be placed in
--       `decremented_input` if the stack of the replaced item has a count of 1.
--     * `decremented_input` = like `input`
---@param input {method: "normal"|"cooking"|"fuel", width:number, items:InvList}
---@return {item: ItemStack, time:number?, replacements: InvList}?,ItemStack?
function core.get_craft_result(input) end

-- * `core.get_craft_recipe(output)`: returns input
--     * returns last registered recipe for output item (node)
--     * `output` is a node or item type such as `"default:torch"`
--     * `input.method` = `"normal"` or `"cooking"` or `"fuel"`
--     * `input.width` = for example `3`
--     * `input.items` = for example
--       `{stack1, stack2, stack3, stack4, stack 5, stack 6, stack 7, stack 8, stack 9}`
--         * `input.items` = `nil` if no recipe found
---@param output string
---@return {method: "normal"|"cooking"|"fuel", width: number, items:InvList?}?
function core.get_craft_recipe(output) end

-- * `core.get_all_craft_recipes(query item)`: returns a table or `nil`
--     * returns indexed table with all registered recipes for query item (node)
--       or `nil` if no recipe was found.
--     * recipe entry table:
--         * `method`: 'normal' or 'cooking' or 'fuel'
--         * `width`: 0-3, 0 means shapeless recipe
--         * `items`: indexed [1-9] table with recipe items
--         * `output`: string with item name and quantity
--     * Example result for `"default:gold_ingot"` with two recipes:
--       ```lua
--       {
--           {
--               method = "cooking", width = 3,
--               output = "default:gold_ingot", items = {"default:gold_lump"}
--           },
--           {
--               method = "normal", width = 1,
--               output = "default:gold_ingot 9", items = {"default:goldblock"}
--           }
--       }
--       ```
--
---@param query_item string
---@return {method: "cooking"|"normal"|"fuel", width: number, items:InvList, output: string}[]?
function core.get_all_craft_recipes(query_item) end

-- * `core.handle_node_drops(pos, drops, digger)`
--     * `drops`: list of itemstrings
--     * Handles drops from nodes after digging: Default action is to put them
--       into digger's inventory.
--     * Can be overridden to get different functionality (e.g. dropping items on
--       ground)
---@param pos vector
---@param drops string[]
---@param digger PlayerRef
function core.handle_node_drops(pos, drops, digger) end
-- * `core.itemstring_with_palette(item, palette_index)`: returns an item
--   string.
--     * Creates an item string which contains palette index information
--       for hardware colorization. You can use the returned string
--       as an output in a craft recipe.
--     * `item`: the item stack which becomes colored. Can be in string,
--       table and native form.
--     * `palette_index`: this index is added to the item stack
---@param item ItemStackAny
---@param palette_index number
---@return string
function core.itemstring_with_palette(item, palette_index) end

-- * `core.itemstring_with_color(item, colorstring)`: returns an item string
--     * Creates an item string which contains static color information
--       for hardware colorization. Use this method if you wish to colorize
--       an item that does not own a palette. You can use the returned string
--       as an output in a craft recipe.
--     * `item`: the item stack which becomes colored. Can be in string,
--       table and native form.
--     * `colorstring`: the new color of the item stack
---@param item ItemStackAny
---@param colorstring ColorString
---@return string
function core.itemstring_with_color(item, colorstring) end

-- * `core.rollback_get_node_actions(pos, range, seconds, limit)`:
--   returns `{{actor, pos, time, oldnode, newnode}, ...}`
--     * Find who has done something to a node, or near a node
--     * `actor`: `"player:<name>"`, also `"liquid"`.
---@param pos vector
---@param range number
---@param seconds number
---@param limit number
---@return {[1]:PlayerRef, [2]:vector, [3]:number, [4]:MapNode, [5]:MapNode}[]
function core.rollback_get_node_actions(pos, range, seconds, limit) end

-- * `core.rollback_revert_actions_by(actor, seconds)`: returns
--   `boolean, log_messages`.
--     * Revert latest actions of someone
--     * `actor`: `"player:<name>"`, also `"liquid"`.
---@param actor string
---@param seconds number
---@return boolean, string[] log_messages
function core.rollback_revert_actions_by(actor, seconds) end