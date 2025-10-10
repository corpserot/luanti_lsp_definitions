---@meta _
-- Miscellaneous. No cohesive grouping
-- luanti/doc/lua_api.md: Definition tables > Bit Library

--[[
Called on uncaught errors to transform error objects into string to display.

By default this is a backtrace from `debug.traceback`. Error object is first
converted with `tostring` if it's not a string. This means that you can use
tables as error objects so long as you give them `__tostring` metamethods.

* @overrideable
* @see [luanti/doc/lua_api.md >> Error Handling](https://github.com/luanti-org/luanti/blob/5.14.0/doc/lua_api.md#error-handling)
* @see [luanti/builtin/init.lua](https://github.com/luanti-org/luanti/blob/5.14.0/builtin/init.lua)
]]
---@nodiscard
---@param err any
---@param level int *>=0*
---@return string
function core.error_handler(err, level) end

--[[
Path separator

* @deprecated 5.X Recommended to use the forward slash `/` instead
* @see [luanti/src/script/cpp_api/s_base.cpp](https://github.com/luanti-org/luanti/blob/5.14.0/src/script/cpp_api/s_base.cpp)
]]
---@deprecated
---@type "/"|"\\"
DIR_DELIM = nil

--[[
Luanti provids the bitop library. Avoid using this unless you really need bit
manipulation as it's not faster than JIT traced arithmetic operations.

* @see [luanti/doc/lua_api.md >> Bit Library](https://github.com/luanti-org/luanti/blob/5.14.0/doc/lua_api.md#bit-library)
* @see <http://bitop.luajit.org/>
* @see [luanti/lib/bitop/](https://github.com/luanti-org/luanti/blob/5.14.0/lib/bitop/)
]]
---@type bitlib
bit = bit

--[[
Passing floats are unspecified and may break.
]]
---@alias int number

--[[
Full absolute path to a file or directory.
]]
---@alias core.Path string

--[[
Partial path or filename corresponding to a file within the current mod.
]]
---@alias core.ModAsset string

--[[
Serializable types
]]
---@alias core.Serializable nil|boolean|number|string|table

--[[
Helper type: `T` or a list of `T`
]]
---@alias OneOrMany<T> T | T[]

--[[
Helper type: accepts a sparse list of `T` with holes
]]
---@alias SparseList<T> {[int]:T}|T[]