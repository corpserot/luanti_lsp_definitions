---@meta

--- These are some of your first functions that you use

-- * `core.set_node(pos, node)`
--     * Set node at position `pos`.
--     * Any existing metadata is deleted.
--     * `node`: table `{name=string, param1=number, param2=number}`
--       If param1 or param2 is omitted, it's set to `0`.
--     * e.g. `core.set_node({x=0, y=10, z=0}, {name="default:wood"})`
---@param pos vector
---@param node MapNodeOpt
function core.set_node(pos, node) end

--- Alias to core.set_node
--- Unofficial note: I think you should be strict and only use `core.set_node`
core.add_node = core.set_node

---@param posarr vector[]
---@param node MapNodeOpt
function core.bulk_set_node(posarr, node) end

-- * `core.swap_node(pos, node)`
--     * Swap node at position with another.
--     * This keeps the metadata intact and will not run con-/destructor callbacks.
---@param pos vector
---@param node MapNodeOpt
function core.swap_node(pos, node) end

-- * `core.bulk_swap_node({pos1, pos2, pos3, ...}, node)`
--     * Equivalent to `core.swap_node` but in bulk.
---@param posarr vector[]
---@param node MapNodeOpt
function core.bulk_swap_node(posarr, node) end

-- * `core.bulk_swap_node({pos1, pos2, pos3, ...}, node)`
--     * Equivalent to `core.swap_node` but in bulk.
---@param pos vector
function core.remove_node(pos) end

-- * `core.get_node(pos)`
--     * Returns the node at the given position as table in the same format as `set_node`.
--     * This function never returns `nil` and instead returns
--       `{name="ignore", param1=0, param2=0}` for unloaded areas.
---@nodiscard
---@param pos vector
---@return MapNode
function core.get_node(pos) end

-- * `core.get_node_or_nil(pos)`
--     * Same as `get_node` but returns `nil` for unloaded areas.
--     * Note that even loaded areas can contain "ignore" nodes.
---@nodiscard
---@param pos vector
---@return MapNode?
function core.get_node_or_nil(pos) end

-- * `core.get_node_raw(x, y, z)`
--     * Same as `get_node` but a faster low-level API
--     * Returns `content_id`, `param1`, `param2`, and `pos_ok`
--     * The `content_id` can be mapped to a name using `core.get_name_from_content_id()`
--     * If `pos_ok` is false, the area is unloaded and `content_id == core.CONTENT_IGNORE`
---@nodiscard
---@param x number
---@param y number
---@param z number
---@return content_id, number param1, number param2, boolean pos_ok
function core.get_node_raw(x, y, z) end

--- Unofficial note: NOO!!! THE LAIGHT!!! NOT THE LAIGHT!!!
--
-- * `core.get_node_light(pos[, timeofday])`
--     * Gets the light value at the given position. Note that the light value
--       "inside" the node at the given position is returned, so you usually want
--       to get the light value of a neighbor.
--     * `pos`: The position where to measure the light.
--     * `timeofday`: `nil` for current time, `0` for night, `0.5` for day
--     * Returns a number between `0` and `15` or `nil`
--     * `nil` is returned e.g. when the map isn't loaded at `pos`
---@param pos vector
---@param timeofday number?
---@return light_level?
function core.get_node_light(pos, timeofday) end

-- * `core.get_natural_light(pos[, timeofday])`
--     * Figures out the sunlight (or moonlight) value at pos at the given time of
--       day.
--     * `pos`: The position of the node
--     * `timeofday`: `nil` for current time, `0` for night, `0.5` for day
--     * Returns a number between `0` and `15` or `nil`
--     * This function tests 203 nodes in the worst case, which happens very
--       unlikely
---@param pos vector
---@param timeofday number?
---@return light_level?
function core.get_natural_light(pos, timeofday) end

-- * `core.get_artificial_light(param1)`
--     * Calculates the artificial light (light from e.g. torches) value from the
--       `param1` value.
--     * `param1`: The param1 value of a `paramtype = "light"` node.
--     * Returns a number between `0` and `15`
--     * Currently it's the same as `math.floor(param1 / 16)`, except that it
--       ensures compatibility.
---@nodiscard
---@param param1 number
---@return number
function core.get_artificial_light(param1) end

-- * `core.place_node(pos, node[, placer])`
--     * Place node with the same effects that a player would cause
--     * `placer`: The ObjectRef that places the node (optional)
---@param pos vector
---@param node MapNode
---@param placer PlayerRef?
---@return nil
function core.place_node(pos, node, placer) end

-- * `core.dig_node(pos[, digger])`
--     * Dig node with the same effects that a player would cause
--     * `digger`: The ObjectRef that digs the node (optional)
--     * Returns `true` if successful, `false` on failure (e.g. protected location)
---@param pos vector
---@param digger PlayerRef?
---@return boolean
function core.dig_node(pos, digger) end

-- * `core.punch_node(pos[, puncher])`
--     * Punch node with the same effects that a player would cause
--     * `puncher`: The ObjectRef that punches the node (optional)
---@param pos vector
---@param puncher PlayerRef?
---@return nil
function core.punch_node(pos, puncher) end

-- * `core.spawn_falling_node(pos)`
--     * Change node into falling node
--     * Returns `true` and the ObjectRef of the spawned entity if successful, `false` on failure
---@param pos vector
---@return boolean
function core.spawn_falling_node(pos) end

-- * `core.find_nodes_with_meta(pos1, pos2)`
--     * Get a table of positions of nodes that have metadata within a region
--       {pos1, pos2}.
---@nodiscard
---@param pos1 vector
---@param pos2 vector
---@return vector[]
function core.find_nodes_with_meta(pos1, pos2) end

---@nodiscard
---@param pos vector
---@return NodeMetaRef
function core.get_meta(pos) end

---@class NodeTimerRef
-- * `set(timeout,elapsed)`
--     * set a timer's state
--     * `timeout` is in seconds, and supports fractional values (0.1 etc)
--     * `elapsed` is in seconds, and supports fractional values (0.1 etc)
--     * will trigger the node's `on_timer` function after `(timeout - elapsed)`
--       seconds.
---@field set fun(timeout:number, elapsed:number)
---@field start fun(timeout:number)
---@field stop fun()
---@field get_timeout fun():number
---@field get_elapsed fun():number
---@field is_started fun():boolean

---@nodiscard
---@param pos vector
---@return NodeTimerRef
function core.get_node_timer(pos) end

-- * `core.add_entity(pos, name, [staticdata])`: Spawn Lua-defined entity at
--   position.
--     * Returns `ObjectRef`, or `nil` if failed
--     * Entities with `static_save = true` can be added also
--       to unloaded and non-generated blocks.
---@param pos vector
---@param name string
---@param staticdata string?
---@return luaentity?
function core.add_entity(pos, name, staticdata) end

-- * `core.add_item(pos, item)`: Spawn item
--     * Returns `ObjectRef`, or `nil` if failed
--     * Items can be added also to unloaded and non-generated blocks.
---@param pos vector
---@param item ItemStack
---@return luaentity?
function core.add_item(pos, item) end

-- * `core.get_player_by_name(name)`: Get an `ObjectRef` to a player
--     * Returns nothing in case of error (player offline, doesn't exist, ...).
---@param name string
---@return PlayerRef
function core.get_player_by_name(name) end

-- * `core.get_objects_inside_radius(center, radius)`
--     * returns a list of ObjectRefs
--     * `radius`: using a Euclidean metric
--     * **Warning**: Any kind of interaction with the environment or other APIs
--       can cause later objects in the list to become invalid while you're iterating it.
--       (e.g. punching an entity removes its children)
--       It is recommended to use `core.objects_inside_radius` instead, which
--       transparently takes care of this possibility.
---@param center vector
---@param radius number
---@return ObjectRef[]
function core.get_objects_inside_radius(center, radius) end

-- * `core.objects_inside_radius(center, radius)`
--     * returns an iterator of valid objects
--     * example: `for obj in core.objects_inside_radius(center, radius) do obj:punch(...) end`
---@param center vector
---@param radius number
---@return function
function core.objects_inside_radius(center, radius) end

-- * `core.get_objects_in_area(min_pos, max_pos)`
--     * returns a list of ObjectRefs
--     * `min_pos` and `max_pos` are the min and max positions of the area to search
--     * **Warning**: The same warning as for `core.get_objects_inside_radius` applies.
--       Use `core.objects_in_area` instead to iterate only valid objects.
---@nodiscard
---@param minp vector
---@param maxp vector
---@return ObjectRef[]
function core.get_objects_in_area(minp, maxp) end

-- * `core.objects_in_area(min_pos, max_pos)`
--     * returns an iterator of valid objects
---@nodiscard
---@param minp vector
---@param maxp vector
---@return function
function core.objects_in_area(minp, maxp) end

---@param val number
function core.set_timeofday(val) end

-- * `core.get_timeofday()`: get time of day
---@return number
function core.get_timeofday() end

-- * `core.get_gametime()`: returns the time, in seconds, since the world was
--   created. The time is not available (`nil`) before the first server step.
---@return number?
function core.get_gametime() end

-- * `core.get_day_count()`: returns number days elapsed since world was
--   created.
--     * Time changes are accounted for.
---@return number
function core.get_day_count() end

-- Unofficial note: I think this function is a lot laggier than the alternatives
-- If you are simply trying to check if a node is in a big area, use `core.find_nodes_in_area`
-- Anyway, someone will need to fact check me on that claim! Anyway: The actual docs:
-- But you can notice that it doesn't have that pesky volume limit, so it's implemented differently
--
-- * `core.find_node_near(pos, radius, nodenames, [search_center])`: returns
--   pos or `nil`.
--     * `radius`: using a maximum metric
--     * `nodenames`: e.g. `{"ignore", "group:tree"}` or `"default:dirt"`
--     * `search_center` is an optional boolean (default: `false`)
--       If true `pos` is also checked for the nodes
---@nodiscard
---@param radius number
---@param nodenames string[]|string
---@param search_center boolean?
---@return vector?
function core.find_node_near(pos, radius, nodenames, search_center) end

-- * `core.find_nodes_in_area(pos1, pos2, nodenames, [grouped])`
--     * `pos1` and `pos2` are the min and max positions of the area to search.
--     * `nodenames`: e.g. `{"ignore", "group:tree"}` or `"default:dirt"`
--     * If `grouped` is true the return value is a table indexed by node name
--       which contains lists of positions.
--     * If `grouped` is false or absent the return values are as follows:
--       first value: Table with all node positions
--       second value: Table with the count of each node with the node name
--       as index
--     * Area volume is limited to 150,000,000 nodes
---@nodiscard
---@param pos1 vector
---@param pos2 vector
---@param nodenames string[]|string
---@param grouped boolean?
---@return table<string, vector[]>|vector[], table<string, number>?
function core.find_nodes_in_area(pos1, pos2, nodenames, grouped) end

-- * `core.find_nodes_in_area_under_air(pos1, pos2, nodenames)`: returns a
--   list of positions.
--     * `nodenames`: e.g. `{"ignore", "group:tree"}` or `"default:dirt"`
--     * Return value: Table with all node positions with a node air above
--     * Area volume is limited to 150,000,000 nodes
---@param pos1 vector
---@param pos2 vector
---@param nodenames string[]|string
---@return vector[]
function core.find_nodes_in_area_under_air(pos1, pos2, nodenames) end
