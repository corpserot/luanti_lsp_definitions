--[[
---------------------------------------------------
Some parts of https://github.com/luanti-org/luanti/blob/5.12.0/doc/lua_api.md?plain=1 have been copy pasted into the definitions

License of what i did:
---
Zero-Clause BSD
=============

Permission to use, copy, modify, and/or distribute this software for
any purpose with or without fee is hereby granted.

THE SOFTWARE IS PROVIDED “AS IS” AND THE AUTHOR DISCLAIMS ALL
WARRANTIES WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES
OF MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE
FOR ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY
DAMAGES WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN
AN ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT
OF OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
---

the license of lua_api.md:
---------------------------------------------------

Luanti
Copyright (C) 2010-2024 celeron55, Perttu Ahola <celeron55@gmail.com>
and contributors (see source file comments and the version control log)

This program is free software; you can redistribute it and/or modify
it under the terms of the GNU Lesser General Public License as published by
the Free Software Foundation; either version 2.1 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU Lesser General Public License for more details.

You should have received a copy of the GNU Lesser General Public License along
with this program; if not, write to the Free Software Foundation, Inc.,
51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.]] ---@meta

-- Key for special L-System symbols used in axioms
-- -----------------------------------------------
--
-- * `G`: move forward one unit with the pen up
-- * `F`: move forward one unit with the pen down drawing trunks and branches
-- * `f`: move forward one unit with the pen down drawing leaves (100% chance)
-- * `T`: move forward one unit with the pen down drawing trunks only
-- * `R`: move forward one unit with the pen down placing fruit
-- * `A`: replace with rules set A
-- * `B`: replace with rules set B
-- * `C`: replace with rules set C
-- * `D`: replace with rules set D
-- * `a`: replace with rules set A, chance 90%
-- * `b`: replace with rules set B, chance 80%
-- * `c`: replace with rules set C, chance 70%
-- * `d`: replace with rules set D, chance 60%
-- * `+`: yaw the turtle right by `angle` parameter
-- * `-`: yaw the turtle left by `angle` parameter
-- * `&`: pitch the turtle down by `angle` parameter
-- * `^`: pitch the turtle up by `angle` parameter
-- * `/`: roll the turtle to the right by `angle` parameter
-- * `*`: roll the turtle to the left by `angle` parameter
-- * `[`: save in stack current state info
-- * `]`: recover from stack state info
--
-- Example
-- -------
--
-- Spawn a small apple tree:
--
-- ```lua
-- pos = {x=230,y=20,z=4}
-- apple_tree={
--     axiom="FFFFFAFFBF",
--     rules_a="[&&&FFFFF&&FFFF][&&&++++FFFFF&&FFFF][&&&----FFFFF&&FFFF]",
--     rules_b="[&&&++FFFFF&&FFFF][&&&--FFFFF&&FFFF][&&&------FFFFF&&FFFF]",
--     trunk="default:tree",
--     leaves="default:leaves",
--     angle=30,
--     iterations=2,
--     random_level=0,
--     trunk_type="single",
--     thin_branches=true,
--     fruit_chance=10,
--     fruit="default:apple"
-- }
-- core.spawn_tree(pos,apple_tree)
---@class lsystem
---@field axiom string
---@field rules_a string
---@field rules_b string
---@field rules_d string
---@field trunk string trunk node name
---@field leaves string leaves node name
---@field leaves2 string secondary leaves node name
---@field leaves2_chance number chance to replace leaves with leaves2
---@field angle number in degrees
---@field iterations number max # of iterations, usually 2 - 5
---@field random_level number factor to lower number of iterations, usually 0 - 3
---@field thin_branches boolean
---@field fruit string fruit node name
---@field fruit_chance number
---@field seed number

---@param pos vector
---@param lsystem lsystem
---@return nil
function core.spawn_tree(pos, lsystem) end

---@param vmanip VoxelManip
---@param pos vector
---@param treedef lsystem
---@return nil
function core.spawn_tree_on_vmanip(vmanip, pos, treedef) end

---@class gen_notify: table<string, vector[]>
---@field dungeon vector?
---@field temple vector?
---@field cave_begin vector?
---@field cave_end vector?
---@field large_cave_begin vector?
---@field large_cave_end vector?
---@field custom table<string, any>

--- Unofficial Note: The types are a guess xD i have no idea how this works
---@return string, table<string, vector>, table<string, any>
function core.get_gen_notify() end

--- Unofficial Note: The types are a guess xD i have no idea how this works
-- * `core.set_gen_notify(flags, [deco_ids], [custom_ids])`
--     * Set the types of on-generate notifications that should be collected.
--     * `flags`: flag field, see [`gennotify`] for available generation notification types.
--     * The following parameters are optional:
--     * `deco_ids` is a list of IDs of decorations which notification
--       is requested for.
--     * `custom_ids` is a list of user-defined IDs (strings) which are
--       requested. By convention these should be the mod name with an optional
--       colon and specifier added, e.g. `"default"` or `"default:dungeon_loot"`
---@param flags string
---@param deco_ids string[]
---@param custom_ids string[]
function core.set_gen_notify(flags, deco_ids, custom_ids) end
---@param decoration_name string
function core.get_decoration_id(decoration_name) end
---@param objectname string
function core.get_mapgen_object(objectname) end

--- Unofficial note: this relates to the biome heat, idk override it and make your own custom mapgen if you dare
-- * `core.get_heat(pos)`
--     * Returns the heat at the position, or `nil` on failure.
---@return number?
---@param pos vector
function core.get_heat(pos) end

--- Unofficial note: this relates to the biome humidity, idk override it and make your own custom mapgen if you dare
-- * `core.get_humidity(pos)`
--     * Returns the humidity at the position, or `nil` on failure.
---@return number?
---@param pos vector
function core.get_humidity(pos) end

-- * `core.get_biome_data(pos)`
--     * Returns a table containing:
--         * `biome` the biome id of the biome at that position
--         * `heat` the heat at the position
--         * `humidity` the humidity at the position
--     * Or returns `nil` on failure.
---@param pos vector
---@return {biome:number, heat:number, humidity:number}?
function core.get_biome_data(pos) end

-- * `core.get_biome_id(biome_name)`
--     * Returns the biome id, as used in the biomemap Mapgen object and returned
--       by `core.get_biome_data(pos)`, for a given biome_name string.
---@param biome_name string
---@return number
function core.get_biome_id(biome_name) end

-- * `core.get_biome_name(biome_id)`
--     * Returns the biome name string for the provided biome id, or `nil` on
--       failure.
--     * If no biomes have been registered, such as in mgv6, returns `default`.
---@param biome_id number
---@return string?
function core.get_biome_name(biome_id) end

-- * `core.get_mapgen_edges([mapgen_limit[, chunksize]])`
--     * Returns the minimum and maximum possible generated node positions
--       in that order.
--     * `mapgen_limit` is an optional number. If it is absent, its value is that
--       of the *active* mapgen setting `"mapgen_limit"`.
--     * `chunksize` is an optional number. If it is absent, its value is that
--       of the *active* mapgen setting `"chunksize"`.
---@param mapgen_limit number?
---@param chunksize number?
function core.get_mapgen_edges(mapgen_limit, chunksize) end

-- * `core.get_mapgen_setting(name)`
--     * Gets the *active* mapgen setting (or nil if none exists) in string
--       format with the following order of precedence:
--         1) Settings loaded from map_meta.txt or overrides set during mod
--            execution.
--         2) Settings set by mods without a metafile override
--         3) Settings explicitly set in the user config file, minetest.conf
--         4) Settings set as the user config default
---@param name string
---@return string
function core.get_mapgen_setting(name) end

-- * `core.get_mapgen_setting_noiseparams(name)`
--     * Same as above, but returns the value as a NoiseParams table if the
--       setting `name` exists and is a valid NoiseParams.
---@return NoiseParams
---@param name string
function core.get_mapgen_setting_noiseparams(name) end

-- * `core.set_mapgen_setting(name, value, [override_meta])`
--     * Sets a mapgen param to `value`, and will take effect if the corresponding
--       mapgen setting is not already present in map_meta.txt.
--     * `override_meta` is an optional boolean (default: `false`). If this is set
--       to true, the setting will become the active setting regardless of the map
--       metafile contents.
--     * Note: to set the seed, use `"seed"`, not `"fixed_map_seed"`.
---@param name string
---@param value string
---@param override_meta boolean?
---@return nil
function core.set_mapgen_setting(name, value, override_meta) end

-- * `core.set_mapgen_setting_noiseparams(name, value, [override_meta])`
--     * Same as above, except value is a NoiseParams table.
---@param value NoiseParams
---@param override_meta boolean?
---@param name string
function core.set_mapgen_setting_noiseparams(name, value, override_meta) end

-- * `core.set_noiseparams(name, noiseparams, set_default)`
--     * Sets the noiseparams setting of `name` to the noiseparams table specified
--       in `noiseparams`.
--     * `set_default` is an optional boolean (default: `true`) that specifies
--       whether the setting should be applied to the default config or current
--       active config.
---@param name string
---@param noiseparams NoiseParams
---@param set_default boolean?
---@return nil
function core.set_noiseparams(name, noiseparams, set_default) end

---@param name string
---@return NoiseParams
function core.get_noiseparams(name) end

--- BIOME DEF

---@class BiomeDef
---@field name string
-- Node dropped onto upper surface after all else is generated
---@field node_dust? string
-- Node forming surface layer of biome
---@field node_top? string
-- Node forming surface layer of biome and thickness of this layer
---@field depth_top? integer
-- Node forming lower layer of biome
---@field node_filler? string
-- Node forming lower layer of biome and thickness of this layer
---@field depth_filler? integer
-- Node that replaces all stone nodes between roughly y_min and y_max.
---@field node_stone? string
-- Node forming a surface layer in seawater with the defined thickness
---@field node_water_top? string
-- Node forming a surface layer in seawater with the defined thickness
---@field depth_water_top? integer
-- Node that replaces all seawater nodes not in the surface layer
---@field node_water? string
-- Node that replaces river water in mapgens that use
-- default:river_water
---@field node_river_water? string
-- Node placed under river water and thickness of this layer
---@field node_riverbed? string
-- Node placed under river water and thickness of this layer
---@field depth_riverbed? integer
-- Nodes placed inside 50% of the medium size caves.
-- Multiple nodes can be specified, each cave will use a randomly
-- chosen node from the list.
-- If this field is left out or 'nil', cave liquids fall back to
-- classic behavior of lava and water distributed using 3D noise.
-- For no cave liquid, specify "air".
---@field node_cave_liquid? string|string[]
-- Node used for primary dungeon structure.
-- If absent, dungeon nodes fall back to the 'mapgen_cobble' mapgen
-- alias, if that is also absent, dungeon nodes fall back to the biome
-- 'node_stone'.
-- If present, the following two nodes are also used.
---@field node_dungeon? string
-- Node used for randomly-distributed alternative structure nodes.
-- If alternative structure nodes are not wanted leave this absent.
---@field node_dungeon_alt? string
-- Node used for dungeon stairs.
-- If absent, stairs fall back to 'node_dungeon'.
---@field node_dungeon_stair? string
---@field y_max? integer
---@field y_min? integer
-- xyz limits for biome, an alternative to using 'y_min' and 'y_max'.
-- Biome is limited to a cuboid defined by these positions.
-- Any x, y or z field left undefined defaults to -31000 in 'min_pos' or
-- 31000 in 'max_pos'.
---@field max_pos? vector
-- xyz limits for biome, an alternative to using 'y_min' and 'y_max'.
-- Biome is limited to a cuboid defined by these positions.
-- Any x, y or z field left undefined defaults to -31000 in 'min_pos' or
-- 31000 in 'max_pos'.
---@field min_pos? vector
-- Vertical distance in nodes above 'y_max' over which the biome will
-- blend with the biome above.
-- Set to 0 for no vertical blend. Defaults to 0.
---@field vertical_blend? number
-- Characteristic temperature and humidity for the biome.
-- These values create 'biome points' on a voronoi diagram with heat and
-- humidity as axes. The resulting voronoi cells determine the
-- distribution of the biomes.
-- Heat and humidity have average values of 50, vary mostly between
-- 0 and 100 but can exceed these values.
---@field heat_point number
-- Characteristic temperature and humidity for the biome.
-- These values create 'biome points' on a voronoi diagram with heat and
-- humidity as axes. The resulting voronoi cells determine the
-- distribution of the biomes.
-- Heat and humidity have average values of 50, vary mostly between
-- 0 and 100 but can exceed these values.
---@field humidity_point number
-- Relative weight of the biome in the Voronoi diagram.
-- A value of 0 (or less) is ignored and equivalent to 1.0.
---@field weight? number

---@class DecorationDef
-- Type. "simple", "schematic" or "lsystem" supported
---@field deco_type "simple"|"schematic"|"lsystem"
-- Node (or list of nodes) that the decoration can be placed on
---@field place_on? string[]|string
-- Size of the square (X / Z) divisions of the mapchunk being generated.
-- Determines the resolution of noise variation if used.
-- If the chunk size is not evenly divisible by sidelen, sidelen is made
-- equal to the chunk size.
---@field sidelen? {x:number,z:number}
-- The value determines 'decorations per surface node'.
-- Used only if noise_params is not specified.
-- If >= 10.0 complete coverage is enabled and decoration placement uses
-- a different and much faster method.
---@field fill_ratio? number
-- NoiseParams structure describing the noise used for decoration
-- distribution.
-- A noise value is calculated for each square division and determines
-- 'decorations per surface node' within each division.
-- If the noise value >= 10.0 complete coverage is enabled and
-- decoration placement uses a different and much faster method.
---@field noise_params NoiseParams
-- List of biomes in which this decoration occurs. Occurs in all biomes
-- if this is omitted, and ignored if the Mapgen being used does not
-- support biomes.
-- Can be a list of (or a single) biome names, IDs, or definitions.
---@field biomes? string|string[]
---@field y_min? integer
---@field y_max? integer
-- Node (or list of nodes) that the decoration only spawns next to.
-- Checks the 8 neighboring nodes on the same height,
-- and also the ones at the height plus the check_offset, excluding both center nodes.
---@field spawn_by? integer
-- Specifies the offset that spawn_by should also check
-- The default value of -1 is useful to e.g check for water next to the base node.
-- 0 disables additional checks, valid values: {-1, 0, 1}
---@field check_offset? integer
-- Number of spawn_by nodes that must be surrounding the decoration
-- position to occur.
-- If absent or -1, decorations occur next to any nodes.
---@field num_spawn_by? integer
-- Flags for all decoration types.
-- "liquid_surface": Find the highest liquid (not solid) surface under
--   open air. Search stops and fails on the first solid node.
--   Cannot be used with "all_floors" or "all_ceilings" below.
-- "force_placement": Nodes other than "air" and "ignore" are replaced
--   by the decoration.
-- "all_floors", "all_ceilings": Instead of placement on the highest
--   surface in a mapchunk the decoration is placed on all floor and/or
--   ceiling surfaces, for example in caves and dungeons.
--   Ceiling decorations act as an inversion of floor decorations so the
--   effect of 'place_offset_y' is inverted.
--   Y-slice probabilities do not function correctly for ceiling
--   schematic decorations as the behavior is unchanged.
--   If a single decoration registration has both flags the floor and
--   ceiling decorations will be aligned vertically.
-- ### Unofficial note: you can also fit schematic flags here i think
---@field flags? string
--- ### Type: "simple"
-- The node name used as the decoration.
-- If instead a list of strings, a randomly selected node from the list
-- is placed as the decoration.
---@field decoration? string
--- ### Type: "simple"
-- Decoration height in nodes.
-- If height_max is not 0, this is the lower limit of a randomly
-- selected height.
---@field height? number
--- ### Type: "simple"
-- Upper limit of the randomly selected height.
-- If absent, the parameter 'height' is used as a constant.
---@field height_max? number
--- ### Type: "simple"
-- Param2 value of decoration nodes.
-- If param2_max is not 0, this is the lower limit of a randomly
-- selected param2.
---@field param2? integer
--- ### Type: "simple"
-- Upper limit of the randomly selected param2.
-- If absent, the parameter 'param2' is used as a constant.
---@field param2_max? integer
--- ### Type: "simple" and "schematic"
-- Y offset of the decoration base node relative to the standard base
-- node position.
-- Can be positive or negative. Default is 0.
-- Effect is inverted for "all_ceilings" decorations.
-- Ignored by 'y_min', 'y_max' and 'spawn_by' checks, which always refer
-- to the 'place_on' node.
---@field place_offset_y? number
--- ### Type: "schematic"
-- If schematic is a string, it is the filepath relative to the current
-- working directory of the specified Luanti schematic file.
-- Could also be the ID of a previously registered schematic.
---@field schematic? string|table
--- ### Type: "schematic"
-- Map of node names to replace in the schematic after reading it.
---@field replacements? table<string,string>
--- ### Type: "schematic"
-- Rotation can be "0", "90", "180", "270", or "random"
---@field rotation? string
----- L-system-type parameters
-- Same as for `core.spawn_tree`.
-- See section [L-system trees] for more details.
---@field treedef? lsystem
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
--- CLASS REFERENCE
---@meta
--- "Misc.", "Helpers", "Utils", "Class reference"
--- what will be their next invention

-- Unofficial note:
-- > Class named "AreaStore"
-- > Look inside
-- > No store
-- ???
--
-- Anyway, the official docs:
-- `AreaStore`
-- -----------
--
-- AreaStore is a data structure to calculate intersections of 3D cuboid volumes
-- and points. The `data` field (string) may be used to store and retrieve any
-- mod-relevant information to the specified area.
--
-- Despite its name, mods must take care of persisting AreaStore data. They may
-- use the provided load and write functions for this.
--
---@class AreaStore
AreaStore = {}

--- Unofficial note: I am aware that "Luanti" isn't a valid AreaStore type, but that makes it default to Luanti functions so, is it not accurate?
-- * `AreaStore(type_name)`
--     * Returns a new AreaStore instance
--     * `type_name`: optional, forces the internally used API.
--         * Possible values: `"LibSpatial"` (default).
--         * When other values are specified, or SpatialIndex is not available,
--           the custom Luanti functions are used.
---@param type "LibSpatial"|"Luanti"|any
---@return AreaStore
function AreaStore(type) end

-- * `get_area(id, include_corners, include_data)`
--     * Returns the area information about the specified ID.
--     * Returned values are either of these:
--       ```lua
--       nil  -- Area not found
--       true -- Without `include_corners` and `include_data`
--       {
--           min = pos, max = pos -- `include_corners == true`
--           data = string        -- `include_data == true`
--       }
--       ```
---@param id number
---@param include_corners boolean
---@param include_data boolean
---@return boolean|{min:vector?,max:vector?,data:string?}
function AreaStore:get_area(id, include_corners, include_data) end

-- * `get_areas_for_pos(pos, include_corners, include_data)`
--     * Returns all areas as table, indexed by the area ID.
--     * Table values: see `get_area`.
---@param pos vector
---@param include_corners boolean
---@param include_data boolean
---@return boolean|table<integer,{min:vector?,max:vector?,data:string?}>
function AreaStore:get_areas_for_pos(pos, include_corners, include_data) end

-- * `get_areas_in_area(corner1, corner2, accept_overlap, include_corners, include_data)`
--     * Returns all areas that contain all nodes inside the area specified by`
--       `corner1 and `corner2` (inclusive).
--     * `accept_overlap`: if `true`, areas are returned that have nodes in
--       common (intersect) with the specified area.
--     * Returns the same values as `get_areas_for_pos`.
---@param pos1 vector
---@param pos2 vector
---@param accept_overlap boolean
---@param include_corners boolean
---@param include_data boolean
---@return boolean|table<integer,{min:vector?,max:vector?,data:string?}>
function AreaStore:get_areas_in_area(pos1, pos2, accept_overlap, include_corners, include_data) end

-- * `insert_area(corner1, corner2, data, [id])`: inserts an area into the store.
--     * Returns the new area's ID, or nil if the insertion failed.
--     * The (inclusive) positions `corner1` and `corner2` describe the area.
--     * `data` is a string stored with the area.
--     * `id` (optional): will be used as the internal area ID if it is a unique
--       number between 0 and 2^32-2.
---@param corner1 vector
---@param corner2 vector
---@param data string
---@param id integer?
---@return integer?
function AreaStore:insert_area(corner1, corner2, data, id) end

-- * `reserve(count)`
--     * Requires SpatialIndex, no-op function otherwise.
--     * Reserves resources for `count` many contained areas to improve
--       efficiency when working with many area entries. Additional areas can still
--       be inserted afterwards at the usual complexity.
---@param count integer
function AreaStore:reserve(count) end

-- * `remove_area(id)`: removes the area with the given id from the store, returns
--   success.
---@nodiscard
---@param id number
---@return boolean
function AreaStore:remove_area(id) end

-- * `set_cache_params(params)`: sets params for the included prefiltering cache.
--   Calling invalidates the cache, so that its elements have to be newly
--   generated.
--     * `params` is a table with the following fields:
--       ```lua
--       {
--           enabled = boolean,   -- Whether to enable, default true
--           block_radius = int,  -- The radius (in nodes) of the areas the cache
--                                -- generates prefiltered lists for, minimum 16,
--                                -- default 64
--           limit = int,         -- The cache size, minimum 20, default 1000
--       }
--       ```
---@param params {enabled:boolean, block_radius:integer, limit:integer}
function AreaStore:set_cache_params(params) end

-- * `to_string()`: Experimental. Returns area store serialized as a (binary)
--   string.
---@return string
function AreaStore:to_string() end

-- * `to_file(filename)`: Experimental. Like `to_string()`, but writes the data to
--   a file.
---@param filename string
function AreaStore:to_file(filename) end

-- * `from_string(str)`: Experimental. Deserializes string and loads it into the
--   AreaStore.
--   Returns success and, optionally, an error message.
---@param str string
function AreaStore:from_string(str) end

-- * `from_file(filename)`: Experimental. Like `from_string()`, but reads the data
--   from a file.
---@param filename string
function AreaStore:from_file(filename) end
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
---@class ColorString: string
---@class ColorSpec: table|number|integer|string|any

---@class content_id: integer

--- Unofficial note: This class isn't mentioned anywhere, but when inputting a node parameter to functions, you don't actually have to provide the param1 and the param2, so that's why it exists
---@class MapNodeOpt: {name: string, param1: number?, param2: number?}
---@class MapNode: {name:string, param1:number, param2:number}
---@class light_level: number
---@class light: {day:light_level, light:light_level}

---@class core
core = {}

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
---@meta

---@param craft_recipe CraftRecipe
function core.register_craft(craft_recipe) end

--- Unofficial note:
--- ... WHAT
--- WHAT
--- WHAT
--- WHY CAN THE SAME TABLE DO COOKING, TOOLREPAIR AND CRAFTING
--- WHAT
--- WHY
--- WHAT
--- this is impressive

---@class CraftRecipe
---@field type "shaped"|"shapeless"|"toolrepair"|"cooking"|"fuel"
---@field output? ItemStackAny
---@field recipe? ItemStackAny[][]|ItemStackAny[]
-- * `replacements`: (optional) Allows you to replace input items with some other items
--       when something is crafted
--     * Provided as a list of item pairs of the form `{ old_item, new_item }` where
--       `old_item` is the input item to replace (same syntax as for a regular input
--       slot; groups are allowed) and `new_item` is an itemstring for the item stack
--       it will become
--     * When the output is crafted, Luanti iterates through the list
--       of input items if the crafting grid. For each input item stack, it checks if
--       it matches with an `old_item` in the item pair list.
--         * If it matches, the item will be replaced. Also, this item pair
--           will *not* be applied again for the remaining items
--         * If it does not match, the item is consumed (reduced by 1) normally
--     * The `new_item` will appear in one of 3 places:
--         * Crafting grid, if the input stack size was exactly 1
--         * Player inventory, if input stack size was larger
--         * Drops as item entity, if it fits neither in craft grid or inventory
---@field replacements? {[1]:ItemStackAny, [2]:ItemStackAny}[]
-- ### Tool repair
--
-- Syntax:
--
--     {
--         type = "toolrepair",
--         additional_wear = -0.02, -- multiplier of 65536
--     }
--
-- Adds a shapeless recipe for *every* tool that doesn't have the `disable_repair=1`
-- group. If this recipe is used, repairing is possible with any crafting grid
-- with at least 2 slots.
-- The player can put 2 equal tools in the craft grid to get one "repaired" tool
-- back.
-- The wear of the output is determined by the wear of both tools, plus a
-- 'repair bonus' given by `additional_wear`. To reduce the wear (i.e. 'repair'),
-- you want `additional_wear` to be negative.
--
-- The formula used to calculate the resulting wear is:
--
--     65536 * (1 - ( (1 - tool_1_wear) + (1 - tool_2_wear) + additional_wear))
--
-- The result is rounded and can't be lower than 0. If the result is 65536 or higher,
-- no crafting is possible.
---@field additional_wear? number
---@field cooktime? number
---@meta

---@class HudID

-- Functions receive a "luaentity" table as `self`:
--
-- * It has the member `name`, which is the registered name `("mod:thing")`
-- * It has the member `object`, which is an `ObjectRef` pointing to the object
-- * The original prototype is visible directly via a metatable
---@class luaentity: table
---@field name string
---@field object ObjectRef
---@field on_activate fun(self:luaentity, staticdata:string, dtime_s:number)
-- * `on_deactivate(self, removal)`
--     * Called when the object is about to get removed or unloaded.
--     * `removal`: boolean indicating whether the object is about to get removed.
--       Calling `object:remove()` on an active object will call this with `removal=true`.
--       The mapblock the entity resides in being unloaded will call this with `removal=false`.
--     * Note that this won't be called if the object hasn't been activated in the first place.
--       In particular, `core.clear_objects({mode = "full"})` won't call this,
--       whereas `core.clear_objects({mode = "quick"})` might call this.
---@field on_deactivate fun(self:luaentity, removal:boolean)
---@field on_step fun(self:luaentity, dtime: number, moveresult: moveresult)
---@field on_punch fun(self:luaentity, puncher:ObjectRef?, time_from_last_punch:number?, tool_capabilities:tool_capabilities?, dir: vector, damage: number):boolean
---@field on_death fun(self:luaentity, killer:ObjectRef?)
---@field on_rightclick fun(self:luaentity, clicker:ObjectRef)
---@field on_attach_child fun(self:luaentity, child:ObjectRef)
---@field on_detach_child fun(self:luaentity, child:ObjectRef)
---@field on_detach fun(self:luaentity, parent:ObjectRef)
---@field get_staticdata fun(self:luaentity)

--- Unofficial note: Never mentioned anywhere but useful for me
---@class collision
---@field type "node"|"object"
---@field axis "x"|"y"|"z"
---@field node_pos vector?
---@field object ObjectRef?
---@field new_pos vector
---@field old_velocity vector
---@field new_velocity vector

---@class moveresult
---@field touching_ground boolean
---@field collides boolean
---@field standing_on_object boolean
---@field collisions collision[]

---@class ObjectProps
-- Defines the maximum and default HP of the object.
-- For Lua entities, the maximum is not enforced.
-- For players, this defaults to `core.PLAYER_MAX_HP_DEFAULT` (20).
-- For Lua entities, the default is 10.
---@field hp_max? integer
-- For players only. Defines the maximum amount of "breath" for the player.
-- Defaults to `core.PLAYER_MAX_BREATH_DEFAULT` (10).
---@field breath_max? integer
-- For players only. Zoom FOV in degrees.
-- Note that zoom loads and/or generates world beyond the server's
-- maximum send and generate distances, so acts like a telescope.
-- Smaller zoom_fov values increase the distance loaded/generated.
-- Defaults to 15 in creative mode, 0 in survival mode.
-- zoom_fov = 0 disables zooming for the player.
---@field zoom_fov? number
-- For players only. Camera height above feet position in nodes.
---@field eye_height? number
-- Collide with `walkable` nodes.
---@field physical? boolean
-- Collide with other objects if physical = true
---@field collide_with_objects? boolean
-- { xmin, ymin, zmin, xmax, ymax, zmax } in nodes from object position.
-- Collision boxes cannot rotate, setting `rotate = true` on it has no effect.
-- If not set, the selection box copies the collision box, and will also not rotate.
-- If `rotate = false`, the selection box will not rotate with the object itself, remaining fixed to the axes.
---@field selectionbox? number[]
-- If `rotate = true`, it will match the object's rotation and any attachment rotations.
-- Raycasts use the selection box and object's rotation, but do *not* obey attachment rotations.
-- For server-side raycasts to work correctly,
-- the selection box should extend at most 5 units in each direction.
---@field collisionbox? table
-- Can be `true` if it is pointable, `false` if it can be pointed through,
-- or `"blocking"` if it is pointable but not selectable.
-- Clients older than 5.9.0 interpret `pointable = "blocking"` as `pointable = true`.
-- Can be overridden by the `pointabilities` of the held item.
---@field pointable? boolean
-- "cube" is a node-sized cube.
-- "sprite" is a flat texture always facing the player.
-- "upright_sprite" is a vertical flat texture.
-- "mesh" uses the defined mesh model.
-- "wielditem" is used for dropped items.
--   (see builtin/game/item_entity.lua).
--   For this use 'wield_item = itemname'.
--   Setting 'textures = {itemname}' has the same effect, but is deprecated.
--   If the item has a 'wield_image' the object will be an extrusion of
--   that, otherwise:
--   If 'itemname' is a cubic node or nodebox the object will appear
--   identical to 'itemname'.
--   If 'itemname' is a plantlike node the object will be an extrusion
--   of its texture.
--   Otherwise for non-node items, the object will be an extrusion of
--   'inventory_image'.
--   If 'itemname' contains a ColorString or palette index (e.g. from
--   `core.itemstring_with_palette()`), the entity will inherit the color.
--   Wielditems are scaled a bit. If you want a wielditem to appear
--   to be as large as a node, use `0.667` in `visual_size`
-- "item" is similar to "wielditem" but ignores the 'wield_image' parameter.
-- "node" looks exactly like a node in-world (supported since 5.12.0)
--   Note that visual effects like waving or liquid reflections will not work.
---@field visual? "cube"|"sprite"|"upright_sprite"|"mesh"|"wielditem"|"item"|"node"
-- Multipliers for the visual size. If `z` is not specified, `x` will be used
-- to scale the entity along both horizontal axes.
---@field visual_size? vector
-- File name of mesh when using "mesh" visual.
-- For legacy reasons, this uses a 10x scale for meshes: 10 units = 1 node.
---@field mesh? string
-- Number of required textures depends on visual:
-- "cube" uses 6 textures just like a node, but all 6 must be defined.
-- "sprite" uses 1 texture.
-- "upright_sprite" uses 2 textures: {front, back}.
-- "mesh" requires one texture for each mesh buffer/material (in order)
-- Deprecated usage of "wielditem" expects 'textures = {itemname}' (see 'visual' above).
-- Unofficial note: I *guessed* that it's string[] but i am not sure
---@field textures? string[]
-- Currently unused.
---@field colors? table
-- Node to show when using the "node" visual
---@field node? MapNodeOpt
-- Use texture's alpha channel for transparency blending.
-- Note: currently causes visual issues when viewed through other
-- semi-transparent materials such as water.
-- Note: ignored for "item", "wielditem" and "node" visual.
---@field use_texture_alpha? boolean
-- Used with spritesheet textures for animation and/or frame selection
-- according to position relative to player.
-- Defines the number of columns and rows in the spritesheet:
-- {columns, rows}.
---@field spritediv? {x:number,y:number}
-- Used with spritesheet textures.
-- Defines the {column, row} position of the initially used frame in the
-- spritesheet.
---@field initial_sprite_basepos? {x:number,y:number}
-- If false, object is invisible and can't be pointed.
---@field is_visible? boolean
-- If true, object is able to make footstep sounds of nodes
-- (see node sound definition for details).
---@field makes_footstep_sound? boolean
-- Set constant rotation in radians per second, positive or negative.
-- Object rotates along the local Y-axis, and works with set_rotation.
-- Set to 0 to disable constant rotation.
---@field automatic_rotate? number
-- If positive number, object will climb upwards when it moves
-- horizontally against a `walkable` node, if the height difference
-- is within `stepheight`.
---@field stepheight? number
-- Automatically set yaw to movement direction, offset in degrees.
-- 'false' to disable.
---@field automatic_face_movement_dir? number|boolean
-- Limit automatic rotation to this value in degrees per second.
-- No limit if value <= 0.
---@field automatic_face_movement_max_rotation_per_sec? number
-- Set to false to disable backface_culling for model
-- Note: only used by "mesh" and "cube" visual
---@field backface_culling? boolean
-- Add this much extra lighting when calculating texture color.
-- Value < 0 disables light's effect on texture color.
-- For faking self-lighting, UI style entities, or programmatic coloring
-- in mods.
---@field glow? number
-- The name to display on the head of the object. By default empty.
-- If the object is a player, a nil or empty nametag is replaced by the player's name.
-- For all other objects, a nil or empty string removes the nametag.
-- To hide a nametag, set its color alpha to zero. That will disable it entirely.
---@field nametag? string
-- Sets text color of nametag
---@field nametag_color? ColorSpec
-- Sets background color of nametag
-- `false` will cause the background to be set automatically based on user settings.
-- Default: false
---@field nametag_bgcolor? ColorSpec
-- Same as infotext for nodes. Empty by default
---@field infotext? string
-- If false, never save this object statically. It will simply be
-- deleted when the block gets unloaded.
-- The get_staticdata() callback is never called then.
-- Defaults to 'true'.
---@field static_save? boolean
-- Texture modifier to be applied for a short duration when object is hit
---@field damage_texture_modifier? string
-- Setting this to 'false' disables diffuse lighting of entity
-- Note: ignored for "item", "wielditem" and "node" visual
---@field shaded? boolean
-- Defaults to true for players, false for other entities.
-- If set to true the entity will show as a marker on the minimap.
---@field show_on_minimap? boolean

-- `ObjectRef`
-- -----------
--
-- Moving things in the game are generally these.
-- This is basically a reference to a C++ `ServerActiveObject`.
--
-- ### Advice on handling `ObjectRefs`
--
-- When you receive an `ObjectRef` as a callback argument or from another API
-- function, it is possible to store the reference somewhere and keep it around.
-- It will keep functioning until the object is unloaded or removed.
--
-- However, doing this is **NOT** recommended - `ObjectRefs` should be "let go"
-- of as soon as control is returned from Lua back to the engine.
--
-- Doing so is much less error-prone and you will never need to wonder if the
-- object you are working with still exists.
--
-- If this is not feasible, you can test whether an `ObjectRef` is still valid
-- via `object:is_valid()`.
--
-- Getters may be called for invalid objects and will return nothing then.
-- All other methods should not be called on invalid objects.
--
-- ### Attachments
--
-- It is possible to attach objects to other objects (`set_attach` method).
--
-- When an object is attached, it is positioned relative to the parent's position
-- and rotation. `get_pos` and `get_rotation` will always return the parent's
-- values and changes via their setter counterparts are ignored.
--
-- To change position or rotation call `set_attach` again with the new values.
--
-- **Note**: Just like model dimensions, the relative position in `set_attach`
-- must be multiplied by 10 compared to world positions.
--
-- It is also possible to attach to a bone of the parent object. In that case the
-- child will follow movement and rotation of that bone.
--
---@class ObjectRef
-- * `is_valid()`: returns whether the object is valid.
--    * See "Advice on handling `ObjectRefs`" above.
---@field is_valid fun(self,):boolean
-- * `get_pos()`: returns position as vector `{x=num, y=num, z=num}`
---@field get_pos fun(self,):vector
-- * `set_pos(pos)`:
--     * Sets the position of the object.
--     * No-op if object is attached.
--     * `pos` is a vector `{x=num, y=num, z=num}`
---@field set_pos fun(self,pos:vector)
-- * `add_pos(pos)`:
--     * Changes position by adding to the current position.
--     * No-op if object is attached.
--     * `pos` is a vector `{x=num, y=num, z=num}`.
--     * In comparison to using `set_pos`, `add_pos` will avoid synchronization problems.
---@field add_pos fun(self,pos:vector)
-- * `get_velocity()`: returns the velocity, a vector.
---@field get_velocity fun(self,):vector
-- * `add_velocity(vel)`
--     * Changes velocity by adding to the current velocity.
--     * `vel` is a vector, e.g. `{x=0.0, y=2.3, z=1.0}`
--     * In comparison to using `get_velocity`, adding the velocity and then using
--       `set_velocity`, `add_velocity` is supposed to avoid synchronization problems.
--       Additionally, players also do not support `set_velocity`.
--     * If object is a player:
--         * Does not apply during `free_move`.
--         * Note that since the player speed is normalized at each move step,
--           increasing e.g. Y velocity beyond what would usually be achieved
--           (see: physics overrides) will cause existing X/Z velocity to be reduced.
--         * Example: `add_velocity({x=0, y=6.5, z=0})` is equivalent to
--           pressing the jump key (assuming default settings)
---@field add_velocity fun(self,vel:vector)
-- * `move_to(pos, continuous=false)`
--     * Does an interpolated move for Lua entities for visually smooth transitions.
--     * If `continuous` is true, the Lua entity will not be moved to the current
--       position before starting the interpolated move.
--     * For players this does the same as `set_pos`,`continuous` is ignored.
--     * no-op if object is attached
---@field move_to fun(self,pos:vector, continuous:boolean?)
-- * `punch(puncher, time_from_last_punch, tool_capabilities, dir)`
--     * punches the object, triggering all consequences a normal punch would have
--     * `puncher`: another `ObjectRef` which punched the object or `nil`
--     * `dir`: direction vector of punch
--     * Other arguments: See `on_punch` for entities
--     * Arguments `time_from_last_punch`, `tool_capabilities`, and `dir`
--       will be replaced with a default value when the caller sets them to `nil`.
---@field punch fun(self,puncher: ObjectRef, time_from_last_punch: number?, tool_capabilities:tool_capabilities?, dir:vector?)
-- * `right_click(clicker)`:
--     * simulates using the 'place/use' key on the object
--     * triggers all consequences as if a real player had done this
--     * `clicker` is another `ObjectRef` which has clicked
--     * note: this is called `right_click` for historical reasons only
---@field right_click fun(self,clicker:PlayerRef)
-- * `get_hp()`: returns number of health points
---@field get_hp fun(self,):number
-- * `set_hp(hp, reason)`: set number of health points
--     * See reason in register_on_player_hpchange
--     * Is limited to the range of 0 ... 65535 (2^16 - 1)
--     * For players: HP are also limited by `hp_max` specified in object properties
--- Unofficial note:I *assume* it's a PlayerHPChangeReason, i am not certain
---@field set_hp fun(self,hp:integer, reason:PlayerHPChangeReason)
-- * `get_inventory()`: returns an `InvRef` for players, otherwise returns `nil`
---@field get_inventory fun(self,):InvRef?
-- * `get_wield_list()`: returns the name of the inventory list the wielded item
--    is in.
---@field get_wield_list fun(self,):string?
-- * `get_wield_index()`: returns the wield list index of the wielded item (starting with 1)
---@field get_wield_index fun(self,):integer?
-- * `get_wielded_item()`: returns a copy of the wielded item as an `ItemStack`
---@field get_wielded_item fun(self,):ItemStack?
-- * `set_wielded_item(item)`: replaces the wielded item, returns `true` if
--   successful.
---@field set_wielded_item fun(self,item:ItemStack):boolean?
-- * `get_armor_groups()`:
--     * returns a table with all of the object's armor group ratings
--     * syntax: the table keys are the armor group names,
--       the table values are the corresponding group ratings
--     * see section '`ObjectRef` armor groups' for details
---@field get_armor_groups fun(self,):table<string, integer>
-- * `set_armor_groups({group1=rating, group2=rating, ...})`
--     * sets the object's full list of armor groups
--     * same table syntax as for `get_armor_groups`
--     * note: all armor groups not in the table will be removed
---@field set_armor_groups fun(self,groups: table<string,integer>)
-- * `set_animation(frame_range, frame_speed, frame_blend, frame_loop)`
--     * Sets the object animation parameters and (re)starts the animation
--     * Animations only work with a `"mesh"` visual
--     * `frame_range`: Beginning and end frame (as specified in the mesh file).
--        * Syntax: `{x=start_frame, y=end_frame}`
--        * Animation interpolates towards the end frame but stops when it is reached
--        * If looped, there is no interpolation back to the start frame
--        * If looped, the model should look identical at start and end
--        * default: `{x=1.0, y=1.0}`
--     * `frame_speed`: How fast the animation plays, in frames per second (number)
--        * default: `15.0`
--     * `frame_blend`: number, default: `0.0`
--     * `frame_loop`: If `true`, animation will loop. If false, it will play once
--        * default: `true`
---@field set_animation fun(self,frame_range: {x:number,y:number}?, frame_speed:number?, frame_blend:number?, frame_loop:boolean?)
-- * `get_animation()`: returns current animation parameters set by `set_animation`:
--     * `frame_range`, `frame_speed`, `frame_blend`, `frame_loop`.
---@field get_animation fun(self,):{x:number,y:number}, number, number, boolean
-- * `set_animation_frame_speed(frame_speed)`
--     * Sets the frame speed of the object's animation
--     * Unlike `set_animation`, this will not restart the animation
--     * `frame_speed`: See `set_animation`
---@field set_animation_frame_speed fun(self,frame_speed: number)
-- * `set_attach(parent[, bone, position, rotation, forced_visible])`
--     * Attaches object to `parent`
--     * See 'Attachments' section for details
--     * `parent`: `ObjectRef` to attach to
--     * `bone`: Bone to attach to. Default is `""` (the root bone)
--     * `position`: relative position, default `{x=0, y=0, z=0}`
--     * `rotation`: relative rotation in degrees, default `{x=0, y=0, z=0}`
--     * `forced_visible`: Boolean to control whether the attached entity
--        should appear in first person, default `false`.
--     * This command may fail silently (do nothing) when it would result
--       in circular attachments.
---@field set_attach fun(self,parent:ObjectRef, bone:string?, position:vector?, rotation:vector?, forced_visible:boolean?)
-- * `get_attach()`:
--     * returns current attachment parameters or nil if it isn't attached
--     * If attached, returns `parent`, `bone`, `position`, `rotation`, `forced_visible`
---@field get_attach fun(self,):ObjectRef?, string?, vector?, vector?, boolean?
-- * `get_children()`: returns a list of ObjectRefs that are attached to the
--     object.
---@field get_children fun(self,): ObjectRef[]
-- * `set_detach()`: Detaches object. No-op if object was not attached.
---@field set_detach fun(self,)
-- * `set_bone_position([bone, position, rotation])`
--     * Sets absolute bone overrides, e.g. it is equivalent to
--       ```lua
--       obj:set_bone_override(bone, {
--           position = {vec = position, absolute = true},
--           rotation = {vec = rotation:apply(math.rad), absolute = true}
--       })
--       ```
--     * **Note:** Rotation is in degrees, not radians.
--     * **Deprecated:** Use `set_bone_override` instead.
---@deprecated
---@field set_bone_position fun(self,bone: string, position:any, rotation:any)
-- * `get_bone_position(bone)`: returns the previously set position and rotation of the bone
--     * Shorthand for `get_bone_override(bone).position.vec, get_bone_override(bone).rotation.vec:apply(math.deg)`.
--     * **Note:** Returned rotation is in degrees, not radians.
--     * **Deprecated:** Use `get_bone_override` instead.
---@field get_bone_position fun(self,bone:string): vector
-- * `set_bone_override(bone, override)`
--     * `bone`: string
--     * `override`: `{ position = property, rotation = property, scale = property }` or `nil`
--     * `override = nil` (including omission) is shorthand for `override = {}` which clears the override
--     * Each `property` is a table of the form
--       `{ vec = vector, interpolation = 0, absolute = false }` or `nil`
--         * `vec` is in the same coordinate system as the model, and in radians for rotation.
--           It defaults to `vector.zero()` for translation and rotation and `vector.new(1, 1, 1)` for scale.
--         * `interpolation`: The old and new overrides are interpolated over this timeframe (in seconds).
--         * `absolute`: If set to `false` (which is the default),
--           the override will be relative to the animated property:
--             * Translation in the case of `position`;
--             * Composition in the case of `rotation`;
--             * Per-axis multiplication in the case of `scale`
--     * `property = nil` is equivalent to no override on that property
--     * **Note:** Unlike `set_bone_position`, the rotation is in radians, not degrees.
--     * Compatibility note: Clients prior to 5.9.0 only support absolute position and rotation.
--       All values are treated as absolute and are set immediately (no interpolation).
---@field set_bone_override fun(self,bone:string, override:table)
-- * `get_bone_override(bone)`: returns `override` in the above format
--     * **Note:** Unlike `get_bone_position`, the returned rotation is in radians, not degrees.
---@field get_bone_override fun(self,bone:string):table
-- * `get_bone_overrides()`: returns all bone overrides as table `{[bonename] = override, ...}`
---@field get_bone_overrides fun(self,):table<string, table>
-- * `set_properties(object property table)`
---@field set_properties fun(self,ObjectProps:ObjectProps)
-- * `get_properties()`: returns a table of all object properties
---@field get_properties fun(self,):ObjectProps
-- * `set_observers(observers)`: sets observers (players this object is sent to)
--     * If `observers` is `nil`, the object's observers are "unmanaged":
--       The object is sent to all players as governed by server settings. This is the default.
--     * `observers` is a "set" of player names: `{name1 = true, name2 = true, ...}`
--         * A set is a table where the keys are the elements of the set
--           (in this case, *valid* player names) and the values are all `true`.
--     * Attachments: The *effective observers* of an object are made up of
--       all players who can observe the object *and* are also effective observers
--       of its parent object (if there is one).
--     * Players are automatically added to their own observer sets.
--       Players **must** effectively observe themselves.
--     * Object activation and deactivation are unaffected by observability.
--     * Attached sounds do not work correctly and thus should not be used
--       on objects with managed observers yet.
---@field set_observers fun(self,observers: table<string, boolean>)
-- * `get_observers()`:
--     * throws an error if the object is invalid
--     * returns `nil` if the observers are unmanaged
--     * returns a table with all observer names as keys and `true` values (a "set") otherwise
---@field get_observers fun(self,): table<string, boolean>?
-- * `get_effective_observers()`:
--     * Like `get_observers()`, but returns the "effective" observers, taking into account attachments
--     * Time complexity: O(nm)
--         * n: number of observers of the involved entities
--         * m: number of ancestors along the attachment chain
---@field get_effective_observers fun(self,): table<string, boolean>
-- * `is_player()`: returns true for players, false otherwise
---@field is_player fun(self,):boolean
-- * `get_nametag_attributes()`
--     * returns a table with the attributes of the nametag of an object
--     * a nametag is a HUD text rendered above the object
--     * ```lua
--       {
--           text = "",
--           color = {a=0..255, r=0..255, g=0..255, b=0..255},
--           bgcolor = {a=0..255, r=0..255, g=0..255, b=0..255},
--       }
--       ```
---@field get_nametag_attributes fun(self,): { text: string, color:ColorSpec, bgcolor:ColorSpec|boolean}
-- * `set_nametag_attributes(attributes)`
--     * sets the attributes of the nametag of an object
--     * `attributes`:
--       ```lua
--       {
--           text = "My Nametag",
--           color = ColorSpec,
--           -- ^ Text color
--           bgcolor = ColorSpec or false,
--           -- ^ Sets background color of nametag
--           -- `false` will cause the background to be set automatically based on user settings
--           -- Default: false
--       }
--       ```
---@field set_nametag_attributes fun(self,attributes:{ text: string?, color:ColorSpec?, bgcolor:ColorSpec|boolean?})
--- Luaentity only
-- * `remove()`: remove object
--     * The object is removed after returning from Lua. However the `ObjectRef`
--       itself instantly becomes unusable with all further method calls having
--       no effect and returning `nil`.
---@field remove fun(self,)
--- Luaentity only
-- * `set_velocity(vel)`
--     * Sets the velocity
--     * `vel` is a vector, e.g. `{x=0.0, y=2.3, z=1.0}`
---@field set_velocity fun(self,vel: vector)
--- Luaentity only
-- * `set_acceleration(acc)`
--     * Sets the acceleration
--     * `acc` is a vector
---@field set_acceleration fun(self,acc:vector)
--- Luaentity only
-- * `get_acceleration()`: returns the acceleration, a vector
---@field get_acceleration fun(self,):vector?
--- Luaentity only
-- * `set_rotation(rot)`
--     * Sets the rotation
--     * `rot` is a vector (radians). X is pitch (elevation), Y is yaw (heading)
--       and Z is roll (bank).
--     * Does not reset rotation incurred through `automatic_rotate`.
--       Remove & re-add your objects to force a certain rotation.
---@field set_rotation fun(self,rot:vector)
--- Luaentity only
-- * `get_rotation()`: returns the rotation, a vector (radians)
---@field get_rotation fun(self,):vector?
--- Luaentity only
-- * `set_yaw(yaw)`: sets the yaw in radians (heading).
---@field set_yaw fun(self,yaw:number)
--- Luaentity only
-- * `get_yaw()`: returns number in radians
---@field get_yaw fun(self,):number
--- Luaentity only
-- * `set_texture_mod(mod)`
--     * Set a texture modifier to the base texture, for sprites and meshes.
--     * When calling `set_texture_mod` again, the previous one is discarded.
--     * `mod` the texture modifier. See [Texture modifiers].
---@field set_texture_mod fun(self,mod:string)
--- Luaentity only
-- * `get_texture_mod()` returns current texture modifier
---@field get_texture_mod fun(self,):string?
--- Luaentity only
-- * `set_sprite(start_frame, num_frames, framelength, select_x_by_camera)`
--     * Specifies and starts a sprite animation
--     * Only used by `sprite` and `upright_sprite` visuals
--     * Animations iterate along the frame `y` position.
--     * `start_frame`: {x=column number, y=row number}, the coordinate of the
--       first frame, default: `{x=0, y=0}`
--     * `num_frames`: Total frames in the texture, default: `1`
--     * `framelength`: Time per animated frame in seconds, default: `0.2`
--     * `select_x_by_camera`: Only for visual = `sprite`. Changes the frame `x`
--       position according to the view direction. default: `false`.
--         * First column:  subject facing the camera
--         * Second column: subject looking to the left
--         * Third column:  subject backing the camera
--         * Fourth column: subject looking to the right
--         * Fifth column:  subject viewed from above
--         * Sixth column:  subject viewed from below
---@field set_sprite fun(self,start_frame: {x:number,y:number}?, num_frames: integer?, framelength:number?, select_x_by_camera: string[]|boolean?)
--- Luaentity only
-- * `get_luaentity()`:
--     * Returns the object's associated luaentity table, if there is one
--     * Otherwise returns `nil` (e.g. for players)
---@field get_luaentity fun(self,):luaentity?
--- Luaentity only
-- * `get_entity_name()`:
--     * **Deprecated**: Will be removed in a future version,
--       use `:get_luaentity().name` instead.
---@field get_entity_name fun(self,):string?
-- * `get_player_name()`: Returns player name or `""` if is not a player
--- Player only
---@field get_player_name fun(self,):string?
-- Player only
-- * `get_player_velocity()`: **DEPRECATED**, use get_velocity() instead.
--   table {x, y, z} representing the player's instantaneous velocity in nodes/s
---@field get_player_velocity fun(self,):vector?
-- Player only
-- * `add_player_velocity(vel)`: **DEPRECATED**, use add_velocity(vel) instead.
---@field add_player_velocity fun(self,vel:vector)
-- Player only
-- * `get_look_dir()`: get camera direction as a unit vector
---@field get_look_dir fun(self,):vector?
-- Player only
-- * `get_look_vertical()`: pitch in radians
--     * Angle ranges between -pi/2 and pi/2, which are straight up and down
--       respectively.
---@field get_look_vertical fun(self,):number?
-- Player only
-- * `get_look_horizontal()`: yaw in radians
--     * Angle is counter-clockwise from the +z direction.
---@field get_look_horizontal fun(self,):number?
-- Player only
-- * `set_look_vertical(radians)`: sets look pitch
--     * radians: Angle from looking forward, where positive is downwards.
---@field set_look_vertical fun(self,radians:number)
-- Player only
-- * `set_look_horizontal(radians)`: sets look yaw
--     * radians: Angle from the +z direction, where positive is counter-clockwise.
---@field set_look_horizontal fun(self,radians:number)
-- Player only
-- * `get_look_pitch()`: pitch in radians - Deprecated as broken. Use
--   `get_look_vertical`.
--     * Angle ranges between -pi/2 and pi/2, which are straight down and up
--       respectively.
---@field get_look_pitch fun(self,):number?
-- Player only
-- * `get_look_yaw()`: yaw in radians - Deprecated as broken. Use
--   `get_look_horizontal`.
--     * Angle is counter-clockwise from the +x direction.
---@field get_look_yaw fun(self,):number?
-- Player only
-- * `set_look_pitch(radians)`: sets look pitch - Deprecated. Use
--   `set_look_vertical`.
---@field set_look_pitch fun(self,radians:number)
-- Player only
-- * `set_look_yaw(radians)`: sets look yaw - Deprecated. Use
--   `set_look_horizontal`.
---@field set_look_yaw fun(self,radians:number)
-- Player only
-- * `get_breath()`: returns player's breath
---@field get_breath fun(self,):number?
-- Player only
-- * `set_breath(value)`: sets player's breath
--     * values:
--         * `0`: player is drowning
--         * max: bubbles bar is not shown
--         * See [Object properties] for more information
--     * Is limited to range 0 ... 65535 (2^16 - 1)
---@field set_breath fun(self,value:number)
-- Player only
-- * `set_fov(fov, is_multiplier, transition_time)`: Sets player's FOV
--     * `fov`: Field of View (FOV) value.
--     * `is_multiplier`: Set to `true` if the FOV value is a multiplier.
--       Defaults to `false`.
--     * `transition_time`: If defined, enables smooth FOV transition.
--       Interpreted as the time (in seconds) to reach target FOV.
--       If set to 0, FOV change is instantaneous. Defaults to 0.
--     * Set `fov` to 0 to clear FOV override.
---@field set_fov fun(self,fov:number, is_multiplier:boolean, transition_time:number?)
-- Player only
-- * `get_fov()`: Returns the following:
--     * Server-sent FOV value. Returns 0 if an FOV override doesn't exist.
--     * Boolean indicating whether the FOV value is a multiplier.
--     * Time (in seconds) taken for the FOV transition. Set by `set_fov`.
---@field get_fov fun(self,):number?
-- Player only
-- * `set_attribute(attribute, value)`:  DEPRECATED, use get_meta() instead
--     * Sets an extra attribute with value on player.
--     * `value` must be a string, or a number which will be converted to a
--       string.
--     * If `value` is `nil`, remove attribute from player.
---@field set_attribute fun(self,attribute:string, value:string|number)
-- Player only
-- * `get_attribute(attribute)`:  DEPRECATED, use get_meta() instead
--     * Returns value (a string) for extra attribute.
--     * Returns `nil` if no attribute found.
---@field get_attribute fun(self,attribute:string):string|nil
-- Player only
-- * `get_meta()`: Returns metadata associated with the player (a PlayerMetaRef).
---@field get_meta fun(self,):PlayerMetaRef
-- Player only
-- * `set_inventory_formspec(formspec)`
--     * Redefines the player's inventory formspec.
--     * Should usually be called at least once in the `on_joinplayer` callback.
--     * If `formspec` is `""`, the player's inventory is disabled.
--     * If the inventory formspec is currently open on the client, it is
--       updated immediately.
--     * See also: `core.register_on_player_receive_fields`
---@field set_inventory_formspec fun(self,formspec:string)
-- Player only
-- * `get_inventory_formspec()`: returns a formspec string
---@field get_inventory_formspec fun(self,):string?
-- Player only
-- * `set_formspec_prepend(formspec)`:
--     * the formspec string will be added to every formspec shown to the user,
--       except for those with a no_prepend[] tag.
--     * This should be used to set style elements such as background[] and
--       bgcolor[], any non-style elements (eg: label) may result in weird behavior.
--     * Only affects formspecs shown after this is called.
---@field set_formspec_prepend fun(self,formspec:string)
-- Player only
-- * `get_formspec_prepend()`: returns a formspec string.
---@field get_formspec_prepend fun(self,):string?
-- Player only
-- * `get_player_control()`: returns table with player input
--     * The table contains the following boolean fields representing the pressed
--       keys: `up`, `down`, `left`, `right`, `jump`, `aux1`, `sneak`, `dig`,
--       `place`, `LMB`, `RMB` and `zoom`.
--     * The fields `LMB` and `RMB` are equal to `dig` and `place` respectively,
--       and exist only to preserve backwards compatibility.
--     * The table also contains the fields `movement_x` and `movement_y`.
--         * They represent the movement of the player. Values are numbers in the
--           range [-1.0,+1.0].
--         * They take both keyboard and joystick input into account.
--         * You should prefer them over `up`, `down`, `left` and `right` to
--           support different input methods correctly.
--     * Returns an empty table `{}` if the object is not a player.
---@field get_player_control fun(self,):{up:boolean, down:boolean, left:boolean, right:boolean, jump:boolean, aux1:boolean, sneak:boolean, dig:boolean, place:boolean, zoom:boolean, movement_x:number, movement_y:number}
-- Player only
-- * `get_player_control_bits()`: returns integer with bit packed player pressed
--   keys.
--     * Bits:
--         * 0 - up
--         * 1 - down
--         * 2 - left
--         * 3 - right
--         * 4 - jump
--         * 5 - aux1
--         * 6 - sneak
--         * 7 - dig
--         * 8 - place
--         * 9 - zoom
--     * Returns `0` (no bits set) if the object is not a player.
---@field get_player_control_bits fun(self,):number
-- Player only
-- * `set_physics_override(override_table)`
--     * Overrides the physics attributes of the player
--     * `override_table` is a table with the following fields:
--         * `speed`: multiplier to *all* movement speed (`speed_*`) and
--                    acceleration (`acceleration_*`) values (default: `1`)
--         * `speed_walk`: multiplier to default walk speed value (default: `1`)
--             * Note: The actual walk speed is the product of `speed` and `speed_walk`
--         * `speed_climb`: multiplier to default climb speed value (default: `1`)
--             * Note: The actual climb speed is the product of `speed` and `speed_climb`
--         * `speed_crouch`: multiplier to default sneak speed value (default: `1`)
--             * Note: The actual sneak speed is the product of `speed` and `speed_crouch`
--         * `speed_fast`: multiplier to default speed value in Fast Mode (default: `1`)
--             * Note: The actual fast speed is the product of `speed` and `speed_fast`
--         * `jump`: multiplier to default jump value (default: `1`)
--         * `gravity`: multiplier to default gravity value (default: `1`)
--         * `liquid_fluidity`: multiplier to liquid movement resistance value
--           (for nodes with `liquid_move_physics`); the higher this value, the lower the
--           resistance to movement. At `math.huge`, the resistance is zero and you can
--           move through any liquid like air. (default: `1`)
--             * Warning: Values below 1 are currently unsupported.
--         * `liquid_fluidity_smooth`: multiplier to default maximum liquid resistance value
--           (for nodes with `liquid_move_physics`); controls deceleration when entering
--           node at high speed. At higher values you come to a halt more quickly
--           (default: `1`)
--         * `liquid_sink`: multiplier to default liquid sinking speed value;
--           (for nodes with `liquid_move_physics`) (default: `1`)
--         * `acceleration_default`: multiplier to horizontal and vertical acceleration
--           on ground or when climbing (default: `1`)
--             * Note: The actual acceleration is the product of `speed` and `acceleration_default`
--         * `acceleration_air`: multiplier to acceleration
--           when jumping or falling (default: `1`)
--             * Note: The actual acceleration is the product of `speed` and `acceleration_air`
--         * `acceleration_fast`: multiplier to acceleration in Fast Mode (default: `1`)
--             * Note: The actual acceleration is the product of `speed` and `acceleration_fast`
--         * `sneak`: whether player can sneak (default: `true`)
--         * `sneak_glitch`: whether player can use the new move code replications
--           of the old sneak side-effects: sneak ladders and 2 node sneak jump
--           (default: `false`)
--         * `new_move`: use new move/sneak code. When `false` the exact old code
--           is used for the specific old sneak behavior (default: `true`)
--     * Note: All numeric fields above modify a corresponding `movement_*` setting.
--     * For games, we recommend for simpler code to first modify the `movement_*`
--       settings (e.g. via the game's `minetest.conf`) to set a global base value
--       for all players and only use `set_physics_override` when you need to change
--       from the base value on a per-player basis
--     * Note: Some of the fields don't exist in old API versions, see feature
--       `physics_overrides_v2`.
--
---@field set_physics_override fun(self,override_table:table)
-- Player only
-- * `get_physics_override()`: returns the table given to `set_physics_override`
---@field get_physics_override fun(self,):table
-- Player only
-- * `hud_add(hud definition)`: add a HUD element described by HUD def, returns ID
--    number on success
---@field hud_add fun(self,hud:HudDef):HudID?
-- Player only
-- * `hud_remove(id)`: remove the HUD element of the specified id
---@field hud_remove fun(self,id:HudID)
-- Player only
-- * `hud_change(id, stat, value)`: change a value of a previously added HUD
--   element.
--     * `stat` supports the same keys as in the hud definition table except for
--       `"type"` (or the deprecated `"hud_elem_type"`).
---@field hud_change fun(self,id:HudID, stat:string, value:any)
-- Player only
-- * `hud_get(id)`: gets the HUD element definition structure of the specified ID
---@field hud_get fun(self,id:HudID)
-- Player only
-- * `hud_get_all()`:
--     * Returns a table in the form `{ [id] = HUD definition, [id] = ... }`.
--     * A mod should keep track of its introduced IDs and only use this to access foreign elements.
--     * It is discouraged to change foreign HUD elements.
---@field hud_get_all fun(self,):table<HudID, HudDef>
-- Player only
-- * `hud_set_flags(flags)`: sets specified HUD flags of player.
--     * `flags`: A table with the following fields set to boolean values
--         * `hotbar`
--         * `healthbar`
--         * `crosshair`
--         * `wielditem`
--         * `breathbar`
--         * `minimap`: Modifies the client's permission to view the minimap.
--           The client may locally elect to not view the minimap.
--         * `minimap_radar`: is only usable when `minimap` is true
--         * `basic_debug`: Allow showing basic debug info that might give a gameplay advantage.
--           This includes map seed, player position, look direction, the pointed node and block bounds.
--           Does not affect players with the `debug` privilege.
--         * `chat`: Modifies the client's permission to view chat on the HUD.
--           The client may locally elect to not view chat. Does not affect the console.
--     * If a flag equals `nil`, the flag is not modified
---@field hud_set_flags fun(self,flags: { hotbar: boolean?, healthbar: boolean?, crosshair:boolean?, wielditem: boolean?, breathbar: boolean?, minimap: boolean?, minimap_radar: boolean?, basic_debug: boolean?})
-- Player only
-- * `hud_get_flags()`: returns a table of player HUD flags with boolean values.
--     * See `hud_set_flags` for a list of flags that can be toggled.
---@field hud_get_flags fun(self,):{ hotbar: boolean?, healthbar: boolean?, crosshair:boolean?, wielditem: boolean?, breathbar: boolean?, minimap: boolean?, minimap_radar: boolean?, basic_debug: boolean?}
-- Player only
-- * `hud_set_hotbar_itemcount(count)`: sets number of items in builtin hotbar
--     * `count`: number of items, must be between `1` and `32`
--     * If `count` exceeds the `"main"` list size, the list size will be used instead.
---@field hud_set_hotbar_itemcount fun(self,count: integer)
-- Player only
-- * `hud_get_hotbar_itemcount()`: returns number of visible items
--     * This value is also clamped by the `"main"` list size.
---@field hud_get_hotbar_itemcount fun(self,):integer?
-- Player only
-- * `hud_set_hotbar_image(texturename)`
--     * sets background image for hotbar
---@field hud_set_hotbar_image fun(self,texturename:string)
-- Player only
-- * `hud_get_hotbar_image()`: returns texturename
---@field hud_get_hotbar_image fun(self,):string?
-- Player only
-- * `hud_set_hotbar_selected_image(texturename)`
--     * sets image for selected item of hotbar
---@field hud_set_hotbar_selected_image fun(self,texturename:string)
-- Player only
-- * `hud_get_hotbar_selected_image()`: returns texturename
---@field hud_get_hotbar_selected_image fun(self,):string?
-- Player only
-- * `set_minimap_modes({mode, mode, ...}, selected_mode)`
--     * Overrides the available minimap modes (and toggle order), and changes the
--     selected mode.
--     * `mode` is a table consisting of up to four fields:
--         * `type`: Available type:
--             * `off`: Minimap off
--             * `surface`: Minimap in surface mode
--             * `radar`: Minimap in radar mode
--             * `texture`: Texture to be displayed instead of terrain map
--               (texture is centered around 0,0 and can be scaled).
--               Texture size is limited to 512 x 512 pixel.
--         * `label`: Optional label to display on minimap mode toggle
--           The translation must be handled within the mod.
--         * `size`: Sidelength or diameter, in number of nodes, of the terrain
--           displayed in minimap
--         * `texture`: Only for texture type, name of the texture to display
--         * `scale`: Only for texture type, scale of the texture map in nodes per
--           pixel (for example a `scale` of 2 means each pixel represents a 2x2
--           nodes square)
--     * `selected_mode` is the mode index to be selected after modes have been changed
--     (0 is the first mode).
---@field set_minimap_modes fun(self,modes: ({ type: "off"|"surface"|"radar"|"texture", label: string?, size: integer, texture: string?, scale: integer?})[], selected_mode: integer )
-- Player only
-- * `set_sky(sky_parameters)`
--     * The presence of the function `set_sun`, `set_moon` or `set_stars` indicates
--       whether `set_sky` accepts this format. Check the legacy format otherwise.
--     * Passing no arguments resets the sky to its default values.
--     * `sky_parameters` is a table with the following optional fields:
--         * `base_color`: ColorSpec, meaning depends on `type` (default: `#ffffff`)
--         * `body_orbit_tilt`: Float, rotation angle of sun/moon orbit in degrees.
--            By default, orbit is controlled by a client-side setting, and this field is not set.
--            After a value is assigned, it can only be changed to another float value.
--            Valid range [-60.0,60.0] (default: not set)
--         * `type`: Available types:
--             * `"regular"`: Uses 0 textures, `base_color` ignored
--             * `"skybox"`: Uses 6 textures, `base_color` used as fog.
--             * `"plain"`: Uses 0 textures, `base_color` used as both fog and sky.
--             (default: `"regular"`)
--         * `textures`: A table containing up to six textures in the following
--             order: Y+ (top), Y- (bottom), X+ (east), X- (west), Z- (south), Z+ (north).
--             The top and bottom textures are oriented in-line with the east (X+) face (the top edge of the
--             bottom texture and the bottom edge of the top texture touch the east face).
--             Some top and bottom textures expect to be aligned with the north face and will need to be rotated
--             by -90 and 90 degrees, respectively, to fit the eastward orientation.
--         * `clouds`: Boolean for whether clouds appear. (default: `true`)
--         * `sky_color`: A table used in `"regular"` type only, containing the
--           following values (alpha is ignored):
--             * `day_sky`: ColorSpec, for the top half of the sky during the day.
--               (default: `#61b5f5`)
--             * `day_horizon`: ColorSpec, for the bottom half of the sky during the day.
--               (default: `#90d3f6`)
--             * `dawn_sky`: ColorSpec, for the top half of the sky during dawn/sunset.
--               (default: `#b4bafa`)
--               The resulting sky color will be a darkened version of the ColorSpec.
--               Warning: The darkening of the ColorSpec is subject to change.
--             * `dawn_horizon`: ColorSpec, for the bottom half of the sky during dawn/sunset.
--               (default: `#bac1f0`)
--               The resulting sky color will be a darkened version of the ColorSpec.
--               Warning: The darkening of the ColorSpec is subject to change.
--             * `night_sky`: ColorSpec, for the top half of the sky during the night.
--               (default: `#006bff`)
--               The resulting sky color will be a dark version of the ColorSpec.
--               Warning: The darkening of the ColorSpec is subject to change.
--             * `night_horizon`: ColorSpec, for the bottom half of the sky during the night.
--               (default: `#4090ff`)
--               The resulting sky color will be a dark version of the ColorSpec.
--               Warning: The darkening of the ColorSpec is subject to change.
--             * `indoors`: ColorSpec, for when you're either indoors or underground.
--               (default: `#646464`)
--             * `fog_sun_tint`: ColorSpec, changes the fog tinting for the sun
--               at sunrise and sunset. (default: `#f47d1d`)
--             * `fog_moon_tint`: ColorSpec, changes the fog tinting for the moon
--               at sunrise and sunset. (default: `#7f99cc`)
--             * `fog_tint_type`: string, changes which mode the directional fog
--                 abides by, `"custom"` uses `sun_tint` and `moon_tint`, while
--                 `"default"` uses the classic Luanti sun and moon tinting.
--                 Will use tonemaps, if set to `"default"`. (default: `"default"`)
--         * `fog`: A table with following optional fields:
--             * `fog_distance`: integer, set an upper bound for the client's viewing_range.
--                Any value >= 0 sets the desired upper bound for viewing_range,
--                disables range_all and prevents disabling fog (F3 key by default).
--                Any value < 0 resets the behavior to being client-controlled.
--                (default: -1)
--             * `fog_start`: float, override the client's fog_start.
--                Fraction of the visible distance at which fog starts to be rendered.
--                Any value between [0.0, 0.99] set the fog_start as a fraction of the viewing_range.
--                Any value < 0, resets the behavior to being client-controlled.
--                (default: -1)
--             * `fog_color`: ColorSpec, override the color of the fog.
--                Unlike `base_color` above this will apply regardless of the skybox type.
--                (default: `"#00000000"`, which means no override)
---@field set_sky fun(self,sky_parameters:table)
-- Player only
-- * `get_sky(as_table)`:
--     * `as_table`: boolean that determines whether the deprecated version of this
--     function is being used.
--         * `true` returns a table containing sky parameters as defined in `set_sky(sky_parameters)`.
--         * Deprecated: `false` or `nil` returns base_color, type, table of textures,
--         clouds.
---@field get_sky fun(self,as_table: boolean): table?
-- Player only
-- * `set_sun(sun_parameters)`:
--     * Passing no arguments resets the sun to its default values.
--     * `sun_parameters` is a table with the following optional fields:
--         * `visible`: Boolean for whether the sun is visible.
--             (default: `true`)
--         * `texture`: A regular texture for the sun. Setting to `""`
--             will re-enable the mesh sun. (default: "sun.png", if it exists)
--             The texture appears non-rotated at sunrise and rotated 180 degrees
--             (upside down) at sunset.
--         * `tonemap`: A 512x1 texture containing the tonemap for the sun
--             (default: `"sun_tonemap.png"`)
--         * `sunrise`: A regular texture for the sunrise texture.
--             (default: `"sunrisebg.png"`)
--         * `sunrise_visible`: Boolean for whether the sunrise texture is visible.
--             (default: `true`)
--         * `scale`: Float controlling the overall size of the sun. (default: `1`)
--             Note: For legacy reasons, the sun is bigger than the moon by a factor
--             of about `1.57` for equal `scale` values.
---@field set_sun fun(self,sun_parameters: table)
-- Player only
-- * `get_sun()`: returns a table with the current sun parameters as in
--     `set_sun`.
---@field get_sun fun(self,):table?
-- Player only
-- * `set_moon(moon_parameters)`:
--     * Passing no arguments resets the moon to its default values.
--     * `moon_parameters` is a table with the following optional fields:
--         * `visible`: Boolean for whether the moon is visible.
--             (default: `true`)
--         * `texture`: A regular texture for the moon. Setting to `""`
--             will re-enable the mesh moon. (default: `"moon.png"`, if it exists)
--             The texture appears non-rotated at sunrise / moonset and rotated 180
--             degrees (upside down) at sunset / moonrise.
--             Note: Relative to the sun, the moon texture is hence rotated by 180°.
--             You can use the `^[transformR180` texture modifier to achieve the same orientation.
--         * `tonemap`: A 512x1 texture containing the tonemap for the moon
--             (default: `"moon_tonemap.png"`)
--         * `scale`: Float controlling the overall size of the moon (default: `1`)
--             Note: For legacy reasons, the sun is bigger than the moon by a factor
--             of about `1.57` for equal `scale` values.
---@field set_moon fun(self,moon_parameters: table)
-- Player only
-- * `get_moon()`: returns a table with the current moon parameters as in
--     `set_moon`.
---@field get_moon fun(self,):table?
-- Player only
-- * `set_stars(star_parameters)`:
--     * Passing no arguments resets stars to their default values.
--     * `star_parameters` is a table with the following optional fields:
--         * `visible`: Boolean for whether the stars are visible.
--             (default: `true`)
--         * `day_opacity`: Float for maximum opacity of stars at day.
--             No effect if `visible` is false.
--             (default: 0.0; maximum: 1.0; minimum: 0.0)
--         * `count`: Integer number to set the number of stars in
--             the skybox. Only applies to `"skybox"` and `"regular"` sky types.
--             (default: `1000`)
--         * `star_color`: ColorSpec, sets the colors of the stars,
--             alpha channel is used to set overall star brightness.
--             (default: `#ebebff69`)
--         * `scale`: Float controlling the overall size of the stars (default: `1`)
---@field set_stars fun(self,star_parameters:table)
-- Player only
-- * `get_stars()`: returns a table with the current stars parameters as in
--     `set_stars`.
---@field get_stars fun(self,):table?
-- Player only
-- * `set_clouds(cloud_parameters)`: set cloud parameters
--     * Passing no arguments resets clouds to their default values.
--     * `cloud_parameters` is a table with the following optional fields:
--         * `density`: from `0` (no clouds) to `1` (full clouds) (default `0.4`)
--         * `color`: basic cloud color with alpha channel, ColorSpec
--           (default `#fff0f0e5`).
--         * `ambient`: cloud color lower bound, use for a "glow at night" effect.
--           ColorSpec (alpha ignored, default `#000000`)
--         * `height`: cloud height, i.e. y of cloud base (default per conf,
--           usually `120`)
--         * `thickness`: cloud thickness in nodes (default `16`).
--           if set to zero the clouds are rendered flat.
--         * `speed`: 2D cloud speed + direction in nodes per second
--           (default `{x=0, z=-2}`).
--         * `shadow`: shadow color, applied to the base of the cloud
--           (default `#cccccc`).
---@field set_clouds fun(self,cloud_parameters:table)
-- Player only
-- * `get_clouds()`: returns a table with the current cloud parameters as in
--   `set_clouds`.
---@field get_clouds fun(self,):table
-- Player only
-- * `override_day_night_ratio(ratio or nil)`
--     * `0`...`1`: Overrides day-night ratio, controlling sunlight to a specific
--       amount.
--     * Passing no arguments disables override, defaulting to sunlight based on day-night cycle
--     * See also `core.time_to_day_night_ratio`,
---@field override_day_night_ratio fun(self,number)
-- Player only
-- * `get_day_night_ratio()`: returns the ratio or nil if it isn't overridden
---@field get_day_night_ratio fun(self,):number?
-- Player only
-- * `set_local_animation(idle, walk, dig, walk_while_dig, frame_speed)`:
--   set animation for player model in third person view.
--     * Every animation equals to a `{x=starting frame, y=ending frame}` table.
--     * `frame_speed` sets the animations frame speed. Default is 30.
-- Unofficial note: Sorry, no types for this one
---@field set_local_animation fun(self,idle, walk, dig, walk_while_dig, frame_speed)
-- Player only
-- * `get_local_animation()`: returns idle, walk, dig, walk_while_dig tables and
--   `frame_speed`.
-- Unofficial note: Sorry, no types for this one
---@field get_local_animation fun(self,):table?, table?, table?, table?,table?
-- Player only
-- * `set_eye_offset([firstperson, thirdperson_back, thirdperson_front])`: Sets camera offset vectors.
--     * `firstperson`: Offset in first person view.
--       Defaults to `vector.zero()` if unspecified.
--     * `thirdperson_back`: Offset in third person back view.
--       Clamped between `vector.new(-10, -10, -5)` and `vector.new(10, 15, 5)`.
--       Defaults to `vector.zero()` if unspecified.
--     * `thirdperson_front`: Offset in third person front view.
--       Same limits as for `thirdperson_back` apply.
--       Defaults to `thirdperson_back` if unspecified.
---@field set_eye_offset fun(self,firstperson: vector?, thirdperson_back:vector?, thirdperson_front:vector? )
-- Player only
-- * `get_eye_offset()`: Returns camera offset vectors as set via `set_eye_offset`.
---@field get_eye_offset fun(self,): vector?, vector?, vector?
-- Player only
-- * `set_camera(params)`: Sets camera parameters.
--     * `mode`: Defines the camera mode used
--       - `any`: free choice between all modes (default)
--       - `first`: first-person camera
--       - `third`: third-person camera
--       - `third_front`: third-person camera, looking opposite of movement direction
--     * Supported by client since 5.12.0.
---@field set_camera fun(self,params: { mode: "any"|"first"|"third"|"third_front"})
-- Player only
-- * `get_camera()`: Returns the camera parameters as a table as above.
---@field get_camera fun(self,):{ mode: "any"|"first"|"third"|"third_front"}?
-- Player only
-- * `send_mapblock(blockpos)`:
--     * Sends an already loaded mapblock to the player.
--     * Returns `false` if nothing was sent (note that this can also mean that
--       the client already has the block)
--     * Resource intensive - use sparsely
---@field send_mapblock fun(self,blockpos:vector):boolean?
-- Player only
-- * `set_lighting(light_definition)`: sets lighting for the player
--     * Passing no arguments resets lighting to its default values.
--     * `light_definition` is a table with the following optional fields:
--       * `saturation` sets the saturation (vividness; default: `1.0`).
--         * It is applied according to the function `result = b*(1-s) + c*s`, where:
--           * `c` is the original color
--           * `b` is the greyscale version of the color with the same luma
--           * `s` is the saturation set here
--         * The resulting color always has the same luma (perceived brightness) as the original.
--         * This means that:
--           * values > 1 oversaturate
--           * values < 1 down to 0 desaturate, 0 being entirely greyscale
--           * values < 0 cause an effect similar to inversion,
--             but keeping original luma and being symmetrical in terms of saturation
--             (eg. -1 and 1 is the same saturation and luma, but different hues)
--         * This value has no effect on clients who have shaders or post-processing disabled.
--       * `shadows` is a table that controls ambient shadows
--         * This has no effect on clients who have the "Dynamic Shadows" effect disabled.
--         * `intensity` sets the intensity of the shadows from 0 (no shadows, default) to 1 (blackness)
--         * `tint` tints the shadows with the provided color, with RGB values ranging from 0 to 255.
--           (default `{r=0, g=0, b=0}`)
--       * `exposure` is a table that controls automatic exposure.
--         The basic exposure factor equation is `e = 2^exposure_correction / clamp(luminance, 2^luminance_min, 2^luminance_max)`
--         * This has no effect on clients who have the "Automatic Exposure" effect disabled.
--         * `luminance_min` set the lower luminance boundary to use in the calculation (default: `-3.0`)
--         * `luminance_max` set the upper luminance boundary to use in the calculation (default: `-3.0`)
--         * `exposure_correction` correct observed exposure by the given EV value (default: `0.0`)
--         * `speed_dark_bright` set the speed of adapting to bright light (default: `1000.0`)
--         * `speed_bright_dark` set the speed of adapting to dark scene (default: `1000.0`)
--         * `center_weight_power` set the power factor for center-weighted luminance measurement (default: `1.0`)
--       * `bloom` is a table that controls bloom.
--         * This has no effect on clients with protocol version < 46 or clients who
--           have the "Bloom" effect disabled.
--         * `intensity` defines much bloom is applied to the rendered image.
--           * Recommended range: from 0.0 to 1.0, default: 0.05
--           * If set to 0, bloom is disabled.
--           * The default value is to be changed from 0.05 to 0 in the future.
--             If you wish to keep the current default value, you should set it
--             explicitly.
--         * `strength_factor` defines the magnitude of bloom overexposure.
--           * Recommended range: from 0.1 to 10.0, default: 1.0
--         * `radius` is a logical value that controls how far the bloom effect
--           spreads from the bright objects.
--           * Recommended range: from 0.1 to 8.0, default: 1.0
--         * The behavior of values outside the recommended range is unspecified.
--       * `volumetric_light`: is a table that controls volumetric light (a.k.a. "godrays")
--         * This has no effect on clients who have the "Volumetric Lighting" or "Bloom" effects disabled.
--         * `strength`: sets the strength of the volumetric light effect from 0 (off, default) to 1 (strongest).
--             * `0.2` is a reasonable standard value.
--             * Currently, bloom `intensity` and `strength_factor` affect volumetric
--               lighting `strength` and vice versa. This behavior is to be changed
--               in the future, do not rely on it.
--
---@field set_lighting fun(self,light_definition: table)
-- Player only
-- * `get_lighting()`: returns the current state of lighting for the player.
--     * Result is a table with the same fields as `light_definition` in `set_lighting`.
---@field get_lighting fun(self,):table?
-- Player only
-- * `respawn()`: Respawns the player using the same mechanism as the death screen,
--   including calling `on_respawnplayer` callbacks.
---@field respawn fun(self,)
-- Player only
-- * `get_flags()`: returns a table of player flags (the following boolean fields):
--   * `breathing`: Whether breathing (regaining air) is enabled, default `true`.
--   * `drowning`: Whether drowning (losing air) is enabled, default `true`.
--   * `node_damage`: Whether the player takes damage from nodes, default `true`.
---@field get_flags fun(self,):{breathing:boolean, drowning:boolean, node_damage:boolean}?
-- Player only
-- * `set_flags(flags)`: sets flags
--   * takes a table in the same format as returned by `get_flags`
--   * absent fields are left unchanged
---@field set_flags fun(self,flags: {breathing:boolean?, drowning:boolean?, node_damage:boolean?})

---@class PlayerRef: ObjectRef
---@class LuaEntityRef: ObjectRef

---@class PlayerMetaRef: MetaDataRef

---@class EntityDef: luaentity
---@field initial_properties ObjectProps
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
---@meta

--- thought luanti used https :sob:, i thought i could trust it!!
--- Anyway why they are so worried about http api that they are locking it down like this? It's not like http is insecure right? (Get it? because the way you approve mods to use `os.execute` is basically the same process to approving them using the http api... was that joke bad... yeah i know it was)

---@class HTTP_async_handle

---@class HTTPRequest
---@field url string?
-- Timeout for request to be completed in seconds. Default depends on engine settings.
---@field timeout number?
-- The http method to use. Defaults to "GET".
---@field method "GET"|"HEAD"|"POST"|"PUT"|"PATCH"|"DELETE"?
-- Data for the POST, PUT, PATCH or DELETE request.
-- Accepts both a string and a table. If a table is specified, encodes
-- table as x-www-form-urlencoded key-value pairs.
---@field data string|table<string,string>?
-- Optional, if specified replaces the default Luanti user agent with
-- given string.
---@field user_agent string?
-- Optional, if specified adds additional headers to the HTTP request.
-- You must make sure that the header strings follow HTTP specification
-- ("Key: Value").
---@field extra_headers string[]?
-- Optional, if true performs a multipart HTTP request.
-- Default is false.
-- Not allowed for GET or HEAD method and `data` must be a table.
---@field multipart boolean?

---@class HTTPRequestResult
-- If true, the request has finished (either succeeded, failed or timed
-- out)
---@field completed boolean?
-- If true, the request was successful
---@field succeeded boolean?
-- If true, the request timed out
---@field timeout boolean?
-- HTTP status code
---@field code number?
-- Response body
---@field data string?

-- **DO NOT ALLOW ANY OTHER MODS TO ACCESS THIS TABLE, STORE IT IN A LOCAL VARIABLE!**
---@class HTTPApiTable
-- * `HTTPApiTable.fetch(HTTPRequest req, callback)`
--     * Performs given request asynchronously and calls callback upon completion
--     * callback: `function(HTTPRequestResult res)`
--     * Use this HTTP function if you are unsure, the others are for advanced use
---@field fetch fun(req: HTTPRequest, callback: fun(res: HTTPRequestResult):nil):nil
-- * `HTTPApiTable.fetch_async(HTTPRequest req)`: returns handle
--     * Performs given request asynchronously and returns handle for
--       `HTTPApiTable.fetch_async_get`
---@field fetch_async fun(req:HTTPRequest):HTTP_async_handle
---@field fetch_async_get fun(handle: HTTP_async_handle):HTTPRequestResult

-- * `core.request_http_api()`:
--     * returns `HTTPApiTable` containing http functions if the calling mod has
--       been granted access by being listed in the `secure.http_mods` or
--       `secure.trusted_mods` setting, otherwise returns `nil`.
--     * The returned table contains the functions `fetch`, `fetch_async` and
--       `fetch_async_get` described below.
--     * Only works at init time and must be called from the mod's main scope
--       (not from a function).
--     * Function only exists if Luanti server was built with cURL support.
--     * **DO NOT ALLOW ANY OTHER MODS TO ACCESS THE RETURNED TABLE, STORE IT IN
--       A LOCAL VARIABLE!**
---@return HTTPApiTable?
function core.request_http_api() end
---@meta
---
---You know, InvRefs ItemStacks things like thatt

---@class inventory_location
---@field type "node"|"player"|"detached"
---@field name string?
---@field pos vector?

---@class InvRef
-- * `is_empty(listname)`: return `true` if list is empty
---@field is_empty fun(listname:string): boolean
-- * `get_size(listname)`: get size of a list
---@field get_size fun(listname:string):number
-- * `set_size(listname, size)`: set size of a list
--     * If `listname` is not known, a new list will be created
--     * Setting `size` to 0 deletes a list
--     * returns `false` on error (e.g. invalid `listname` or `size`)
---@field set_size fun(listname:string, size:integer):boolean
-- * `get_width(listname)`: get width of a list
---@field get_width fun(listname:string):integer
-- * `set_width(listname, width)`: set width of list; currently used for crafting
--     * returns `false` on error (e.g. invalid `listname` or `width`)
---@field set_width fun(listname:string, width:integer)
-- * `get_stack(listname, i)`: get a copy of stack index `i` in list
---@field get_stack fun(listname:string, i:integer)
-- * `set_stack(listname, i, stack)`: copy `stack` to index `i` in list
---@field set_stack fun(listname:string, i:integer, stack:ItemStackAny)
-- * `get_list(listname)`: returns full list (list of `ItemStack`s)
--                         or `nil` if list doesn't exist (size 0)
---@field get_list fun(listname:string):InvList
-- * `set_list(listname, list)`: set full list (size will not change)
---@field set_list fun(listname:string, list:InvList)
-- * `get_lists()`: returns table that maps listnames to inventory lists
---@field get_lists fun():table<string, InvList>
-- * `set_lists(lists)`: sets inventory lists (size will not change)
---@field set_lists fun(lists:table<string, InvList>)
-- * `add_item(listname, stack)`: add item somewhere in list, returns leftover
--   `ItemStack`.
---@field add_item fun(listname:string, stack:ItemStackAny)
-- * `room_for_item(listname, stack):` returns `true` if the stack of items
--   can be fully added to the list
---@field room_for_item fun(listname:string, stack:ItemStackAny):boolean
-- * `contains_item(listname, stack, [match_meta])`: returns `true` if
--   the stack of items can be fully taken from the list.
--     * If `match_meta` is `true`, item metadata is also considered when comparing
--       items. Otherwise, only the items names are compared. Default: `false`
--     * The method ignores wear.
---@field contains_item fun(listname:string, stack:ItemStackAny, match_meta:boolean?)
-- * `remove_item(listname, stack, [match_meta])`: take as many items as specified from the
--   list, returns the items that were actually removed (as an `ItemStack`).
--     * If `match_meta` is `true` (available since feature `remove_item_match_meta`),
--       item metadata is also considered when comparing items. Otherwise, only the
--       items names are compared. Default: `false`
--     * The method ignores wear.
---@field remove_item fun(listname:string, stack:ItemStackAny, match_meta: boolean?)
-- * `get_location()`: returns a location compatible to
--   `core.get_inventory(location)`.
--     * returns `{type="undefined"}` in case location is not known
---@field get_location fun():inventory_location

---@alias InvList ItemStack[]
-- * inventory table keys are inventory list names
-- * inventory table values are item tables
-- * item table keys are slot IDs (starting with 1)
-- * item table values are ItemStacks
---@class InvTable: table<string, InvList>

---@alias ItemStackAny ItemStack|string|table

---@class ItemStackMetaRef: MetaDataRef
---@field set_tool_capabilities fun(tool_capabilities:tool_capabilities?)
---@field set_wear_bar_params fun(wear_bar_params:wear_bar_params?)

---@class ItemStack
-- * `is_empty()`: returns `true` if stack is empty.
---@field is_empty fun():boolean
-- * `get_name()`: returns item name (e.g. `"default:stone"`).
---@field get_name fun():string
-- * `set_name(item_name)`: returns a boolean indicating whether the item was
--   cleared.
---@field set_name fun(item_name:string):boolean
-- * `get_count()`: Returns number of items on the stack.
---@field get_count fun():integer
-- * `set_count(count)`: returns a boolean indicating whether the item was cleared
--     * `count`: number, unsigned 16 bit integer
---@field set_count fun(count:integer):boolean
-- * `get_wear()`: returns tool wear (`0`-`65535`), `0` for non-tools.
---@field get_wear fun():integer
-- * `set_wear(wear)`: returns boolean indicating whether item was cleared
--     * `wear`: number, unsigned 16 bit integer
---@field set_wear fun(wear:integer):boolean
-- * `get_meta()`: returns ItemStackMetaRef. See section for more details
---@field get_meta fun():ItemStackMetaRef
-- * `get_description()`: returns the description shown in inventory list tooltips.
--     * The engine uses this when showing item descriptions in tooltips.
--     * Fields for finding the description, in order:
--         * `description` in item metadata (See [Item Metadata].)
--         * `description` in item definition
--         * item name
---@field get_description fun():string
-- * `get_short_description()`: returns the short description or nil.
--     * Unlike the description, this does not include new lines.
--     * Fields for finding the short description, in order:
--         * `short_description` in item metadata (See [Item Metadata].)
--         * `short_description` in item definition
--         * first line of the description (From item meta or def, see `get_description()`.)
--         * Returns nil if none of the above are set
---@field get_short_description fun():string
-- * `clear()`: removes all items from the stack, making it empty.
---@field clear fun()
-- * `replace(item)`: replace the contents of this stack.
--     * `item` can also be an itemstring or table.
---@field replace fun(item:ItemStackAny)
-- * `to_string()`: returns the stack in itemstring form.
---@field to_string fun():string
-- * `to_table()`: returns the stack in Lua table form.
---@field to_table fun():table
-- * `get_stack_max()`: returns the maximum size of the stack (depends on the
--   item).
---@field get_stack_max fun():integer
-- * `get_free_space()`: returns `get_stack_max() - get_count()`.
---@field get_free_space fun():integer
-- * `is_known()`: returns `true` if the item name refers to a defined item type.
---@field is_known fun():boolean
-- * `get_definition()`: returns the item definition table.
---@field get_definition fun():ItemDef
-- * `get_tool_capabilities()`: returns the digging properties of the item,
--   or those of the hand if none are defined for this item type
---@field get_tool_capabilities fun():tool_capabilities
-- * `add_wear(amount)`
--     * Increases wear by `amount` if the item is a tool, otherwise does nothing
--     * Valid `amount` range is [0,65536]
--     * `amount`: number, integer
---@field add_wear fun(amount:integer)
-- * `add_wear_by_uses(max_uses)`
--     * Increases wear in such a way that, if only this function is called,
--       the item breaks after `max_uses` times
--     * Valid `max_uses` range is [0,65536]
--     * Does nothing if item is not a tool or if `max_uses` is 0
---@field add_wear_by_uses fun(max_uses:integer)
-- * `get_wear_bar_params()`: returns the wear bar parameters of the item,
--   or nil if none are defined for this item type or in the stack's meta
---@field get_wear_bar_params fun():wear_bar_params?
-- * `add_item(item)`: returns leftover `ItemStack`
--     * Put some item or stack onto this stack
---@field add_item fun(item:ItemStackAny)
-- * `item_fits(item)`: returns `true` if item or stack can be fully added to
--   this one.
---@field item_fits fun(item:ItemStackAny):boolean
-- * `take_item(n)`: returns taken `ItemStack`
--     * Take (and remove) up to `n` items from this stack
--     * `n`: number, default: `1`
---@field take_item fun(n:integer):ItemStack
-- * `peek_item(n)`: returns taken `ItemStack`
--     * Copy (don't remove) up to `n` items from this stack
--     * `n`: number, default: `1`
---@field peek_item fun(n:integer):ItemStack
-- * `equals(other)`:
-- * returns `true` if this stack is identical to `other`.
-- * Note: `stack1:to_string() == stack2:to_string()` is not reliable,
--   as stack metadata can be serialized in arbitrary order.
-- * Note: if `other` is an itemstring or table representation of an
--   ItemStack, this will always return false, even if it is
--   "equivalent".
---@field equals fun(other:any):boolean

---@class detached_inventory_callbacks
---@field allow_move fun(inv:InvRef, from_list:InvList, from_index:number, to_list:InvList, to_index:number, count:number, player:PlayerRef)?
---@field allow_put fun(inv:InvRef, listname:string, index:number, stack:ItemStack, player:PlayerRef)?
---@field allow_take fun(inv:InvRef, listname:string, index:number, stack:ItemStack, player:PlayerRef)?
---@field on_move fun(inv:InvRef, from_list:InvList, from_index:number, to_list:InvList, to_index:number, count:number, player:PlayerRef)?
---@field on_put fun(inv:InvRef, listname:string, index:number, stack:ItemStack, player:PlayerRef)?
---@field on_take fun(inv:InvRef, listname:string, index:number, stack:ItemStack, player:PlayerRef)?

-- `core.get_inventory(location)`: returns an `InvRef`
--
-- * `location` = e.g.
--     * `{type="player", name="celeron55"}`
--     * `{type="node", pos={x=, y=, z=}}`
--     * `{type="detached", name="creative"}`
---@param location inventory_location
---@return InvRef
function core.get_inventory_location(location) end

---@nodiscard
---@param name string
---@param callbacks nil
---@param player_name string?
---@return InvRef
function core.create_detached_inventory(name, callbacks, player_name) end

---@param name string
---@return boolean
function core.remove_detached_inventory(name) end
---@meta
-- `StorageRef`
-- ------------
--
-- Mod metadata: per mod and world metadata, saved automatically.
-- Can be obtained via `core.get_mod_storage()` during load time.
--
-- WARNING: This storage backend is incapable of saving raw binary data due
-- to restrictions of JSON.
--
-- ### Methods
--
-- * All methods in MetaDataRef
--
---@class StorageRef: MetaDataRef

--- Unofficial note: Usually not able to store the character "\1" (string.char(1))
-- Note: If a metadata value is in the format `${k}`, an attempt to get the value
-- will return the value associated with key `k`. There is a low recursion limit.
-- This behavior is **deprecated** and will be removed in a future version. Usage
-- of the `${k}` syntax in formspecs is not deprecated.
---@class MetaDataRef
-- * `contains(key)`: Returns true if key present, otherwise false.
--     * Returns `nil` when the MetaData is inexistent.
---@field contains fun(key:string):boolean?
-- * `get(key)`: Returns `nil` if key not present, else the stored string.
---@field get fun(key:string):string?
-- * `set_string(key, value)`: Value of `""` will delete the key.
---@field set_string fun(key:string, value:string)
-- * `set_int(key, value)`
--     * The range for the value is system-dependent (usually 32 bits).
--       The value will be converted into a string when stored.
---@field set_int fun(key:string, value:integer)
-- * `get_int(key)`: Returns `0` if key not present.
---@field get_int fun(key:string):integer
-- * `set_float(key, value)`
--     * Store a number (a 64-bit float) exactly.
--     * The value will be converted into a string when stored.
---@field set_float fun(key:string, value:number)
---@field get_float fun(key:string):number
---@field get_keys fun():string[]
---@field to_table fun():{fields:table<string, string>,inventory:InvTable}

-- * `core.get_mod_storage()`:
--     * returns reference to mod private `StorageRef`
--     * must be called during mod load time
---@return StorageRef
function core.get_mod_storage() end

--- Inheritance is so nice

---@class NodeMetaRef: MetaDataRef
---@field get_inventory fun():InvRef
-- * `mark_as_private(name or {name1, name2, ...})`: Mark specific vars as private
--   This will prevent them from being sent to the client. Note that the "private"
--   status will only be remembered if an associated key-value pair exists,
--   meaning it's best to call this when initializing all other meta (e.g.
--   `on_construct`).
---@field mark_as_private fun(fields:string|string[])

---@type Settings
core.settings = core.settings

---@param filename string
---@return Settings
function Settings(filename) end

-- ### Format
--
-- The settings have the format `key = value`. Example:
--
--     foo = example text
--     bar = """
--     Multiline
--     value
--     """
---@class Settings
-- * `get(key)`: returns a value
--     * Returns `nil` if `key` is not found.
---@field get fun(key:string):any
-- * `get_bool(key, [default])`: returns a boolean
--     * `default` is the value returned if `key` is not found.
--     * Returns `nil` if `key` is not found and `default` not specified.
---@field get_bool fun(key:string, fundefault:any):any?
-- * `get_np_group(key)`: returns a NoiseParams table
--     * Returns `nil` if `key` is not found.
---@field get_np_group fun(key:string):NoiseParams
-- * `get_flags(key)`:
--     * Returns `{flag = true/false, ...}` according to the set flags.
--     * Is currently limited to mapgen flags `mg_flags` and mapgen-specific
--       flags like `mgv5_spflags`.
--     * Returns `nil` if `key` is not found.
---@field get_flags fun(key: string):table<string, boolean>
-- * `get_pos(key)`:
--     * Returns a `vector`
--     * Returns `nil` if no value is found or parsing failed.
---@field get_pos fun(key:string):vector?
-- * `set(key, value)`
--     * Setting names can't contain whitespace or any of `="{}#`.
--     * Setting values can't contain the sequence `\n"""`.
--     * Setting names starting with "secure." can't be set on the main settings
--       object (`core.settings`).
---@field set fun(key:string, value:any)
-- * `set_bool(key, value)`
--     * See documentation for `set()` above.
---@field set_bool fun(key:string, value:boolean)
-- * `set_np_group(key, value)`
--     * `value` is a NoiseParams table.
--     * Also, see documentation for `set()` above.
---@field set_np_group fun(key:string, value:NoiseParams)
-- * `set_pos(key, value)`
--     * `value` is a `vector`.
--     * Also, see documentation for `set()` above.
---@field set_pos fun(key:string, value:vector)
-- * `remove(key)`: returns a boolean (`true` for success)
---@field remove fun(key:boolean):boolean
-- * `get_names()`: returns `{key1,...}`
---@field get_names fun():string[]
-- * `has(key)`:
--     * Returns a boolean indicating whether `key` exists.
--     * In contrast to the various getter functions, `has()` doesn't consider
--       any default values.
--     * This means that on the main settings object (`core.settings`),
--       `get(key)` might return a value even if `has(key)` returns `false`.
---@field has fun(key: string):boolean
-- * `write()`: returns a boolean (`true` for success)
--     * Writes changes to file.
---@field write fun():boolean
-- * `to_table()`: returns `{[key1]=value1,...}`
---@field to_table fun():table
---@meta

--- "Oh hell no what are these types... man..."
--- Anyway i omit the deprecated stuff, you shouldn't use it :)

---@class Particle

---@alias particle_spawner_vec3_range (number|vector|{min:vector|number,max:vector|number,bias:number?})
---@alias particle_spawner_float_range (number|{min:number,max:number,bias:number?})

--- Cannot be done using generics i think, if yes contribute in :)
---@class particle_spawner_tween_vec3_range
---@field style ("fwd"|"rev"|"pulse"|"flicker")?
---@field reps number?
---@field start number?
---@field [integer] particle_spawner_vec3_range

---@class particle_spawner_tween_float_range
---@field style ("fwd"|"rev"|"pulse"|"flicker")?
---@field reps number?
---@field start number?
---@field [integer] particle_spawner_float_range

---@class particle_spawner_tween_vec3
---@field style ("fwd"|"rev"|"pulse"|"flicker")?
---@field reps number?
---@field start number?
---@field [integer] vector

---@class particle_spawner_tween_vec2
---@field style ("fwd"|"rev"|"pulse"|"flicker")?
---@field reps number?
---@field start number?
---@field [integer] {x:number, y:number}

---@class ParticleSpawnerAttract
---@field kind "none"|"point"|"line"|"plane"
---@field strength number
---@field strength_tween particle_spawner_tween_float_range?
---@field origin vector?
---@field origin_tween particle_spawner_tween_vec3?
---@field direction vector?
---@field direction_tween particle_spawner_tween_vec3?
---@field origin_attached ObjectRef?
---@field direction_attached ObjectRef?
---@field die_on_contact boolean?

---@alias ParticleTextureI ParticleTexture|string

---@class ParticleTexture
---@field name string
---@field alpha number?
---@field alpha_tween particle_spawner_float_range?
---@field scale number|{x:number, y:number}?
---@field scale_tween particle_spawner_tween_vec2?
---@field blend ("alpha"|"clip"|"add"|"screen"|"sub")?
---@field animation TileAnimation?

--- Unofficial note: i omit the deprecated stuff, you shouldn't use it :)
-- `ParticleSpawner` definition
-- ----------------------------
--
-- Used by `core.add_particlespawner`.
--
-- Before v5.6.0, particlespawners used a different syntax and had a more limited set
-- of features. Definition fields that are the same in both legacy and modern versions
-- are shown in the next listing, and the fields that are used by legacy versions are
-- shown separated by a comment; the modern fields are too complex to compactly
-- describe in this manner and are documented after the listing.
--
-- The older syntax can be used in combination with the newer syntax (e.g. having
-- `minpos`, `maxpos`, and `pos` all set) to support older servers. On newer servers,
-- the new syntax will override the older syntax; on older servers, the newer syntax
-- will be ignored.
---@class ParticleSpawner
-- Number of particles spawned over the time period `time`.
---@field amount number
-- Lifespan of spawner in seconds.
-- If time is 0 spawner has infinite lifespan and spawns the `amount` on
-- a per-second basis.
---@field time number
-- If true collide with `walkable` nodes and, depending on the
-- `object_collision` field, objects too.
---@field collisiondetection boolean?
-- If true particles are removed when they collide.
-- Requires collisiondetection = true to have any effect.
---@field collision_removal boolean?
-- If true particles collide with objects that are defined as
-- `physical = true,` and `collide_with_objects = true,`.
-- Requires collisiondetection = true to have any effect.
---@field object_collision boolean?
-- If defined, particle positions, velocities and accelerations are
-- relative to this object's position and yaw
---@field attached ObjectRef?
-- If true face player using y axis only
---@field vertical boolean?
-- The texture of the particle
-- v5.6.0 and later: also supports the table format described in the
-- following section.
---@field texture ParticleTextureI?
-- Optional, if specified spawns particles only on the player's client
---@field playername string?
-- Optional, specifies how to animate the particles' texture
-- v5.6.0 and later: set length to -1 to synchronize the length
-- of the animation with the expiration time of individual particles.
-- (-2 causes the animation to be played twice, and so on)
---@field animation TileAnimation?
-- Optional, specify particle self-luminescence in darkness.
-- Values 0-14.
---@field glow number?
-- Optional, if specified the particles will have the same appearance as
-- node dig particles for the given node.
-- `texture` and `animation` will be ignored if this is set.
---@field node MapNodeOpt?
-- Optional, only valid in combination with `node`
-- If set to a valid number 1-6, specifies the tile from which the
-- particle texture is picked.
-- Otherwise, the default behavior is used. (currently: any random tile)
---@field node_tile number?
---@field pos particle_spawner_vec3_range?
---@field vel particle_spawner_vec3_range?
---@field acc particle_spawner_vec3_range?
---@field jitter particle_spawner_vec3_range?
---@field drag particle_spawner_vec3_range?
---@field radius particle_spawner_vec3_range?
---@field pos_tween particle_spawner_tween_vec3_range?
---@field vel_tween particle_spawner_tween_vec3_range?
---@field acc_tween particle_spawner_tween_vec3_range?
---@field jitter_tween particle_spawner_tween_vec3_range?
---@field drag_tween particle_spawner_tween_vec3_range? Unofficial note: oh its that thing conservatives are mad abou- nevermind no sorry wrong oops
---@field radius_tween particle_spawner_tween_vec3_range?
---@field size particle_spawner_float_range?
---@field size_tween particle_spawner_tween_float_range?
---@field bounce particle_spawner_float_range?
---@field bounce_tween particle_spawner_tween_float_range?
---@field exptime particle_spawner_float_range?
---@field exptime_tween particle_spawner_tween_float_range?
---@field attract ParticleSpawnerAttract?
-- For particlespawners, it is also possible to set the `texpool` property instead
-- of a single texture definition. A `texpool` consists of a list of possible
-- particle textures. Every time a particle is spawned, the engine will pick a
-- texture at random from the `texpool` and assign it as that particle's texture.
-- You can also specify a `texture` in addition to a `texpool`; the `texture`
-- value will be ignored on newer clients but will be sent to older (pre-v5.6.0)
-- clients that do not implement texpools.
--
-- ```lua
-- texpool = {
--     "mymod_particle_texture.png";
--     { name = "mymod_spark.png", alpha_tween = {1, 0} },
--     {
--       name = "mymod_dust.png",
--       alpha = 0.3,
--       scale = 1.5,
--       animation = {
--             type = "vertical_frames",
--             aspect_w = 16, aspect_h = 16,
--
--             length = 3,
--             -- the animation lasts for 3s and then repeats
--             length = -3,
--             -- repeat the animation three times over the particle's lifetime
--             -- (post-v5.6.0 clients only)
--       },
--     },
-- }
-- ```
---@field textpool ParticleTextureI[]?
--- Unofficial note: Intentionally obscured type, i'll let you know a secret... it's a number, but don't act like it's a number
---@class ParticleSpawner_id

---@class Particle
---@field pos vector
---@field velocity vector?
---@field acceleration vector?
---@field expirationtime number
-- Scales the visual size of the particle texture.
-- If `node` is set, size can be set to 0 to spawn a randomly-sized
-- particle (just like actual node dig particles).
---@field size number?
-- If true collides with `walkable` nodes and, depending on the
-- `object_collision` field, objects too.
---@field collisiondetection boolean?
-- If true particle is removed when it collides.
-- Requires collisiondetection = true to have any effect.
---@field collision_removal boolean?
-- If true particle collides with objects that are defined as
-- `physical = true,` and `collide_with_objects = true,`.
-- Requires collisiondetection = true to have any effect.
---@field object_collision boolean?
-- If true faces player using y axis only
---@field vertical boolean?
-- The texture of the particle
-- v5.6.0 and later: also supports the table format described in the
-- following section, but due to a bug this did not take effect
-- (beyond the texture name).
-- v5.9.0 and later: fixes the bug.
-- Note: "texture.animation" is ignored here. Use "animation" below instead.
---@field texture ParticleTextureI?
-- Optional, if specified spawns particle only on the player's client
---@field playername string?
-- Optional, specifies how to animate the particle texture
---@field animation TileAnimation?
-- Optional, specify particle self-luminescence in darkness.
-- Values 0-14.
---@field glow number?
-- Optional, if specified the particle will have the same appearance as
-- node dig particles for the given node.
-- `texture` and `animation` will be ignored if this is set.
---@field node MapNodeOpt?
-- Optional, only valid in combination with `node`
-- If set to a valid number 1-6, specifies the tile from which the
-- particle texture is picked.
-- Otherwise, the default behavior is used. (currently: any random tile)
---@field node_tile number?
-- v5.6.0 and later: Optional drag value, consult the following section
-- Note: Only a vector is supported here. Alternative forms like a single
-- number are not supported.
---@field drag vector?
-- v5.6.0 and later: Optional jitter range, consult the following section
---@field jitter number|{min:number,max:number,bias:number?}?
-- v5.6.0 and later: Optional bounce range, consult the following section
---@field bounce number|{min:number,max:number,bias:number?}?

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
---@meta
-- Like 4 ways to make random things?
-- Wow
-- `math.random`, PcgRandom, PseudoRandom, (ValueNoise, ValueNoiseMap (not included here) )
-- What will be their next invention
-- OH there is securerandom too???? who the hell uses that???
--
--- Unofficial note: PseudoRandom but better
---@class PcgRandom
PcgRandom = {}

---@param seed integer
---@param seq integer[]?
---@return PcgRandom
function PcgRandom(seed, seq) end

-- * `next()`: return next integer random number [`-2147483648`...`2147483647`]
---@return integer
function PcgRandom:next() end

-- * `next(min, max)`: return next integer random number [`min`...`max`]
---@param min integer
---@param max integer
---@return integer
function PcgRandom:next(min, max) end

-- * `rand_normal_dist(min, max, num_trials=6)`: return normally distributed
--   random number [`min`...`max`].
--     * This is only a rough approximation of a normal distribution with:
--     * `mean = (max - min) / 2`, and
--     * `variance = (((max - min + 1) ^ 2) - 1) / (12 * num_trials)`
--     * Increasing `num_trials` improves accuracy of the approximation
---@param min integer
---@param max integer
---@param num_trials integer?
---@return integer
function PcgRandom:rand_normal_dist(min, max, num_trials) end

-- * `get_state()`: return generator state encoded in string
---@return string
function PcgRandom:get_state() end

-- * `set_state(state_string)`: restore generator state from encoded string
---@param state string
function PcgRandom:set_state(state) end

-- `PseudoRandom`
-- --------------
--
-- A 16-bit pseudorandom number generator.
-- Uses a well-known LCG algorithm introduced by K&R.
--
-- **Note**:
-- `PseudoRandom` is slower and has worse random distribution than `PcgRandom`.
-- Use `PseudoRandom` only if you need output to match the well-known LCG algorithm introduced by K&R.
-- Otherwise, use `PcgRandom`.
--
-- * constructor `PseudoRandom(seed)`
--   * `seed`: 32-bit signed number
---@class PseudoRandom
PseudoRandom = {}

---@param seed integer
function PseudoRandom(seed) end

-- * `next()`: return next integer random number [`0`...`32767`]
---@return integer
function PseudoRandom:next() end
-- * `next(min, max)`: return next integer random number [`min`...`max`]
--     * Either `max - min == 32767` or `max - min <= 6553` must be true
--       due to the simple implementation making a bad distribution otherwise.
---@param min integer
---@param max integer
---@return integer
function PseudoRandom:next(min, max) end

-- * `get_state()`: return state of pseudorandom generator as number
--     * use returned number as seed in PseudoRandom constructor to restore
---@return integer
function PseudoRandom:get_state() end

-- `SecureRandom`
-- --------------
--
-- Interface for the operating system's crypto-secure PRNG.
--
-- It can be created via `SecureRandom()`.  The constructor throws an error if a
-- secure random device cannot be found on the system.
--
-- ### Methods
--
-- * `next_bytes([count])`: return next `count` (default 1, capped at 2048) many
--   random bytes, as a string.
---@class SecureRandom
SecureRandom = {}

---@return SecureRandom
function SecureRandom() end

-- * `next_bytes([count])`: return next `count` (default 1, capped at 2048) many
--   random bytes, as a string.
---@return string
---@param count integer
function SecureRandom:next_bytes(count) end
---@meta

---@param biome_def BiomeDef
function core.register_biome(biome_def) end

---@param decoration_def DecorationDef
function core.register_decoration(decoration_def) end

---@param chatcommand_def ChatCommandDef
function core.register_chatcommand(chatcommand_def) end

--- core.register_node defined somewhere else

-- * Note: you must pass a clean table that hasn't already been used for
--   another registration to this function, as it will be modified.
---@param name string
---@param itemdef ItemDef
function core.register_craftitem(name, itemdef) end

-- * Note: you must pass a clean table that hasn't already been used for
--   another registration to this function, as it will be modified.
---@param name string
---@param itemdef ItemDef
function core.register_tool(name, itemdef) end

-- * `core.override_item(name, redefinition, del_fields)`
--     * `redefinition` is a table of fields `[name] = new_value`,
--       overwriting fields of or adding fields to the existing definition.
--     * `del_fields` is a list of field names to be set
--       to `nil` ("deleted from") the original definition.
--     * Overrides fields of an item registered with register_node/tool/craftitem.
--     * Note: Item must already be defined.
--     * Example: `core.override_item("default:mese",
--       {light_source=core.LIGHT_MAX}, {"sounds"})`:
--       Overwrites the `light_source` field,
--       removes the sounds from the definition of the mese block.
---@param name string
---@param redefinition table sorry no types for this one :)
---@param del_fields table sorry no types for this one :)
function core.override_item(name, redefinition, del_fields) end

---@param name string
function core.unregister_item(name) end

---@param name string
---@param entity_def EntityDef
function core.register_entity(name, entity_def) end

--- core.register_abm is defined somewhere else

---@param lbmdef LBMDef
function core.register_lbm(lbmdef) end

---@param schem_def table sorry no types :(
function core.register_schematic(schem_def) end

---@param recipe CraftRecipe
function core.clear_craft(recipe) end

---@param name string
---@param redef table sorry no types
function core.override_chatcommand(name, redef) end

---@param name string
function core.unregister_chatcommand(name) end

---@param def PrivDef
---@param name string
function core.register_privilege(name, def) end

---@param def OreDef
---@return number?
function core.register_ore(def) end

--- How many people do you think, have interacted with this function
--- Have *wanted* to interact with this function...
---
--- i think that number is like, 5?
---
--- anyway docs:
-- * Registers an auth handler that overrides the builtin one.
-- * This function can be called by a single mod once only.
---@param auth_handler_def table you know what you are doing, i am sorry but no types
function core.register_authentication_handler(auth_handler_def) end

--- LINE 6000 of lua_api.md

--- Why is luanti mgv6 so mtg centric?
---@alias item_alias string | "mapgen_stone"|"mapgen_water_source"|"mapgen_river_water_source"|"mapgen_lava_source"|"mapgen_cobble"|"mapgen_dirt"|"mapgen_dirt_with_grass"|"mapgen_sand"|"mapgen_tree"|"mapgen_leaves"|"mapgen_apple"|"mapgen_cobble"|"mapgen_gravel"|"mapgen_desert_stone"|"mapgen_desert_sand"|"mapgen_dirt_with_snow"|"mapgen_snowblock"|"mapgen_snow"|"mapgen_ice"|"mapgen_jungletree"|"mapgen_jungleleaves"|"mapgen_pine_tree"|"mapgen_pine_needles"|"mapgen_stair_cobble"|"mapgen_mossycobble"|"mapgen_stair_desert_stone"|"mapgen_singlenode"

-- Also use this to set the 'mapgen aliases' needed in a game for the code mapgens.
---@param alias item_alias
---@param original_name string
function core.register_alias(alias, original_name) end

---@param alias item_alias
---@param original_name string
function core.register_alias_force(alias, original_name) end

-- * Unregisters the biome from the engine, and deletes the entry with key
--   `name` from `core.registered_biomes`.
-- * Warning: This alters the biome to biome ID correspondences, so any
--   decorations or ores using the 'biomes' field must afterwards be cleared
--   and re-registered.
---@param name string
function core.unregister_biome(name) end

-- * `core.clear_registered_biomes()`
--     * Clears all biomes currently registered.
--     * Warning: Clearing and re-registering biomes alters the biome to biome ID
--       correspondences, so any decorations or ores using the 'biomes' field must
--       afterwards be cleared and re-registered.
---@return nil
function core.clear_registered_biomes() end

function core.clear_registered_decorations() end

function core.clear_registered_ores() end

function core.clear_registered_schematics() end

---@type table<string, ItemDef>
core.registered_items = core.registered_items
---@type table<string, NodeDef>
core.registered_nodes = core.registered_nodes
---@type table<string, ItemDef>
core.registered_craftitems = core.registered_craftitems
---@type table<string, ItemDef>
core.registered_tools = core.registered_tools
---@type table<string, EntityDef>
core.registered_entities = core.registered_entities
---@type table<integer, ObjectRef>
core.object_refs = core.object_refs
---@type table<integer, luaentity>
core.luaentities = core.luaentities
---@type ABMDef[]
core.registered_abms = core.registered_abms
---@type LBMDef[]
core.registered_lbms = core.registered_lbms
---@type table<string, string>
core.registered_aliases = core.registered_aliases
---@type table<string|integer, OreDef>
core.registered_ores = core.registered_ores
---@type table<string|integer, BiomeDef>
core.registered_biomes = core.registered_biomes
---@type table<string|integer, DecorationDef>
core.registered_decorations = core.registered_decorations
---@type table<string, ChatCommandDef>
core.registered_chatcommands = core.registered_chatcommands
---@type table<string, PrivDef>
core.registered_privileges = core.registered_privileges

--- I got lazy, sowwy :<

---@type function[]
core.registered_on_chat_messages = core.registered_on_chat_messages
---@type function[]
core.registered_on_chatcommands = core.registered_on_chatcommands
---@type function[]
core.registered_globalsteps = core.registered_globalsteps
---@type function[]
core.registered_on_punchnodes = core.registered_on_punchnodes
---@type function[]
core.registered_on_placenodes = core.registered_on_placenodes
---@type function[]
core.registered_on_dignodes = core.registered_on_dignodes
---@type function[]
core.registered_on_generateds = core.registered_on_generateds
---@type function[]
core.registered_on_newplayers = core.registered_on_newplayers
---@type function[]
core.registered_on_dieplayers = core.registered_on_dieplayers
---@type function[]
core.registered_on_respawnplayers = core.registered_on_respawnplayers
---@type function[]
core.registered_on_prejoinplayers = core.registered_on_prejoinplayers
---@type function[]
core.registered_on_joinplayers = core.registered_on_joinplayers
---@type function[]
core.registered_on_leaveplayers = core.registered_on_leaveplayers
---@type function[]
core.registered_on_player_receive_fields = core.registered_on_player_receive_fields
---@type function[]
core.registered_on_cheats = core.registered_on_cheats
---@type function[]
core.registered_on_crafts = core.registered_on_crafts
---@type function[]
core.registered_craft_predicts = core.registered_craft_predicts
---@type function[]
core.registered_on_item_eats = core.registered_on_item_eats
---@type function[]
core.registered_on_item_pickups = core.registered_on_item_pickups
---@type function[]
core.registered_on_punchplayers = core.registered_on_punchplayers
---@type function[]
core.registered_on_authplayers = core.registered_on_authplayers
---@type function[]
core.registered_on_player_inventory_actions = core.registered_on_player_inventory_actions
---@type function[]
core.registered_allow_player_inventory_actions = core.registered_allow_player_inventory_actions
---@type function[]
core.registered_on_rightclickplayers = core.registered_on_rightclickplayers
---@type function[]
core.registered_on_mods_loaded = core.registered_on_mods_loaded
---@type function[]
core.registered_on_shutdown = core.registered_on_shutdown
---@type function[]
core.registered_on_protection_violation = core.registered_on_protection_violation
---@type function[]
core.registered_on_priv_grant = core.registered_on_priv_grant
---@type function[]
core.registered_on_priv_revoke = core.registered_on_priv_revoke
---@type function[]
core.registered_can_bypass_userlimit = core.registered_can_bypass_userlimit
---@type function[]
core.registered_on_modchannel_message = core.registered_on_modchannel_message
---@type function[]
core.registered_on_liquid_transformed = core.registered_on_liquid_transformed
---@type function[]
core.registered_on_mapblocks_changed = core.registered_on_mapblocks_changed

---@param abmdef ABMDef
function core.register_abm(abmdef) end

-- ABM (ActiveBlockModifier) definition
-- ------------------------------------
--
-- Used by `core.register_abm`.
--
-- An active block modifier (ABM) is used to define a function that is continously
-- and randomly called for specific nodes (defined by `nodenames` and other conditions)
-- in active mapblocks.
---@class ABMDef
-- Descriptive label for profiling purposes (optional).
-- Definitions with identical labels will be listed as one.
---@field label?  string
-- Apply `action` function to these nodes.
-- `group:groupname` can also be used here.
---@field nodenames? string[]
-- Only apply `action` to nodes that have one of, or any
-- combination of, these neighbors.
-- If left out or empty, any neighbor will do.
-- `group:groupname` can also be used here.
---@field neighbors? string[]
-- Only apply `action` to nodes that have no one of these neighbors.
-- If left out or empty, it has no effect.
-- `group:groupname` can also be used here.
---@field without_neighbors? string[]
-- Operation interval in seconds
---@field interval? number
-- Probability of triggering `action` per-node per-interval is 1.0 / chance (integers only)
---@field chance? number
---@field min_y? number
---@field max_y? number
-- If true, catch-up behavior is enabled: The `chance` value is
-- temporarily reduced when returning to an area to simulate time lost
-- by the area being unattended. Note that the `chance` value can often
-- be reduced to 1.
---@field catch_up? boolean
-- Function triggered for each qualifying node.
-- `active_object_count` is number of active objects in the node's
-- mapblock.
-- `active_object_count_wider` is number of active objects in the node's
-- mapblock plus all 26 neighboring mapblocks. If any neighboring
-- mapblocks are unloaded an estimate is calculated for them based on
-- loaded mapblocks.
---@field action fun(pos:vector, node:MapNode, active_object_count:number, active_object_count_wider:number):nil

-- LBM (LoadingBlockModifier) definition
-- -------------------------------------
--
-- Used by `core.register_lbm`.
--
-- A loading block modifier (LBM) is used to define a function that is called for
-- specific nodes (defined by `nodenames`) when a mapblock which contains such nodes
-- gets **activated** (**not loaded!**).
--
-- *Note*: LBMs operate on a "snapshot" of node positions taken once before they are triggered.
-- That means if an LBM callback adds a node, it won't be taken into account.
-- However the engine guarantees that at the point in time when the callback is called
-- that all given positions contain a matching node.
--
-- For `run_at_every_load = false` to work, both mapblocks and LBMs have timestamps
-- associated with them:
--
-- * Each mapblock has a "last active" timestamp. It is also updated when the
--   mapblock is generated.
-- * For each LBM, an introduction timestamp is stored in the world data, identified
--   by the LBM's `name` field. If an LBM disappears, the corresponding timestamp
--   is cleared.
--
-- When a mapblock is activated, only LBMs whose introduction timestamp is newer
-- than the mapblock's timestamp are run.
--
-- *Note*: For maps generated in 5.11.0 or older, many newly generated mapblocks
-- did not get a timestamp set. This means LBMs introduced between generation time
-- and time of first activation will never run.
-- Currently the only workaround is to use `run_at_every_load = true`.
---@class LBMDef
-- Descriptive label for profiling purposes (optional).
-- Definitions with identical labels will be listed as one.
---@field label? string
-- Identifier of the LBM, should follow the modname:<whatever> convention
---@field name? string
-- List of node names to trigger the LBM on.
-- Names of non-registered nodes and groups (as group:groupname)
-- will work as well.
---@field nodenames? string[]
-- If `false`: The LBM only runs on mapblocks the first time they are
-- activated after the LBM was introduced.
-- It never runs on mapblocks generated after the LBM's introduction.
-- See above for details.
--
-- If `true`: The LBM runs every time a mapblock is activated.
---@field run_at_every_load? boolean
-- Function triggered for each qualifying node.
-- `dtime_s` is the in-game time (in seconds) elapsed since the mapblock
-- was last active (available since 5.7.0).
---@field action? fun(pos:vector, node:MapNode, dtime_s:number)
-- Function triggered with a list of all applicable node positions at once.
-- This can be provided as an alternative to `action` (not both).
-- Available since `core.features.bulk_lbms` (5.10.0)
-- `dtime_s`: as above
---@field bulk_action? fun(pos_list: vector[], dtime_s:number)

--- Node boxes have sneaked in here!!
--- And yeah i know im duplicating the docs, intentionally

-- Node boxes
-- ----------
--
-- Node selection boxes and collision boxes, and the appearance of the `nodebox`
-- drawtype, are defined using "node boxes".
--
-- A nodebox is defined as any of:
-- ```lua
-- {
--     -- A normal cube; the default in most things
--     type = "regular"
-- }
-- {
--     -- A fixed box (or boxes) (facedir param2 is used, if applicable)
--     type = "fixed",
--     fixed = box OR {box1, box2, ...}
-- }
-- {
--     -- A variable height box (or boxes) with the top face position defined
--     -- by the node parameter 'leveled = ', or if 'paramtype2 == "leveled"'
--     -- by param2.
--     -- Other faces are defined by 'fixed = {}' as with 'type = "fixed"'.
--     type = "leveled",
--     fixed = box OR {box1, box2, ...}
-- }
-- {
--     -- A box like the selection box for torches
--     -- (wallmounted param2 is used, if applicable)
--     type = "wallmounted",
--     wall_top = box,
--     wall_bottom = box,
--     wall_side = box
-- }
-- {
--     -- A node that has optional boxes depending on neighboring nodes'
--     -- presence and type. See also `connects_to`.
--     type = "connected",
--     fixed = box OR {box1, box2, ...}
--     connect_top = box OR {box1, box2, ...}
--     connect_bottom = box OR {box1, box2, ...}
--     connect_front = box OR {box1, box2, ...}
--     connect_left = box OR {box1, box2, ...}
--     connect_back = box OR {box1, box2, ...}
--     connect_right = box OR {box1, box2, ...}
--     -- The following `disconnected_*` boxes are the opposites of the
--     -- `connect_*` ones above, i.e. when a node has no suitable neighbor
--     -- on the respective side, the corresponding disconnected box is drawn.
--     disconnected_top = box OR {box1, box2, ...}
--     disconnected_bottom = box OR {box1, box2, ...}
--     disconnected_front = box OR {box1, box2, ...}
--     disconnected_left = box OR {box1, box2, ...}
--     disconnected_back = box OR {box1, box2, ...}
--     disconnected_right = box OR {box1, box2, ...}
--     disconnected = box OR {box1, box2, ...} -- when there is *no* neighbor
--     disconnected_sides = box OR {box1, box2, ...} -- when there are *no*
--                                                   -- neighbors to the sides
-- }
-- A `box` is defined as:
--
-- ```lua
-- {x1, y1, z1, x2, y2, z2}
-- ```
--
-- A box of a regular node would look like:
--
-- ```lua
-- {-0.5, -0.5, -0.5, 0.5, 0.5, 0.5},
-- ```
--
-- To avoid collision issues, keep each value within the range of +/- 1.45.
-- This also applies to leveled nodeboxes, where the final height shall not
-- exceed this soft limit.
---@class NodeBox
-- ```lua
-- {
--     -- A normal cube; the default in most things
--     type = "regular"
-- }
-- {
--     -- A fixed box (or boxes) (facedir param2 is used, if applicable)
--     type = "fixed",
--     fixed = box OR {box1, box2, ...}
-- }
-- {
--     -- A variable height box (or boxes) with the top face position defined
--     -- by the node parameter 'leveled = ', or if 'paramtype2 == "leveled"'
--     -- by param2.
--     -- Other faces are defined by 'fixed = {}' as with 'type = "fixed"'.
--     type = "leveled",
--     fixed = box OR {box1, box2, ...}
-- }
-- {
--     -- A box like the selection box for torches
--     -- (wallmounted param2 is used, if applicable)
--     type = "wallmounted",
--     wall_top = box,
--     wall_bottom = box,
--     wall_side = box
-- }
-- {
--     -- A node that has optional boxes depending on neighboring nodes'
--     -- presence and type. See also `connects_to`.
--     type = "connected",
--     fixed = box OR {box1, box2, ...}
--     connect_top = box OR {box1, box2, ...}
--     connect_bottom = box OR {box1, box2, ...}
--     connect_front = box OR {box1, box2, ...}
--     connect_left = box OR {box1, box2, ...}
--     connect_back = box OR {box1, box2, ...}
--     connect_right = box OR {box1, box2, ...}
--     -- The following `disconnected_*` boxes are the opposites of the
--     -- `connect_*` ones above, i.e. when a node has no suitable neighbor
--     -- on the respective side, the corresponding disconnected box is drawn.
--     disconnected_top = box OR {box1, box2, ...}
--     disconnected_bottom = box OR {box1, box2, ...}
--     disconnected_front = box OR {box1, box2, ...}
--     disconnected_left = box OR {box1, box2, ...}
--     disconnected_back = box OR {box1, box2, ...}
--     disconnected_right = box OR {box1, box2, ...}
--     disconnected = box OR {box1, box2, ...} -- when there is *no* neighbor
--     disconnected_sides = box OR {box1, box2, ...} -- when there are *no*
--                                                   -- neighbors to the sides
-- }
---@field type "regular"|"fixed"|"leveled"|"wallmounted"|"connected"
---@field fixed Box
---@field wall_top Box_single
---@field wall_bottom Box_single
---@field wall_side Box_single
---@field connect_top Box
---@field connect_front Box
---@field connect_back Box
---@field connect_right Box
---@field disconnected_top Box
---@field disconnected_bottom Box
---@field disconnected_front Box
---@field disconnected_left Box
---@field disconnected_back Box
---@field disconnected_right Box
---@field disconnected Box
---@field disconnected_sides Box

---@alias Box Box_single[]|Box_single
---@alias Box_single number[]

--- Tool capabilities...

---@class tool_capabilities:table
---@field full_punch_interval? number
---@field max_drop_level? number
---@field groupcaps? table<string, {times:number[]?, uses:number?, maxlevel:number?}>
---@field damage_groups? table<string, integer>
-- Amount of uses this tool has for attacking players and entities
-- by punching them (0 = infinite uses).
-- For compatibility, this is automatically set from the first
-- suitable groupcap using the formula "uses * 3^(maxlevel - 1)".
-- It is recommend to set this explicitly instead of relying on the
-- fallback behavior.
---@field punch_attack_uses? integer

-- ITEM DEFINITION (yey)

---@alias TouchInteractionMode "long_dig_short_place"|"short_dig_long_place"|"user"

---@class ItemDef: table
-- Can contain new lines. "\n" has to be used as new line character.
-- See also: `get_description` in [`ItemStack`]
---@field description string
-- Must not contain new lines.
-- Defaults to nil.
-- Use an [`ItemStack`] to get the short description, e.g.:
--   ItemStack(itemname):get_short_description()
---@field short_description? string
-- key = name, value = rating; rating = <number>.
-- If rating not applicable, use 1.
-- e.g. {wool = 1, fluffy = 3}
--      {soil = 2, outerspace = 1, crumbly = 1}
--      {bendy = 2, snappy = 1},
--      {hard = 1, metal = 1, spikes = 1}
---@field groups table<string, integer>
-- Texture shown in the inventory GUI
-- Defaults to a 3D rendering of the node if left empty.
---@field inventory_image? string
-- An overlay texture which is not affected by colorization
---@field inventory_overlay? string
-- Texture shown when item is held in hand
-- Defaults to a 3D rendering of the node if left empty.
---@field wield_image? string
-- Like inventory_overlay but only used in the same situation as wield_image
---@field wield_overlay? string
-- Scale for the item when held in hand
---@field wield_scale? vector
-- An image file containing the palette of a node.
-- You can set the currently used color as the "palette_index" field of
-- the item stack metadata.
-- The palette is always stretched to fit indices between 0 and 255, to
-- ensure compatibility with "colorfacedir" (and similar) nodes.
---@field palette? string
-- Color the item is colorized with. The palette overrides this.
---@field color? ColorSpec
-- Maximum amount of items that can be in a single stack.
-- The default can be changed by the setting `default_stack_max`
---@field stack_max? integer
-- Range of node and object pointing that is possible with this item held
-- Can be overridden with itemstack meta.
---@field range? number
-- If true, item can point to all liquid nodes (`liquidtype ~= "none"`),
-- even those for which `pointable = false`
---@field liquids_pointable? boolean
-- Contains lists to override the `pointable` property of nodes and objects.
-- The index can be a node/entity name or a group with the prefix `"group:"`.
-- (For objects `armor_groups` are used and for players the entity name is irrelevant.)
-- If multiple fields fit, the following priority order is applied:
-- 1. value of matching node/entity name
-- 2. `true` for any group
-- 3. `false` for any group
-- 4. `"blocking"` for any group
-- 5. `liquids_pointable` if it is a liquid node
-- 6. `pointable` property of the node or object
---@field pointabilities {nodes:table<string, "blocking"|boolean>, objects:table<string, "blocking"|boolean>}
-- When used for nodes: Defines amount of light emitted by node.
-- Otherwise: Defines texture glow when viewed as a dropped item
-- To set the maximum (14), use the value 'core.LIGHT_MAX'.
-- A value outside the range 0 to core.LIGHT_MAX causes undefined
-- behavior.
---@field light_source? integer
-- See "Tool Capabilities" section for an example including explanation
---@field tool_capabilities? tool_capabilities
-- Set wear bar color of the tool by setting color stops and blend mode
-- See "Wear Bar Color" section for further explanation including an example
---@field wear_color? wear_bar_params
-- If nil and item is node, prediction is made automatically.
-- If nil and item is not a node, no prediction is made.
-- If "" and item is anything, no prediction is made.
-- Otherwise should be name of node which the client immediately places
-- on ground when the player places the item. Server will always update
-- with actual result shortly.
---@field node_placement_prediction? string
-- if "", no prediction is made.
-- if "air", node is removed.
-- Otherwise should be name of node which the client immediately places
-- upon digging. Server will always update with actual result shortly.
---@field node_dig_prediction? string
-- Only affects touchscreen clients.
-- Defines the meaning of short and long taps with the item in hand.
-- If specified as a table, the field to be used is selected according to
-- the current `pointed_thing`.
-- There are three possible TouchInteractionMode values:
-- * "long_dig_short_place" (long tap  = dig, short tap = place)
-- * "short_dig_long_place" (short tap = dig, long tap  = place)
-- * "user":
--   * For `pointed_object`: Equivalent to "short_dig_long_place" if the
--     client-side setting "touch_punch_gesture" is "short_tap" (the
--     default value) and the item is able to punch (i.e. has no on_use
--     callback defined).
--     Equivalent to "long_dig_short_place" otherwise.
--   * For `pointed_node` and `pointed_nothing`:
--     Equivalent to "long_dig_short_place".
--   * The behavior of "user" may change in the future.
-- The default value is "user".
---@field touch_interaction TouchInteractionMode | {pointed_nothing:TouchInteractionMode, pointed_node:TouchInteractionMode, pointed_object: TouchInteractionMode}
---@field sound {breaks:SimpleSoundSpec?, eat:SimpleSoundSpec?, punch_use:SimpleSoundSpec?, punch_use_dir:SimpleSoundSpec?}
-- When the 'place' key was pressed with the item in hand
-- and a node was pointed at.
-- Shall place item and return the leftover itemstack
-- or nil to not modify the inventory.
-- The placer may be any ObjectRef or nil.
-- default: core.item_place
---@field on_place? fun(itemstack:ItemStack, placer:PlayerRef, pointed_thing:pointed_thing):ItemStack?
-- Same as on_place but called when not pointing at a node.
-- Function must return either nil if inventory shall not be modified,
-- or an itemstack to replace the original itemstack.
-- The user may be any ObjectRef or nil.
-- default: nil
---@field on_secondary_use? fun(itemstack:ItemStack, user:PlayerRef, pointed_thing:pointed_thing)
-- Shall drop item and return the leftover itemstack.
-- The dropper may be any ObjectRef or nil.
-- default: core.item_drop
---@field on_drop? fun(itemstack:ItemStack, dropper:PlayerRef, pos:vector)
-- Called when a dropped item is punched by a player.
-- Shall pick-up the item and return the leftover itemstack or nil to not
-- modify the dropped item.
-- Parameters:
-- * `itemstack`: The `ItemStack` to be picked up.
-- * `picker`: Any `ObjectRef` or `nil`.
-- * `pointed_thing` (optional): The dropped item (a `"__builtin:item"`
--   luaentity) as `type="object"` `pointed_thing`.
-- * `time_from_last_punch, ...` (optional): Other parameters from
--   `luaentity:on_punch`.
-- default: `core.item_pickup`
---@field on_pickup? fun(itemstack: ItemStack, picker:PlayerRef, pointed_thing:pointed_thing, time_from_last_punch: number, ...):ItemStack?
-- default: nil
-- When user pressed the 'punch/mine' key with the item in hand.
-- Function must return either nil if inventory shall not be modified,
-- or an itemstack to replace the original itemstack.
-- e.g. itemstack:take_item(); return itemstack
-- Otherwise, the function is free to do what it wants.
-- The user may be any ObjectRef or nil.
-- The default functions handle regular use cases.
---@field on_use? fun(itemstack:ItemStack, user:PlayerRef?, pointed_thing:pointed_thing)
-- default: nil
-- If defined, should return an itemstack and will be called instead of
-- wearing out the item (if tool). If returnskk nil, does nothing.
-- If after_use doesn't exist, it is the same as:
--   function(itemstack, user, node, digparams)
--     itemstack:add_wear(digparams.wear)
--     return itemstack
--   end
-- The user may be any ObjectRef or nil.
---@field after_use? fun(itemstack:ItemStack, user:PlayerRef?, node:MapNode, digparams:table)

---@class NodeDef: ItemDef
-- drawtype = "normal",  -- See "Node drawtypes"
-- Node drawtypes
-- --------------
--
-- There are a bunch of different looking node types.
--
-- * `normal`
--     * A node-sized cube.
-- * `airlike`
--     * Invisible, uses no texture.
-- * `liquid`
--     * The cubic source node for a liquid.
--     * Faces bordering to the same node are never rendered.
--     * Connects to node specified in `liquid_alternative_flowing` if specified.
--     * Use `backface_culling = false` for the tiles you want to make
--       visible when inside the node.
-- * `flowingliquid`
--     * The flowing version of a liquid, appears with various heights and slopes.
--     * Faces bordering to the same node are never rendered.
--     * Connects to node specified in `liquid_alternative_source`.
--     * You *must* set `liquid_alternative_flowing` to the node's own name.
--     * Node textures are defined with `special_tiles` where the first tile
--       is for the top and bottom faces and the second tile is for the side
--       faces.
--     * `tiles` is used for the item/inventory/wield image rendering.
--     * Use `backface_culling = false` for the special tiles you want to make
--       visible when inside the node
-- * `glasslike`
--     * Often used for partially-transparent nodes.
--     * Only external sides of textures are visible.
-- * `glasslike_framed`
--     * All face-connected nodes are drawn as one volume within a surrounding
--       frame.
--     * The frame appearance is generated from the edges of the first texture
--       specified in `tiles`. The width of the edges used are 1/16th of texture
--       size: 1 pixel for 16x16, 2 pixels for 32x32 etc.
--     * The glass 'shine' (or other desired detail) on each node face is supplied
--       by the second texture specified in `tiles`.
-- * `glasslike_framed_optional`
--     * This switches between the above 2 drawtypes according to the menu setting
--       'Connected Glass'.
-- * `allfaces`
--     * Often used for partially-transparent nodes.
--     * External sides of textures, and unlike other drawtypes, the external sides
--       of other nodes, are visible from the inside.
-- * `allfaces_optional`
--     * Often used for leaves nodes.
--     * This switches between `normal`, `glasslike` and `allfaces` according to
--       the menu setting: Opaque Leaves / Simple Leaves / Fancy Leaves.
--     * With 'Simple Leaves' selected, the texture specified in `special_tiles`
--       is used instead, if present. This allows a visually thicker texture to be
--       used to compensate for how `glasslike` reduces visual thickness.
-- * `torchlike`
--     * A single vertical texture.
--     * If `paramtype2="[color]wallmounted"`:
--         * If placed on top of a node, uses the first texture specified in `tiles`.
--         * If placed against the underside of a node, uses the second texture
--           specified in `tiles`.
--         * If placed on the side of a node, uses the third texture specified in
--           `tiles` and is perpendicular to that node.
--     * If `paramtype2="none"`:
--         * Will be rendered as if placed on top of a node (see
--           above) and only the first texture is used.
-- * `signlike`
--     * A single texture parallel to, and mounted against, the top, underside or
--       side of a node.
--     * If `paramtype2="[color]wallmounted"`, it rotates according to `param2`
--     * If `paramtype2="none"`, it will always be on the floor.
-- * `plantlike`
--     * Two vertical and diagonal textures at right-angles to each other.
--     * See `paramtype2 = "meshoptions"` above for other options.
-- * `firelike`
--     * When above a flat surface, appears as 6 textures, the central 2 as
--       `plantlike` plus 4 more surrounding those.
--     * If not above a surface the central 2 do not appear, but the texture
--       appears against the faces of surrounding nodes if they are present.
-- * `fencelike`
--     * A 3D model suitable for a wooden fence.
--     * One placed node appears as a single vertical post.
--     * Adjacently-placed nodes cause horizontal bars to appear between them.
-- * `raillike`
--     * Often used for tracks for mining carts.
--     * Requires 4 textures to be specified in `tiles`, in order: Straight,
--       curved, t-junction, crossing.
--     * Each placed node automatically switches to a suitable rotated texture
--       determined by the adjacent `raillike` nodes, in order to create a
--       continuous track network.
--     * Becomes a sloping node if placed against stepped nodes.
-- * `nodebox`
--     * Often used for stairs and slabs.
--     * Allows defining nodes consisting of an arbitrary number of boxes.
--     * See [Node boxes] below for more information.
-- * `mesh`
--     * Uses models for nodes.
--     * Tiles should hold model materials textures.
--     * Only static meshes are implemented.
--     * For supported model formats see Irrlicht engine documentation.
-- * `plantlike_rooted`
--     * Enables underwater `plantlike` without air bubbles around the nodes.
--     * Consists of a base cube at the coordinates of the node plus a
--       `plantlike` extension above
--     * If `paramtype2="leveled", the `plantlike` extension has a height
--       of `param2 / 16` nodes, otherwise it's the height of 1 node
--     * If `paramtype2="wallmounted"`, the `plantlike` extension
--       will be at one of the corresponding 6 sides of the base cube.
--       Also, the base cube rotates like a `normal` cube would
--     * The `plantlike` extension visually passes through any nodes above the
--       base cube without affecting them.
--     * The base cube texture tiles are defined as normal, the `plantlike`
--       extension uses the defined special tile, for example:
--       `special_tiles = {{name = "default_papyrus.png"}},`
--
-- `*_optional` drawtypes need less rendering time if deactivated
-- (always client-side).
---@field drawtype? "normal"|"airlike"|"liquid"|"flowingliquid"|"glasslike"|"glasslike_framed"|"glasslike_framed_optional"|"allfaces"|"allfaces_optional"|"torchlike"|"signlike"|"plantlike"|"firelike"|"fencelike"|"raillike"|"nodebox"|"mesh"|"plantlike_rooted"
-- visual_scale = 1.0,
-- Supported for drawtypes "plantlike", "signlike", "torchlike",
-- "firelike", "mesh", "nodebox", "allfaces".
-- For plantlike and firelike, the image will start at the bottom of the
-- node. For torchlike, the image will start at the surface to which the
-- node "attaches". For the other drawtypes the image will be centered
-- on the node.
---@field visual_scale? number
-- tiles = {tile definition 1, def2, def3, def4, def5, def6},
-- Textures of node; +Y, -Y, +X, -X, +Z, -Z
-- List can be shortened to needed length.
---@field tiles? Tile[]
-- overlay_tiles = {tile definition 1, def2, def3, def4, def5, def6},
-- Same as `tiles`, but these textures are drawn on top of the base
-- tiles. You can use this to colorize only specific parts of your
-- texture. If the texture name is an empty string, that overlay is not
-- drawn. Since such tiles are drawn twice, it is not recommended to use
-- overlays on very common nodes.
---@field overlay_tiles? Tile[]
-- special_tiles = {tile definition 1, Tile definition 2},
-- Special textures of node; used rarely.
-- List can be shortened to needed length.
---@field special_tiles? Tile[]
-- color = ColorSpec,
-- The node's original color will be multiplied with this color.
-- If the node has a palette, then this setting only has an effect in
-- the inventory and on the wield item.
---@field color? ColorSpec
-- use_texture_alpha = ...,
-- Specifies how the texture's alpha channel will be used for rendering.
-- Possible values:
-- * "opaque":
--   Node is rendered opaque regardless of alpha channel.
-- * "clip":
--   A given pixel is either fully see-through or opaque
--   depending on the alpha channel being below/above 50% in value.
--   Use this for nodes with fully transparent and fully opaque areas.
-- * "blend":
--   The alpha channel specifies how transparent a given pixel
--   of the rendered node is. This comes at a performance cost.
--   Only use this when correct rendering
--   among semitransparent nodes is necessary.
-- The default is "opaque" for drawtypes normal, liquid and flowingliquid,
-- mesh and nodebox or "clip" otherwise.
-- If set to a boolean value (deprecated): true either sets it to blend
-- or clip, false sets it to clip or opaque mode depending on the drawtype.
---@field use_texture_alpha? "opaque"|"clip"|"blend"
-- palette = "",
-- The node's `param2` is used to select a pixel from the image.
-- Pixels are arranged from left to right and from top to bottom.
-- The node's color will be multiplied with the selected pixel's color.
-- Tiles can override this behavior.
-- Only when `paramtype2` supports palettes.
---@field palette? string
-- post_effect_color = "#00000000",
-- Screen tint if a player is inside this node, see `ColorSpec`.
-- Color is alpha-blended over the screen.
---@field post_effect_color? ColorSpec
-- post_effect_color_shaded = false,
-- Determines whether `post_effect_color` is affected by lighting.
---@field post_effect_color_shaded? boolean
-- paramtype = "none",  -- See "Nodes"
-- ### Unofficial note: you want this to be "light" most of the time, ESPECIALLY for other drawtypes, as some will appear pitch black if you don't have smooth lighting
-- The function of `param1` is determined by `paramtype` in node definition.
-- `param1` is reserved for the engine when `paramtype != "none"`.
--
-- * `paramtype = "light"`
--     * The value stores light with and without sun in its lower and upper 4 bits
--       respectively.
--     * Required by a light source node to enable spreading its light.
--     * Required by the following drawtypes as they determine their visual
--       brightness from their internal light value:
--         * torchlike
--         * signlike
--         * firelike
--         * fencelike
--         * raillike
--         * nodebox
--         * mesh
--         * plantlike
--         * plantlike_rooted
-- * `paramtype = "none"`
--     * `param1` will not be used by the engine and can be used to store
--       an arbitrary value
---@field paramtype? "light"|"none"
-- paramtype2 = "none",  -- See "Nodes"
-- The function of `param2` is determined by `paramtype2` in node definition.
-- `param2` is reserved for the engine when `paramtype2 != "none"`.
--
-- * `paramtype2 = "flowingliquid"`
--     * Used by `drawtype = "flowingliquid"` and `liquidtype = "flowing"`
--     * The liquid level and a flag of the liquid are stored in `param2`
--     * Bits 0-2: Liquid level (0-7). The higher, the more liquid is in this node;
--       see `core.get_node_level`, `core.set_node_level` and `core.add_node_level`
--       to access/manipulate the content of this field
--     * Bit 3: If set, liquid is flowing downwards (no graphical effect)
-- * `paramtype2 = "wallmounted"`
--     * Supported drawtypes: "torchlike", "signlike", "plantlike",
--       "plantlike_rooted", "normal", "nodebox", "mesh"
--     * The rotation of the node is stored in `param2`
--     * Node is 'mounted'/facing towards one of 6 directions
--     * You can make this value by using `core.dir_to_wallmounted()`
--     * Values range 0 - 7
--     * The value denotes at which direction the node is "mounted":
--       0 = y+,   1 = y-,   2 = x+,   3 = x-,   4 = z+,   5 = z-
--       6 = y+, but rotated by  90°
--       7 = y-, but rotated by -90°
--     * By default, on placement the param2 is automatically set to the
--       appropriate rotation (0 to 5), depending on which side was
--       pointed at. With the node field `wallmounted_rotate_vertical = true`,
--       the param2 values 6 and 7 might additionally be set
-- * `paramtype2 = "facedir"`
--     * Supported drawtypes: "normal", "nodebox", "mesh"
--     * The rotation of the node is stored in `param2`.
--     * Node is rotated around face and axis; 24 rotations in total.
--     * Can be made by using `core.dir_to_facedir()`.
--     * Chests and furnaces can be rotated that way, and also 'flipped'
--     * Values range 0 - 23
--     * facedir / 4 = axis direction:
--       0 = y+,   1 = z+,   2 = z-,   3 = x+,   4 = x-,   5 = y-
--     * The node is rotated 90 degrees around the X or Z axis so that its top face
--       points in the desired direction. For the y- direction, it's rotated 180
--       degrees around the Z axis.
--     * facedir modulo 4 = left-handed rotation around the specified axis, in 90° steps.
--     * By default, on placement the param2 is automatically set to the
--       horizontal direction the player was looking at (values 0-3)
--     * Special case: If the node is a connected nodebox, the nodebox
--       will NOT rotate, only the textures will.
-- * `paramtype2 = "4dir"`
--     * Supported drawtypes: "normal", "nodebox", "mesh"
--     * The rotation of the node is stored in `param2`.
--     * Allows node to be rotated horizontally, 4 rotations in total
--     * Can be made by using `core.dir_to_fourdir()`.
--     * Chests and furnaces can be rotated that way, but not flipped
--     * Values range 0 - 3
--     * 4dir modulo 4 = rotation
--     * Otherwise, behavior is identical to facedir
-- * `paramtype2 = "leveled"`
--     * Only valid for "nodebox" with 'type = "leveled"', and "plantlike_rooted".
--         * Leveled nodebox:
--             * The level of the top face of the nodebox is stored in `param2`.
--             * The other faces are defined by 'fixed = {}' like 'type = "fixed"'
--               nodeboxes.
--             * The nodebox height is (`param2` / 64) nodes.
--             * The maximum accepted value of `param2` is 127.
--         * Rooted plantlike:
--             * The height of the 'plantlike' section is stored in `param2`.
--             * The height is (`param2` / 16) nodes.
-- * `paramtype2 = "degrotate"`
--     * Valid for `plantlike` and `mesh` drawtypes. The rotation of the node is
--       stored in `param2`.
--     * Values range 0–239. The value stored in `param2` is multiplied by 1.5 to
--       get the actual rotation in degrees of the node.
-- * `paramtype2 = "meshoptions"`
--     * Only valid for "plantlike" drawtype. `param2` encodes the shape and
--       optional modifiers of the "plant". `param2` is a bitfield.
--     * Bits 0 to 2 select the shape.
--       Use only one of the values below:
--         * 0 = an "x" shaped plant (ordinary plant)
--         * 1 = a "+" shaped plant (just rotated 45 degrees)
--         * 2 = a "*" shaped plant with 3 faces instead of 2
--         * 3 = a "#" shaped plant with 4 faces instead of 2
--         * 4 = a "#" shaped plant with 4 faces that lean outwards
--         * 5-7 are unused and reserved for future meshes.
--     * Bits 3 to 7 are used to enable any number of optional modifiers.
--       Just add the corresponding value(s) below to `param2`:
--         * 8  - Makes the plant slightly vary placement horizontally
--         * 16 - Makes the plant mesh 1.4x larger
--         * 32 - Moves each face randomly a small bit down (1/8 max)
--         * values 64 and 128 (bits 6-7) are reserved for future use.
--     * Example: `param2 = 0` selects a normal "x" shaped plant
--     * Example: `param2 = 17` selects a "+" shaped plant, 1.4x larger (1+16)
-- * `paramtype2 = "color"`
--     * `param2` tells which color is picked from the palette.
--       The palette should have 256 pixels.
-- * `paramtype2 = "colorfacedir"`
--     * Same as `facedir`, but with colors.
--     * The three most significant bits of `param2` tells which color is picked from the
--       palette. The palette should have 8 pixels.
--     * The five least significant bits contain the `facedir` value.
-- * `paramtype2 = "color4dir"`
--     * Same as `4dir`, but with colors.
--     * The six most significant bits of `param2` tells which color is picked from the
--       palette. The palette should have 64 pixels.
--     * The two least significant bits contain the `4dir` rotation.
-- * `paramtype2 = "colorwallmounted"`
--     * Same as `wallmounted`, but with colors.
--     * The five most significant bits of `param2` tells which color is picked from the
--       palette. The palette should have 32 pixels.
--     * The three least significant bits contain the `wallmounted` value.
-- * `paramtype2 = "glasslikeliquidlevel"`
--     * Only valid for "glasslike_framed" or "glasslike_framed_optional"
--       drawtypes. "glasslike_framed_optional" nodes are only affected if the
--       "Connected Glass" setting is enabled.
--     * Bits 0-5 define 64 levels of internal liquid, 0 being empty and 63 being
--       full.
--     * Bits 6 and 7 modify the appearance of the frame and node faces. One or
--       both of these values may be added to `param2`:
--         * 64  - Makes the node not connect with neighbors above or below it.
--         * 128 - Makes the node not connect with neighbors to its sides.
--     * Liquid texture is defined using `special_tiles = {"modname_tilename.png"}`
-- * `paramtype2 = "colordegrotate"`
--     * Same as `degrotate`, but with colors.
--     * The three most significant bits of `param2` tells which color is picked
--       from the palette. The palette should have 8 pixels.
--     * The five least significant bits store rotation in range 0–23 (i.e. in 15° steps)
-- * `paramtype2 = "none"`
--     * `param2` will not be used by the engine and can be used to store
--       an arbitrary value
---@field paramtype2? "flowingliquid"|"wallmounted"|"facedir"|"4dir"|"leveled"|"degrotate"|"meshoptions"|"color"|"colorfacedir"|"color4dir"|"colorwallmounted"|"glasslikeliquidlevel"|"colordegrotate"|"none"
-- place_param2 = 0,
-- Value for param2 that is set when player places node
---@field place_param2? integer
-- wallmounted_rotate_vertical = false,
-- If true, place_param2 is nil, and this is a wallmounted node,
-- this node might use the special 90° rotation when placed
-- on the floor or ceiling, depending on the direction.
-- See the explanation about wallmounted for details.
-- Otherwise, the rotation is always the same on vertical placement.
---@field wallmounted_rotate_vertical? boolean
-- is_ground_content = true,
-- If false, the cave generator and dungeon generator will not carve
-- through this node.
-- Specifically, this stops mod-added nodes being removed by caves and
-- dungeons when those generate in a neighbor mapchunk and extend out
-- beyond the edge of that mapchunk.
---@field is_ground_content? boolean
-- sunlight_propagates = false,
-- If true, sunlight will go infinitely through this node
---@field sunlight_propagates? boolean
-- walkable = true,  -- If true, objects collide with node
---@field walkable? boolean
-- pointable = true,
-- Can be `true` if it is pointable, `false` if it can be pointed through,
-- or `"blocking"` if it is pointable but not selectable.
-- Clients older than 5.9.0 interpret `pointable = "blocking"` as `pointable = true`.
-- Can be overridden by the `pointabilities` of the held item.
-- A client may be able to point non-pointable nodes, since it isn't checked server-side.
---@field pointable? boolean
-- diggable = true,  -- If false, can never be dug
---@field diggable? boolean
-- climbable = false,  -- If true, can be climbed on like a ladder
---@field climbable? boolean
-- move_resistance = 0,
-- Slows down movement of players through this node (max. 7).
-- If this is nil, it will be equal to liquid_viscosity.
-- Note: If liquid movement physics apply to the node
-- (see `liquid_move_physics`), the movement speed will also be
-- affected by the `movement_liquid_*` settings.
---@field move_resistance? number
-- buildable_to = false,  -- If true, placed nodes can replace this node
---@field buildable_to? boolean
-- floodable = false,
-- If true, liquids flow into and replace this node.
-- Warning: making a liquid node 'floodable' will cause problems.
---@field floodable? boolean
-- liquidtype = "none",  -- specifies liquid flowing physics
-- * "none":    no liquid flowing physics
-- * "source":  spawns flowing liquid nodes at all 4 sides and below;
--              recommended drawtype: "liquid".
-- * "flowing": spawned from source, spawns more flowing liquid nodes
--              around it until `liquid_range` is reached;
--              will drain out without a source;
--              recommended drawtype: "flowingliquid".
-- If it's "source" or "flowing", then the
-- `liquid_alternative_*` fields _must_ be specified
---@field liquidtype? "none"|"source"|"flowing"
-- liquid_alternative_flowing = "",
-- liquid_alternative_source = "",
-- These fields may contain node names that represent the
-- flowing version (`liquid_alternative_flowing`) and
-- source version (`liquid_alternative_source`) of a liquid.
--
-- Specifically, these fields are required if `liquidtype ~= "none"` or
-- `drawtype == "flowingliquid"`.
--
-- Liquids consist of up to two nodes: source and flowing.
--
-- There are two ways to define a liquid:
-- 1) Source node and flowing node. This requires both fields to be
--    specified for both nodes.
-- 2) Standalone source node (cannot flow). `liquid_alternative_source`
--    must be specified and `liquid_range` must be set to 0.
--
-- Example:
--     liquid_alternative_flowing = "example:water_flowing",
--     liquid_alternative_source = "example:water_source",
---@field liquid_alternative_flowing? string
---@field liquid_alternative_source? string
-- liquid_viscosity = 0,
-- Controls speed at which the liquid spreads/flows (max. 7).
-- 0 is fastest, 7 is slowest.
-- By default, this also slows down movement of players inside the node
-- (can be overridden using `move_resistance`)
---@field liquid_viscosity? number
-- liquid_renewable = true,
-- If true, a new liquid source can be created by placing two or more
-- sources nearby
---@field liquid_renewable? boolean
-- liquid_move_physics = nil, -- specifies movement physics if inside node
-- * false: No liquid movement physics apply.
-- * true: Enables liquid movement physics. Enables things like
--   ability to "swim" up/down, sinking slowly if not moving,
--   smoother speed change when falling into, etc. The `movement_liquid_*`
--   settings apply.
-- * nil: Will be treated as true if `liquidtype ~= "none"`
--   and as false otherwise.
---@field liquid_move_physics? boolean
-- air_equivalent = nil,
-- unclear meaning, the engine sets this to true for 'air' and 'ignore'
-- deprecated.
-- Unofficial note: But what else are you supposed to do? i guess make an is_air function lmao
---@field air_equivalent? boolean
-- leveled = 0,
-- Only valid for "nodebox" drawtype with 'type = "leveled"'.
-- Allows defining the nodebox height without using param2.
-- The nodebox height is 'leveled' / 64 nodes.
-- The maximum value of 'leveled' is `leveled_max`.
---@field leveled? integer
-- leveled_max = 127,
-- Maximum value for `leveled` (0-127), enforced in
-- `core.set_node_level` and `core.add_node_level`.
-- Values above 124 might causes collision detection issues.
---@field leveled_max? integer
-- liquid_range = 8,
-- Maximum distance that flowing liquid nodes can spread around
-- source on flat land;
-- maximum = 8; set to 0 to disable liquid flow
---@field liquid_range? integer
-- drowning = 0,
-- Player will take this amount of damage if no bubbles are left
---@field drowning? integer
-- damage_per_second = 0,
-- If player is inside node, this damage is caused
---@field damage_per_second? integer
-- node_box = {type = "regular"},  -- See "Node boxes"
---@field node_box? NodeBox
-- connects_to = {},
-- Used for nodebox nodes with the type == "connected".
-- Specifies to what neighboring nodes connections will be drawn.
-- e.g. `{"group:fence", "default:wood"}` or `"default:stone"`
---@field connects_to? string[]
-- connect_sides = {},
-- Tells connected nodebox nodes to connect only to these sides of this
-- node. possible: "top", "bottom", "front", "left", "back", "right"
---@field connect_sides? string[]
-- mesh = "",
-- File name of mesh when using "mesh" drawtype
-- The center of the node is the model origin.
-- For legacy reasons, this uses a different scale depending on the mesh:
-- 1. For glTF models: 10 units = 1 node (consistent with the scale for entities).
-- 2. For obj models: 1 unit = 1 node.
-- 3. For b3d and x models: 1 unit = 1 node if static, otherwise 10 units = 1 node.
-- Using static glTF or obj models is recommended.
-- You can use the `visual_scale` multiplier to achieve the expected scale.
---@field mesh? string
-- selection_box = {
-- see [Node boxes] for possibilities
-- },
-- Custom selection box definition. Multiple boxes can be defined.
-- If "nodebox" drawtype is used and selection_box is nil, then node_box
-- definition is used for the selection box.
---@field selection_box? NodeBox
-- collision_box = {
-- see [Node boxes] for possibilities
-- },
-- Custom collision box definition. Multiple boxes can be defined.
-- If "nodebox" drawtype is used and collision_box is nil, then node_box
-- definition is used for the collision box.
---@field collision_box? NodeBox
-- Support maps made in and before January 2012
---@field legacy_wallmounted? boolean
-- Support maps made in and before January 2012
---@field legacy_facedir_simple? boolean
-- waving = 0,
-- Valid for drawtypes:
-- mesh, nodebox, plantlike, allfaces_optional, liquid, flowingliquid.
-- 1 - wave node like plants (node top moves side-to-side, bottom is fixed)
-- 2 - wave node like leaves (whole node moves side-to-side)
-- 3 - wave node like liquids (whole node moves up and down)
-- Not all models will properly wave.
-- plantlike drawtype can only wave like plants.
-- allfaces_optional drawtype can only wave like leaves.
-- liquid, flowingliquid drawtypes can only wave like liquids.
---@field waving? integer
-- sounds = {
-- Definition of node sounds to be played at various events.
-- All fields in this table are optional.
--
--footstep = <SimpleSoundSpec>,
-- If walkable, played when object walks on it. If node is
-- climbable or a liquid, played when object moves through it.
-- Sound is played at the base of the object's collision-box.
-- Gain is multiplied by `0.6`.
-- For local player, it's played position-less, with normal gain.
--
--        dig = <SimpleSoundSpec> or "__group",
-- While digging node.
-- If `"__group"`, then the sound will be
-- `{name = "default_dig_<groupname>", gain = 0.5}` , where `<groupname>` is the
-- name of the item's digging group with the fastest digging time.
-- In case of a tie, one of the sounds will be played (but we
-- cannot predict which one)
-- Default value: `"__group"`
--
--        dug = <SimpleSoundSpec>,
-- Node was dug
--
--        place = <SimpleSoundSpec>,
-- Node was placed. Also played after falling
--
--        place_failed = <SimpleSoundSpec>,
-- When node placement failed.
-- Note: This happens if the _built-in_ node placement failed.
-- This sound will still be played if the node is placed in the
-- `on_place` callback manually.
--
--        fall = <SimpleSoundSpec>,
-- When node starts to fall or is detached
--    },
---@field sounds? {footstep:SimpleSoundSpec, dig:SimpleSoundSpec, dug:SimpleSoundSpec, place:SimpleSoundSpec, place_failed:SimpleSoundSpec, fall:SimpleSoundSpec}
-- drop = "",
-- Name of dropped item when dug.
-- Default dropped item is the node itself.
-- -----------------
-- Using a table allows multiple items, drop chances and item filtering:
-- drop = {
--     max_items = 1,
--     -- Maximum number of item lists to drop.
--     -- The entries in 'items' are processed in order. For each:
--     -- Item filtering is applied, chance of drop is applied, if both are
--     -- successful the entire item list is dropped.
--     -- Entry processing continues until the number of dropped item lists
--     -- equals 'max_items'.
--     -- Therefore, entries should progress from low to high drop chance.
--     items = {
--         -- Examples:
--         {
--             -- 1 in 1000 chance of dropping a diamond.
--             -- Default rarity is '1'.
--             rarity = 1000,
--             items = {"default:diamond"},
--         },
--         {
--             -- Only drop if using an item whose name is identical to one
--             -- of these.
--             tools = {"default:shovel_mese", "default:shovel_diamond"},
--             rarity = 5,
--             items = {"default:dirt"},
--             -- Whether all items in the dropped item list inherit the
--             -- hardware coloring palette color from the dug node.
--             -- Default is 'false'.
--             inherit_color = true,
--         },
--         {
--             -- Only drop if using an item whose name contains
--             -- "default:shovel_" (this item filtering by string matching
--             -- is deprecated, use tool_groups instead).
--             tools = {"~default:shovel_"},
--             rarity = 2,
--             -- The item list dropped.
--             items = {"default:sand", "default:desert_sand"},
--         },
--         {
--             -- Only drop if using an item in the "magicwand" group, or
--             -- an item that is in both the "pickaxe" and the "lucky"
--             -- groups.
--             tool_groups = {
--                 "magicwand",
--                 {"pickaxe", "lucky"}
--             },
--             items = {"default:coal_lump"},
--         },
--     },
-- },
---@field drop? string|{max_items:integer?,items:{rarity:integer?, items:string[], tools:table?, inherit_color:boolean?}[]}
-- on_construct = function(pos),
-- Node constructor; called after adding node.
-- Can set up metadata and stuff like that.
-- Not called for bulk node placement (i.e. schematics and VoxelManip).
-- Note: Within an on_construct callback, core.set_node can cause an
-- infinite loop if it invokes the same callback.
--  Consider using core.swap_node instead.
-- default: nil
---@field on_construct? fun(pos:vector):nil
-- on_destruct = function(pos),
-- Node destructor; called before removing node.
-- Not called for bulk node placement.
-- default: nil
---@field on_destruct? fun(pos:vector?):nil
-- after_destruct = function(pos, oldnode),
-- Node destructor; called after removing node.
-- Not called for bulk node placement.
-- default: nil
---@field after_destruct? fun(pos:vector, oldnode:MapNode):nil
-- on_flood = function(pos, oldnode, newnode),
-- Called when a liquid (newnode) is about to flood oldnode, if it has
-- `floodable = true` in the nodedef. Not called for bulk node placement
-- (i.e. schematics and VoxelManip) or air nodes. If return true the
-- node is not flooded, but on_flood callback will most likely be called
-- over and over again every liquid update interval.
-- Default: nil
-- Warning: making a liquid node 'floodable' will cause problems.
---@field on_flood? fun(pos:vector, oldnode:MapNode, newnode:MapNode):boolean?
-- preserve_metadata = function(pos, oldnode, oldmeta, drops),
-- Called when `oldnode` is about be converted to an item, but before the
-- node is deleted from the world or the drops are added. This is
-- generally the result of either the node being dug or an attached node
-- becoming detached.
-- * `pos`: node position
-- * `oldnode`: node table of node before it was deleted
-- * `oldmeta`: metadata of node before it was deleted, as a metadata table
-- * `drops`: a table of `ItemStack`s, so any metadata to be preserved can
--   be added directly to one or more of the dropped items. See
--   "ItemStackMetaRef".
-- default: `nil`
---@field preserve_metadata? fun(pos:vector, oldnode:MapNode, oldmeta:{fields:table<string, string>, inventory:InvTable})
-- after_place_node = function(pos, placer, itemstack, pointed_thing),
-- Called after constructing node when node was placed using
-- core.item_place_node / core.place_node.
-- If return true no item is taken from itemstack.
-- `placer` may be any valid ObjectRef or nil.
-- default: nil
---@field after_place_node? fun(pos:vector, placer:PlayerRef, itemstack:ItemStack, pointed_thing:pointed_thing):nil
-- after_dig_node = function(pos, oldnode, oldmetadata, digger),
-- Called after destructing the node when node was dug using
-- `core.node_dig` / `core.dig_node`.
-- * `pos`: node position
-- * `oldnode`: node table of node before it was dug
-- * `oldmetadata`: metadata of node before it was dug,
--                  as a metadata table
-- * `digger`: ObjectRef of digger
-- default: nil
---@field after_dig_node? fun(pos:vector, oldnode:MapNode, oldmetadata:{fields:table<string,string>, inventory:InvTable}, digger:PlayerRef):nil
-- can_dig = function(pos, [player]),
-- Returns true if node can be dug, or false if not.
-- default: nil
---@field can_dig? fun(pos:vector, player:PlayerRef?):boolean
-- on_punch = function(pos, node, puncher, pointed_thing),
-- default: core.node_punch
-- Called when puncher (an ObjectRef) punches the node at pos.
-- By default calls core.register_on_punchnode callbacks.
---@field on_punch? fun(pos:vector, node:MapNode, puncher:PlayerRef, pointed_thing:pointed_thing)
-- on_rightclick = function(pos, node, clicker, itemstack, pointed_thing),
-- default: nil
-- Called when clicker (an ObjectRef) used the 'place/build' key
-- (not necessarily an actual rightclick)
-- while pointing at the node at pos with 'node' being the node table.
-- itemstack will hold clicker's wielded item.
-- Shall return the leftover itemstack.
-- Note: pointed_thing can be nil, if a mod calls this function.
-- This function does not get triggered by clients <=0.4.16 if the
-- "formspec" node metadata field is set.
-- Unofficial note: Ah, i love the "Not triggered in these specific old unusable versions you probably cannot support even if you tried, and which servers get penaltied for supporting them"
---@field on_rightclick? fun(pos:vector, node:MapNode, clicker:PlayerRef, itemstack:ItemStack, pointed_thing:pointed_thing):ItemStack
-- on_dig = function(pos, node, digger),
-- default: core.node_dig
-- By default checks privileges, wears out item (if tool) and removes node.
-- return true if the node was dug successfully, false otherwise.
-- Deprecated: returning nil is the same as returning true.
---@field on_dig? fun(pos:vector, node:MapNode, digger:PlayerRef):boolean
-- on_timer = function(pos, elapsed),
-- default: nil
-- called by NodeTimers, see core.get_node_timer and NodeTimerRef.
-- elapsed is the total time passed since the timer was started.
-- return true to run the timer for another cycle with the same timeout
-- value.
---@field on_timer? fun(pos:vector, elapsed:number):boolean?
-- on_receive_fields = function(pos, formname, fields, sender),
-- fields = {name1 = value1, name2 = value2, ...}
-- formname should be the empty string; you **must not** use formname.
-- Called when an UI form (e.g. sign text input) returns data.
-- See core.register_on_player_receive_fields for more info.
-- default: nil
---@field on_receive_fields? fun(pos:vector, _:nil, fields: table<string, string>):nil
-- allow_metadata_inventory_move = function(pos, from_list, from_index, to_list, to_index, count, player),
-- Called when a player wants to move items inside the inventory.
-- Return value: number of items allowed to move.
---@field allow_metadata_inventory_move? fun(pos:vector, from_list:string, from_index:integer, to_list:string, to_index:integer, count:integer, player:PlayerRef):integer
-- allow_metadata_inventory_put = function(pos, listname, index, stack, player),
-- Called when a player wants to put something into the inventory.
-- Return value: number of items allowed to put.
-- Return value -1: Allow and don't modify item count in inventory.
---@field allow_metadata_inventory_put? fun(pos:vector, listname:string, index:integer, stack:ItemStack, player:PlayerRef):integer
-- allow_metadata_inventory_take = function(pos, listname, index, stack, player),
-- Called when a player wants to take something out of the inventory.
-- Return value: number of items allowed to take.
-- Return value -1: Allow and don't modify item count in inventory.
---@field allow_metadata_inventory_take? fun(pos:vector, listname:string, index:integer, stack:ItemStack, player:PlayerRef):integer
-- on_metadata_inventory_move = function(pos, from_list, from_index, to_list, to_index, count, player),
-- Called after the actual action has happened, according to what was
-- allowed.
-- No return value.
---@field on_metadata_inventory_move? fun(pos:vector, from_list:string, from_index:integer, to_list:string, to_index:integer, count:integer, player:PlayerRef):nil
-- on_metadata_inventory_put = function(pos, listname, index, stack, player),
-- Called after the actual action has happened, according to what was
-- allowed.
-- No return value.
---@field on_metadata_inventory_put? fun(pos:vector, listname:string, index:integer, stack:ItemStack, player:PlayerRef):nil
-- on_metadata_inventory_take = function(pos, listname, index, stack, player),
-- Called after the actual action has happened, according to what was
-- allowed.
-- No return value.
---@field on_metadata_inventory_take? fun(pos:vector, listname:string, index:integer, stack:ItemStack, player:PlayerRef):nil
-- on_blast = function(pos, intensity),
-- intensity: 1.0 = mid range of regular TNT.
-- If defined, called when an explosion touches the node, instead of
-- removing the node.
-- Unofficial note: this is a custom field, just documented in lua_api.md i assume because TNT mods usually don't handle indestructible nodes/whatever very well
---@field on_blast? fun(pos:vector, intensity: number?):any?
-- mod_origin = "modname",
-- stores which mod actually registered a node
-- If the source could not be determined it contains "??"
-- Useful for getting which mod truly registered something
-- example: if a node is registered as ":othermodname:nodename",
-- nodename will show "othermodname", but mod_origin will say "modname"
---@field mod_origin? string

---@param name string
---@param node_def NodeDef
function core.register_node(name, node_def) end

--- Oops, wear bar params have sneaked into this file somehow too?

-- Wear Bar Color
-- --------------
--
-- 'Wear Bar' is a property of items that defines the coloring
-- of the bar that appears under damaged tools.
-- If it is absent, the default behavior of green-yellow-red is
-- used.
--
-- ### Wear bar colors definition
--
-- #### Syntax
--
-- ```lua
-- {
--     -- 'constant' or 'linear'
--     -- (nil defaults to 'constant')
--     blend = "linear",
--     color_stops = {
--         [0.0] = "#ff0000",
--         [0.5] = "slateblue",
--         [1.0] = {r=0, g=255, b=0, a=150},
--     }
-- }
-- ```
--
-- #### Blend mode `blend`
--
-- * `linear`: blends smoothly between each defined color point.
-- * `constant`: each color starts at its defined point, and continues up to the next point
--
-- #### Color stops `color_stops`
--
-- Specified as `ColorSpec` color values assigned to `float` durability keys.
--
-- "Durability" is defined as `1 - (wear / 65535)`.
--
-- #### Shortcut usage
--
-- Wear bar color can also be specified as a single `ColorSpec` instead of a table.
---@class wear_bar_params
---@field blend "linear"|"constant"
---@field color_stops table<number, ColorSpec>

--- "This file is way too long"
--- Said who? me... oh... right... me, right i said that in my head
---
---
--- Anyway...

--- ORE DEFINITIONS

---@class OreDef
---@field name string
-- Supported: "scatter", "sheet", "puff", "blob", "vein", "stratum"
---@field ore_type "scatter"|"sheet"|"puff"|"blob"|"vein"|"stratum"
-- Ore node to place
---@field ore string
-- Param2 to set for ore (e.g. facedir rotation)
---@field ore_param2? integer
-- Node to place ore in. Multiple are possible by passing a list.
---@field wherein string[]|string
-- Ore has a 1 out of clust_scarcity chance of spawning in a node.
-- If the desired average distance between ores is 'd', set this to
-- d * d * d.
---@field clust_scarcity? number
-- Number of ores in a cluster
---@field clust_num_ores? integer
-- Size of the bounding box of the cluster.
-- In this example, there is a 3 * 3 * 3 cluster where 8 out of the 27
-- nodes are coal ore.
---@field clust_size? integer
---@field y_min? number
---@field y_max? number
-- Attributes for the ore generation, see 'Ore attributes' section above
-- Ore attributes
-- --------------
--
-- See section [Flag Specifier Format].
--
-- Currently supported flags:
-- `puff_cliffs`, `puff_additive_composition`.
--
-- ### `puff_cliffs`
--
-- If set, puff ore generation will not taper down large differences in
-- displacement when approaching the edge of a puff. This flag has no effect for
-- ore types other than `puff`.
--
-- ### `puff_additive_composition`
--
-- By default, when noise described by `np_puff_top` or `np_puff_bottom` results
-- in a negative displacement, the sub-column at that point is not generated. With
-- this attribute set, puff ore generation will instead generate the absolute
-- difference in noise displacement values. This flag has no effect for ore types
-- other than `puff`.
---@field flags? string
-- If noise is above this threshold, ore is placed. Not needed for a
-- uniform distribution.
---@field noise_threshold? number
-- NoiseParams structure describing one of the noises used for
-- ore distribution.
-- Needed by "sheet", "puff", "blob" and "vein" ores.
-- Omit from "scatter" ore for a uniform ore distribution.
-- Omit from "stratum" ore for a simple horizontal strata from y_min to
-- y_max.
---@field noise_params NoiseParams
-- List of biomes in which this ore occurs.
-- Occurs in all biomes if this is omitted, and ignored if the Mapgen
-- being used does not support biomes.
-- Can be a list of (or a single) biome names, IDs, or definitions.
---@field biomes? string[]|string
-- "sheet" type
---@field column_height_min? integer
-- "sheet" type
---@field column_height_max? integer
-- "sheet" type
---@field column_midpoint_factor? integer
-- "puff" type
---@field np_puff_top? NoiseParams
---@field np_puff_bottom? NoiseParams
-- "vein" type
---@field random_factor? number
-- "stratum"
---@field np_stratum_thickness? NoiseParams
---@field stratum_thickness? number

---@class ChatCommandDef
-- Note that in params, the conventional use of symbols is as follows:
--
-- * `<>` signifies a placeholder to be replaced when the command is used. For
--   example, when a player name is needed: `<name>`
-- * `[]` signifies param is optional and not required when the command is used.
--   For example, if you require param1 but param2 is optional:
--   `<param1> [<param2>]`
-- * `|` signifies exclusive or. The command requires one param from the options
--   provided. For example: `<param1> | <param2>`
-- * `()` signifies grouping. For example, when param1 and param2 are both
--   required, or only param3 is required: `(<param1> <param2>) | <param3>`
---@field params string
---@field description string
---@field privs table<string, boolean>
---@field func fun(name:string, param:string):boolean, string

---@class PrivDef
---@field description string
---@field give_to_singleplayer boolean
-- Whether to grant the privilege to the server admin.
-- Uses value of 'give_to_singleplayer' by default.
---@field give_to_admin? boolean
-- Note that the above two callbacks will be called twice if a player is
-- responsible, once with the player name, and then with a nil player
-- name.
-- Return true in the above callbacks to stop register_on_priv_grant or
-- revoke being called.
---@field on_grant fun(name: string, granter_name:string)
-- Note that the above two callbacks will be called twice if a player is
-- responsible, once with the player name, and then with a nil player
-- name.
-- Return true in the above callbacks to stop register_on_priv_grant or
-- revoke being called.
---@field on_revoke fun(name:string, revoker_name:string)

-- HUD Definition
-- --------------
--
-- Since most values have multiple different functions, please see the
-- documentation in [HUD] section.
--
-- Used by `ObjectRef:hud_add`. Returned by `ObjectRef:hud_get`.

--- Unofficial note: Haha the most useless section, you thought probably when reading it
--- Since there is already a detailed documentation on HUDs, this one just, yeah puts it in a more inconvenient format *for a normal reader* :) but neovim macros like this format
---@class HudDef
-- Type of element, can be "compass", "hotbar" (46 ¹), "image", "image_waypoint",
-- "inventory", "minimap" (44 ¹), "statbar", "text" or "waypoint"
-- ¹: minimal protocol version for client-side support
-- If undefined "text" will be used.
---@field type "compass"|"hotbar"|"image"|"image_waypoint"|"inventory"|"minimap"|"statbar"|"text"|"waypoint"
-- Top left corner position of element
---@field position {x:number,y:number}
---@field name string
---@field scale? {x:number,y:number}
---@field text? string
---@field text2? string peak luanti naming
---@field number? number
---@field item? number peak luanti naming
---@field direction? number
---@field alignment? {x:number, y:number}
---@field offset? {x:number, y:number}
---@field world_pos? vector
---@field size? {x:number, y:number}
---@field z_index number
---@field style? number

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
--       the eaten stack, then the remainings go to a different spot, or are dropped.
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

---@class pointed_thing
---@field type "nothing"|"node"|"object"
---@field under vector?
---@field above vector?
---@field ref ObjectRef?
--- Only raycast supports this
-- * `pointed_thing.intersection_point`: The absolute world coordinates of the
--   point on the selection box which is pointed at. May be in the selection box
--   if the pointer is in the box too.
---@field intersection_point vector?
--- Only raycast supports this
-- * `pointed_thing.box_id`: The ID of the pointed selection box (counting starts
--   from 1).
---@field box_id integer?
--- Only raycast supports this
-- * `pointed_thing.intersection_normal`: Unit vector, points outwards of the
--   selected selection box. This specifies which face is pointed at.
--   Is a null vector `vector.zero()` when the pointer is inside the selection box.
--   For entities with rotated selection boxes, this will be rotated properly
--   by the entity's rotation - it will always be in absolute world space.
---@field intersection_normal vector?
---@meta

-- * `core.request_shutdown([message],[reconnect],[delay])`: request for
--   server shutdown. Will display `message` to clients.
--     * `reconnect` == true displays a reconnect button
--     * `delay` adds an optional delay (in seconds) before shutdown.
--       Negative delay cancels the current active shutdown.
--       Zero delay triggers an immediate shutdown.
---@param message string?
---@param reconnect boolean?
---@param delay number?
function core.request_shutdown(message, reconnect, delay) end

-- * `core.cancel_shutdown_requests()`: cancel current delayed shutdown
function core.cancel_shutdown_requests() end

-- Unofficial note: This is really cool i didn't know this
-- * `core.get_server_status(name, joined)`
--     * Returns the server status string when a player joins or when the command
--       `/status` is called. Returns `nil` or an empty string when the message is
--       disabled.
--     * `joined`: Boolean value, indicates whether the function was called when
--       a player joined.
--     * This function may be overwritten by mods to customize the status message.
---@nodiscard
---@param name string
---@param joined boolean
---@return string?
function core.get_server_status(name, joined) end

-- * `core.get_server_uptime()`: returns the server uptime in seconds
---@return number
function core.get_server_uptime() end

-- * `core.get_server_max_lag()`: returns the current maximum lag
--   of the server in seconds or nil if server is not fully loaded yet
---@return number?
function core.get_server_max_lag() end

-- * `core.remove_player(name)`: remove player from database (if they are not
--   connected).
--     * As auth data is not removed, `core.player_exists` will continue to
--       return true. Call the below method as well if you want to remove auth
--       data too.
--     * Returns a code (0: successful, 1: no such player, 2: player is connected)
---@param name string
---@return 0|1|2
function core.remove_player(name) end

-- * `core.remove_player_auth(name)`: remove player authentication data
--     * Returns boolean indicating success (false if player nonexistent)
---@param name string
---@return boolean success
function core.remove_player_auth(name) end

-- * `core.dynamic_add_media(options, callback)`
--     * `options`: table containing the following parameters
--         * `filename`: name the media file will be usable as
--                       (optional if `filepath` present)
--         * `filepath`: path to the file on the filesystem [*]
--         * `filedata`: the data of the file to be sent [*]
--         * `to_player`: name of the player the media should be sent to instead of
--                        all players (optional)
--         * `ephemeral`: boolean that marks the media as ephemeral,
--                        it will not be cached on the client (optional, default false)
--         * Exactly one of the parameters marked [*] must be specified.
--     * `callback`: function with arguments `name`, which is a player name
--     * Pushes the specified media file to client(s). (details below)
--       The file must be a supported image, sound or model format.
--       Dynamically added media is not persisted between server restarts.
--     * Returns false on error, true if the request was accepted
--     * The given callback will be called for every player as soon as the
--       media is available on the client.
--     * Details/Notes:
--       * If `ephemeral`=false and `to_player` is unset the file is added to the media
--         sent to clients on startup, this means the media will appear even on
--         old clients if they rejoin the server.
--       * If `ephemeral`=false the file must not be modified, deleted, moved or
--         renamed after calling this function.
--       * Regardless of any use of `ephemeral`, adding media files with the same
--         name twice is not possible/guaranteed to work. An exception to this is the
--         use of `to_player` to send the same, already existent file to multiple
--         chosen players.
--       * You can also call this at startup time. In that case `callback` MUST
--         be `nil` and you cannot use `ephemeral` or `to_player`, as these logically
--         do not make sense.
--     * Clients will attempt to fetch files added this way via remote media,
--       this can make transfer of bigger files painless (if set up). Nevertheless
--       it is advised not to use dynamic media for big media files.
---@async
---@param options {filename: string?, filepath: string?, filedata: string?, to_player: string?, ephemeral: boolean?}
---@param callback function
function core.dynamic_add_media(options, callback) end

--- Bans
--- Though it would be a lot funnier if you just simulated infinite loading

-- * `core.get_ban_list()`: returns a list of all bans formatted as string
---@return string
function core.get_ban_list() end

-- * `core.get_ban_description(ip_or_name)`: returns list of bans matching
--   IP address or name formatted as string
---@param ip_or_name string
---@return string
function core.get_ban_description(ip_or_name) end

-- * `core.ban_player(name)`: ban the IP of a currently connected player
--     * Returns boolean indicating success
---@param name string
---@nodiscard
---@return boolean success
function core.ban_player(name) end

-- * `core.unban_player_or_ip(ip_or_name)`: remove ban record matching
--   IP address or name
---@param ip_or_name string
function core.unban_player_or_ip(ip_or_name) end

-- * `core.kick_player(name[, reason[, reconnect]])`: disconnect a player with an optional
--   reason.
--     * Returns boolean indicating success (false if player nonexistent)
--     * If `reconnect` is true, allow the user to reconnect.
---@param name string
---@param reason string?
---@param reconnect boolean?
---@nodiscard
---@return boolean success
function core.kick_player(name, reason, reconnect) end

-- * `core.disconnect_player(name[, reason[, reconnect]])`: disconnect a player with an
--   optional reason, this will not prefix with 'Kicked: ' like kick_player.
--   If no reason is given, it will default to 'Disconnected.'
--     * Returns boolean indicating success (false if player nonexistent)
---@param name string
---@param reason string?
---@param reconnect boolean?
function core.disconnect_player(name, reason, reconnect) end

--- NOW THE AUTH: Name one person who has touched any of these functions xdd
---@alias Tile string|{name:string, backface_culling:boolean?, animation: TileAnimation?, align_style: ("node"|"world"|"user")?, scale:integer}

---@class TileAnimation: table
---@field type "vertical_frames"|"sheet_2d"
---@field aspect_w integer?
---@field aspect_h integer?
---@field length number?
---@field frames_w integer?
---@field frames_h integer?
---@field frame_length number?
---@meta
---@alias textdomain string

--[[
`core.get_translator(textdomain)` is a simple wrapper around
`core.translate` and `core.translate_n`.  
After `local S, PS = core.get_translator(textdomain)`, we have
`S(str, ...)` equivalent to `core.translate(textdomain, str, ...)`, and
`PS(str, str_plural, n, ...)` to `core.translate_n(textdomain, str, str_plural, n, ...)`.  
It is intended to be used in the following way, so that it avoids verbose
repetitions of `core.translate`:

```lua
local S, PS = core.get_translator(textdomain)
S(str, ...)
```

As an extra commodity, if `textdomain` is nil, it is assumed to be "" instead.
]]
---@nodiscard
---@param textdomain textdomain|nil
---@return fun(str:string, ...:string):string S, fun(str:string, str_plural:string, n:number, ...:string):string PS
function core.get_translator(textdomain) end

--[[
* `core.translate(textdomain, str, ...)` translates the string `str` with
  the given `textdomain` for disambiguation. The textdomain must match the
  textdomain specified in the translation file in order to get the string
  translated. This can be used so that a string is translated differently in
  different contexts.
  It is advised to use the name of the mod as textdomain whenever possible, to
  avoid clashes with other mods.
  This function must be given a number of arguments equal to the number of
  arguments the translated string expects.
  Arguments are literal strings -- they will not be translated.
]]
---@nodiscard
---@param textdomain textdomain
---@param str string
---@param ... string
function core.translate(textdomain, str, ...) end

--[[
* `core.translate_n(textdomain, str, str_plural, n, ...)` translates the
  string `str` with the given `textdomain` for disambiguaion. The value of
  `n`, which must be a nonnegative integer, is used to decide whether to use
  the singular or the plural version of the string. Depending on the locale of
  the client, the choice between singular and plural might be more complicated,
  but the choice will be done automatically using the value of `n`.

  You can read https://www.gnu.org/software/gettext/manual/html_node/Plural-forms.html
  for more details on the differences of plurals between languages.

  Also note that plurals are only handled in .po or .mo files, and not in .tr files.


For instance, suppose we want to greet players when they join and provide a
command that shows the amount of time since the player joined. We can do the
following:

```lua
local S, PS = core.get_translator("hello")
core.register_on_joinplayer(function(player)
    local name = player:get_player_name()
    core.chat_send_player(name, S("Hello @1, how are you today?", name))
end)
core.register_chatcommand("playtime", {
    func = function(name)
        local last_login = core.get_auth_handler().get_auth(name).last_login
        local playtime = math.floor((last_login-os.time())/60)
        return true, PS(
            "You have been playing for @1 minute.",
            "You have been playing for @1 minutes.",
            minutes, tostring(minutes))
    end,
})

```
When someone called "CoolGuy" joins the game with an old client or a client
that does not have localization enabled, they will see `Hello CoolGuy, how are
you today?`. If they use the `/playtime` command, they will see `You have been
playing for 1 minute` or (for example) `You have been playing for 4 minutes.`

However, if we have for instance a translation file named `hello.de.po`
containing the following:

```po
msgid ""
msgstr ""
"Plural-Forms: nplurals=2; plural=(n != 1);\n"

msgid "Hello @1, how are you today?"
msgstr "Hallo @1, wie geht es dir heute?"

msgid "You have been playing for @1 minute."
msgid_plural "You have been playing for @1 minutes."
msgstr[0] "Du spielst seit @1 Minute."
msgstr[1] "Du spielst seit @1 Minuten."
```

and CoolGuy has set a German locale, they will see `Hallo CoolGuy, wie geht es
dir heute?` when they join, and the `/playtime` command will show them `Du
spielst seit 1 Minute.` or (for example) `Du spielst seit 4 Minuten.`
]]
---@nodiscard
---@param textdomain textdomain
---@param str string
---@param str_plural string
---@param n number
---@param ... string
function core.translate_n(textdomain, str, str_plural, n, ...) end
---@meta

--Unofficial note: Hover over the fields to see what they do :)

-- ### Format example
--
-- For 2D or 3D value noise or value noise maps:
--
-- ```lua
-- np_terrain = {
--     offset = 0,
--     scale = 1,
--     spread = {x = 500, y = 500, z = 500},
--     seed = 571347,
--     octaves = 5,
--     persistence = 0.63,
--     lacunarity = 2.0,
--     flags = "defaults, absvalue",
-- }
-- ```
--
-- For 2D noise the Z component of `spread` is still defined but is ignored.
-- A single noise parameter table can be used for 2D or 3D noise.
---@class NoiseParams
--[[
After the multiplication by `scale` this is added to the result and is the final
step in creating the noise value.
Can be positive or negative.
]]
---@field offset number
--Once all octaves have been combined, the result is multiplied by this.
--Can be positive or negative.
---@field scale number
-- For octave1, this is roughly the change of input value needed for a very large
-- variation in the noise value generated by octave1. It is almost like a
-- 'wavelength' for the wavy noise variation.
-- Each additional octave has a 'wavelength' that is smaller than the previous
-- octave, to create finer detail. `spread` will therefore roughly be the typical
-- size of the largest structures in the final noise variation.
--
-- `spread` is a vector with values for x, y, z to allow the noise variation to be
-- stretched or compressed in the desired axes.
-- Values are positive numbers.
---@field spread vector
-- This is a whole number that determines the entire pattern of the noise
-- variation. Altering it enables different noise patterns to be created.
-- With other parameters equal, different seeds produce different noise patterns
-- and identical seeds produce identical noise patterns.
--
-- For this parameter you can randomly choose any whole number. Usually it is
-- preferable for this to be different from other seeds, but sometimes it is useful
-- to be able to create identical noise patterns.
--
-- In some noise APIs the world seed is added to the seed specified in noise
-- parameters. This is done to make the resulting noise pattern vary in different
-- worlds, and be 'world-specific'.
---@field seed number
-- The number of simple noise generators that are combined.
-- A whole number, 1 or more.
-- Each additional octave adds finer detail to the noise but also increases the
-- noise calculation load.
-- 3 is a typical minimum for a high quality, complex and natural-looking noise
-- variation. 1 octave has a slight 'gridlike' appearance.
--
-- Choose the number of octaves according to the `spread` and `lacunarity`, and the
-- size of the finest detail you require. For example:
-- if `spread` is 512 nodes, `lacunarity` is 2.0 and finest detail required is 16
-- nodes, octaves will be 6 because the 'wavelengths' of the octaves will be
-- 512, 256, 128, 64, 32, 16 nodes.
-- Warning: If the 'wavelength' of any octave falls below 1 an error will occur.
---@field octaves integer
-- Each additional octave has an amplitude that is the amplitude of the previous
-- octave multiplied by `persistence`, to reduce the amplitude of finer details,
-- as is often helpful and natural to do so.
-- Since this controls the balance of fine detail to large-scale detail
-- `persistence` can be thought of as the 'roughness' of the noise.
--
-- A positive or negative non-zero number, often between 0.3 and 1.0.
-- A common medium value is 0.5, such that each octave has half the amplitude of
-- the previous octave.
-- This may need to be tuned when altering `lacunarity`; when doing so consider
-- that a common medium value is 1 / lacunarity.
--
-- Instead of `persistence`, the key `persist` may be used to the same effect.
---@field persistence number
-- Each additional octave has a 'wavelength' that is the 'wavelength' of the
-- previous octave multiplied by 1 / lacunarity, to create finer detail.
-- 'lacunarity' is often 2.0 so 'wavelength' often halves per octave.
--
-- A positive number no smaller than 1.0.
-- Values below 2.0 create higher quality noise at the expense of requiring more
-- octaves to cover a particular range of 'wavelengths'.
---@field lacunarity number
-- Leave this field unset for no special handling.
-- Currently supported are `defaults`, `eased` and `absvalue`:
---@field flags string?
-- Specify this if you would like to keep auto-selection of eased/not-eased while
-- specifying some other flags.
---| "defaults"
-- Maps noise gradient values onto a quintic S-curve before performing
-- interpolation. This results in smooth, rolling noise.
-- Disable this (`noeased`) for sharp-looking noise with a slightly gridded
-- appearance.
-- If no flags are specified (or defaults is), 2D noise is eased and 3D noise is
-- not eased.
-- Easing a 3D noise significantly increases the noise calculation load, so use
-- with restraint.
---| "eased"
-- The absolute value of each octave's noise variation is used when combining the
-- octaves. The final value noise variation is created as follows:
--
-- ```
-- noise = offset + scale * (abs(octave1) +
--                           abs(octave2) * persistence +
--                           abs(octave3) * persistence ^ 2 +
--                           abs(octave4) * persistence ^ 3 +
--                           ...)
-- ```
---| "absvalue"

-- * `core.get_value_noise(noiseparams)`
--     * Return world-specific value noise.
--     * The actual seed used is the noiseparams seed plus the world seed.
--     * **Important**: Requires the mapgen environment to be initalized, do not use at load time.

-- * `core.get_value_noise(noiseparams)`
--     * Return world-specific value noise.
--     * The actual seed used is the noiseparams seed plus the world seed.
--     * **Important**: Requires the mapgen environment to be initalized, do not use at load time.
---@param noiseparams NoiseParams
---@return ValueNoise
function core.get_value_noise(noiseparams) end

---@param noiseparams NoiseParams
---@return ValueNoise
function ValueNoise(noiseparams) end

---@deprecated
---@param noiseparams NoiseParams
---@return ValueNoise
function PerlinNoise(noiseparams) end

---@deprecated
---@param noiseparams NoiseParams
---@return ValueNoise
function core.get_perlin(noiseparams) end

---@param noiseparams NoiseParams
---@param size vector|{x:number,y:number}
---@return ValueNoiseMap
function core.get_value_noise_map(noiseparams, size) end

---@param noiseparams NoiseParams
---@param size vector|{x:number,y:number}
---@return ValueNoiseMap
function ValueNoiseMap(noiseparams, size) end

---@param noiseparams NoiseParams
---@param size vector|{x:number,y:number}
---@return ValueNoiseMap
function core.get_perlin_noise_map(noiseparams, size) end

---@param noiseparams NoiseParams
---@param size vector|{x:number,y:number}
---@return ValueNoiseMap
function PerlinNoiseMap(noiseparams, size) end

---@class ValueNoise
-- * `get_2d(pos)`: returns 2D noise value at `pos={x=,y=}`
---@field get_2d fun(self,pos:{x:number,y:number}):{x:number,y:number}
-- * `get_3d(pos)`: returns 3D noise value at `pos={x=,y=,z=}`
---@field get_3d fun(self,pos:vector):vector

---@class ValueNoiseMap
-- * `get_2d_map(pos)`: returns a `<size.x>` times `<size.y>` 2D array of 2D noise
--   with values starting at `pos={x=,y=}`
---@field get_2d_map fun(self,pos:{x:number,y:number}):number[][]
-- * `get_3d_map(pos)`: returns a `<size.x>` times `<size.y>` times `<size.z>`
--   3D array of 3D noise with values starting at `pos={x=,y=,z=}`.
---@field get_3d_map fun(self,pos:vector):number[][][]
-- * `get_2d_map_flat(pos, buffer)`: returns a flat `<size.x * size.y>` element
--   array of 2D noise with values starting at `pos={x=,y=}`
---@field get_2d_map_flat fun(self,pos:{x:number, y:number}, buffer:number[]?):number[]?
-- * `get_3d_map_flat(pos, buffer)`: Same as `get2dMap_flat`, but 3D noise
---@field get_3d_map_flat fun(self,pos:vector, buffer:number[]?):number[]?
-- * `calc_2d_map(pos)`: Calculates the 2d noise map starting at `pos`. The result
--   is stored internally.
---@field calc_2d_map fun(self,pos:{x:number,y:number})
-- * `calc_3d_map(pos)`: Calculates the 3d noise map starting at `pos`. The result
--   is stored internally.
---@field calc_3d_map fun(self,pos:vector)
-- * `get_map_slice(slice_offset, slice_size, buffer)`: In the form of an array,
--   returns a slice of the most recently computed noise results. The result slice
--   begins at coordinates `slice_offset` and takes a chunk of `slice_size`.
--   E.g., to grab a 2-slice high horizontal 2d plane of noise starting at buffer
--   offset `y = 20`:
--   ```lua
--   noisevals = noise:get_map_slice({y=20}, {y=2})
--   ```
--   It is important to note that `slice_offset` offset coordinates begin at 1,
--   and are relative to the starting position of the most recently calculated
--   noise.
--   To grab a single vertical column of noise starting at map coordinates
--   `x = 1023, y=1000, z = 1000`:
--   ```lua
--   noise:calc_3d_map({x=1000, y=1000, z=1000})
--   noisevals = noise:get_map_slice({x=24, z=1}, {x=1, z=1})
--   ```
---@field get_map_slice fun(slice_offset: {x:number?, y:number?, z:number?}, slice_size:{x:number?, y:number?, z:number?}, buffer: number[]?):number[]?
---@meta

--- This one was my first one and it was NOT fun i don't recomend doing this

---@class vectorlib
--[[
(Unofficial note: This is easy to miss: Manually constructed vector tables are deprecated and highly discouraged. Unofficial-er possibly-going-against-advice note: It makes sense to still manually construct tables for performance reasons)

Spatial Vectors
===============

Luanti stores 3-dimensional spatial vectors in Lua as tables of 3 coordinates,
and has a class to represent them (`vector.*`), which this chapter is about.
For details on what a spatial vectors is, please refer to Wikipedia:
https://en.wikipedia.org/wiki/Euclidean_vector.

Spatial vectors are used for various things, including, but not limited to:

* any 3D spatial vector (x/y/z-directions)
* Euler angles (pitch/yaw/roll in radians) (Spatial vectors have no real semantic
  meaning here. Therefore, most vector operations make no sense in this use case.)

Note that they are *not* used for:

* n-dimensional vectors where n is not 3 (ie. n=2)
* arrays of the form `{num, num, num}`

The API documentation may refer to spatial vectors, as produced by `vector.new`,
by any of the following notations:

* `(x, y, z)` (Used rarely, and only if it's clear that it's a vector.)
* `vector.new(x, y, z)`
* `{x=num, y=num, z=num}` (Even here you are still supposed to use `vector.new`.)


Compatibility notes
-------------------

Vectors used to be defined as tables of the form `{x = num, y = num, z = num}`.
Since version 5.5.0, vectors additionally have a metatable to enable easier use.
Note: Those old-style vectors can still be found in old mod code. Hence, mod and
engine APIs still need to be able to cope with them in many places.

Manually constructed tables are deprecated and highly discouraged. This interface
should be used to ensure seamless compatibility between mods and the Luanti API.
This is especially important to callback function parameters and functions overwritten
by mods.
Also, though not likely, the internal implementation of a vector might change in
the future.
In your own code, or if you define your own API, you can, of course, still use
other representations of vectors.

Vectors provided by API functions will provide an instance of this class if not
stated otherwise. Mods should adapt this for convenience reasons.

Special properties of the class
-------------------------------

Vectors can be indexed with numbers and allow method and operator syntax.

All these forms of addressing a vector `v` are valid:
`v[1]`, `v[3]`, `v.x`, `v[1] = 42`, `v.y = 13`
Note: Prefer letter over number indexing for performance and compatibility reasons.

Where `v` is a vector and `foo` stands for any function name, `v:foo(...)` does
the same as `vector.foo(v, ...)`, apart from deprecated functionality.

`tostring` is defined for vectors, see `vector.to_string`.

The metatable that is used for vectors can be accessed via `vector.metatable`.
Do not modify it!

All `vector.*` functions allow vectors `{x = X, y = Y, z = Z}` without metatables.
Returned vectors always have a metatable set.
]]
vector = {}

-- Unofficial notes:
-- Please treat vectors like they are immutable as much as you can, unless for performance reasons, in that case get rid of that metatable
-- Example:
--[[
local x_coords = {}
local y_coords = {}
local z_coords = {}

local vec_t = {}

....

vec_t.x = x_coords[n]
vec_t.y = y_coords[n]
vec_t.z = z_coords[n]

This will probably drastically reduce on garbage collector use, as vectors are HORRIBLE for it
]]
---@class vector: vectorlib
---@field x number
---@field y number
---@field z number
----@field protected [number] number you know... i don't know how to make this deprecated, so i'm just not going to include it in here, you should NOT!! index vectors like that
---@operator unm(vector):vector
---@operator add(vector):vector
---@operator sub(vector):vector
---@operator div(vector):vector
---@operator mul(vector):vector

--- Returns a new vector `(a, b, c)`
---@nodiscard
---@param a number
---@param b number?
---@param c number?
---@return vector
function vector.new(a, b, c) end

--- `vector.new(v)` does the same as `vector.copy(v)`
---@deprecated
---@nodiscard
---@param a vector
---@return vector
function vector.new(a) end

--- `vector.new()` does the same as `vector.zero()`
---@deprecated
---@nodiscard
---@return vector
function vector.new() end

--- Returns a new vector `(0, 0, 0)`
---@nodiscard
---@return vector
function vector.zero() end

--- Returns a new vector of length 1, pointing into a direction chosen uniformly at random.
---@nodiscard
---@return vector
function vector.random_direction() end

--- Returns a copy of the vector `v`.
---@param v vector
---@return vector
---@nodiscard
function vector.copy(v) end

--[[
Returns v, np, where v is a vector read from the given string s and np is the next position in the string after the vector.
Returns nil on failure.
]]
---@nodiscard
---@param s string Has to begin with a substring of the form `"(x, y, z)"`. Additional spaces, leaving away commas, and adding an additional comma to the end is allowed.
---@param init number? Starts looking for the vector at this string index
---@return vector? v, number? np
function vector.from_string(s, init) end

--- Returns a string of the form `"(x, y, z)"`
--- `tostring(v)` does the same
---@nodiscard
---@param v vector
---@return string
function vector.to_string(v) end

--[[
Returns a vector of length 1 with direction p1 to p2.
If p1 and p2 are identical, returns (0, 0, 0).
]]
---@nodiscard
---@param p1 vector
---@param p2 vector
---@return vector
function vector.direction(p1, p2) end

--[[
Returns zero or a positive number, the distance between p1 and p2.
]]
---@nodiscard
---@param p1 vector
---@param p2 vector
---@return number
function vector.distance(p1, p2) end

-- Returns zero or a positive number, the length of vector v.
---@nodiscard
---@param v vector
---@return number
function vector.length(v) end

-- Returns a vector of length 1 with direction of vector v.
-- If v has zero length, returns (0, 0, 0).
---@param v vector
---@return vector
---@nodiscard
function vector.normalize(v) end

---@param v vector
---@return vector
---@nodiscard
---Returns a vector, each dimension rounded down.
function vector.floor(v) end

---@param v vector
---@return vector
---@nodiscard
---Returns a vector, each dimension rounded up.
function vector.ceil(v) end

---@param v vector
---@return vector
---@nodiscard
---Returns a vector, each dimension rounded to the nearest integer.
--- At a multiple of 0.5, rounds away from zero.
function vector.round(v) end

--- Returns a vector where `math.sign` was called for each component
---@return vector
---@nodiscard
---@param v vector
---@param tolerance number?
function vector.sign(v, tolerance) end

-- You know, at this point, just direct the user to use `vector.apply` OMG

--- Returns a vector with absolute values for each component
---@param v vector
---@return vector
---@nodiscard
function vector.abs(v) end

--- Applies `func` to each component
---@nodiscard
---@param v vector
---@param func fun(n: number): number
---@param ... any Optional arguments passed to `func`
---@return vector
function vector.apply(v, func, ...) end

--- Returns a vector where the function `func` has combined both components of `v` and `w` for each component
---@nodiscard
---@param v vector
---@param w vector
---@param func fun(x:number, y:number):number
---@return vector
function vector.combine(v, w, func) end

--- Returns true if the vectors are identical, false if not
---@param v1 vector
---@param v2 vector
---@nodiscard
---@return boolean
function vector.equals(v1, v2) end

--- Returns in order minp, maxp vectors of the cuboid defined by v1, v2.
--- (Unofficial note: In other words, the first vector that gets returned will be smaller than the second, yknow it sorts them)
---@param v1 vector
---@param v2 vector
---@nodiscard
---@return vector, vector
function vector.sort(v1, v2) end

--- Returns the angle between v1 and v2 in radians
---@nodiscard
---@return number # in radians
---@param v1 vector
---@param v2 vector
function vector.angle(v1, v2) end

-- Returns the dot product
---@nodiscard
---@return number
---@param v1 vector
---@param v2 vector
function vector.dot(v1, v2) end

-- Returns the cross product
---@nodiscard
---@return vector
---@param v1 vector
---@param v2 vector
function vector.cross(v1, v2) end

--- Returns the sum of vectors `v` and `(x,y,z)`
---@return vector
---@nodiscard
---@param v vector
---@param x number
---@param y number
---@param z number
function vector.offset(v, x, y, z) end

--- Checks if `v` is a vector, returns false even for tables like {x=,y=,z=}, has to be created with a vector function
---@param v vector
---@nodiscard
---@return boolean
function vector.check(v) end

--- Checks if `pos` is inside an area formed by `min` and `max`
--- `min` and `max` are inclusive
--- If min is bigger than max on some axis, function always returns false.
--- You can use vector.sort if you have two vectors and don't know which are the minimum and the maximum.
---@nodiscard
---@param pos vector
---@param min vector
---@param max vector
---@return boolean
function vector.in_area(pos, min, max) end

--[[
Returns a random integer position in area formed by min and max
min and max are inclusive.
You can use vector.sort if you have two vectors and don't know which are the minimum and the maximum.
]]
---@nodiscard
---@return vector
---@param min vector
---@param max vector
function vector.random_in_area(min, max) end

-- FINALLY, that was a LOT

---@nodiscard
---@param v vector
---@param x vector|number
---@return vector
function vector.add(v, x) end

---@nodiscard
---@param v vector
---@param x vector|number
---@return vector
function vector.subtract(v, x) end

---@nodiscard
---@param v vector
---@param x number
---@return vector
function vector.multiply(v, x) end

---@nodiscard
---@param v vector
---@param x number
---@return vector
function vector.divide(v, x) end

---@deprecated
---@class vector.Schur
---@field x vector
---@field y vector
---@field z vector

--- Unofficial note: Haha i know you did this and were confused
--- Anyway, this returns the schur product
---@deprecated
---@nodiscard
---@param v vector
---@param x vector
---@return vector.Schur
function vector.multiply(v, x) end

--- Unofficial note: Haha i know you did this and were confused
--- Anyway, this returns the schur quotient
---@deprecated
---@nodiscard
---@param v vector
---@param x vector
---@return vector.Schur
function vector.divide(v, x) end

--[[
Applies the rotation r to v and returns the result.
vector.rotate(vector.new(0, 0, 1), r) and vector.rotate(vector.new(0, 1, 0), r) return vectors pointing forward and up relative to an entity's rotation r.
]]
---@nodiscard
---@param v vector
---@param r vector Rotation vector {x=<pitch>, y=<yaw>, z=<roll>}
---@return vector
function vector.rotate(v, r) end

--- Returns v1 rotated around axis v2 by a radians according to the right hand rule.
---@nodiscard
---@param v1 vector
---@param v2 vector
---@param a number radians
---@return vector
function vector.rotate_around_axis(v1, v2, a) end

--[[
Returns a rotation vector for direction pointing forward using up as the up vector.
If up is omitted, the roll of the returned vector defaults to zero.
Otherwise direction and up need to be vectors in a 90 degree angle to each other.
]]
---@nodiscard
---@param up vector?
---@param direction vector
---@return vector
function vector.dir_to_rotation(direction, up) end
---@meta

--- Offtopic but what a cool name

--- Anyway i lied we are doing Content IDs here

--- HACK:
---@type content_id
core.CONTENT_UNKNOWN = core.CONTENT_UNKNOWN
---@type content_id
core.CONTENT_AIR = core.CONTENT_AIR
---@type content_id
core.CONTENT_IGNORE = core.CONTENT_IGNORE

--[[
Unofficial note: Building the next worldedit eh?

About VoxelManip
----------------

VoxelManip is a scripting interface to the internal 'Map Voxel Manipulator'
facility. The purpose of this object is for fast, low-level, bulk access to
reading and writing Map content. As such, setting map nodes through VoxelManip
will lack many of the higher level features and concepts you may be used to
with other methods of setting nodes. For example, nodes will not have their
construction and destruction callbacks run, and no rollback information is
logged.

It is important to note that VoxelManip is designed for speed, and *not* ease
of use or flexibility. If your mod requires a map manipulation facility that
will handle 100% of all edge cases, or the use of high level node placement
features, perhaps `core.set_node()` is better suited for the job.

In addition, VoxelManip might not be faster, or could even be slower, for your
specific use case. VoxelManip is most effective when setting large areas of map
at once - for example, if only setting a 3x3x3 node area, a
`core.set_node()` loop may be more optimal. Always profile code using both
methods of map manipulation to determine which is most appropriate for your
usage.

A recent simple test of setting cubic areas showed that `core.set_node()`
is faster than a VoxelManip for a 3x3x3 node cube or smaller.
]]
---@class VoxelManip
VoxelManip = {}

---@nodiscard
---@param p1 vector?
---@param p2 vector?
---@return VoxelManip
function VoxelManip(p1, p2) end

---@nodiscard
---@param p1 vector?
---@param p2 vector?
---@return VoxelManip
function core.get_voxel_manip(p1, p2) end

--[[
* `read_from_map(p1, p2)`: Loads a part of the map into the VoxelManip object
  containing the region formed by `p1` and `p2`.
    * returns actual emerged `pmin`, actual emerged `pmax` (MapBlock-aligned)
    * Note that calling this multiple times will *add* to the area loaded in the
      VoxelManip, and not reset it.
]]
---@param p1 vector
---@param p2 vector
---@return vector pmin, vector pmax
function VoxelManip:read_from_map(p1, p2) end

--[[
* `initialize(p1, p2, [node])`: Clears and resizes the VoxelManip object to
  comprise the region formed by `p1` and `p2`.
   * **No data** is read from the map, so you can use this to treat `VoxelManip`
     objects as general containers of node data.
   * `node`: if present the data will be filled with this node; if not it will
     be uninitialized
   * returns actual emerged `pmin`, actual emerged `pmax` (MapBlock-aligned)
   * (introduced in 5.13.0)
]]
---@param p1 vector
---@param p2 vector
---@param node MapNodeOpt
---@return vector pmin, vector pmax
function VoxelManip:initialize(p1, p2, node) end

--[[
Unofficial note: If you can, try to not use this function for performance reasons (there is no alternative, but you can avoid using it by checking if vmanip data was modified, if yes then use it)

* `write_to_map([light])`: Writes the data loaded from the `VoxelManip` back to
  the map.
    * **important**: you should call `set_data()` before this, or nothing will change.
    * if `light` is true, then lighting is automatically recalculated.
      The default value is true.
      If `light` is false, no light calculations happen, and you should correct
      all modified blocks with `core.fix_light()` as soon as possible.
      Keep in mind that modifying the map where light is incorrect can cause
      more lighting bugs.
]]
---@param light boolean?
---@return nil
function VoxelManip:write_to_map(light) end

-- Unofficial note: i don't think you should be using this for performance reasons, this is a function i would personally NEVER use
---@nodiscard
---@param pos vector
---@return MapNode
function VoxelManip:get_node_at(pos) end

-- Unofficial note: i don't think you should be using this for performance reasons, this is a function i would personally NEVER use
---@nodiscard
---@param pos vector
---@param node MapNodeOpt
---@return nil
function VoxelManip:set_node_at(pos, node) end

--- Retrieves the node content data loaded into the `VoxelManip` object, the `data` table will be used to store the result
---@param data content_id[]
---@return nil
function VoxelManip:get_data(data) end

--- Retrieves the node content data loaded into the `VoxelManip` object and returns it
--- Unofficial note: I would recomend doing VoxelManip.get_data(data) instead, as this form will make the garbage collector scream, in a way that you can't profile very well
---@nodiscard
---@return content_id[]
function VoxelManip:get_data() end

---@param data content_id[]
---@return nil
function VoxelManip:set_data(data) end

--- Unofficial note: In need of a noop? Instead of depending on modlib to do it, how about using this pre-made function baked into the luanti api, written most likely in C for super fast noops
--- Does nothing, kept for compatibility.
---@deprecated
function VoxelManip:update_map() end

--[[
* `set_lighting(light, [p1, p2])`: Set the lighting within the `VoxelManip` to
  a uniform value.
    * `light` is a table, `{day=<0...15>, night=<0...15>}`
    * To be used only by a `VoxelManip` object from
      `core.get_mapgen_object`.
    * (`p1`, `p2`) is the area in which lighting is set, defaults to the whole
      area if left out.
]]
---@param light light
---@param p1 vector?
---@param p2 vector?
function VoxelManip:set_lighting(light, p1, p2) end

--[[
* `get_light_data([buffer])`: Gets the light data read into the
  `VoxelManip` object
    * Returns an array (indices 1 to volume) of integers ranging from `0` to
      `255`.
    * Each value is the bitwise combination of day and night light values
      (`0` to `15` each).
    * `light = day + (night * 16)`
    * If the param `buffer` is present, this table will be used to store the
      result instead.
]]
---@param buffer light_level[]?
---@return light_level[]?
function VoxelManip:get_light_data(buffer) end

--[[
* `set_light_data(light_data)`: Sets the `param1` (light) contents of each node
  in the `VoxelManip`.
    * expects lighting data in the same format that `get_light_data()` returns
]]
---@param light_data light_level[]
function VoxelManip:set_light_data(light_data) end

---@param buffer number[]?
---@return number[]?
function VoxelManip:get_param2_data(buffer) end

---@param param2_data number[]
---@return nil
function VoxelManip:set_param2_data(param2_data) end

--[[
* `calc_lighting([p1, p2], [propagate_shadow])`:  Calculate lighting within the
  `VoxelManip`.
    * To be used only with a `VoxelManip` object from `core.get_mapgen_object`.
    * (`p1`, `p2`) is the area in which lighting is set, defaults to the whole
      area if left out or nil. For almost all uses these should be left out
      or nil to use the default.
    * `propagate_shadow` is an optional boolean deciding whether shadows in a
      generated mapchunk above are propagated down into the mapchunk, defaults
      to `true` if left out.
]]
---@param p1 vector?
---@param p2 vector?
---@param propagate_shadow boolean?
---@return boolean
function VoxelManip:calc_lighting(p1, p2, propagate_shadow) end

---@return nil
function VoxelManip:update_liquids() end

--[[
* `was_modified()`: Returns `true` if the data in the VoxelManip has been modified
   since it was last read from the map. This means you have to call `get_data()` again.
   This only applies to a `VoxelManip` object from `core.get_mapgen_object`,
   where the engine will keep the map and the VM in sync automatically.
   * Note: this doesn't do what you think it does and is subject to removal. Don't use it!
]]
---@deprecated
function VoxelManip:was_modified() end

--* `get_emerged_area()`: Returns actual emerged minimum and maximum positions.
-- * "Emerged" does not imply that this region was actually loaded from the map,
--    if `initialize()` has been used.
---@return vector emin, vector emax
function VoxelManip:get_emerged_area() end

-- * `close()`: Frees the data buffers associated with the VoxelManip object.
--    It will become empty.
--    * Since Lua's garbage collector is not aware of the potentially significant
--      memory behind a VoxelManip, frequent VoxelManip usage can cause the server to
--      run out of RAM. Therefore it's recommend to call this method once you're done
--      with the VoxelManip.
--    * (introduced in 5.13.0)
---@return nil
function VoxelManip:close() end

--- I lied again, VoxelAreas are here in this file too

---@class VoxelArea
VoxelArea = {}

---@nodiscard
---@param pmin vector
---@param pmax vector
---@return VoxelArea
function VoxelArea(pmin, pmax) end

---@nodiscard
---@param arg {MinEdge:vector, MaxEdge:vector}
---@return VoxelArea
function VoxelArea:new(arg) end

---@nodiscard
---@return vector
function VoxelArea:getExtent() end

---@nodiscard
---@return vector
function VoxelArea:getVolume() end

--[[
* `index(x, y, z)`: returns the index of an absolute position in a flat array
  starting at `1`.
    * `x`, `y` and `z` must be integers to avoid an incorrect index result.
    * The position (x, y, z) is not checked for being inside the area volume,
      being outside can cause an incorrect index result.
    * Useful for things like `VoxelManip`, raw Schematic specifiers,
      `ValueNoiseMap:get2d`/`3dMap`, and so on.
]]
---@nodiscard
---@param x number
---@param y number
---@param z number
---@return number
function VoxelArea:index(x, y, z) end

--[[
* `indexp(p)`: same functionality as `index(x, y, z)` but takes a vector.
    * As with `index(x, y, z)`, the components of `p` must be integers, and `p`
      is not checked for being inside the area volume.
    ]]
---@nodiscard
---@param p vector
---@return number
function VoxelArea:indexp(p) end

-- * `position(i)`: returns the absolute position vector corresponding to index
--   `i`.
---@param i number
---@return vector
function VoxelArea:position(i) end

---@nodiscard
---@param x number
---@param y number
---@param z number
---@return boolean
function VoxelArea:contains(x, y, z) end

---@nodiscard
---@param p vector
---@return boolean
function VoxelArea:containsp(p) end

---@nodiscard
---@param i number
---@return boolean
function VoxelArea:containsi(i) end

---@nodiscard
---@param minx number
---@param miny number
---@param minz number
---@param maxx number
---@param maxy number
---@param maxz number
---@return function
function iter(minx, miny, minz, maxx, maxy, maxz) end

---@nodiscard
---@param minp vector
---@param maxp vector
---@return function
function iterp(minp, maxp) end
