---@meta _
-- 3D vector class, along with 2D and 3D plain vectors
-- luanti/doc/lua_api.md: Spatial Vectors

-- ---------------------------------- vec2 ---------------------------------- --

--[[
2D plain vector with xy components.
]]
---@alias vec2 {x:number, y:number}

--[[
2D plain integer vector with xy components. Passing floats are unspecified and may break.
]]
---@alias ivec2 vec2

-- ---------------------------------- vec3 ---------------------------------- --

--[[
3D plain vector with xyz components.
]]
---@alias vec3 {x:number, y:number, z:number}

--[[
3D integer plain vector with xyz components. Passing floats are unspecified and may break
]]
---@alias ivec3 vec3

-- ----------------------------------- vec ---------------------------------- --

--[[
3D vector class instance

* @added 5.5.0
* @see [luanti/doc/lua_api.md > Spatial Vectors](https://github.com/luanti-org/luanti/blob/5.13.0/doc/lua_api.md#spatial-vectors)
* @see [luanti/builtin/common/vector.lua](https://github.com/luanti-org/luanti/blob/5.13.0/builtin/common/vector.lua)
]]
---@class vec: core.VectorLib
---@operator unm:vec
---@operator add(vector):vec
---@operator sub(vector):vec
---@operator mul(number):vec
---@operator div(number):vec
---@field x number
---@field y number
---@field z number
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
3D vector class instance

* @added 5.5.0
* @see [luanti/doc/lua_api.md > Spatial Vectors](https://github.com/luanti-org/luanti/blob/5.13.0/doc/lua_api.md#spatial-vectors)
* @see [luanti/builtin/common/vector.lua](https://github.com/luanti-org/luanti/blob/5.13.0/builtin/common/vector.lua)
]]
---@alias ivec vec

--[[
3D vector with xyz components. It is either a plain vector or vector class
instance.

* @see [luanti/doc/lua_api.md > Spatial Vectors](https://github.com/luanti-org/luanti/blob/5.13.0/doc/lua_api.md#spatial-vectors)
* @see [luanti/builtin/common/vector.lua](https://github.com/luanti-org/luanti/blob/5.13.0/builtin/common/vector.lua)
]]
---@alias vector vec | vec3

--[[
3D integer vector with xyz components. It is either a plain vector or vector
class instance. Passing floats are unspecified and may break.

* @see [luanti/doc/lua_api.md > Spatial Vectors](https://github.com/luanti-org/luanti/blob/5.13.0/doc/lua_api.md#spatial-vectors)
* @see [luanti/builtin/common/vector.lua](https://github.com/luanti-org/luanti/blob/5.13.0/builtin/common/vector.lua)
]]
---@alias ivector vector