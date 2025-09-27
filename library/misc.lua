---@meta _
-- DRAFT 1 DONE
-- lua_api.md: Definition tables > Bit Library

--[[
When an error occurs that is not caught, Luanti calls the function
`core.error_handler` with the error object as its first argument. The second
argument is the stack level where the error occurred. The return value is the
error string that should be shown. By default this is a backtrace from
`debug.traceback`. If the error object is not a string, it is first converted
with `tostring` before being displayed. This means that you can use tables as
error objects so long as you give them `__tostring` metamethods.

You can override `core.error_handler`. You should call the previous handler
with the correct stack level in your implementation.
]]
---@nodiscard
---@param err any
---@param level integer
---@return string
function core.error_handler(err, level) end

--[[
WIPDOC
]]
---@deprecated
---@type "/"|"\\"
DIR_DELIM = nil

--[[
WIPDOC
]]
---@type bitlib
bit = bit

--[[
WIPDOC
]]
---@alias core.Path string

--[[
WIPDOC
]]
---@alias core.ModAsset string

--[[
WIPDOC
]]
---@alias core.Serializable nil|boolean|number|string|table

--[[
WIPDOC
]]
---@generic T
---@alias OneOrMany T|T[]

--[[
WIPDOC
]]
---@generic T
---@alias SparseList {[integer]:T}|T[]