---@meta _
-- Constructors for 3D vector class
-- luanti/doc/lua_api.md: Spatial Vectors

---@class core.VectorLib
local vector = {}

--[[
Returns a new vector `(a, b, c)`.

* @see [luanti/doc/lua_api.md > Spatial Vectors](https://github.com/luanti-org/luanti/blob/5.13.0/doc/lua_api.md#spatial-vectors)
* @see [luanti/builtin/common/vector.lua](https://github.com/luanti-org/luanti/blob/5.13.0/builtin/common/vector.lua)
]]
---@nodiscard
---@param x integer
---@param y integer
---@param z integer
---@return ivec
function vector.new(x, y, z) end

--[[
Returns a new vector `(a, b, c)`.

* @see [luanti/doc/lua_api.md > Spatial Vectors](https://github.com/luanti-org/luanti/blob/5.13.0/doc/lua_api.md#spatial-vectors)
* @see [luanti/builtin/common/vector.lua](https://github.com/luanti-org/luanti/blob/5.13.0/builtin/common/vector.lua)
]]
---@nodiscard
---@param x number
---@param y number
---@param z number
---@return vec
function vector.new(x, y, z) end

--[[
Returns a copy of given vector.

* @deprecated 5.X
* @see [luanti/doc/lua_api.md > Spatial Vectors](https://github.com/luanti-org/luanti/blob/5.13.0/doc/lua_api.md#spatial-vectors)
* @see [luanti/builtin/common/vector.lua](https://github.com/luanti-org/luanti/blob/5.13.0/builtin/common/vector.lua)
]]
---@deprecated
---@nodiscard
---@param v ivector
---@return ivec
function vector.new(v) end

--[[
Returns a copy of given vector.

* @deprecated 5.X
* @see [luanti/doc/lua_api.md > Spatial Vectors](https://github.com/luanti-org/luanti/blob/5.13.0/doc/lua_api.md#spatial-vectors)
* @see [luanti/builtin/common/vector.lua](https://github.com/luanti-org/luanti/blob/5.13.0/builtin/common/vector.lua)
]]
---@deprecated
---@nodiscard
---@param v fvector
---@return vec
function vector.new(v) end

--[[
Returns a new vector `(0, 0, 0)`

* @deprecated 5.X
* @see [luanti/doc/lua_api.md > Spatial Vectors](https://github.com/luanti-org/luanti/blob/5.13.0/doc/lua_api.md#spatial-vectors)
* @see [luanti/builtin/common/vector.lua](https://github.com/luanti-org/luanti/blob/5.13.0/builtin/common/vector.lua)
]]
---@deprecated
---@nodiscard
---@return ivec
function vector.new() end