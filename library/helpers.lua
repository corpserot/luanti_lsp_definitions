---@meta _
-- DRAFT 1 DONE
-- lua_api.md: Helper functions

-- NOTE: core.* helpers are moved to library/core/utilities/helpers.lua

--[[
Makes `obj` human-readable, handles reference loops
]]
---@param obj any
---@param name string?
---@param dumped table?
---@return string
function dump2(obj, name, dumped) end

--[[
WIPDOC
]]
---@param value any
---@param indent string?
---@return string
function dump(value, indent) end

-- ---------------------------------- math ---------------------------------- --

--[[
WIPDOC
]]
---@nodiscard
---@param x number
---@param y number
---@return number
function math.hypot(x, y) end

--[[
WIPDOC
]]
---@nodiscard
---@param x number
---@param tolerance number?
---@return -1|0|1
function math.sign(x, tolerance) end

--[[
WIPDOC
]]
---@nodiscard
---@param x number
---@return number
function math.factorial(x) end

--[[
WIPDOC
]]
---@nodiscard
---@param x number
---@return integer
function math.round(x) end

-- --------------------------------- string --------------------------------- --

--[[
WIPDOC
]]
---@nodiscard
---@param str string
---@param separator string?
---@param include_empty boolean?
---@param max_splits integer?
---@param sep_is_pattern boolean?
---@return string[]
function string.split(str, separator, include_empty, max_splits, sep_is_pattern) end

--[[
WIPDOC
]]
---@nodiscard
---@param str string
---@return string
function string.trim(str) end

-- ---------------------------------- table --------------------------------- --

--[[
WIPDOC
]]
---@nodiscard
---@generic T : table
---@param table `T`
---@return T
function table.copy(table) end

--[[
WIPDOC
]]
---@nodiscard
---@generic T : table
---@param table `T`
---@return T
function table.copy_with_metatables(table) end

--[[
If it's not found it will return -1, list must not have negative indices and any non-numerical indices are ignored
]]
---@nodiscard
---@param val any
---@param list any[]
---@return integer
function table.indexof(list, val) end

--[[
WIPDOC
]]
---@nodiscard
---@param table table
---@param val any
---@return any
function table.keyof(table, val) end

--[[
WIPDOC
]]
---@param table table
---@param other_table table
function table.insert_all(table, other_table) end

--[[
WIPDOC
]]
---@nodiscard
---@param t table
---@return table
function table.key_value_swap(t) end

--[[
WIPDOC
]]
---@alias table.random_func fun(int1:integer, int2:integer): integer

--[[
WIPDOC
]]
---@param table table
---@param from integer?
---@param to integer?
---@param random_func table.random_func?
function table.shuffle(table, from, to, random_func) end