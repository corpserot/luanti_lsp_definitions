---
---@meta
---@version 5.1, JIT # btw if you got a big complicated game, it might stop making sense targetting lua5.1

--- ALSO: My comments will be "Unofficial note: ..."

--[[
`#RGB` defines a color in hexadecimal format.

`#RGBA` defines a color in hexadecimal format and alpha channel.

`#RRGGBB` defines a color in hexadecimal format.

`#RRGGBBAA` defines a color in hexadecimal format and alpha channel.

Named colors are also supported and are equivalent to
[CSS Color Module Level 4](https://www.w3.org/TR/css-color-4/#named-color).
To specify the value of the alpha channel, append `#A` or `#AA` to the end of
the color name (e.g. `colorname#08`).
]]
-- Unofficial note: sorry they need to be aliases
---@alias ColorString string
---@alias ColorSpec table|number|integer|string|any

---@class content_id: integer

--- Unofficial note: This class isn't mentioned anywhere, but when inputting a node parameter to functions, you don't actually have to provide the param1 and the param2, so that's why it exists
---@class MapNodeOpt: {name: string, param1: number?, param2: number?}
---@class MapNode: {name:string, param1:number, param2:number}
---@class light_level: number
---@class light: {day:light_level, light:light_level}

---@class core
core = {}

core.LIGHT_MAX = 14

--- Anyway, HERE Belongeth the misc stuff

--- Unofficial note: In newer luanti versions, `core.*` is prefered, `core.*` existed in older versions too, really no reason to NOT lsp rename unless you got something scuffed going on
---@deprecated
---@class minetest: core
minetest = core

--- The escape sequence sets the text color to color
--- (Unofficial note: this is mostly for formspec UI elements)
---@nodiscard
---@param color ColorString
---@return string
function core.get_color_escape_sequence(color) end

-- Equivalent to: core.get_color_escape_sequence(color) .. message .. core.get_color_escape_sequence("#ffffff")
--- (Unofficial note: this is mostly for formspec UI elements)
---@nodiscard
---@param color ColorString
---@param message string
---@return string
function core.colorize(color, message) end

-- The escape sequence sets the background of the whole text element to color. Only defined for item descriptions and tooltips.
---@nodiscard
---@param color ColorString
---@return string
function core.get_background_escape_sequence(color) end

-- Removes foreground colors added by get_color_escape_sequence.
---@nodiscard
---@param str string
---@return string
function core.strip_foreground_colors(str) end

-- Removes background colors added by get_background_escape_sequence.
---@nodiscard
---@param str string
---@return string
function core.strip_background_colors(str) end

-- Removes all color escape sequences.
---@nodiscard
---@param str string
---@return string
function core.strip_colors(str) end

--- CHAT

---@param text string
---@return nil
function core.chat_send_all(text) end

---@param name string
---@param text string
---@return nil
function core.chat_send_player(name, text) end

-- * `core.format_chat_message(name, message)`
--     * Used by the server to format a chat message, based on the setting `chat_message_format`.
--       Refer to the documentation of the setting for a list of valid placeholders.
--     * Takes player name and message, and returns the formatted string to be sent to players.
--     * Can be redefined by mods if required, for things like colored names or messages.
--     * **Only** the first occurrence of each placeholder will be replaced.
---@param name string
---@param message string
---@return nil
function core.format_chat_message(name, message) end

---@class SimpleSoundSpec
---@field name string
---@field gain number?
---@field pitch number?
---@field fade number?

---@class sound_params
---@field gain number?
---@field pitch number?
---@field fade number?
---@field start_time number?
---@field loop boolean?
---@field pos vector?
---@field object ObjectRef?
---@field to_player string?
---@field exclude_player string?
---@field max_hear_distance number?

---@class sound_handle

--- Unofficial note: i made ephemeral NOT be optional because it's a good idea to explicitely set it (most of the time you don't use that, so set it to true)
-- * `core.sound_play(spec, parameters, [ephemeral])`: returns a handle
--     * `spec` is a `SimpleSoundSpec`
--     * `parameters` is a sound parameter table
--     * `ephemeral` is a boolean (default: false)
--       Ephemeral sounds will not return a handle and can't be stopped or faded.
--       It is recommend to use this for short sounds that happen in response to
--       player actions (e.g. door closing).
---@param spec SimpleSoundSpec
---@param parameters sound_params
---@param ephemeral boolean
---@return sound_handle?
function core.sound_play(spec, parameters, ephemeral) end

-- * `core.sound_stop(handle)`
--     * `handle` is a handle returned by `core.sound_play`
---@param handle sound_handle
function core.sound_stop(handle) end
-- * `core.sound_fade(handle, step, gain)`
--     * `handle` is a handle returned by `core.sound_play`
--     * `step` determines how fast a sound will fade.
--       The gain will change by this much per second,
--       until it reaches the target gain.
--       Note: Older versions used a signed step. This is deprecated, but old
--       code will still work. (the client uses abs(step) to correct it)
--     * `gain` the target gain for the fade.
--       Fading to zero will delete the sound.
---@param handle sound_handle
---@param step number
---@param gain number
function core.sound_fade(handle, step, gain) end

---@class job
-- * `job:cancel()`
--     * Cancels the job function from being called
---@field cancel fun()

-- * `core.after(time, func, ...)`: returns job table to use as below.
--     * Call the function `func` after `time` seconds, may be fractional
--     * Optional: Variable number of arguments that are passed to `func`
--     * Jobs set for earlier times are executed earlier. If multiple jobs expire
--       at exactly the same time, then they are executed in registration order.
--     * `time` is a lower bound. The job is executed in the first server-step that
--       started at least `time` seconds after the last time a server-step started,
--       measured with globalstep dtime.
--     * If `time` is `0`, the job is executed in the next step.
---@param time number
---@param f function
---@param ... any
---@return job
function core.after(time, f, ...) end

--- ASYNC (oh i am definitely using ---@async wrong you can bet)

--- Unofficial note: async is quite painful, good luck
-- The engine allows you to submit jobs to be ran in an isolated environment
-- concurrently with normal server operation.
-- A job consists of a function to be ran in the async environment, any amount of
-- arguments (will be serialized) and a callback that will be called with the return
-- value of the job function once it is finished.
--
-- The async environment does *not* have access to the map, entities, players or any
-- globals defined in the 'usual' environment. Consequently, functions like
-- `core.get_node()` or `core.get_player_by_name()` simply do not exist in it.
--
-- Arguments and return values passed through this can contain certain userdata
-- objects that will be seamlessly copied (not shared) to the async environment.
-- This allows you easy interoperability for delegating work to jobs.
--
-- * `core.handle_async(func, callback, ...)`:
--     * Queue the function `func` to be ran in an async environment.
--       Note that there are multiple persistent workers and any of them may
--       end up running a given job. The engine will scale the amount of
--       worker threads automatically.
--     * When `func` returns the callback is called (in the normal environment)
--       with all of the return values as arguments.
--     * Optional: Variable number of arguments that are passed to `func`
--
-- ### List of APIs available in an async environment
--
-- Classes:
--
-- * `AreaStore`
-- * `ItemStack`
-- * `ValueNoise`
-- * `ValueNoiseMap`
-- * `PseudoRandom`
-- * `PcgRandom`
-- * `SecureRandom`
-- * `VoxelArea`
-- * `VoxelManip`
--     * only if transferred into environment; can't read/write to map
-- * `Settings`
--
-- Class instances that can be transferred between environments:
--
-- * `ItemStack`
-- * `ValueNoise`
-- * `ValueNoiseMap`
-- * `VoxelManip`
--
-- Functions:
--
-- * Standalone helpers such as logging, filesystem, encoding,
--   hashing or compression APIs
-- * `core.register_portable_metatable`
-- * IPC
--
-- Variables:
--
-- * `core.settings`
-- * `core.registered_items`, `registered_nodes`, `registered_tools`,
--   `registered_craftitems` and `registered_aliases`
--     * with all functions and userdata values replaced by `true`, calling any
--       callbacks here is obviously not possible
---@async
---@param f function
---@param callback function
---@param ... any
function core.handle_async(f, callback, ...) end

-- * `core.register_async_dofile(path)`:
--     * Register a path to a Lua file to be imported when an async environment
--       is initialized. You can use this to preload code which you can then call
--       later using `core.handle_async()`.
---@param path string
function core.register_async_dofile(path) end

-- Mapgen environment
-- ------------------
--
-- The engine runs the map generator on separate threads, each of these also has
-- a Lua environment. Its primary purpose is to allow mods to operate on newly
-- generated parts of the map to e.g. generate custom structures.
-- Internally it is referred to as "emerge environment".
--
-- Refer to [Async environment] for the usual disclaimer on what environment isolation entails.
--
-- The map generator threads, which also contain the above mentioned Lua environment,
-- are initialized after all mods have been loaded by the server. After that the
-- registered scripts (not all mods!) - see below - are run during initialization of
-- the mapgen environment. After that only callbacks happen. The mapgen env
-- does not have a global step or timer.
--
-- * `core.register_mapgen_script(path)`:
--     * Register a path to a Lua file to be imported when a mapgen environment
--       is initialized. Run in order of registration.
-- ### List of APIs available in the mapgen env
--
-- Classes:
--
-- * `AreaStore`
-- * `ItemStack`
-- * `ValueNoise`
-- * `ValueNoiseMap`
-- * `PseudoRandom`
-- * `PcgRandom`
-- * `SecureRandom`
-- * `VoxelArea`
-- * `VoxelManip`
--     * only given by callbacks; cannot access rest of map
-- * `Settings`
--
-- Functions:
--
-- * Standalone helpers such as logging, filesystem, encoding,
--   hashing or compression APIs
-- * `core.get_biome_id`, `get_biome_name`, `get_heat`, `get_humidity`,
--   `get_biome_data`, `get_mapgen_object`, `get_mapgen_params`, `get_mapgen_edges`,
--   `get_mapgen_setting`, `get_noiseparams`, `get_decoration_id` and more
-- * `core.get_node`, `set_node`, `find_node_near`, `find_nodes_in_area`,
--   `spawn_tree` and similar
--     * these only operate on the current chunk (if inside a callback)
-- * IPC
--
-- Variables:
--
-- * `core.settings`
-- * `core.registered_items`, `registered_nodes`, `registered_tools`,
--   `registered_craftitems` and `registered_aliases`
--     * with all functions and userdata values replaced by `true`, calling any
--       callbacks here is obviously not possible
-- * `core.registered_biomes`, `registered_ores`, `registered_decorations`
--
-- Note that node metadata does not exist in the mapgen env, we suggest deferring
-- setting any metadata you need to the `on_generated` callback in the regular env.
-- You can use the gennotify mechanism to transfer this information.
---@param path string
function core.register_mapgen_script(path) end

--- EXCLUSIVE TO MAPGEN ENV
-- * `core.register_on_generated(function(vmanip, minp, maxp, blockseed))`
--     * Called after the engine mapgen finishes a chunk but before it is written to
--       the map.
--     * Chunk data resides in `vmanip`. Other parts of the map are not accessible.
--       The area of the chunk if comprised of `minp` and `maxp`, note that is smaller
--       than the emerged area of the VoxelManip.
--       Note: calling `read_from_map()` or `write_to_map()` on the VoxelManipulator object
--       is not necessary and is disallowed.
---@async
---@param f fun(vmanip:VoxelManip, minp:vector, maxp:vector, blockseed:number):nil
function core.register_on_generated(f) end

-- * `core.save_gen_notify(id, data)`
--     * Saves data for retrieval using the gennotify mechanism (see [Mapgen objects]).
--     * Data is bound to the chunk that is currently being processed, so this function
--       only makes sense inside the `on_generated` callback.
--     * `id`: user-defined ID (a string)
--       By convention these should be the mod name with an optional
--       colon and specifier added, e.g. `"default"` or `"default:dungeon_loot"`
--     * `data`: any Lua object (will be serialized, no userdata allowed)
--     * returns `true` if the data was remembered. That is if `core.set_gen_notify`
--       was called with the same user-defined ID before.
---@param id string
---@param data any
function core.save_gen_notify(id, data) end

--- IPC

-- * `core.ipc_get(key)`:
--   * Read a value from the shared data area.
--   * `key`: string, should use the `"modname:thing"` convention to avoid conflicts.
--   * returns an arbitrary Lua value, or `nil` if this key does not exist
---@param key string
---@return any
function core.ipc_get(key) end
-- * `core.ipc_set(key, value)`:
--   * Write a value to the shared data area.
--   * `key`: as above
--   * `value`: an arbitrary Lua value, cannot be or contain userdata.
--
-- Interacting with the shared data will perform an operation comparable to
-- (de)serialization on each access.
-- For that reason modifying references will not have any effect, as in this example:
-- ```lua
-- core.ipc_set("test:foo", {})
-- core.ipc_get("test:foo").subkey = "value" -- WRONG!
-- core.ipc_get("test:foo") -- returns an empty table
-- ```
--
---@param key string
---@param value any
function core.ipc_set(key, value) end

-- * `core.ipc_cas(key, old_value, new_value)`:
--   * Write a value to the shared data area, but only if the previous value
--     equals what was given.
--     This operation is called Compare-and-Swap and can be used to implement
--     synchronization between threads.
--   * `key`: as above
--   * `old_value`: value compared to using `==` (`nil` compares equal for non-existing keys)
--   * `new_value`: value that will be set
--   * returns: true on success, false otherwise
---@param key string
---@param old_value any
---@param new_value any
---@return boolean success
function core.ipc_cas(key, old_value, new_value) end

-- * `core.ipc_poll(key, timeout)`:
--   * Do a blocking wait until a value (other than `nil`) is present at the key.
--   * **IMPORTANT**: You usually don't need this function. Use this as a last resort
--     if nothing else can satisfy your use case! None of the Lua environments the
--     engine has are safe to block for extended periods, especially on the main
--     thread any delays directly translate to lag felt by players.
--   * `key`: as above
--   * `timeout`: maximum wait time, in milliseconds (positive values only)
--   * returns: true on success, false on timeout
---@param key string
---@param timeout number
---@return boolean success
function core.ipc_poll(key, timeout) end

--- Not hidden intentionally but hidden because i can't be bothered to figure it out
---@class schematic: table

-- * `core.create_schematic(p1, p2, probability_list, filename, slice_prob_list)`
--     * Create a schematic from the volume of map specified by the box formed by
--       p1 and p2.
--     * Apply the specified probability and per-node force-place to the specified
--       nodes according to the `probability_list`.
--         * `probability_list` is an array of tables containing two fields, `pos`
--           and `prob`.
--             * `pos` is the 3D vector specifying the absolute coordinates of the
--               node being modified,
--             * `prob` is an integer value from `0` to `255` that encodes
--               probability and per-node force-place. Probability has levels
--               0-127, then 128 may be added to encode per-node force-place.
--               For probability stated as 0-255, divide by 2 and round down to
--               get values 0-127, then add 128 to apply per-node force-place.
--             * If there are two or more entries with the same pos value, the
--               last entry is used.
--             * If `pos` is not inside the box formed by `p1` and `p2`, it is
--               ignored.
--             * If `probability_list` equals `nil`, no probabilities are applied.
--     * Apply the specified probability to the specified horizontal slices
--       according to the `slice_prob_list`.
--         * `slice_prob_list` is an array of tables containing two fields, `ypos`
--           and `prob`.
--             * `ypos` indicates the y position of the slice with a probability
--               applied, the lowest slice being `ypos = 0`.
--             * If slice probability list equals `nil`, no slice probabilities
--               are applied.
--     * Saves schematic in the Luanti Schematic format to filename.
---@param p1 vector
---@param p2 vector
---@param probabilities {pos:vector, prob:number}[] unwanted commentary: wow that seems inefficient, good luck!
---@param filename string
---@param slice_prob_list {ypos: number, prob:number}[]
function core.create_schematic(p1, p2, probabilities, filename, slice_prob_list) end

-- * `core.place_schematic(pos, schematic, rotation, replacements, force_placement, flags)`
--     * Place the schematic specified by schematic (see [Schematic specifier]) at
--       `pos`.
--     * `rotation` can equal `"0"`, `"90"`, `"180"`, `"270"`, or `"random"`.
--     * If the `rotation` parameter is omitted, the schematic is not rotated.
--     * `replacements` = `{["old_name"] = "convert_to", ...}`
--     * `force_placement` is a boolean indicating whether nodes other than `air`
--       and `ignore` are replaced by the schematic.
--     * Returns nil if the schematic could not be loaded.
--     * **Warning**: Once you have loaded a schematic from a file, it will be
--       cached. Future calls will always use the cached version and the
--       replacement list defined for it, regardless of whether the file or the
--       replacement list parameter have changed. The only way to load the file
--       anew is to restart the server.
--     * `flags` is a flag field with the available flags:
--         * place_center_x
--         * place_center_y
--         * place_center_z
---@param pos vector
---@param schematic schematic
---@param rotation ("0"|"90"|"180"|"270"|"random")?
---@param replacements table<string, string>
---@param force_placement boolean
---@param flags string?
---@return boolean?
function core.place_schematic(pos, schematic, rotation, replacements, force_placement, flags) end

-- stylua: ignore
-- * `core.place_schematic_on_vmanip(vmanip, pos, schematic, rotation, replacement, force_placement, flags)`:
--     * This function is analogous to core.place_schematic, but places a
--       schematic onto the specified VoxelManip object `vmanip` instead of the
--       map.
--     * Returns false if any part of the schematic was cut-off due to the
--       VoxelManip not containing the full area required, and true if the whole
--       schematic was able to fit.
--     * Returns nil if the schematic could not be loaded.
--     * After execution, any external copies of the VoxelManip contents are
--       invalidated.
--     * `flags` is a flag field with the available flags:
--         * place_center_x
--         * place_center_y
--         * place_center_z
---@param schematic schematic
---@param rotation ("0"|"90"|"180"|"270"|"random")?
---@param replacement table<string, string>
---@param force_placement boolean
---@param flags string?
---@param vmanip VoxelManip
---@return boolean?
function core.place_schematic_on_vmanip(vmanip, pos, schematic, rotation, replacement, force_placement, flags)end

-- stylua: ignore pop

-- * `core.serialize_schematic(schematic, format, options)`
--     * Return the serialized schematic specified by schematic
--       (see [Schematic specifier])
--     * in the `format` of either "mts" or "lua".
--     * "mts" - a string containing the binary MTS data used in the MTS file
--       format.
--     * "lua" - a string containing Lua code representing the schematic in table
--       format.
--     * `options` is a table containing the following optional parameters:
--         * If `lua_use_comments` is true and `format` is "lua", the Lua code
--           generated will have (X, Z) position comments for every X row
--           generated in the schematic data for easier reading.
--         * If `lua_num_indent_spaces` is a nonzero number and `format` is "lua",
--           the Lua code generated will use that number of spaces as indentation
--           instead of a tab character.
---@param schematic schematic
---@param format "mts"|"lua"
---@param options {lua_use_comments:boolean?, lua_num_indent_spaces:number?}?
function core.serialize_schematic(schematic, format, options) end

-- * `core.read_schematic(schematic, options)`
--     * Returns a Lua table representing the schematic (see: [Schematic specifier])
--     * `schematic` is the schematic to read (see: [Schematic specifier])
--     * `options` is a table containing the following optional parameters:
--         * `write_yslice_prob`: string value:
--             * `none`: no `write_yslice_prob` table is inserted,
--             * `low`: only probabilities that are not 254 or 255 are written in
--               the `write_ylisce_prob` table,
--             * `all`: write all probabilities to the `write_yslice_prob` table.
--             * The default for this option is `all`.
--             * Any invalid value will be interpreted as `all`.
---@param schematic any? unofficial note: i have no clue i'm sorry
---@param options {write_yslice_prob:("none"|"low"|"all")?}?
---@return schematic?
function core.read_schematic(schematic, options) end

--- THE MISC SECTION
--- We had Helpers, Utils and now misc
--- What will be their next innovation?

-- * `core.get_connected_players()`: returns list of `ObjectRefs`
---@return PlayerRef[]
function core.get_connected_players() end
-- * `core.is_player(obj)`: boolean, whether `obj` is a player
---@param obj ObjectRef
---@return boolean
function core.is_player(obj) end
-- * `core.player_exists(name)`: boolean, whether player exists
--   (regardless of online status)
---@param name string
---@return boolean
function core.player_exists(name) end
-- * `core.is_valid_player_name(name)`: boolean, whether the given name
--   could be used as a player name (regardless of whether said player exists).
---@param name string
---@return boolean
function core.is_valid_player_name(name) end
-- * `core.hud_replace_builtin(name, hud_definition)`
--     * Replaces definition of a builtin hud element
--     * `name`: `"breath"`, `"health"`, `"minimap"` or `"hotbar"`
--     * `hud_definition`: definition to replace builtin definition
---@param name "breath"|"health"|"minimap"|"hotbar"
---@param hud_definition HudDef
function core.hud_replace_builtin(name, hud_definition) end
-- * `core.parse_relative_number(arg, relative_to)`: returns number or nil
--     * Helper function for chat commands.
--     * For parsing an optionally relative number of a chat command
--       parameter, using the chat command tilde notation.
--     * `arg`: String snippet containing the number; possible values:
--         * `"<number>"`: return as number
--         * `"~<number>"`: return `relative_to + <number>`
--         * `"~"`: return `relative_to`
--         * Anything else will return `nil`
--     * `relative_to`: Number to which the `arg` number might be relative to
--     * Examples:
--         * `core.parse_relative_number("5", 10)` returns 5
--         * `core.parse_relative_number("~5", 10)` returns 15
--         * `core.parse_relative_number("~", 10)` returns 10
---@param arg string
---@param relative_to vector
function core.parse_relative_number(arg, relative_to) end
-- * `core.send_join_message(player_name)`
--     * This function can be overridden by mods to change the join message.
---@param player_name string
function core.send_join_message(player_name) end
-- * `core.send_leave_message(player_name, timed_out)`
--     * This function can be overridden by mods to change the leave message.
---@param player_name string
---@param timed_out boolean
function core.send_leave_message(player_name, timed_out) end
-- * `core.hash_node_position(pos)`: returns a 48-bit integer
--     * `pos`: table {x=number, y=number, z=number},
--     * Gives a unique numeric encoding for a node position (16+16+16=48bit)
--     * Despite the name, this is not a hash function (so it doesn't mix or produce collisions).

---@class poshash: number

---@param pos vector
---@return poshash
function core.hash_node_position(pos) end
-- * `core.get_position_from_hash(hash)`: returns a position
--     * Inverse transform of `core.hash_node_position`
---@param hash poshash
---@return vector
function core.get_position_from_hash(hash) end
-- * `core.get_item_group(name, group)`: returns a rating
--     * Get rating of a group of an item. (`0` means: not in group)
---@param name string
---@param group string
---@return integer
function core.get_item_group(name, group) end
-- * `core.get_node_group(name, group)`: returns a rating
--     * Deprecated: An alias for the former.
---@deprecated
function core.get_node_group(name, group) end
-- * `core.raillike_group(name)`: returns a rating
--     * Returns rating of the connect_to_raillike group corresponding to name
--     * If name is not yet the name of a connect_to_raillike group, a new group
--       id is created, with that name.
---@param name string
---@return number
function core.raillike_group(name) end
-- * `core.get_content_id(name)`: returns an integer
--     * Gets the internal content ID of `name`
---@param name string
---@return content_id
function core.get_content_id(name) end
-- * `core.get_name_from_content_id(content_id)`: returns a string
--     * Gets the name of the content with that content ID
---@param content_id content_id
---@return string
function core.get_name_from_content_id(content_id) end
-- * `core.parse_json(string[, nullvalue, return_error])`: returns something
--     * Convert a string containing JSON data into the Lua equivalent
--     * `nullvalue`: returned in place of the JSON null; defaults to `nil`
--     * On success returns a table, a string, a number, a boolean or `nullvalue`
--     * On failure: If `return_error` is not set or is `false`,
--       outputs an error message and returns `nil`.
--       Otherwise returns `nil, err` (error message).
--     * Example: `parse_json("[10, {\"a\":false}]")`, returns `{10, {a = false}}`
---@param string string
---@param nullvalue any?
---@param return_error boolean?
---@return boolean?|any, any?
function core.parse_json(string, nullvalue, return_error) end
-- * `core.write_json(data[, styled])`: returns a string or `nil` and an error
--   message.
--     * Convert a Lua table into a JSON string
--     * styled: Outputs in a human-readable format if this is set, defaults to
--       false.
--     * Unserializable things like functions and userdata will cause an error.
--     * **Warning**: JSON is more strict than the Lua table format.
--         1. You can only use strings and positive integers of at least one as
--            keys.
--         2. You cannot mix string and integer keys.
--            This is due to the fact that JSON has two distinct array and object
--            values.
--     * Example: `write_json({10, {a = false}})`,
--       returns `'[10, {"a": false}]'`
---@param data any
---@param styled boolean?
---@return string
function core.write_json(data, styled) end
-- * `core.serialize(table)`: returns a string
--     * Convert a value into string form readable by `core.deserialize`.
--     * Supports tables, strings, numbers, booleans and `nil`.
--     * Support for dumping function bytecode is **deprecated**.
--     * Note: To obtain a human-readable representation of a value, use `dump` instead.
--     * Example: `serialize({foo="bar"})`, returns `'return { ["foo"] = "bar" }'`
---@param table any
---@return string
function core.serialize(table) end
-- * `core.deserialize(string[, safe])`: returns a table
--     * Convert a string returned by `core.serialize` into a table
--     * `string` is loaded in an empty sandbox environment.
--     * Will load functions if `safe` is `false` or omitted.
--       Although these functions cannot directly access the global environment,
--       they could bypass this restriction with maliciously crafted Lua bytecode
--       if mod security is disabled.
--     * Will silently strip functions embedded via calls to `loadstring`
--       (typically bytecode dumped by `core.serialize`) if `safe` is `true`.
--       You should not rely on this if possible.
--       * Example: `core.deserialize("return loadstring('')", true)` will be `nil`.
--     * This function should not be used on untrusted data, regardless of the
--      value of `safe`. It is fine to serialize then deserialize user-provided
--      data, but directly providing user input to deserialize is always unsafe.
--     * Example: `deserialize('return { ["foo"] = "bar" }')`,
--       returns `{foo="bar"}`
--     * Example: `deserialize('print("foo")')`, returns `nil`
--       (function call fails), returns
--       `error:[string "print("foo")"]:1: attempt to call global 'print' (a nil value)`
---@param string string
---@param safe boolean?
---@return any
function core.deserialize(string, safe) end
-- * `core.compress(data, method, ...)`: returns `compressed_data`
--     * Compress a string of data.
--     * `method` is a string identifying the compression method to be used.
--     * Supported compression methods:
--         * Deflate (zlib): `"deflate"`
--         * Zstandard: `"zstd"`
--     * `...` indicates method-specific arguments. Currently defined arguments
--       are:
--         * Deflate: `level` - Compression level, `0`-`9` or `nil`.
--         * Zstandard: `level` - Compression level. Integer or `nil`. Default `3`.
--         Note any supported Zstandard compression level could be used here,
--         but these are subject to change between Zstandard versions.
---@param data string
---@param method "zstd"|"deflate"
---@param ... any
---@return string
function core.compress(data, method, ...) end
-- * `core.decompress(compressed_data, method, ...)`: returns data
--     * Decompress a string of data using the algorithm specified by `method`.
--     * See documentation on `core.compress()` for supported compression
--       methods.
--     * `...` indicates method-specific arguments. Currently, no methods use this
---@param compressed_data string
---@param method "zstd"|"deflate"
---@param ... nil
---@return string
function core.decompress(compressed_data, method, ...) end
-- * `core.rgba(red, green, blue[, alpha])`: returns a string
--     * Each argument is an 8 Bit unsigned integer
--     * Returns the ColorString from rgb or rgba values
--     * Example: `core.rgba(10, 20, 30, 40)`, returns `"#0A141E28"`
---@nodiscard
---@param red number
---@param green number
---@param blue number
---@param alpha number?
---@return string
function core.rgba(red, green, blue, alpha) end
-- * `core.encode_base64(string)`: returns string encoded in base64
--     * Encodes a string in base64.
---@param string string
---@return string
function core.encode_base64(string) end
-- * `core.decode_base64(string)`: returns string or nil on failure
--     * Padding characters are only supported starting at version 5.4.0, where
--       5.5.0 and newer perform proper checks.
--     * Decodes a string encoded in base64.
---@param string string
---@return string
function core.decode_base64(string) end

--- Unofficial note: Do NOT localize it, i know you want to, just don't
-- * `core.is_protected(pos, name)`: returns boolean
--     * Returning `true` restricts the player `name` from modifying (i.e. digging,
--        placing) the node at position `pos`.
--     * `name` will be `""` for non-players or unknown players.
--     * This function should be overridden by protection mods. It is highly
--       recommended to grant access to players with the `protection_bypass` privilege.
--     * Cache and call the old version of this function if the position is
--       not protected by the mod. This will allow using multiple protection mods.
--     * Example:
--       ```lua
--       local old_is_protected = core.is_protected
--       function core.is_protected(pos, name)
--           if mymod:position_protected_from(pos, name) then
--               return true
--           end
--           return old_is_protected(pos, name)
--       end
--       ```
---@param pos vector
---@param name string
---@return boolean
function core.is_protected(pos, name) end

-- * `core.record_protection_violation(pos, name)`
--     * This function calls functions registered with
--       `core.register_on_protection_violation`.

---@param pos vector
---@param name string
function core.record_protection_violation(pos, name) end

-- * `core.is_creative_enabled(name)`: returns boolean
--     * Returning `true` means that Creative Mode is enabled for player `name`.
--     * `name` will be `""` for non-players or if the player is unknown.
--     * This function should be overridden by Creative Mode-related mods to
--       implement a per-player Creative Mode.
--     * By default, this function returns `true` if the setting
--       `creative_mode` is `true` and `false` otherwise.
---@param name string
---@return boolean
function core.is_creative_enabled(name) end
-- * `core.is_area_protected(pos1, pos2, player_name, interval)`
--     * Returns the position of the first node that `player_name` may not modify
--       in the specified cuboid between `pos1` and `pos2`.
--     * Returns `false` if no protections were found.
--     * Applies `is_protected()` to a 3D lattice of points in the defined volume.
--       The points are spaced evenly throughout the volume and have a spacing
--       similar to, but no larger than, `interval`.
--     * All corners and edges of the defined volume are checked.
--     * `interval` defaults to 4.
--     * `interval` should be carefully chosen and maximized to avoid an excessive
--       number of points being checked.
--     * Like `core.is_protected`, this function may be extended or
--       overwritten by mods to provide a faster implementation to check the
--       cuboid for intersections.
---@param pos1 vector
---@param pos2 vector
---@param player_name string
---@param interval number
---@return boolean
function core.is_area_protected(pos1, pos2, player_name, interval) end

-- stylua: ignore

-- * `core.rotate_and_place(itemstack, placer, pointed_thing[, infinitestacks,
--   orient_flags, prevent_after_place])`
--     * Attempt to predict the desired orientation of the facedir-capable node
--       defined by `itemstack`, and place it accordingly (on-wall, on the floor,
--       or hanging from the ceiling).
--     * `infinitestacks`: if `true`, the itemstack is not changed. Otherwise the
--       stacks are handled normally.
--     * `orient_flags`: Optional table containing extra tweaks to the placement code:
--         * `invert_wall`:   if `true`, place wall-orientation on the ground and
--           ground-orientation on the wall.
--         * `force_wall`:    if `true`, always place the node in wall orientation.
--         * `force_ceiling`: if `true`, always place on the ceiling.
--         * `force_floor`:   if `true`, always place the node on the floor.
--         * `force_facedir`: if `true`, forcefully reset the facedir to north
--           when placing on the floor or ceiling.
--         * The first four options are mutually-exclusive; the last in the list
--           takes precedence over the first.
--     * `prevent_after_place` is directly passed to `core.item_place_node`
--     * Returns the new itemstack after placement
---@param itemstack ItemStack
---@param placer PlayerRef
---@param pointed_thing pointed_thing
---@param infinitestacks boolean?
---@param orient_flags {invert_wall:boolean?, force_wall:boolean?, force_ceiling:boolean?, force_floor:boolean?, force_facedir:boolean?}?
---@param prevent_after_place boolean?
---@return integer
function core.rotate_and_place(itemstack, placer, pointed_thing, infinitestacks, orient_flags, prevent_after_place) end

-- stylua: ignore pop

-- * `core.rotate_node(itemstack, placer, pointed_thing)`
--     * calls `rotate_and_place()` with `infinitestacks` set according to the state
--       of the creative mode setting, checks for "sneak" to set the `invert_wall`
--       parameter and `prevent_after_place` set to `true`
---@param itemstack ItemStack
---@param placer PlayerRef
---@param pointed_thing pointed_thing
---@return nil
function core.rotate_node(itemstack, placer, pointed_thing) end

-- stylua: ignore

-- * `core.calculate_knockback(player, hitter, time_from_last_punch,
--   tool_capabilities, dir, distance, damage)`
--     * Returns the amount of knockback applied on the punched player.
--     * Arguments are equivalent to `register_on_punchplayer`, except the following:
--         * `distance`: distance between puncher and punched player
--     * This function can be overridden by mods that wish to modify this behavior.
--     * You may want to cache and call the old function to allow multiple mods to
--       change knockback behavior.
---@param player PlayerRef
---@param hitter ObjectRef
---@param time_from_last_punch number
---@param tool_capabilities vector
---@param dir vector
---@param distance number
function core.calculate_knockback(player, hitter, time_from_last_punch, tool_capabilities, dir, distance, damage) end

-- stylua: ignore pop

-- * `core.forceload_block(pos[, transient[, limit]])`
--     * forceloads the position `pos`.
--     * this means that the mapblock containing `pos` will always be kept in the
--       `"active"` state, regardless of nearby players or server settings.
--     * returns `true` if area could be forceloaded
--     * If `transient` is `false` or absent, the forceload will be persistent
--       (saved between server runs). If `true`, the forceload will be transient
--       (not saved between server runs).
--     * `limit` is an optional limit on the number of blocks that can be
--       forceloaded at once. If `limit` is negative, there is no limit. If it is
--       absent, the limit is the value of the setting `"max_forceloaded_blocks"`.
--       If the call would put the number of blocks over the limit, the call fails.
---@param pos vector
---@param transient boolean?
---@param limit number?
function core.forceload_block(pos, transient, limit) end
-- * `core.forceload_free_block(pos[, transient])`
--     * stops forceloading the position `pos`
--     * If `transient` is `false` or absent, frees a persistent forceload.
--       If `true`, frees a transient forceload.
---@param pos vector
---@param transient boolean?
function core.forceload_free_block(pos, transient) end
-- * `core.compare_block_status(pos, condition)`
--     * Checks whether the mapblock at position `pos` is in the wanted condition.
--     * `condition` may be one of the following values:
--         * `"unknown"`: not in memory
--         * `"emerging"`: in the queue for loading from disk or generating
--         * `"loaded"`: in memory but inactive (no ABMs are executed)
--         * `"active"`: in memory and active
--         * Other values are reserved for future functionality extensions
--     * Return value, the comparison status:
--         * `false`: Mapblock does not fulfill the wanted condition
--         * `true`: Mapblock meets the requirement
--         * `nil`: Unsupported `condition` value
---@param pos vector
---@param condition "unknown"|"emerging"|"loaded"|"active"|string
---@return boolean?
function core.compare_block_status(pos, condition) end

--- Unofficial note: This is one of the best features of luanti (no need to ask "is this mod safe?????"), but also a pain when you need it, and when it would be a lot more performant if you had it tbh
-- * `core.request_insecure_environment()`: returns an environment containing
--   insecure functions if the calling mod has been listed as trusted in the
--   `secure.trusted_mods` setting or security is disabled, otherwise returns
--   `nil`.
--     * Only works at init time and must be called from the mod's main scope
--       (ie: the init.lua of the mod, not from another Lua file or within a function).
--     * **DO NOT ALLOW ANY OTHER MODS TO ACCESS THE RETURNED ENVIRONMENT, STORE
--       IT IN A LOCAL VARIABLE!**
---@return table
function core.request_insecure_environment() end
-- * `core.global_exists(name)`
--     * Checks if a global variable has been set, without triggering a warning.
---@param name any unofficial note: yeah that's right, any
---@return boolean
function core.global_exists(name) end
-- * `core.register_portable_metatable(name, mt)`:
--     * Register a metatable that should be preserved when Lua data is transferred
--       between environments (via IPC or `handle_async`).
--     * `name` is a string that identifies the metatable. It is recommended to
--       follow the `modname:name` convention for this identifier.
--     * `mt` is the metatable to register.
--     * Note that the same metatable can be registered under multiple names,
--       but multiple metatables must not be registered under the same name.
--     * You must register the metatable in both the main environment
--       and the async environment for this mechanism to work.
---@param name string
---@param mt table
function core.register_portable_metatable(name, mt) end

-- When an error occurs that is not caught, Luanti calls the function
-- `core.error_handler` with the error object as its first argument. The second
-- argument is the stack level where the error occurred. The return value is the
-- error string that should be shown. By default this is a backtrace from
-- `debug.traceback`. If the error object is not a string, it is first converted
-- with `tostring` before being displayed. This means that you can use tables as
-- error objects so long as you give them `__tostring` metamethods.
--
-- You can override `core.error_handler`. You should call the previous handler
-- with the correct stack level in your implementation.
---@param err any
---@param level number|any
---@return string
function core.error_handler(err, level) end

--- It feels so satisfying to just be done with all of this

---@type bitlib
bit = bit
