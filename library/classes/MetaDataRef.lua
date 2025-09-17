---@meta _
-- DRAFT 1 DONE
-- lua_api.md: Class reference > `MetaDataRef`

-- ----------------------------- metadata tables ---------------------------- --

--[[
WIPDOC
]]
---@class core.MetaDataTable
--[[
WIPDOC
]]
---@field fields table<string, string>


-- ------------------------------- MetaDataRef ------------------------------ --

--[[
will return the value associated with key `k`. There is a low recursion limit.
]]
---@class core.MetaDataRef
local MetaDataRef = {}

--[[
* `contains(key)`: Returns true if key present, otherwise false.
    * Returns `nil` when the MetaData is inexistent.
]]
---@param key string
---@return boolean?
function MetaDataRef:contains(key) end

--[[
* `get(key)`: Returns `nil` if key not present, else the stored string.
]]
---@param key string
---@return string?
function MetaDataRef:get(key) end

--[[
* `set_string(key, value)`: Value of `""` will delete the key.
]]
---@param key string
---@param value string
function MetaDataRef:set_string(key, value) end

--[[
* `get_string(key)`: Returns `""` if key not present.
]]
---@param key string
---@return string
function MetaDataRef:get_string(key) end

--[[
* `set_int(key, value)`
    * The range for the value is system-dependent (usually 32 bits).
      The value will be converted into a string when stored.
]]
---@param key string
---@param value integer
function MetaDataRef:set_int(key, value) end

--[[
* `get_int(key)`: Returns `0` if key not present.
]]
---@param key string
---@return integer
function MetaDataRef:get_int(key) end

--[[
* `set_float(key, value)`
    * Store a number (a 64-bit float) exactly.
    * The value will be converted into a string when stored.
]]
---@param key string
---@param value number
function MetaDataRef:set_float(key, value) end

--[[
WIPDOC
]]
---@param key string
---@return number
function MetaDataRef:get_float(key) end

--[[
WIPDOC
]]
---@return string[]
function MetaDataRef:get_keys() end

--[[
WIPDOC
]]
---@param data core.MetaDataTable?
---@return boolean?
function MetaDataRef:from_table(data) end

--[[
WIPDOC
]]
---@return core.MetaDataTable
function MetaDataRef:to_table() end
