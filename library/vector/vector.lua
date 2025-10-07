---@meta _
-- 3D vector class
-- luanti/doc/lua_api.md: Spatial Vectors

--[[
3D integer vector class instance

* @added 5.5.0
* @see [luanti/doc/lua_api.md > Spatial Vectors](https://github.com/luanti-org/luanti/blob/5.13.0/doc/lua_api.md#spatial-vectors)
* @see [luanti/builtin/common/vector.lua](https://github.com/luanti-org/luanti/blob/5.13.0/builtin/common/vector.lua)
]]
---@class ivec: ivec3.xyz, core.VectorLib
---@operator unm:ivec
---@operator add(ivector):ivec
---@operator add(vector):vec
---@operator sub(ivector):ivec
---@operator sub(vector):vec
---@operator mul(integer):ivec
---@operator mul(number):vec
---@operator div(number):vec
--[[
Metatable used by the 3D integer vector class.

* @added 5.5.0
* @see [luanti/doc/lua_api.md > Spatial Vectors](https://github.com/luanti-org/luanti/blob/5.13.0/doc/lua_api.md#spatial-vectors)
* @see [luanti/builtin/common/vector.lua](https://github.com/luanti-org/luanti/blob/5.13.0/builtin/common/vector.lua)
]]
---@field metatable core.VectorLib
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
---@class vec: vec3.xyz, core.VectorLib
---@operator unm:vec
---@operator add(vector):vec
---@operator sub(vector):vec
---@operator mul(number):vec
---@operator div(number):vec
--[[
Metatable used by the 3D vector class.

* @added 5.5.0
* @see [luanti/doc/lua_api.md > Spatial Vectors](https://github.com/luanti-org/luanti/blob/5.13.0/doc/lua_api.md#spatial-vectors)
* @see [luanti/builtin/common/vector.lua](https://github.com/luanti-org/luanti/blob/5.13.0/builtin/common/vector.lua)
]]
---@field metatable core.VectorLib
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
---@alias ivector ivec3.xyz | ivec

--[[
3D float vector with xyz components. It is either a plain vector or vector class
instance.

* @see [luanti/doc/lua_api.md > Spatial Vectors](https://github.com/luanti-org/luanti/blob/5.13.0/doc/lua_api.md#spatial-vectors)
* @see [luanti/builtin/common/vector.lua](https://github.com/luanti-org/luanti/blob/5.13.0/builtin/common/vector.lua)
]]
---@alias fvector vec3.xyz | vec

--[[
3D vector with xyz components. It is either a plain vector or vector class
instance.

* @see [luanti/doc/lua_api.md > Spatial Vectors](https://github.com/luanti-org/luanti/blob/5.13.0/doc/lua_api.md#spatial-vectors)
* @see [luanti/builtin/common/vector.lua](https://github.com/luanti-org/luanti/blob/5.13.0/builtin/common/vector.lua)
]]
---@alias vector ivector | fvector

--[[
3D integer vector with xyz components. It is either a plain vector or vector
class instance. Passing floats are unspecified.

* @see [luanti/doc/lua_api.md > Spatial Vectors](https://github.com/luanti-org/luanti/blob/5.13.0/doc/lua_api.md#spatial-vectors)
* @see [luanti/builtin/common/vector.lua](https://github.com/luanti-org/luanti/blob/5.13.0/builtin/common/vector.lua)
]]
---@alias ivector.soft vector