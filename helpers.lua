---@meta

-- HEY   EVERY   !!!
--- So lua_api.md has a section for "utilities" and "helpers" and also "further helpers"
--- I am going to have all of those be here

--- Makes `obj` human-readable, handles reference loops
---@param obj any
---@param name string?
---@param dumped table?
---@return string
function dump2(obj, name, dumped) end

---@param value any
---@param indent string?
---@return string
function dump(value, indent) end

---@param x number
---@param y number
---@return number
function math.hypot(x, y) end

---@param x number
---@param tolerance number?
---@return number
function math.sign(x, tolerance) end

---@param x number
---@return number
---@nodiscard # You know since its pretty expensive
function math.factorial(x) end

---@param x number
---@return number
function math.round(x) end

---@param str string
---@param separator string
---@param include_empty boolean?
---@param max_splits integer?
---@param sep_is_pattern boolean?
---@return string[]
function string.split(str, separator, include_empty, max_splits, sep_is_pattern) end

---@param str string
---@param limit integer
---@param as_table boolean?
---@return string
function core.wrap_text(str, limit, as_table) end

---@param pos vector
---@param decimal_places number?
---@return string
function core.pos_to_string(pos, decimal_places) end

---@param string string
---@return vector
function core.string_to_pos(string) end

--[[
returns two positions
Converts a string representing an area box into two positions
X1, Y1, ... Z2 are coordinates
relative_to: Optional. If set to a position, each coordinate can use the tilde notation for relative positions
"~": Relative coordinate
"~<number>": Relative coordinate plus <number>
Example: core.string_to_area("(1,2,3) (~5,~-5,~)", {x=10,y=10,z=10}) returns {x=1,y=2,z=3}, {x=15,y=5,z=10}
]]
---@param str string (X1, Y1, Z1) (X2, Y2, Z2)
---@param relative_to vector?
---@return vector?, vector?
function core.string_to_area(str, relative_to) end

--- escapes the characters "[", "]", "", "," and ";", which cannot be used in formspecs.
---@param string string
---@return string
function core.formspec_escape(string) end

---@param arg any
---@return boolean
function core.is_yes(arg) end

---@param arg any
---@return boolean
function core.is_nan(arg) end

--- returns time with microsecond precision. May not return wall time.
--- Unofficial note: I think you should use os.clock() for benchmarking instead
---@return number
function core.get_us_time() end

---@param table table
---@return table
function table.copy(table) end

---@param table table
---@return table
function table.copy_with_metatables(table) end

--- If it's not found it will return -1, list must not have negative indeces and any non-numerical indeces are ignored
---@param val any
---@param list table<integer, any>
---@return integer
function table.indexof(list, val) end

---@param table table
---@param val any
---@return any
function table.keyof(table, val) end

---@param table table
---@param other_table table
---@return nil
function table.insert_all(table, other_table) end

---@param t table
---@return table
function table.key_value_swap(t) end

---@param table table
---@param from integer?
---@param to integer?
---@param random_func (fun(int1:integer, int2:integer): integer)? # Should return a random int, by default math.random
---@return nil
function table.shuffle(table, from, to, random_func) end

---@param pointed_thing pointed_thing
---@return vector
function core.pointed_thing_to_face_pos(pointed_thing) end

---@param uses integer
---@param initial_wear integer?
---@return integer
function core.get_tool_wear_after_use(uses, initial_wear) end

---@nodiscard
---@param groups table<string, integer>
---@param tool_capabilities tool_capabilities
---@param wear integer?
---@return table
function core.get_dig_params(groups, tool_capabilities, wear) end

---@nodiscard
---@param groups table<string, integer>
---@param wear integer?
---@param tool_capabilities tool_capabilities?
---@param time_from_last_punch number?
---@return table
function core.get_hit_params(groups, tool_capabilities, time_from_last_punch, wear) end

-- Utilities

--- Returns currently loading mod's name WHEN LOADING A MOD
---@return string
---@nodiscard
function core.get_current_modname() end

---@nodiscard
---@param modname string
---@return string
function core.get_modpath(modname) end

---@return string[]
---@nodiscard
function core.get_modnames() end

--- Unofficial: Path is the root directory of the game, useful if you are looking for it
---@return {id:string, title:string, author:string, path:string}
function core.get_game_info() end

---@return string
---@nodiscard
function core.get_worldpath() end

---@return boolean
function core.is_singleplayer() end

--- Oh [[boy]], vim macros are totally not going to get involved hehe
--- OK I love vim macros

---@class core.features
-- 0.4.7
---@field glasslike_framed  boolean?
-- 0.4.7
---@field nodebox_as_selectionbox  boolean?
-- 0.4.7
---@field get_all_craft_recipes_works  boolean?
-- The transparency channel of textures can optionally be used on
-- nodes (0.4.7)
---@field use_texture_alpha  boolean?
-- Tree and grass ABMs are no longer done from C++ (0.4.8)
---@field no_legacy_abms  boolean?
-- Texture grouping is possible using parentheses (0.4.11)
---@field texture_names_parens  boolean?
-- Unique Area ID for AreaStoreinsert_area (0.4.14)
---@field area_store_custom_ids  boolean?
-- add_entity supports passing initial staticdata to on_activate
-- (0.4.16)
---@field add_entity_with_staticdata  boolean?
-- Chat messages are no longer predicted (0.4.16)
---@field no_chat_message_prediction  boolean?
-- The transparency channel of textures can optionally be used on
-- objects (ie players and lua entities) (5.0.0)
---@field object_use_texture_alpha  boolean?
-- Object selectionbox is settable independently from collisionbox
-- (5.0.0)
---@field object_independent_selectionbox  boolean?
-- Specifies whether binary data can be uploaded or downloaded using
-- the HTTP API (5.1.0)
---@field httpfetch_binary_data  boolean?
-- Whether formspec_version[<version>] may be used (5.1.0)
---@field formspec_version_element  boolean?
-- Whether AreaStore's IDs are kept on save/load (5.1.0)
---@field area_store_persistent_ids  boolean?
-- Whether core.find_path is functional (5.2.0)
---@field pathfinder_works  boolean?
-- Whether Collision info is available to an objects' on_step (5.3.0)
---@field object_step_has_moveresult  boolean?
-- Whether get_velocity() and add_velocity() can be used on players (5.4.0)
---@field direct_velocity_on_players  boolean?
-- nodedef's use_texture_alpha accepts new string modes (5.4.0)
---@field use_texture_alpha_string_modes  boolean?
-- degrotate param2 rotates in units of 1.5° instead of 2°
-- thus changing the range of values from 0-179 to 0-240 (5.5.0)
---@field degrotate_240_steps  boolean?
-- ABM supports min_y and max_y fields in definition (5.5.0)
---@field abm_min_max_y  boolean?
-- dynamic_add_media supports passing a table with options (5.5.0)
---@field dynamic_add_media_table  boolean?
-- particlespawners support texpools and animation of properties,
-- particle textures support smooth fade and scale animations, and
-- sprite-sheet particle animations can by synced to the lifetime
-- of individual particles (5.6.0)
---@field particlespawner_tweenable  boolean?
-- allows get_sky to return a table instead of separate values (5.6.0)
---@field get_sky_as_table  boolean?
-- VoxelManipget_light_data accepts an optional buffer argument (5.7.0)
---@field get_light_data_buffer  boolean?
-- When using a mod storage backend that is not "files" or "dummy",
-- the amount of data in mod storage is not constrained by
-- the amount of RAM available. (5.7.0)
---@field mod_storage_on_disk  boolean?
-- "zstd" method for compress/decompress (5.7.0)
---@field compress_zstd  boolean?
-- Sound parameter tables support start_time (5.8.0)
---@field sound_params_start_time  boolean?
-- New fields for set_physics_override speed_climb, speed_crouch,
-- liquid_fluidity, liquid_fluidity_smooth, liquid_sink,
-- acceleration_default, acceleration_air (5.8.0)
---@field physics_overrides_v2  boolean?
-- In HUD definitions the field `type` is used and `hud_elem_type` is deprecated (5.9.0)
---@field hud_def_type_field  boolean?
-- PseudoRandom and PcgRandom state is restorable
-- PseudoRandom has get_state method
-- PcgRandom has get_state and set_state methods (5.9.0)
---@field random_state_restore  boolean?
-- core.after guarantees that coexisting jobs are executed primarily
-- in order of expiry and secondarily in order of registration (5.9.0)
---@field after_order_expiry_registration  boolean?
-- wallmounted nodes mounted at floor or ceiling may additionally
-- be rotated by 90° with special param2 values (5.9.0)
---@field wallmounted_rotate  boolean?
-- Availability of the `pointabilities` property in the item definition (5.9.0)
---@field item_specific_pointabilities  boolean?
-- Nodes `pointable` property can be `"blocking"` (5.9.0)
---@field blocking_pointability_type  boolean?
-- dynamic_add_media can be called at startup when leaving callback as `nil` (5.9.0)
---@field dynamic_add_media_startup  boolean?
-- dynamic_add_media supports `filename` and `filedata` parameters (5.9.0)
---@field dynamic_add_media_filepath  boolean?
-- L-system decoration type (5.9.0)
---@field lsystem_decoration_type  boolean?
-- Overridable pointing range using the itemstack meta key `"range"` (5.9.0)
---@field item_meta_range  boolean?
-- Allow passing an optional "actor" ObjectRef to the following functions
-- core.place_node, core.dig_node, core.punch_node (5.9.0)
---@field node_interaction_actor  boolean?
-- "new_pos" field in entity moveresult (5.9.0)
---@field moveresult_new_pos  boolean?
-- Allow removing definition fields in `core.override_item` (5.9.0)
---@field override_item_remove_fields  boolean?
-- The predefined hotbar is a Lua HUD element of type `hotbar` (5.10.0)
---@field hotbar_hud_element  boolean?
-- Bulk LBM support (5.10.0)
---@field bulk_lbms  boolean?
-- ABM supports field without_neighbors (5.10.0)
---@field abm_without_neighbors  boolean?
-- biomes have a weight parameter (5.11.0)
---@field biome_weights  boolean?
-- Particles can specify a "clip" blend mode (5.11.0)
---@field particle_blend_clip  boolean?
-- The `match_meta` optional parameter is available for `InvRefremove_item()` (5.12.0)
---@field remove_item_match_meta  boolean?
-- The HTTP API supports the HEAD and PATCH methods (5.12.0)
---@field httpfetch_additional_methods  boolean?

---@return core.features
function core.features() end

---@nodiscard
---@param arg string[]|string
---@return boolean, table<string, boolean> missing_features
function core.has_feature(arg) end

---@class player_information
-- IP address of client
---@field address string
-- IPv4 / IPv6
---@field ip_version number
-- seconds since client connected
---@field connection_uptime number
-- protocol version used by client
---@field protocol_version number
-- supported formspec version
---@field formspec_version number
-- Language code used for translation
---@field lang_code string
-- minimum round trip time
---@field min_rtt number?
-- maximum round trip time
---@field max_rtt number?
-- average round trip time
---@field avg_rtt number?
-- minimum packet time jitter
---@field min_jitter number?
-- maximum packet time jitter
---@field max_jitter number?
-- average packet time jitter
---@field avg_jitter number?
-- The version information is provided by the client and may be spoofed
-- or inconsistent in engine forks. You must not use this for checking
-- feature availability of clients. Instead, do use the fields
-- `protocol_version` and `formspec_version` where it matters.
-- Use `core.protocol_versions` to map Luanti versions to protocol versions.
-- This version string is only suitable for analysis purposes.
-- full version string
---@field version_string string

---@param player_name string
---@return player_information
function core.get_player_information(player_name) end

---@type table<string, number>
core.protocol_versions = core.protocol_versions

-- Unofficial note: You can compute the pixel size from this, if you are crazy you can make a library based on this or something
-- Will only be present if the client sent this information (requires v5.7+)
--
-- Note that none of these things are constant, they are likely to change during a client
-- connection as the player resizes the window and moves it between monitors
--
-- real_gui_scaling and real_hud_scaling can be used instead of DPI.
-- OSes don't necessarily give the physical DPI, as they may allow user configuration.
-- real_*_scaling is just OS DPI / 96 but with another level of user configuration.
---@class window_information
-- Current size of the in-game render target (pixels).
--
-- This is usually the window size, but may be smaller in certain situations,
-- such as side-by-side mode.
---@field size {x:integer,  y:integer}
-- Estimated maximum formspec size before Luanti will start shrinking the
-- formspec to fit. For a fullscreen formspec, use this formspec size and
-- `padding[0,0]`. `bgcolor[;true]` is also recommended.
---@field max_formspec_size {x: number, y:number}
-- GUI Scaling multiplier
-- Equal to the setting `gui_scaling` multiplied by `dpi / 96`
---@field real_gui_scaling number
-- HUD Scaling multiplier
-- Equal to the setting `hud_scaling` multiplied by `dpi / 96`
---@field real_hud_scaling number
-- Whether the touchscreen controls are enabled.
-- Usually (but not always) `true` on Android.
-- Requires at least version 5.9.0 on the client. For older clients, it
-- is always set to `false`.
---@field touch_controls boolean Requires 5.9.0 on android

---@param player_name string
---@return window_information? Client must have version 5.7+
function core.get_player_window_information(player_name) end

---@nodiscard
---@param path string
---@return boolean success
function core.mkdir(path) end

---@nodiscard
---@param path string
---@param recursive boolean?
---@return boolean success
function core.rmdir(path, recursive) end

---@nodiscard
---@param source string
---@param destination string
---@return boolean success
function core.cpdir(source, destination) end

---@nodiscard
---@param source string
---@param destination string
---@return boolean success
function core.mvdir(source, destination) end

-- * `core.get_dir_list(path, [is_dir])`: returns list of entry names
--     * is_dir is one of:
--         * nil: return all entries,
--         * true: return only subdirectory names, or
--         * false: return only file names.
---@nodiscard
---@param path string
---@param is_dir nil|true|false
function core.get_dir_list(path, is_dir) end

-- * `core.safe_file_write(path, content)`: returns boolean indicating success
--     * Replaces contents of file at path with new contents in a safe (atomic)
--       way. Use this instead of below code when writing e.g. database files:
--       `local f = io.open(path, "wb"); f:write(content); f:close()`
---@nodiscard
---@param path string
---@param content string
---@return boolean success
function core.safe_file_write(path, content) end

-- Use this for informational purposes only. The information in the returned
--   table does not represent the capabilities of the engine, nor is it
--   reliable or verifiable. Compatible forks will have a different name and
--   version entirely. To check for the presence of engine features, test
--   whether the functions exported by the wanted features exist. For example:
--   `if core.check_for_falling then ... end`.
---@class core.get_version
--- Name of the project, eg, "Luanti"
---@field project "Luanti" # These annotations are only made for luanti, so the project name is forced
--- Simple version, eg, "1.2.3-dev"
---@field string string # These annotations are made for 5.13.0 (and above i guess? or even below?)
--- The minimum supported protocol version
---@field proto_min number
--- The maximum supported protocol version
---@field proto_max number
--- Full git version (only set if available), eg, "1.2.3-dev-01234567-dirty".
---@field hash string
--- Boolean value indicating whether it's a development build
---@field is_dev boolean

---@return core.get_version
function core.get_version() end

--- Unofficial note: you could be mining bitcoin rn /joke
---@nodiscard
---@param data string
---@param raw boolean? raw bytes instead of hex digits, default: false
---@return string
function core.sha1(data, raw) end

---@nodiscard
---@param data string
---@param raw boolean? raw bytes instead of hex digits, default: false
---@return string
function core.sha256(data, raw) end

--- Colorspec to hex basically
---@param colorspec ColorSpec
---@return ColorString
function core.colorspec_to_colorstring(colorspec) end

--- Layout: RGBA
---@return string
---@param colorspec ColorSpec
function core.colorspec_to_bytes(colorspec) end

---@param colorspec ColorSpec
---@return {r:number,g:number,b:number,a:number}
function core.colorspec_to_table(colorspec) end

---@param time_of_day string
---@return number
function core.time_to_day_night_ratio(time_of_day) end

--- Unofficial note: shhh.... but you can do this in `core.handle_async` instead, get like a really good Promise library
--- Unofficial note: shh... but you can also use it real-time and it's real cool
--- Unofficial note: you can do "[png:"..core.encode_base64(core.encode_png(...)) to have a png
--- Unofficial note: Can we do jpeg XL next?
-- * `core.encode_png(width, height, data, [compression])`: Encode a PNG
--   image and return it in string form.
--     * `width`: Width of the image
--     * `height`: Height of the image
--     * `data`: Image data, one of:
--         * array table of ColorSpec, length must be width*height
--         * string with raw RGBA pixels, length must be width*height*4
--     * `compression`: Optional zlib compression level, number in range 0 to 9.
--   The data is one-dimensional, starting in the upper left corner of the image
--   and laid out in scanlines going from left to right, then top to bottom.
--   You can use `colorspec_to_bytes` to generate raw RGBA values.
--   Palettes are not supported at the moment.
--   You may use this to procedurally generate textures during server init.
---@nodiscard
---@param width integer
---@param height integer
---@param data string|ColorSpec[]
---@param compression integer?
---@return string
function core.encode_png(width, height, data, compression) end

-- * `core.urlencode(str)`: Encodes reserved URI characters by a
--   percent sign followed by two hex digits. See
--   [RFC 3986, section 2.3](https://datatracker.ietf.org/doc/html/rfc3986#section-2.3).
---@param str string
---@return string
function core.urlencode(str) end

-- LOGGING

-- Unofficial note: I made it deprecated because this should NOT be in any production code, and you should use something better tbh, like dbg.pp (from lars's dbg mod)
-- * Equivalent to `core.log(table.concat({...}, "\t"))`
---@param ... any
---@deprecated
---@return nil
function core.debug(...) end

---@alias loglevel "none"|"error"|"warning"|"action"|"info"|"verbose"
---@param loglevel loglevel
---@param text string
---@return nil
function core.log(loglevel, text) end

---@param text string
---@return nil
function core.log(text) end

-- * `core.generate_ores(vm, pos1, pos2)`
--     * Generate all registered ores within the VoxelManip `vm` and in the area
--       from `pos1` to `pos2`.
--     * `pos1` and `pos2` are optional and default to mapchunk minp and maxp.
---@param vm VoxelManip
---@param pos1 vector?
---@param pos2 vector?
function core.generate_ores(vm, pos1, pos2) end

-- * `core.generate_decorations(vm, pos1, pos2)`
--     * Generate all registered decorations within the VoxelManip `vm` and in the
--       area from `pos1` to `pos2`.
--     * `pos1` and `pos2` are optional and default to mapchunk minp and maxp.
---@param vm VoxelManip
---@param pos1 vector?
---@param pos2 vector?
function core.generate_decorations(vm, pos1, pos2) end

-- * `core.clear_objects([options])`
--     * Clear all objects in the environment
--     * Takes an optional table as an argument with the field `mode`.
--         * mode = `"full"`: Load and go through every mapblock, clearing
--                             objects (default).
--         * mode = `"quick"`: Clear objects immediately in loaded mapblocks,
--                             clear objects in unloaded mapblocks only when the
--                             mapblocks are next activated.
---@param opt ("full"|"quick")?
function core.clear_objects(opt) end

-- * `core.load_area(pos1[, pos2])`
--     * Load the mapblocks containing the area from `pos1` to `pos2`.
--       `pos2` defaults to `pos1` if not specified.
--     * This function does not trigger map generation.
---@param pos1 vector
---@param pos2 vector?
---@return nil
function core.load_area(pos1, pos2) end

--- I don't know what ---@async is, the more i looked the more confused i was

---@class core.EMERGE_CANCELLED
---@type core.EMERGE_CANCELLED
core.EMERGE_CANCELLED = core.EMERGE_CANCELLED
---@class core.EMERGE_ERRORED
---@type core.EMERGE_ERRORED
core.EMERGE_ERRORED = core.EMERGE_ERRORED
---@class core.EMERGE_FROM_MEMORY
---@type core.EMERGE_FROM_MEMORY
core.EMERGE_FROM_MEMORY = core.EMERGE_FROM_MEMORY
---@class core.EMERGE_FROM_DISK
---@type core.EMERGE_FROM_DISK
core.EMERGE_FROM_DISK = core.EMERGE_FROM_DISK
---@class core.EMERGE_GENERATED
---@type core.EMERGE_GENERATED
core.EMERGE_GENERATED = core.EMERGE_GENERATED

-- * `core.emerge_area(pos1, pos2, [callback], [param])`
--     * Queue all blocks in the area from `pos1` to `pos2`, inclusive, to be
--       asynchronously fetched from memory, loaded from disk, or if inexistent,
--       generates them.
--     * If `callback` is a valid Lua function, this will be called for each block
--       emerged.
--     * The function signature of callback is:
--       `function EmergeAreaCallback(blockpos, action, calls_remaining, param)`
--         * `blockpos` is the *block* coordinates of the block that had been
--           emerged.
--         * `action` could be one of the following constant values:
--             * `core.EMERGE_CANCELLED`
--             * `core.EMERGE_ERRORED`
--             * `core.EMERGE_FROM_MEMORY`
--             * `core.EMERGE_FROM_DISK`
--             * `core.EMERGE_GENERATED`
--         * `calls_remaining` is the number of callbacks to be expected after
--           this one.
--         * `param` is the user-defined parameter passed to emerge_area (or
--           nil if the parameter was absent).
---@param pos1 vector
---@param pos2 vector
---@param callback fun(blockpos:vector, action: core.EMERGE_CANCELLED|core.EMERGE_ERRORED|core.EMERGE_FROM_MEMORY|core.EMERGE_FROM_DISK|core.EMERGE_GENERATED, calls_remaining:number, param:any?)
---@param param any?
---@async
function core.emerge_area(pos1, pos2, callback, param) end

-- * `core.delete_area(pos1, pos2)`
--     * delete all mapblocks in the area from pos1 to pos2, inclusive
---@param pos1 vector
---@param pos2 vector
---@return nil
function core.delete_area(pos1, pos2) end

-- Unofficial note: The annoying thing about this little function is that it is hardcoded to check specifically for "air", nothing else
-- Though i am sure you can make it work out
--
-- * `core.line_of_sight(pos1, pos2)`: returns `boolean, pos`
--     * Checks if there is anything other than air between pos1 and pos2.
--     * Returns false if something is blocking the sight.
--     * Returns the position of the blocking node when `false`
--     * `pos1`: First position
--     * `pos2`: Second position
---@param pos1 vector
---@param pos2 vector
---@return boolean, MapNode?
function core.line_of_sight(pos1, pos2) end

-- * `core.raycast(pos1, pos2, objects, liquids, pointabilities)`: returns `Raycast`
--     * Creates a `Raycast` object.
--     * `pos1`: start of the ray
--     * `pos2`: end of the ray
--     * `objects`: if false, only nodes will be returned. Default is `true`.
--     * `liquids`: if false, liquid nodes (`liquidtype ~= "none"`) won't be
--                  returned. Default is `false`.
--     * `pointabilities`: Allows overriding the `pointable` property of
--       nodes and objects. Uses the same format as the `pointabilities` property
--       of item definitions. Default is `nil`.
---@return function Raycast
---@nodiscard
---@param pos1 vector
---@param pos2 vector
---@param objects boolean?
---@param liquids boolean?
---@param pointabilities {nodes:table<string, boolean|"blocking">?, objects: table<string, boolean|"blocking">?}?
function Raycast(pos1, pos2, objects, liquids, pointabilities) end

core.raycast = Raycast

--- Is this the one they ask you in coding interviews
--- Idk, not old enough for that yet

-- * `core.find_path(pos1, pos2, searchdistance, max_jump, max_drop, algorithm)`
--     * returns table containing path that can be walked on
--     * returns a table of 3D points representing a path from `pos1` to `pos2` or
--       `nil` on failure.
--     * Reasons for failure:
--         * No path exists at all
--         * No path exists within `searchdistance` (see below)
--         * Start or end pos is buried in land
--     * `pos1`: start position
--     * `pos2`: end position
--     * `searchdistance`: maximum distance from the search positions to search in.
--       In detail: Path must be completely inside a cuboid. The minimum
--       `searchdistance` of 1 will confine search between `pos1` and `pos2`.
--       Larger values will increase the size of this cuboid in all directions
--     * `max_jump`: maximum height difference to consider walkable
--     * `max_drop`: maximum height difference to consider droppable
--     * `algorithm`: One of `"A*_noprefetch"` (default), `"A*"`, `"Dijkstra"`.
--       Difference between `"A*"` and `"A*_noprefetch"` is that
--       `"A*"` will pre-calculate the cost-data, the other will calculate it
--       on-the-fly
---@nodiscard
---@param pos1 vector
---@param pos2 vector
---@param searchdistance number
---@param max_jump number
---@param max_drop number
---@param algo "A*_noprefetch"|"A*"|"Dijkstra"
---@return vector[]?
function core.find_path(pos1, pos2, searchdistance, max_jump, max_drop, algo) end

-- * `core.get_node_boxes(box_type, pos, [node])`
--     * `box_type` must be `"node_box"`, `"collision_box"` or `"selection_box"`.
--     * `pos` must be a node position.
--     * `node` can be a table in the form `{name=string, param1=number, param2=number}`.
--       If `node` is `nil`, the actual node at `pos` is used instead.
--     * Resolves any facedir-rotated boxes, connected boxes and the like into
--       actual boxes.
--     * Returns a list of boxes in the form
--       `{{x1, y1, z1, x2, y2, z2}, {x1, y1, z1, x2, y2, z2}, ...}`. Coordinates
--       are relative to `pos`.
--     * See also: [Node boxes](#node-boxes)
---@param box_type "node_box"|"collision_box"|"selection_box"
---@param pos vector
---@param node MapNode?
---@return number[][]
function core.get_node_boxes(box_type, pos, node) end

-- * `core.fix_light(pos1, pos2)`: returns `true`/`false`
--     * resets the light in a cuboid-shaped part of
--       the map and removes lighting bugs.
--     * Loads the area if it is not loaded.
--     * `pos1` is the corner of the cuboid with the least coordinates
--       (in node coordinates), inclusive.
--     * `pos2` is the opposite corner of the cuboid, inclusive.
--     * The actual updated cuboid might be larger than the specified one,
--       because only whole map blocks can be updated.
--       The actual updated area consists of those map blocks that intersect
--       with the given cuboid.
--     * However, the neighborhood of the updated area might change
--       as well, as light can spread out of the cuboid, also light
--       might be removed.
--     * returns `false` if the area is not fully generated,
--       `true` otherwise
---@param pos1 vector
---@param pos2 vector
---@return boolean
function core.fix_light(pos1, pos2) end

--- Unofficial note: You can override this one for your own custom cool falling blocks
-- * `core.check_single_for_falling(pos)`
--     * causes an unsupported `group:falling_node` node to fall and causes an
--       unattached `group:attached_node` node to fall.
--     * does not spread these updates to neighbors.
---@param pos vector
function core.check_single_for_falling(pos) end

-- * `core.check_for_falling(pos)`
--     * causes an unsupported `group:falling_node` node to fall and causes an
--       unattached `group:attached_node` node to fall.
--     * spread these updates to neighbors and can cause a cascade
--       of nodes to fall.
---@param pos vector
function core.check_for_falling(pos) end

-- * `core.get_spawn_level(x, z)`
--     * Returns a player spawn y coordinate for the provided (x, z)
--       coordinates, or `nil` for an unsuitable spawn point.
--     * For most mapgens a 'suitable spawn point' is one with y between
--       `water_level` and `water_level + 16`, and in mgv7 well away from rivers,
--       so `nil` will be returned for many (x, z) coordinates.
--     * The spawn level returned is for a player spawn in unmodified terrain.
--     * The spawn level is intentionally above terrain level to cope with
--       full-node biome 'dust' nodes.
---@param x number
---@param z number
---@return number y
function core.get_spawn_level(x, z) end

---@class ModChannel
-- * `leave()`: leave the mod channel.
--     * Server leaves channel `channel_name`.
--     * No more incoming or outgoing messages can be sent to this channel from
--       server mods.
--     * This invalidate all future object usage.
--     * Ensure you set mod_channel to nil after that to free Lua resources.
---@field leave fun()
-- * `is_writeable()`: returns true if channel is writeable and mod can send over
--   it.
---@field is_writeable fun()
-- * `send_all(message)`: Send `message` though the mod channel.
--     * If mod channel is not writeable or invalid, message will be dropped.
--     * Message size is limited to 65535 characters by protocol.
---@field send_all fun(message:string)

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
---@param above boolean
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
