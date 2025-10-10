---@meta _
-- DRAFT 1 DONE
-- luanti/doc/lua_api.md: 'core' namespace reference > Environment access

-- ------------------------------ MapgenParams ------------------------------ --

--[[
WIPDOC
]]
---@class core.MapgenSettings.mapgen_param
--[[
WIPDOC
]]
---@field mgname core.LuantiSettings.enums.mg_name
--[[
WIPDOC
]]
---@field seed string
--[[
WIPDOC
]]
---@field chunksize string
--[[
WIPDOC
]]
---@field water_level string
--[[
WIPDOC
]]
---@field flags core.LuantiSettings.flags

--[[
WIPDOC
]]
---@alias core.MapgenSetting.keys.integer
--- | _.LuantiSettings.mapgen.keys.integer
--- | "seed"
--- | "chunksize"

--[[
WIPDOC
]]
---@alias core.MapgenSetting.keys.number
--- | _.LuantiSettings.mapgen.keys.number

--[[
WIPDOC
]]
---@alias core.MapgenSetting.keys.noise_params.3d
--- | _.LuantiSettings.mapgen.keys.noise_params.3d

--[[
WIPDOC
]]
---@alias core.MapgenSetting.keys.noise_params.2d
--- | _.LuantiSettings.mapgen.keys.noise_params.2d

--[[
WIPDOC
]]
---@alias core.MapgenSetting.keys
--- | _.LuantiSettings.mapgen.keys

-- ---------------------------- core.* functions ---------------------------- --

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
---@deprecated
---@nodiscard
---@return core.MapgenSettings.mapgen_param
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
---@deprecated
---@param MapgenParams core.MapgenSettings.mapgen_param
function core.set_mapgen_params(MapgenParams) end

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
---@nodiscard
---@param name core.MapgenSetting.keys.integer
---@return string
function core.get_mapgen_setting(name) end

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
---@nodiscard
---@param name core.MapgenSetting.keys.number
---@return string|number
function core.get_mapgen_setting(name) end

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
---@nodiscard
---@param name core.MapgenSetting.keys
---@return string
function core.get_mapgen_setting(name) end

--[[
* `core.get_mapgen_setting_noiseparams(name)`
    * Same as above, but returns the value as a NoiseParams table if the
      setting `name` exists and is a valid NoiseParams.
]]
---@nodiscard
---@param name core.MapgenSetting.keys.noise_params.3d
---@return core.NoiseParams.3d?
function core.get_mapgen_setting_noiseparams(name) end

--[[
* `core.get_mapgen_setting_noiseparams(name)`
    * Same as above, but returns the value as a NoiseParams table if the
      setting `name` exists and is a valid NoiseParams.
]]
---@nodiscard
---@param name core.MapgenSetting.keys.noise_params.2d
---@return core.NoiseParams.2d?
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
---@deprecated
---@param name core.MapgenSetting.keys.integer
---@param value int
---@param override_meta boolean?
function core.set_mapgen_setting(name, value, override_meta) end

--[[
* `core.set_mapgen_setting(name, value, [override_meta])`
    * Sets a mapgen param to `value`, and will take effect if the corresponding
      mapgen setting is not already present in map_meta.txt.
    * `override_meta` is an optional boolean (default: `false`). If this is set
      to true, the setting will become the active setting regardless of the map
      metafile contents.
    * Note: to set the seed, use `"seed"`, not `"fixed_map_seed"`.
]]
---@deprecated
---@param name core.MapgenSetting.keys.number
---@param value number
---@param override_meta boolean?
function core.set_mapgen_setting(name, value, override_meta) end

--[[
* `core.set_mapgen_setting(name, value, [override_meta])`
    * Sets a mapgen param to `value`, and will take effect if the corresponding
      mapgen setting is not already present in map_meta.txt.
    * `override_meta` is an optional boolean (default: `false`). If this is set
      to true, the setting will become the active setting regardless of the map
      metafile contents.
    * Note: to set the seed, use `"seed"`, not `"fixed_map_seed"`.
]]
---@param name core.MapgenSetting.keys
---@param value string
---@param override_meta boolean?
function core.set_mapgen_setting(name, value, override_meta) end

--[[
* `core.set_mapgen_setting_noiseparams(name, value, [override_meta])`
    * Same as above, except value is a NoiseParams table.
]]
---@param name core.MapgenSetting.keys.noise_params.3d
---@param value core.NoiseParams.3d
---@param override_meta boolean?
function core.set_mapgen_setting_noiseparams(name, value, override_meta) end

--[[
* `core.set_mapgen_setting_noiseparams(name, value, [override_meta])`
    * Same as above, except value is a NoiseParams table.
]]
---@param name core.MapgenSetting.keys.noise_params.2d
---@param value core.NoiseParams.2d
---@param override_meta boolean?
function core.set_mapgen_setting_noiseparams(name, value, override_meta) end