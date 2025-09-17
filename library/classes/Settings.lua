---@meta _
-- DRAFT 1 WIP
-- lua_api.md: Class reference > `Settings`

-- ------------------------------- constructor ------------------------------ --

--[[
WIPDOC
]]
---@param filename string
---@return core.Settings
function Settings(filename) end

-- -------------------------------- Settings -------------------------------- --

--[[
### Format

The settings have the format `key = value`. Example:

    foo = example text
    bar = """
    Multiline
    value
    """
]]
---@class core.Settings
Settings = {}

--[[
WIPDOC
]]
---@type core.Settings
core.settings = nil

--[[
* `get(key)`: returns a value
    * Returns `nil` if `key` is not found.
]]
---@nodiscard
---@param key string
---@return any
function Settings:get(key) end

--[[
* `get_bool(key, [default])`: returns a boolean
    * `default` is the value returned if `key` is not found.
    * Returns `nil` if `key` is not found and `default` not specified.
]]
---@param key string
---@param fundefault any
---@return any?
function Settings:get_bool(key, fundefault) end

--[[
* `get_np_group(key)`: returns a NoiseParams table
    * Returns `nil` if `key` is not found.
]]
---@param key string
---@return core.NoiseParams
function Settings:get_np_group(key) end

--[[
* `get_flags(key)`:
    * Returns `{flag = true/false, ...}` according to the set flags.
    * Is currently limited to mapgen flags `mg_flags` and mapgen-specific
      flags like `mgv5_spflags`.
    * Returns `nil` if `key` is not found.
]]
---@param key string
---@return table<string, boolean>
function Settings:get_flags(key) end

--[[
* `get_pos(key)`:
    * Returns a `vector`
    * Returns `nil` if no value is found or parsing failed.
]]
---@param key string
---@return vector?
function Settings:get_pos(key) end

--[[
* `set(key, value)`
    * Setting names can't contain whitespace or any of `="{}#`.
    * Setting values can't contain the sequence `\n"""`.
    * Setting names starting with "secure." can't be set on the main settings
      object (`core.settings`).
]]
---@param key string
---@param value any
function Settings:set(key, value) end

--[[
* `set_bool(key, value)`
    * See documentation for `set()` above.
]]
---@param key string
---@param value boolean
function Settings:set_bool(key, value) end

--[[
* `set_np_group(key, value)`
    * `value` is a NoiseParams table.
    * Also, see documentation for `set()` above.
]]
---@param key string
---@param value core.NoiseParams
function Settings:set_np_group(key, value) end

--[[
* `set_pos(key, value)`
    * `value` is a `vector`.
    * Also, see documentation for `set()` above.
]]
---@param key string
---@param value vector
function Settings:set_pos(key, value) end

--[[
* `remove(key)`: returns a boolean (`true` for success
]]
---@param key boolean
---@return boolean
function Settings:remove(key) end

--[[
* `get_names()`: returns `{key1,...}`
]]
---@return string[]
function Settings:get_names() end

--[[
* `has(key)`:
    * Returns a boolean indicating whether `key` exists.
    * In contrast to the various getter functions, `has()` doesn't consider
      any default values.
    * This means that on the main settings object (`core.settings`),
      `get(key)` might return a value even if `has(key)` returns `false`.
]]
---@param key string
---@return boolean
function Settings:has(key) end

--[[
* `write()`: returns a boolean (`true` for success
    * Writes changes to file.
]]
---@return boolean
function Settings:write() end

-- TODO we can be more precise with the value since we know all types allowed in settingstype.txt/minetest.conf
--[[
* `to_table()`: returns `{[key1]=value1,...}`
]]
---@return table<string, any>
function Settings:to_table() end
