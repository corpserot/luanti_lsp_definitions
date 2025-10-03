---@meta _
-- 3D vector class
-- luanti/doc/lua_api.md: Spatial Vectors

---@class _.vec.__base : core.VectorLib
--[[
Metatable used by the 3D vector class.

* @added 5.5.0
* @see [luanti/doc/lua_api.md > Spatial Vectors](https://github.com/luanti-org/luanti/blob/5.13.0/doc/lua_api.md#spatial-vectors)
* @see [luanti/builtin/common/vector.lua](https://github.com/luanti-org/luanti/blob/5.13.0/builtin/common/vector.lua)
]]
---@field metatable core.VectorLib
--[[
Returns a new vector from inverting the sign of each component.

* @see [luanti/doc/lua_api.md > Spatial Vectors](https://github.com/luanti-org/luanti/blob/5.13.0/doc/lua_api.md#spatial-vectors)
* @see [luanti/builtin/common/vector.lua](https://github.com/luanti-org/luanti/blob/5.13.0/builtin/common/vector.lua)
]]
---@operator unm():vec
--[[
Returns a new vector from summing vectors.

* @see [luanti/doc/lua_api.md > Spatial Vectors](https://github.com/luanti-org/luanti/blob/5.13.0/doc/lua_api.md#spatial-vectors)
* @see [luanti/builtin/common/vector.lua](https://github.com/luanti-org/luanti/blob/5.13.0/builtin/common/vector.lua)
]]
---@operator add(vector):vec
--[[
Returns a new vector from difference of vectors.

* @see [luanti/doc/lua_api.md > Spatial Vectors](https://github.com/luanti-org/luanti/blob/5.13.0/doc/lua_api.md#spatial-vectors)
* @see [luanti/builtin/common/vector.lua](https://github.com/luanti-org/luanti/blob/5.13.0/builtin/common/vector.lua)
]]
---@operator sub(vector):vec
--[[
Returns a new vector from scaling vector by given number.
Operand position can be reversed.

* @see [luanti/doc/lua_api.md > Spatial Vectors](https://github.com/luanti-org/luanti/blob/5.13.0/doc/lua_api.md#spatial-vectors)
* @see [luanti/builtin/common/vector.lua](https://github.com/luanti-org/luanti/blob/5.13.0/builtin/common/vector.lua)
]]
---@operator mul(number):vec
--[[
Returns a new vector from scaling vector by reciprocal of given number.
Operand position can be reversed.

* @see [luanti/doc/lua_api.md > Spatial Vectors](https://github.com/luanti-org/luanti/blob/5.13.0/doc/lua_api.md#spatial-vectors)
* @see [luanti/builtin/common/vector.lua](https://github.com/luanti-org/luanti/blob/5.13.0/builtin/common/vector.lua)
]]
---@operator div(number):vec

--[[
3D integer vector class instance

* @added 5.5.0
* @see [luanti/doc/lua_api.md > Spatial Vectors](https://github.com/luanti-org/luanti/blob/5.13.0/doc/lua_api.md#spatial-vectors)
* @see [luanti/builtin/common/vector.lua](https://github.com/luanti-org/luanti/blob/5.13.0/builtin/common/vector.lua)
]]
---@class ivec: ivec3.xyz, _.vec.__base
--[[
Not recommended as it is accessed and modified through `__index` and
`__newindex` functions resulting in more work than using xyz.

* @added 5.5.0
* @see [luanti/doc/lua_api.md > Spatial Vectors](https://github.com/luanti-org/luanti/blob/5.13.0/doc/lua_api.md#spatial-vectors)
* @see [luanti/builtin/common/vector.lua](https://github.com/luanti-org/luanti/blob/5.13.0/builtin/common/vector.lua)
]]
---@field [1] integer
--[[
Not recommended as it is accessed and modified through `__index` and
`__newindex` functions resulting in more work than using xyz.

* @added 5.5.0
* @see [luanti/doc/lua_api.md > Spatial Vectors](https://github.com/luanti-org/luanti/blob/5.13.0/doc/lua_api.md#spatial-vectors)
* @see [luanti/builtin/common/vector.lua](https://github.com/luanti-org/luanti/blob/5.13.0/builtin/common/vector.lua)
]]
---@field [2] integer
--[[
Not recommended as it is accessed and modified through `__index` and
`__newindex` functions resulting in more work than using xyz.

* @added 5.5.0
* @see [luanti/doc/lua_api.md > Spatial Vectors](https://github.com/luanti-org/luanti/blob/5.13.0/doc/lua_api.md#spatial-vectors)
* @see [luanti/builtin/common/vector.lua](https://github.com/luanti-org/luanti/blob/5.13.0/builtin/common/vector.lua)
]]
---@field [3] integer

--[[
3D vector class instance

* @added 5.5.0
* @see [luanti/doc/lua_api.md > Spatial Vectors](https://github.com/luanti-org/luanti/blob/5.13.0/doc/lua_api.md#spatial-vectors)
* @see [luanti/builtin/common/vector.lua](https://github.com/luanti-org/luanti/blob/5.13.0/builtin/common/vector.lua)
]]
---@class vec: vec3.xyz, _.vec.__base
--[[
Not recommended as it is accessed and modified through `__index` and
`__newindex` functions resulting in more work than using xyz.

* @added 5.5.0
* @see [luanti/doc/lua_api.md > Spatial Vectors](https://github.com/luanti-org/luanti/blob/5.13.0/doc/lua_api.md#spatial-vectors)
* @see [luanti/builtin/common/vector.lua](https://github.com/luanti-org/luanti/blob/5.13.0/builtin/common/vector.lua)
]]
---@field [1] number
--[[
Not recommended as it is accessed and modified through `__index` and
`__newindex` functions resulting in more work than using xyz.

* @added 5.5.0
* @see [luanti/doc/lua_api.md > Spatial Vectors](https://github.com/luanti-org/luanti/blob/5.13.0/doc/lua_api.md#spatial-vectors)
* @see [luanti/builtin/common/vector.lua](https://github.com/luanti-org/luanti/blob/5.13.0/builtin/common/vector.lua)
]]
---@field [2] number
--[[
Not recommended as it is accessed and modified through `__index` and
`__newindex` functions resulting in more work than using xyz.

* @added 5.5.0
* @see [luanti/doc/lua_api.md > Spatial Vectors](https://github.com/luanti-org/luanti/blob/5.13.0/doc/lua_api.md#spatial-vectors)
* @see [luanti/builtin/common/vector.lua](https://github.com/luanti-org/luanti/blob/5.13.0/builtin/common/vector.lua)
]]
---@field [3] number

--[[
3D integer vector with xyz components. It is either a plain vector or vector
class instance.

* @see [luanti/doc/lua_api.md > Spatial Vectors](https://github.com/luanti-org/luanti/blob/5.13.0/doc/lua_api.md#spatial-vectors)
* @see [luanti/builtin/common/vector.lua](https://github.com/luanti-org/luanti/blob/5.13.0/builtin/common/vector.lua)
]]
---@alias ivector
--- | ivec3.xyz
--- | ivec

--[[
3D vector with xyz components. It is either a plain vector or vector class
instance.

* @see [luanti/doc/lua_api.md > Spatial Vectors](https://github.com/luanti-org/luanti/blob/5.13.0/doc/lua_api.md#spatial-vectors)
* @see [luanti/builtin/common/vector.lua](https://github.com/luanti-org/luanti/blob/5.13.0/builtin/common/vector.lua)
]]
---@alias vector
--- | vec3.xyz
--- | vec