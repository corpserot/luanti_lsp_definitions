---@meta _
-- DRAFT 1 DONE
-- lua_api.md: 'core' namespace reference > Utilities

--[[
WIPDOC
]]
---@class FeatureFlags
core.features = {}

--[[
0.4.7
]]
---@type   boolean?
core.features.glasslike_framed = nil

--[[
0.4.7
]]
---@type   boolean?
core.features.nodebox_as_selectionbox = nil

--[[
0.4.7
]]
---@type   boolean?
core.features.get_all_craft_recipes_works = nil

--[[
The transparency channel of textures can optionally be used on
nodes (0.4.7)
]]
---@type   boolean?
core.features.use_texture_alpha = nil

--[[
Tree and grass ABMs are no longer done from C++ (0.4.8)
]]
---@type   boolean?
core.features.no_legacy_abms = nil

--[[
Texture grouping is possible using parentheses (0.4.11)
]]
---@type   boolean?
core.features.texture_names_parens = nil

--[[
Unique Area ID for AreaStoreinsert_area (0.4.14)
]]
---@type   boolean?
core.features.area_store_custom_ids = nil

--[[
add_entity supports passing initial staticdata to on_activate
-- (0.4.16)
]]
---@type   boolean?
core.features.add_entity_with_staticdata = nil

--[[
Chat messages are no longer predicted (0.4.16)
]]
---@type   boolean?
core.features.no_chat_message_prediction = nil

--[[
The transparency channel of textures can optionally be used on
objects (ie players and lua entities) (5.0.0)
]]
---@type   boolean?
core.features.object_use_texture_alpha = nil

--[[
Object selectionbox is settable independently from collisionbox
(5.0.0)
]]
---@type   boolean?
core.features.object_independent_selectionbox = nil

--[[
SpeeldQcifies whether binary data can be uploaded or downloaded using
the HTTP API (5.1.0)
]]
---@type   boolean?
core.features.httpfetch_binary_data = nil

--[[
Whether formspec_version[<version>] may be used (5.1.0)
]]
---@type   boolean?
core.features.formspec_version_element = nil

--[[
Whether AreaStore's IDs are kept on save/load (5.1.0)
]]
---@type   boolean?
core.features.area_store_persistent_ids = nil

--[[
Whether core.find_path is functional (5.2.0)
]]
---@type   boolean?
core.features.pathfinder_works = nil

--[[
Whether Collision info is available to an objects' on_step (5.3.0)
]]
---@type   boolean?
core.features.object_step_has_moveresult = nil

--[[
Whether get_velocity() and add_velocity() can be used on players (5.4.0)
]]
---@type   boolean?
core.features.direct_velocity_on_players = nil

--[[
nodedef's use_texture_alpha accepts new string modes (5.4.0)
]]
---@type   boolean?
core.features.use_texture_alpha_string_modes = nil

--[[
degrotate param2 rotates in units of 1.5° instead of 2°
thus changing the range of values from 0-179 to 0-240 (5.5.0)
]]
---@type   boolean?
core.features.degrotate_240_steps = nil

--[[
ABM supports min_y and max_y fields in definition (5.5.0)
]]
---@type   boolean?
core.features.abm_min_max_y = nil

--[[
dynamic_add_media supports passing a table with options (5.5.0)
]]
---@type   boolean?
core.features.dynamic_add_media_table = nil

--[[
particlespawners support texpools and animation of properties,
particle textures support smooth fade and scale animations, and
sprite-sheet particle animations can by synced to the lifetime
of individual particles (5.6.0)
]]
---@type   boolean?
core.features.particlespawner_tweenable = nil

--[[
allows get_sky to return a table instead of separate values (5.6.0)
]]
---@type   boolean?
core.features.get_sky_as_table = nil

--[[
VoxelManipget_light_data accepts an optional buffer argument (5.7.0)
]]
---@type   boolean?
core.features.get_light_data_buffer = nil

--[[
When using a mod storage backend that is not "files" or "dummy",
the amount of data in mod storage is not constrained by
the amount of RAM available. (5.7.0)
]]
---@type   boolean?
core.features.mod_storage_on_disk = nil

--[[
"zstd" method for compress/decompress (5.7.0)
]]
---@type   boolean?
core.features.compress_zstd = nil

--[[
Sound parameter tables support start_time (5.8.0)
]]
---@type   boolean?
core.features.sound_params_start_time = nil

--[[
New fields for set_physics_override speed_climb, speed_crouch,
liquid_fluidity, liquid_fluidity_smooth, liquid_sink,
acceleration_default, acceleration_air (5.8.0)
]]
---@type   boolean?
core.features.physics_overrides_v2 = nil

--[[
In HUD definitions the field `type` is used and `hud_elem_type` is deprecated (5.9.0)
]]
---@type   boolean?
core.features.hud_def_type_field = nil

--[[
PseudoRandom and PcgRandom state is restorable
PseudoRandom has get_state method
PcgRandom has get_state and set_state methods (5.9.0)
]]
---@type   boolean?
core.features.random_state_restore = nil

--[[
core.after guarantees that coexisting jobs are executed primarily
in order of expiry and secondarily in order of registration (5.9.0)
]]
---@type   boolean?
core.features.after_order_expiry_registration = nil

--[[
wallmounted nodes mounted at floor or ceiling may additionally
be rotated by 90° with special param2 values (5.9.0)
]]
---@type   boolean?
core.features.wallmounted_rotate = nil

--[[
Availability of the `pointabilities` property in the item definition (5.9.0)
]]
---@type   boolean?
core.features.item_specific_pointabilities = nil

--[[
Nodes `pointable` property can be `"blocking"` (5.9.0)
]]
---@type   boolean?
core.features.blocking_pointability_type = nil

--[[
dynamic_add_media can be called at startup when leaving callback as `nil` (5.9.0)
]]
---@type   boolean?
core.features.dynamic_add_media_startup = nil

--[[
dynamic_add_media supports `filename` and `filedata` parameters (5.9.0)
]]
---@type   boolean?
core.features.dynamic_add_media_filepath = nil

--[[
L-system decoration type (5.9.0)
]]
---@type   boolean?
core.features.lsystem_decoration_type = nil

--[[
Overridable pointing range using the itemstack meta key `"range"` (5.9.0)
]]
---@type   boolean?
core.features.item_meta_range = nil

--[[
Allow passing an optional "actor" ObjectRef to the following functions
core.place_node, core.dig_node, core.punch_node (5.9.0)
]]
---@type   boolean?
core.features.node_interaction_actor = nil

--[[
"new_pos" field in entity moveresult (5.9.0)
]]
---@type   boolean?
core.features.moveresult_new_pos = nil

--[[
Allow removing definition fields in `core.override_item` (5.9.0)
]]
---@type   boolean?
core.features.override_item_remove_fields = nil

--[[
The predefined hotbar is a Lua HUD element of type `hotbar` (5.10.0)
]]
---@type   boolean?
core.features.hotbar_hud_element = nil

--[[
Bulk LBM support (5.10.0)
]]
---@type   boolean?
core.features.bulk_lbms = nil

--[[
ABM supports field without_neighbors (5.10.0)
]]
---@type   boolean?
core.features.abm_without_neighbors = nil

--[[
biomes have a weight parameter (5.11.0)
]]
---@type   boolean?
core.features.biome_weights = nil

--[[
Particles can specify a "clip" blend mode (5.11.0)
]]
---@type   boolean?
core.features.particle_blend_clip = nil

--[[
The `match_meta` optional parameter is available for `InvRefremove_item()` (5.12.0)
]]
---@type   boolean?
core.features.remove_item_match_meta = nil

--[[
The HTTP API supports the HEAD and PATCH methods (5.12.0)
]]
---@type   boolean?
core.features.httpfetch_additional_methods = nil