---@meta _
-- DRAFT 1 WIP
-- lua_api.md: 'core' namespace reference > Environment access

-- ---------------------------------- node ---------------------------------- --

--[[
* `core.set_node(pos, node)`
    * Set node at position `pos`.
    * Any existing metadata is deleted.
    * `node`: table `{name=string, param1=number, param2=number}`
      If param1 or param2 is omitted, it's set to `0`.
    * e.g. `core.set_node({x=0, y=10, z=0}, {name="default:wood"})`
]]
---@param pos vector
---@param node core.Node.set
function core.set_node(pos, node) end

--[[
Alias to core.set_node
Unofficial note: I think you should be strict and only use `core.set_node`
]]
core.add_node = core.set_node

--[[
WIPDOC
]]
---@param posarr vector[]
---@param node core.Node.set
function core.bulk_set_node(posarr, node) end

--[[
* `core.swap_node(pos, node)`
    * Swap node at position with another.
    * This keeps the metadata intact and will not run con-/destructor callbacks.
]]
---@param pos vector
---@param node core.Node.set
function core.swap_node(pos, node) end

--[[
* `core.bulk_swap_node({pos1, pos2, pos3, ...}, node)`
    * Equivalent to `core.swap_node` but in bulk.
]]
---@param posarr vector[]
---@param node core.Node.set
function core.bulk_swap_node(posarr, node) end

--[[
* `core.bulk_swap_node({pos1, pos2, pos3, ...}, node)`
    * Equivalent to `core.swap_node` but in bulk.
]]
---@param pos vector
function core.remove_node(pos) end

--[[
* `core.get_node(pos)`
    * Returns the node at the given position as table in the same format as `set_node`.
    * This function never returns `nil` and instead returns
      `{name="ignore", param1=0, param2=0}` for unloaded areas.
]]
---@nodiscard
---@param pos vector
---@return core.Node.set
function core.get_node(pos) end

--[[
* `core.get_node_or_nil(pos)`
    * Same as `get_node` but returns `nil` for unloaded areas.
    * Note that even loaded areas can contain "ignore" nodes.
]]
---@nodiscard
---@param pos vector
---@return core.Node.get?
function core.get_node_or_nil(pos) end

--[[
* `core.get_node_raw(x, y, z)`
    * Same as `get_node` but a faster low-level API
    * Returns `content_id`, `param1`, `param2`, and `pos_ok`
    * The `content_id` can be mapped to a name using `core.get_name_from_content_id()`
    * If `pos_ok` is false, the area is unloaded and `content_id == core.CONTENT_IGNORE`
]]
---@nodiscard
---@param x number
---@param y number
---@param z number
---@return core.ContentID, number param1, number param2, boolean pos_ok
function core.get_node_raw(x, y, z) end

--[[
* `core.get_node_light(pos[, timeofday])`
    * Gets the light value at the given position. Note that the light value
      "inside" the node at the given position is returned, so you usually want
      to get the light value of a neighbor.
    * `pos`: The position where to measure the light.
    * `timeofday`: `nil` for current time, `0` for night, `0.5` for day
    * Returns a number between `0` and `15` or `nil`
    * `nil` is returned e.g. when the map isn't loaded at `pos`
]]
---@param pos vector
---@param timeofday number?
---@return core.Light?
function core.get_node_light(pos, timeofday) end

--[[
* `core.get_natural_light(pos[, timeofday])`
    * Figures out the sunlight (or moonlight) value at pos at the given time of
      day.
    * `pos`: The position of the node
    * `timeofday`: `nil` for current time, `0` for night, `0.5` for day
    * Returns a number between `0` and `15` or `nil`
    * This function tests 203 nodes in the worst case, which happens very
      unlikely
]]
---@param pos vector
---@param timeofday number?
---@return core.Light?
function core.get_natural_light(pos, timeofday) end

--[[
* `core.get_artificial_light(param1)`
    * Calculates the artificial light (light from e.g. torches) value from the
      `param1` value.
    * `param1`: The param1 value of a `paramtype = "light"` node.
    * Returns a number between `0` and `15`
    * Currently it's the same as `math.floor(param1 / 16)`, except that it
      ensures compatibility.
]]
---@nodiscard
---@param param1 number
---@return number
function core.get_artificial_light(param1) end

--[[
* `core.place_node(pos, node[, placer])`
    * Place node with the same effects that a player would cause
    * `placer`: The ObjectRef that places the node (optional)
]]
---@param pos vector
---@param node core.Node.get
---@param placer core.PlayerRef?
---@return nil
function core.place_node(pos, node, placer) end

--[[
* `core.dig_node(pos[, digger])`
    * Dig node with the same effects that a player would cause
    * `digger`: The ObjectRef that digs the node (optional)
    * Returns `true` if successful, `false` on failure (e.g. protected location)
]]
---@param pos vector
---@param digger core.PlayerRef?
---@return boolean
function core.dig_node(pos, digger) end

--[[
* `core.punch_node(pos[, puncher])`
    * Punch node with the same effects that a player would cause
    * `puncher`: The ObjectRef that punches the node (optional)
]]
---@param pos vector
---@param puncher core.PlayerRef?
---@return nil
function core.punch_node(pos, puncher) end

--[[
* `core.spawn_falling_node(pos)`
    * Change node into falling node
    * Returns `true` and the ObjectRef of the spawned entity if successful, `false` on failure
]]
---@param pos vector
---@return boolean
function core.spawn_falling_node(pos) end

--[[
* `core.find_nodes_with_meta(pos1, pos2)`
    * Get a table of positions of nodes that have metadata within a region
      {pos1, pos2}.
]]
---@nodiscard
---@param pos1 vector
---@param pos2 vector
---@return vector[]
function core.find_nodes_with_meta(pos1, pos2) end

--[[
WIPDOC
]]
---@nodiscard
---@param pos vector
---@return NodeMetaRef
function core.get_meta(pos) end

--[[
WIPDOC
]]
---@nodiscard
---@param pos vector
---@return NodeTimerRef
function core.get_node_timer(pos) end

-- --------------------------------- entity --------------------------------- --

--[[
* `core.add_entity(pos, name, [staticdata])`: Spawn Lua-defined entity at
  position.
    * Returns `ObjectRef`, or `nil` if failed
    * Entities with `static_save = true` can be added also
      to unloaded and non-generated blocks.
]]
---@param pos vector
---@param name string
---@param staticdata string?
---@return ObjectRef?
function core.add_entity(pos, name, staticdata) end

--[[
* `core.add_item(pos, item)`: Spawn item
    * Returns `ObjectRef`, or `nil` if failed
    * Items can be added also to unloaded and non-generated blocks.
]]
---@param pos vector
---@param item ItemStack
---@return LuaEntityRef?
function core.add_item(pos, item) end

--[[
* `core.get_player_by_name(name)`: Get an `ObjectRef` to a player
    * Returns nothing in case of error (player offline, doesn't exist, ...).
]]
---@param name string
---@return core.PlayerRef
function core.get_player_by_name(name) end

--[[
* `core.get_objects_inside_radius(center, radius)`
    * returns a list of ObjectRefs
    * `radius`: using a Euclidean metric
    * **Warning**: Any kind of interaction with the environment or other APIs
      can cause later objects in the list to become invalid while you're iterating it.
      (e.g. punching an entity removes its children)
      It is recommended to use `core.objects_inside_radius` instead, which
      transparently takes care of this possibility.
]]
---@param center vector
---@param radius number
---@return ObjectRef[]
function core.get_objects_inside_radius(center, radius) end

--[[
* `core.objects_inside_radius(center, radius)`
    * returns an iterator of valid objects
    * example: `for obj in core.objects_inside_radius(center, radius) do obj:punch(...) end`
]]
---@param center vector
---@param radius number
---@return function
function core.objects_inside_radius(center, radius) end

--[[
* `core.get_objects_in_area(min_pos, max_pos)`
    * returns a list of ObjectRefs
    * `min_pos` and `max_pos` are the min and max positions of the area to search
    * **Warning**: The same warning as for `core.get_objects_inside_radius` applies.
      Use `core.objects_in_area` instead to iterate only valid objects.
]]
---@nodiscard
---@param minp vector
---@param maxp vector
---@return ObjectRef[]
function core.get_objects_in_area(minp, maxp) end

--[[
* `core.objects_in_area(min_pos, max_pos)`
    * returns an iterator of valid objects
]]
---@nodiscard
---@param minp vector
---@param maxp vector
---@return function
function core.objects_in_area(minp, maxp) end

-- ---------------------------------- time ---------------------------------- --

--[[
WIPDOC
]]
---@param val number
function core.set_timeofday(val) end

--[[
* `core.get_timeofday()`: get time of day
]]
---@return number
function core.get_timeofday() end

--[[
* `core.get_gametime()`: returns the time, in seconds, since the world was
  created. The time is not available (`nil`) before the first server step.
]]
---@return number?
function core.get_gametime() end

--[[
* `core.get_day_count()`: returns number days elapsed since world was
  created.
    * Time changes are accounted for.
]]
---@return number
function core.get_day_count() end

-- -------------------------------- find node ------------------------------- --

--[[
Unofficial note: I think this function is a lot laggier than the alternatives
If you are simply trying to check if a node is in a big area, use `core.find_nodes_in_area`
Anyway, someone will need to fact check me on that claim! Anyway: The actual docs:
But you can notice that it doesn't have that pesky volume limit, so it's implemented differently

* `core.find_node_near(pos, radius, nodenames, [search_center])`: returns
  pos or `nil`.
    * `radius`: using a maximum metric
    * `nodenames`: e.g. `{"ignore", "group:tree"}` or `"default:dirt"`
    * `search_center` is an optional boolean (default: `false`)
      If true `pos` is also checked for the nodes
]]
---@nodiscard
---@param radius number
---@param nodenames string[]|string
---@param search_center boolean?
---@return vector?
function core.find_node_near(pos, radius, nodenames, search_center) end

--[[
* `core.find_nodes_in_area(pos1, pos2, nodenames, [grouped])`
    * `pos1` and `pos2` are the min and max positions of the area to search.
    * `nodenames`: e.g. `{"ignore", "group:tree"}` or `"default:dirt"`
    * If `grouped` is true the return value is a table indexed by node name
      which contains lists of positions.
    * If `grouped` is false or absent the return values are as follows:
      first value: Table with all node positions
      second value: Table with the count of each node with the node name
      as index
    * Area volume is limited to 150,000,000 nodes
]]
---@nodiscard
---@param pos1 vector
---@param pos2 vector
---@param nodenames string[]|string
---@param grouped true
---@return table<string, vector[]>
function core.find_nodes_in_area(pos1, pos2, nodenames, grouped) end

--[[
WIPDOC
]]
---@nodiscard
---@param pos1 vector
---@param pos2 vector
---@param nodenames string[]|string
---@param grouped false?
---@return vector[], table<string, number>
function core.find_nodes_in_area(pos1, pos2, nodenames, grouped) end

--[[
* `core.find_nodes_in_area_under_air(pos1, pos2, nodenames)`: returns a
  list of positions.
    * `nodenames`: e.g. `{"ignore", "group:tree"}` or `"default:dirt"`
    * Return value: Table with all node positions with a node air above
    * Area volume is limited to 150,000,000 nodes
]]
---@param pos1 vector
---@param pos2 vector
---@param nodenames string[]|string
---@return vector[]
function core.find_nodes_in_area_under_air(pos1, pos2, nodenames) end

-- ---------------------- mapblocks and map generation ---------------------- --

--[[ core.get_value_noise() .. core.get_voxel_manip() split off into classes/ValueNoise.lua ]]--

--[[ core.set_gen_notify() .. core.get_gen_notify() split off into ./gen_notify.lua ]]

--[[
WIPDOC
]]
---@param decoration_name string
function core.get_decoration_id(decoration_name) end

--[[
WIPDOC
]]
---@param objectname string
---@return unknown
---@overload fun(objectname:"voxelmanip"):VoxelManip,vector,vector
---@overload fun(objectname:"heightmap"):vector[]
---@overload fun(objectname:"biomemap"):integer
---@overload fun(objectname:"heatmap"):number
---@overload fun(objectname:"humiditymap"):number
---@overload fun(objectname:"gennotify"):table<string,any>
function core.get_mapgen_object(objectname) end

--[[
Unofficial note: this relates to the biome heat, idk override it and make your own custom mapgen if you dare
* `core.get_heat(pos)`
    * Returns the heat at the position, or `nil` on failure.
]]
---@return number?
---@param pos vector
function core.get_heat(pos) end

--[[
Unofficial note: this relates to the biome humidity, idk override it and make your own custom mapgen if you dare
* `core.get_humidity(pos)`
    * Returns the humidity at the position, or `nil` on failure.
]]
---@return number?
---@param pos vector
function core.get_humidity(pos) end

--[[
* `core.get_biome_data(pos)`
    * Returns a table containing:
        * `biome` the biome id of the biome at that position
        * `heat` the heat at the position
        * `humidity` the humidity at the position
    * Or returns `nil` on failure.
]]
---@param pos vector
---@return {biome:number, heat:number, humidity:number}?
function core.get_biome_data(pos) end

--[[
* `core.get_biome_id(biome_name)`
    * Returns the biome id, as used in the biomemap Mapgen object and returned
      by `core.get_biome_data(pos)`, for a given biome_name string.
]]
---@param biome_name string
---@return number
function core.get_biome_id(biome_name) end

--[[
* `core.get_biome_name(biome_id)`
    * Returns the biome name string for the provided biome id, or `nil` on
      failure.
    * If no biomes have been registered, such as in mgv6, returns `default`.
]]
---@param biome_id number
---@return string?
function core.get_biome_name(biome_id) end

--[[
* `core.get_mapgen_params()`
    * Deprecated: use `core.get_mapgen_setting(name)` instead.
    * Returns a table containing:
        * `mgname`
        * `seed`
        * `chunksize`
        * `water_level`
        * `flags`
]]
function core.get_mapgen_params() end

--[[
* `core.set_mapgen_params(MapgenParams)`
    * Deprecated: use `core.set_mapgen_setting(name, value, override)`
      instead.
    * Set map generation parameters.
    * Function cannot be called after the registration period.
    * Takes a table as an argument with the fields:
        * `mgname`
        * `seed`
        * `chunksize`
        * `water_level`
        * `flags`
    * Leave field unset to leave that parameter unchanged.
    * `flags` contains a comma-delimited string of flags to set, or if the
      prefix `"no"` is attached, clears instead.
    * `flags` is in the same format and has the same options as `mg_flags` in
      `minetest.conf`.
]]
function core.set_mapgen_params(MapgenParams) end

--[=[
* `core.get_mapgen_edges([mapgen_limit[, chunksize]])`
    * Returns the minimum and maximum possible generated node positions
      in that order.
    * `mapgen_limit` is an optional number. If it is absent, its value is that
      of the *active* mapgen setting `"mapgen_limit"`.
    * `chunksize` is an optional number. If it is absent, its value is that
      of the *active* mapgen setting `"chunksize"`.
]=]
---@param mapgen_limit number?
---@param chunksize number?
function core.get_mapgen_edges(mapgen_limit, chunksize) end

--[[
* `core.get_mapgen_chunksize()`
    * Returns the currently active chunksize of the mapgen, as a vector.
      The size is specified in blocks.
]]
---@return vector
function core.get_mapgen_chunksize() end

--[[
* `core.get_mapgen_setting(name)`
    * Gets the *active* mapgen setting (or nil if none exists) in string
      format with the following order of precedence:
        1) Settings loaded from map_meta.txt or overrides set during mod
           execution.
        2) Settings set by mods without a metafile override
        3) Settings explicitly set in the user config file, minetest.conf
        4) Settings set as the user config default
]]
---@param name string
---@return string
function core.get_mapgen_setting(name) end

--[[
* `core.get_mapgen_setting_noiseparams(name)`
    * Same as above, but returns the value as a NoiseParams table if the
      setting `name` exists and is a valid NoiseParams.
]]
---@return NoiseParams
---@param name string
function core.get_mapgen_setting_noiseparams(name) end

--[[
* `core.set_mapgen_setting(name, value, [override_meta])`
    * Sets a mapgen param to `value`, and will take effect if the corresponding
      mapgen setting is not already present in map_meta.txt.
    * `override_meta` is an optional boolean (default: `false`). If this is set
      to true, the setting will become the active setting regardless of the map
      metafile contents.
    * Note: to set the seed, use `"seed"`, not `"fixed_map_seed"`.
]]
---@param name string
---@param value string
---@param override_meta boolean?
---@return nil
function core.set_mapgen_setting(name, value, override_meta) end

--[[
* `core.set_mapgen_setting_noiseparams(name, value, [override_meta])`
    * Same as above, except value is a NoiseParams table.
]]
---@param value NoiseParams
---@param override_meta boolean?
---@param name string
function core.set_mapgen_setting_noiseparams(name, value, override_meta) end

--[[
* `core.set_noiseparams(name, noiseparams, set_default)`
    * Sets the noiseparams setting of `name` to the noiseparams table specified
      in `noiseparams`.
    * `set_default` is an optional boolean (default: `true`) that specifies
      whether the setting should be applied to the default config or current
      active config.
]]
---@param name string
---@param noiseparams NoiseParams
---@param set_default boolean?
---@return nil
function core.set_noiseparams(name, noiseparams, set_default) end

--[[
WIPDOC
]]
---@param name string
---@return NoiseParams
function core.get_noiseparams(name) end

--[[
* `core.generate_ores(vm, pos1, pos2)`
    * Generate all registered ores within the VoxelManip `vm` and in the area
      from `pos1` to `pos2`.
    * `pos1` and `pos2` are optional and default to mapchunk minp and maxp.
]]
---@param vm VoxelManip
---@param pos1 vector?
---@param pos2 vector?
function core.generate_ores(vm, pos1, pos2) end

--[[
* `core.generate_decorations(vm, pos1, pos2)`
    * Generate all registered decorations within the VoxelManip `vm` and in the
      area from `pos1` to `pos2`.
    * `pos1` and `pos2` are optional and default to mapchunk minp and maxp.
]]
---@param vm VoxelManip
---@param pos1 vector?
---@param pos2 vector?
function core.generate_decorations(vm, pos1, pos2) end

--[[
* `core.clear_objects([options])`
    * Clear all objects in the environment
    * Takes an optional table as an argument with the field `mode`.
        * mode = `"full"`: Load and go through every mapblock, clearing
                            objects (default).
        * mode = `"quick"`: Clear objects immediately in loaded mapblocks,
                            clear objects in unloaded mapblocks only when the
                            mapblocks are next activated.
]]
---@param opt ("full"|"quick")?
function core.clear_objects(opt) end

--[[
* `core.load_area(pos1[, pos2])`
    * Load the mapblocks containing the area from `pos1` to `pos2`.
      `pos2` defaults to `pos1` if not specified.
    * This function does not trigger map generation.
]]
---@param pos1 vector
---@param pos2 vector?
---@return nil
function core.load_area(pos1, pos2) end

--[[
WIPDOC
]]
---@class core.EMERGE_CANCELLED
core.EMERGE_CANCELLED = nil

--[[
WIPDOC
]]
---@class core.EMERGE_ERRORED
core.EMERGE_ERRORED = nil

--[[
WIPDOC
]]
---@class core.EMERGE_FROM_MEMORY
core.EMERGE_FROM_MEMORY = nil

--[[
WIPDOC
]]
---@class core.EMERGE_FROM_DISK
core.EMERGE_FROM_DISK = nil

--[[
WIPDOC
]]
---@class core.EMERGE_GENERATED
core.EMERGE_GENERATED = nil

---@alias EmergeAction
--- | core.EMERGE_CANCELLED
--- | core.EMERGE_ERRORED
--- | core.EMERGE_FROM_MEMORY
--- | core.EMERGE_FROM_DISK
--- | core.EMERGE_GENERATED

--[[
* `core.emerge_area(pos1, pos2, [callback], [param])`
    * Queue all blocks in the area from `pos1` to `pos2`, inclusive, to be
      asynchronously fetched from memory, loaded from disk, or if inexistent,
      generates them.
    * If `callback` is a valid Lua function, this will be called for each block
      emerged.
    * The function signature of callback is:
      `function EmergeAreaCallback(blockpos, action, calls_remaining, param)`
        * `blockpos` is the *block* coordinates of the block that had been
          emerged.
        * `action` could be one of the following constant values:
            * `core.EMERGE_CANCELLED`
            * `core.EMERGE_ERRORED`
            * `core.EMERGE_FROM_MEMORY`
            * `core.EMERGE_FROM_DISK`
            * `core.EMERGE_GENERATED`
        * `calls_remaining` is the number of callbacks to be expected after
          this one.
        * `param` is the user-defined parameter passed to emerge_area (or
          nil if the parameter was absent).
]]
---@param pos1 vector
---@param pos2 vector
---@param callback fun(blockpos:vector, action:EmergeAction , calls_remaining:number, param:any?)?
---@param param any?
---@async
function core.emerge_area(pos1, pos2, callback, param) end

--[[
* `core.delete_area(pos1, pos2)`
    * delete all mapblocks in the area from pos1 to pos2, inclusive
]]
---@param pos1 vector
---@param pos2 vector
---@return nil
function core.delete_area(pos1, pos2) end

-- ----------------------- ray casting and pathfinding ---------------------- --

--[[
Unofficial note: The annoying thing about this little function is that it is hardcoded to check specifically for "air", nothing else
Though i am sure you can make it work out

* `core.line_of_sight(pos1, pos2)`: returns `boolean, pos`
    * Checks if there is anything other than air between pos1 and pos2.
    * Returns false if something is blocking the sight.
    * Returns the position of the blocking node when `false`
    * `pos1`: First position
    * `pos2`: Second position
]]
---@param pos1 vector
---@param pos2 vector
---@return boolean, core.Node.get?
function core.line_of_sight(pos1, pos2) end

--[[ core.raycast() split off into classes/Raycast.lua ]]--

--[[
* `core.find_path(pos1, pos2, searchdistance, max_jump, max_drop, algorithm)`
    * returns table containing path that can be walked on
    * returns a table of 3D points representing a path from `pos1` to `pos2` or
      `nil` on failure.
    * Reasons for failure:
        * No path exists at all
        * No path exists within `searchdistance` (see below)
        * Start or end pos is buried in land
    * `pos1`: start position
    * `pos2`: end position
    * `searchdistance`: maximum distance from the search positions to search in.
      In detail: Path must be completely inside a cuboid. The minimum
      `searchdistance` of 1 will confine search between `pos1` and `pos2`.
      Larger values will increase the size of this cuboid in all directions
    * `max_jump`: maximum height difference to consider walkable
    * `max_drop`: maximum height difference to consider droppable
    * `algorithm`: One of `"A*_noprefetch"` (default), `"A*"`, `"Dijkstra"`.
      Difference between `"A*"` and `"A*_noprefetch"` is that
      `"A*"` will pre-calculate the cost-data, the other will calculate it
      on-the-fly
]]
---@nodiscard
---@param pos1 vector
---@param pos2 vector
---@param searchdistance number
---@param max_jump number
---@param max_drop number
---@param algo "A*_noprefetch"|"A*"|"Dijkstra"
---@return vector[]?
function core.find_path(pos1, pos2, searchdistance, max_jump, max_drop, algo) end

-- ------------------------------ L-system tree ----------------------------- --

--[[
WIPDOC
]]
---@param pos vector
---@param lsystem lsystem
---@return nil
function core.spawn_tree(pos, lsystem) end

--[[
WIPDOC
]]
---@param vmanip VoxelManip
---@param pos vector
---@param treedef lsystem
---@return nil
function core.spawn_tree_on_vmanip(vmanip, pos, treedef) end

-- --------------------------------- liquid --------------------------------- --

--[[
* `core.transforming_liquid_add(pos)`
    * add node to liquid flow update queue
]]
function core.transforming_liquid_add(pos) end

-- ------------------------------- node level ------------------------------- --

--[[
* `core.get_node_max_level(pos)`
    * get max available level for leveled node
]]
function core.get_node_max_level(pos) end

--[[
* `core.get_node_level(pos)`
    * get level of leveled node (water, snow)
]]
function core.get_node_level(pos) end

--[[
* `core.set_node_level(pos, level)`
    * set level of leveled node, default `level` equals `1`
    * if `totallevel > maxlevel`, returns rest (`total-max`).
]]
function core.set_node_level(pos, level) end

--[[
* `core.add_node_level(pos, level)`
    * increase level of leveled node by level, default `level` equals `1`
    * if `totallevel > maxlevel`, returns rest (`total-max`)
    * `level` must be between -127 and 127
]]
function core.add_node_level(pos, level) end

-- ---------------------------------- misc ---------------------------------- --

--[[
* `core.get_node_boxes(box_type, pos, [node])`
    * `box_type` must be `"node_box"`, `"collision_box"` or `"selection_box"`.
    * `pos` must be a node position.
    * `node` can be a table in the form `{name=string, param1=number, param2=number}`.
      If `node` is `nil`, the actual node at `pos` is used instead.
    * Resolves any facedir-rotated boxes, connected boxes and the like into
      actual boxes.
    * Returns a list of boxes in the form
      `{{x1, y1, z1, x2, y2, z2}, {x1, y1, z1, x2, y2, z2}, ...}`. Coordinates
      are relative to `pos`.
    * See also: [Node boxes](#node-boxes)
]]
---@param box_type "node_box"|"collision_box"|"selection_box"
---@param pos vector
---@param node core.Node.get?
---@return number[][]
function core.get_node_boxes(box_type, pos, node) end

--[[
* `core.fix_light(pos1, pos2)`: returns `true`/`false`
    * resets the light in a cuboid-shaped part of
      the map and removes lighting bugs.
    * Loads the area if it is not loaded.
    * `pos1` is the corner of the cuboid with the least coordinates
      (in node coordinates), inclusive.
    * `pos2` is the opposite corner of the cuboid, inclusive.
    * The actual updated cuboid might be larger than the specified one,
      because only whole map blocks can be updated.
      The actual updated area consists of those map blocks that intersect
      with the given cuboid.
    * However, the neighborhood of the updated area might change
      as well, as light can spread out of the cuboid, also light
      might be removed.
    * returns `false` if the area is not fully generated,
      `true` otherwise
]]
---@param pos1 vector
---@param pos2 vector
---@return boolean
function core.fix_light(pos1, pos2) end

--[[
Unofficial note: You can override this one for your own custom cool falling blocks
* `core.check_single_for_falling(pos)`
    * causes an unsupported `group:falling_node` node to fall and causes an
      unattached `group:attached_node` node to fall.
    * does not spread these updates to neighbors.
]]
---@param pos vector
function core.check_single_for_falling(pos) end

--[[
* `core.check_for_falling(pos)`
    * causes an unsupported `group:falling_node` node to fall and causes an
      unattached `group:attached_node` node to fall.
    * spread these updates to neighbors and can cause a cascade
      of nodes to fall.
]]
---@param pos vector
function core.check_for_falling(pos) end

--[[
* `core.get_spawn_level(x, z)`
    * Returns a player spawn y coordinate for the provided (x, z)
      coordinates, or `nil` for an unsuitable spawn point.
    * For most mapgens a 'suitable spawn point' is one with y between
      `water_level` and `water_level + 16`, and in mgv7 well away from rivers,
      so `nil` will be returned for many (x, z) coordinates.
    * The spawn level returned is for a player spawn in unmodified terrain.
    * The spawn level is intentionally above terrain level to cope with
      full-node biome 'dust' nodes.
]]
---@param x number
---@param z number
---@return number y
function core.get_spawn_level(x, z) end