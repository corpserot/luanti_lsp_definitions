---@meta _
-- 3D vector class and library
-- luanti/doc/lua_api.md: Spatial Vectors

--[[
3D vector class library
]]
---@class core.VectorLib
vector = {}

-- ------------------------------ constructors ------------------------------ --

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
---@param v vector
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
---@return vec
function vector.new() end

--[[
Returns a new vector `(0, 0, 0)`

* @see [luanti/doc/lua_api.md > Spatial Vectors](https://github.com/luanti-org/luanti/blob/5.13.0/doc/lua_api.md#spatial-vectors)
* @see [luanti/builtin/common/vector.lua](https://github.com/luanti-org/luanti/blob/5.13.0/builtin/common/vector.lua)
]]
---@nodiscard
---@return vec
function vector.zero() end

--[[
Returns a new length 1 vector, pointing at a uniformly random direction.

* @see [luanti/doc/lua_api.md > Spatial Vectors](https://github.com/luanti-org/luanti/blob/5.13.0/doc/lua_api.md#spatial-vectors)
* @see [luanti/builtin/common/vector.lua](https://github.com/luanti-org/luanti/blob/5.13.0/builtin/common/vector.lua)
]]
---@nodiscard
---@return vec
function vector.random_direction() end

--[[
Returns a copy of the given vector

* @see [luanti/doc/lua_api.md > Spatial Vectors](https://github.com/luanti-org/luanti/blob/5.13.0/doc/lua_api.md#spatial-vectors)
* @see [luanti/builtin/common/vector.lua](https://github.com/luanti-org/luanti/blob/5.13.0/builtin/common/vector.lua)
]]
---@nodiscard
---@param v vector
---@return vec
function vector.copy(v) end

-- ---------------------------- string conversion --------------------------- --

--[[
Reads the format `"(x, y, z)"` from the start of given string to return:
- `v`: vector read from given string.
- `np`: next position after the vector.
Returns `nil` on failure.

Format may have less or more spaces, less commas, or an extra comma at the end.

* @see [luanti/doc/lua_api.md > Spatial Vectors](https://github.com/luanti-org/luanti/blob/5.13.0/doc/lua_api.md#spatial-vectors)
* @see [luanti/builtin/common/vector.lua](https://github.com/luanti-org/luanti/blob/5.13.0/builtin/common/vector.lua)
]]
---@nodiscard
---@param s string
---@param init int? #@default(`1`) *[1,`#s`]*
---@return vec? v, int? np
function vector.from_string(s, init) end

--[[
Returns vector in the string format `"(x, y, z)"`.

* @see [`tostring()`](lua://tostring) does the same
* @see [luanti/doc/lua_api.md > Spatial Vectors](https://github.com/luanti-org/luanti/blob/5.13.0/doc/lua_api.md#spatial-vectors)
* @see [luanti/builtin/common/vector.lua](https://github.com/luanti-org/luanti/blob/5.13.0/builtin/common/vector.lua)
]]
---@nodiscard
---@param v vector
---@return string
function vector.to_string(v) end

-- -------------------------------------------------------------------------- --

--[[
Returns a new length 1 vector following direction from `p1` to `p2`.
If `p1` and `p2` are identical, returns `(0, 0, 0)`.

* @see [luanti/doc/lua_api.md > Spatial Vectors](https://github.com/luanti-org/luanti/blob/5.13.0/doc/lua_api.md#spatial-vectors)
* @see [luanti/builtin/common/vector.lua](https://github.com/luanti-org/luanti/blob/5.13.0/builtin/common/vector.lua)
]]
---@nodiscard
---@param p1 vector
---@param p2 vector
---@return vec
function vector.direction(p1, p2) end

--[[
Returns distance between `p1` and `p2`.

* @see [luanti/doc/lua_api.md > Spatial Vectors](https://github.com/luanti-org/luanti/blob/5.13.0/doc/lua_api.md#spatial-vectors)
* @see [luanti/builtin/common/vector.lua](https://github.com/luanti-org/luanti/blob/5.13.0/builtin/common/vector.lua)
]]
---@nodiscard
---@param p1 vector
---@param p2 vector
---@return number *>=0*
function vector.distance(p1, p2) end

--[[
Returns length of `v`.

* @see [luanti/doc/lua_api.md > Spatial Vectors](https://github.com/luanti-org/luanti/blob/5.13.0/doc/lua_api.md#spatial-vectors)
* @see [luanti/builtin/common/vector.lua](https://github.com/luanti-org/luanti/blob/5.13.0/builtin/common/vector.lua)
]]
---@nodiscard
---@param v vector
---@return number *>=0*
function vector.length(v) end

--[[
Returns a new length 1 vector following direction of `v`.
If `v` has zero length, returns `(0, 0, 0)`.

* @see [luanti/doc/lua_api.md > Spatial Vectors](https://github.com/luanti-org/luanti/blob/5.13.0/doc/lua_api.md#spatial-vectors)
* @see [luanti/builtin/common/vector.lua](https://github.com/luanti-org/luanti/blob/5.13.0/builtin/common/vector.lua)
]]
---@nodiscard
---@param v vector
---@return vec
function vector.normalize(v) end

-- -------------------------- rounding and signness ------------------------- --

--[[
Returns a new vector with each component from `v` rounded down.

* @see [luanti/doc/lua_api.md > Spatial Vectors](https://github.com/luanti-org/luanti/blob/5.13.0/doc/lua_api.md#spatial-vectors)
* @see [luanti/builtin/common/vector.lua](https://github.com/luanti-org/luanti/blob/5.13.0/builtin/common/vector.lua)
]]
---@nodiscard
---@param v vector
---@return ivec
function vector.floor(v) end

--[[
Returns a new vector with each component from `v` rounded up.

* @see [luanti/doc/lua_api.md > Spatial Vectors](https://github.com/luanti-org/luanti/blob/5.13.0/doc/lua_api.md#spatial-vectors)
* @see [luanti/builtin/common/vector.lua](https://github.com/luanti-org/luanti/blob/5.13.0/builtin/common/vector.lua)
]]
---@nodiscard
---@param v vector
---@return ivec
function vector.ceil(v) end

--[[
Returns a new vector with each component from `v` rounded to the nearest integer.
At a multiple of 0.5, rounds away from zero.

* @see [luanti/doc/lua_api.md > Spatial Vectors](https://github.com/luanti-org/luanti/blob/5.13.0/doc/lua_api.md#spatial-vectors)
* @see [luanti/builtin/common/vector.lua](https://github.com/luanti-org/luanti/blob/5.13.0/builtin/common/vector.lua)
]]
---@nodiscard
---@param v vector
---@return ivec
function vector.round(v) end

--[[
Returns a new vector from sign of each component

* @see math.sign()
* @see [luanti/doc/lua_api.md > Spatial Vectors](https://github.com/luanti-org/luanti/blob/5.13.0/doc/lua_api.md#spatial-vectors)
* @see [luanti/builtin/common/vector.lua](https://github.com/luanti-org/luanti/blob/5.13.0/builtin/common/vector.lua)
]]
---@nodiscard
---@param v vector
---@param anchor number? #@default(`0`)
---@return ivec
function vector.sign(v, anchor) end

--[[
Returns a new vector from absolute values of each component

* @see [luanti/doc/lua_api.md > Spatial Vectors](https://github.com/luanti-org/luanti/blob/5.13.0/doc/lua_api.md#spatial-vectors)
* @see [luanti/builtin/common/vector.lua](https://github.com/luanti-org/luanti/blob/5.13.0/builtin/common/vector.lua)
]]
---@nodiscard
---@param v vector
---@return vec
function vector.abs(v) end

-- -------------------------------------------------------------------------- --

--[[
Returns a new vector from `func` applied on each component.

* @see [luanti/doc/lua_api.md > Spatial Vectors](https://github.com/luanti-org/luanti/blob/5.13.0/doc/lua_api.md#spatial-vectors)
* @see [luanti/builtin/common/vector.lua](https://github.com/luanti-org/luanti/blob/5.13.0/builtin/common/vector.lua)
]]
---@nodiscard
---@param v vector
---@param func fun(a:number, ...:any):number
---@param ... any Optional arguments passed to `func`
---@return vec
function vector.apply(v, func, ...) end

--[[
Returns a new vector from `func` combining each component of `v`and `w`.

* @see [luanti/doc/lua_api.md > Spatial Vectors](https://github.com/luanti-org/luanti/blob/5.13.0/doc/lua_api.md#spatial-vectors)
* @see [luanti/builtin/common/vector.lua](https://github.com/luanti-org/luanti/blob/5.13.0/builtin/common/vector.lua)
]]
---@nodiscard
---@param v vector
---@param w vector
---@param func fun(va:number, wa:number):number
---@return vec
function vector.combine(v, w, func) end

--[[
Whether `v1` has components equal to `v2`

* @see [luanti/doc/lua_api.md > Spatial Vectors](https://github.com/luanti-org/luanti/blob/5.13.0/doc/lua_api.md#spatial-vectors)
* @see [luanti/builtin/common/vector.lua](https://github.com/luanti-org/luanti/blob/5.13.0/builtin/common/vector.lua)
]]
---@nodiscard
---@param v1 vector
---@param v2 vector
---@return boolean
function vector.equals(v1, v2) end

--[[
Returns new vectors `minp` and `maxp` from components of `v1` and `v2`.
- `minp`: vector with smaller components from both vectors
- `maxp`: vector with larger components from both vectors

* @see [luanti/doc/lua_api.md > Spatial Vectors](https://github.com/luanti-org/luanti/blob/5.13.0/doc/lua_api.md#spatial-vectors)
* @see [luanti/builtin/common/vector.lua](https://github.com/luanti-org/luanti/blob/5.13.0/builtin/common/vector.lua)
]]
---@nodiscard
---@param v1 vector
---@param v2 vector
---@return vec minp, vec maxp
function vector.sort(v1, v2) end

-- -------------------------------------------------------------------------- --

--[[
Returns the angle between `v1` and `v2` in radians.

* @see [luanti/doc/lua_api.md > Spatial Vectors](https://github.com/luanti-org/luanti/blob/5.13.0/doc/lua_api.md#spatial-vectors)
* @see [luanti/builtin/common/vector.lua](https://github.com/luanti-org/luanti/blob/5.13.0/builtin/common/vector.lua)
]]
---@nodiscard
---@param v1 vector
---@param v2 vector
---@return number
function vector.angle(v1, v2) end

--[[
Returns the dot product of `v1` and `v2`.

* @see [luanti/doc/lua_api.md > Spatial Vectors](https://github.com/luanti-org/luanti/blob/5.13.0/doc/lua_api.md#spatial-vectors)
* @see [luanti/builtin/common/vector.lua](https://github.com/luanti-org/luanti/blob/5.13.0/builtin/common/vector.lua)
]]
---@nodiscard
---@param v1 vector
---@param v2 vector
---@return number
function vector.dot(v1, v2) end

--[[
Returns the cross product of `v1` and `v2`.

* @see [luanti/doc/lua_api.md > Spatial Vectors](https://github.com/luanti-org/luanti/blob/5.13.0/doc/lua_api.md#spatial-vectors)
* @see [luanti/builtin/common/vector.lua](https://github.com/luanti-org/luanti/blob/5.13.0/builtin/common/vector.lua)
]]
---@nodiscard
---@param v1 vector
---@param v2 vector
---@return vec
function vector.cross(v1, v2) end

--[[
Returns a new vector from summing `v` and `(x,y,z)`.

* @see [luanti/doc/lua_api.md > Spatial Vectors](https://github.com/luanti-org/luanti/blob/5.13.0/doc/lua_api.md#spatial-vectors)
* @see [luanti/builtin/common/vector.lua](https://github.com/luanti-org/luanti/blob/5.13.0/builtin/common/vector.lua)
]]
---@nodiscard
---@param v vector
---@param x number
---@param y number
---@param z number
---@return vec
function vector.offset(v, x, y, z) end

--[[
Whether `v` is a vector class instance. Plain vectors will return `false`

* @see [luanti/doc/lua_api.md > Spatial Vectors](https://github.com/luanti-org/luanti/blob/5.13.0/doc/lua_api.md#spatial-vectors)
* @see [luanti/builtin/common/vector.lua](https://github.com/luanti-org/luanti/blob/5.13.0/builtin/common/vector.lua)
]]
---@nodiscard
---@param v any
---@return boolean
function vector.check(v) end

--[[
Whether `pos` is inside an area formed by `min` and `max` (inclusive).
`min` components must be smaller than `max`. Otherwise, returns `false`.

* @see [luanti/doc/lua_api.md > Spatial Vectors](https://github.com/luanti-org/luanti/blob/5.13.0/doc/lua_api.md#spatial-vectors)
* @see [luanti/builtin/common/vector.lua](https://github.com/luanti-org/luanti/blob/5.13.0/builtin/common/vector.lua)
]]
---@nodiscard
---@param pos vector
---@param min vector *`min` < `max`* for xyx components
---@param max vector *`min` < `max`* for xyz components
---@return boolean
function vector.in_area(pos, min, max) end

--[[
Returns a random integer position in area formed by `min` and `max` (inclusive).

* @see [luanti/doc/lua_api.md > Spatial Vectors](https://github.com/luanti-org/luanti/blob/5.13.0/doc/lua_api.md#spatial-vectors)
* @see [luanti/builtin/common/vector.lua](https://github.com/luanti-org/luanti/blob/5.13.0/builtin/common/vector.lua)
]]
---@nodiscard
---@param min vector *`min` < `max`* for xyx components
---@param max vector *`min` < `max`* for xyz components
---@return ivec
function vector.random_in_area(min, max) end

-- ------------------------- arithmetic and products ------------------------ --

--[[
- `x` is a vector: Returns a new vector from summing `v` and `x`.
- `x` is a number: Returns a new vector from adding `x` to each component of `v`.

* @see [luanti/doc/lua_api.md > Spatial Vectors](https://github.com/luanti-org/luanti/blob/5.13.0/doc/lua_api.md#spatial-vectors)
* @see [luanti/builtin/common/vector.lua](https://github.com/luanti-org/luanti/blob/5.13.0/builtin/common/vector.lua)
]]
---@nodiscard
---@param v vector
---@param x vector|number
---@return vec
function vector.add(v, x) end

--[[
- `x` is a vector: Returns a new vector from difference of `v` and `x`.
- `x` is a number: Returns a new vector from subtracting `x` from each component of `v`.

* @see [luanti/doc/lua_api.md > Spatial Vectors](https://github.com/luanti-org/luanti/blob/5.13.0/doc/lua_api.md#spatial-vectors)
* @see [luanti/builtin/common/vector.lua](https://github.com/luanti-org/luanti/blob/5.13.0/builtin/common/vector.lua)
]]
---@nodiscard
---@param v vector
---@param x vector|number
---@return vec
function vector.subtract(v, x) end

--[[
Returns a new vector from scaling `v` by `s`

* @see [luanti/doc/lua_api.md > Spatial Vectors](https://github.com/luanti-org/luanti/blob/5.13.0/doc/lua_api.md#spatial-vectors)
* @see [luanti/builtin/common/vector.lua](https://github.com/luanti-org/luanti/blob/5.13.0/builtin/common/vector.lua)
]]
---@nodiscard
---@param v vector
---@param s number
---@return vec
function vector.multiply(v, s) end

--[[
Returns a new vector from scaling `v` by `1/s`

* @see [luanti/doc/lua_api.md > Spatial Vectors](https://github.com/luanti-org/luanti/blob/5.13.0/doc/lua_api.md#spatial-vectors)
* @see [luanti/builtin/common/vector.lua](https://github.com/luanti-org/luanti/blob/5.13.0/builtin/common/vector.lua)
]]
---@nodiscard
---@param v vector
---@param s number
---@return vec
function vector.divide(v, s) end

--[[
Returns the schur product between `v1` and `v2`.

* @deprecated 5.X
* @see [luanti/doc/lua_api.md > Spatial Vectors](https://github.com/luanti-org/luanti/blob/5.13.0/doc/lua_api.md#spatial-vectors)
* @see [luanti/builtin/common/vector.lua](https://github.com/luanti-org/luanti/blob/5.13.0/builtin/common/vector.lua)
]]
---@deprecated
---@nodiscard
---@param v1 vector
---@param v2 vector
---@return vec
function vector.multiply(v1, v2) end

--[[
Returns the schur product between `v1` and `(1/v2.x, 1/v2.y, 1/v2.z)`.

* @deprecated 5.X
* @see [luanti/doc/lua_api.md > Spatial Vectors](https://github.com/luanti-org/luanti/blob/5.13.0/doc/lua_api.md#spatial-vectors)
* @see [luanti/builtin/common/vector.lua](https://github.com/luanti-org/luanti/blob/5.13.0/builtin/common/vector.lua)
]]
---@deprecated
---@nodiscard
---@param v1 vector
---@param v2 vector
---@return vec
function vector.divide(v1, v2) end

-- ----------------------- rotation-related functions ----------------------- --

--[[
Returns a new vector from applying rotation `r` to `v`. Angles are in radians.

Rotation order is right-handed extrinsic pitch-yaw-roll. This is exceptional,
following `ObjectRef:set_rotation()`. As a rotation matrix, it's written as `z*y*x`.

* @see [luanti/doc/lua_api.md > Coordinate System](https://github.com/luanti-org/luanti/blob/5.13.0/doc/lua_api.md#coordinate-system)
* @see [luanti/doc/lua_api.md > Spatial Vectors](https://github.com/luanti-org/luanti/blob/5.13.0/doc/lua_api.md#spatial-vectors)
* @see [luanti/builtin/common/vector.lua](https://github.com/luanti-org/luanti/blob/5.13.0/builtin/common/vector.lua)
]]
---@nodiscard
---@param v vector
---@param r vector rotation vector
---@return vec
function vector.rotate(v, r) end

--[[
Returns a new vector from rotating `v` around `axis` by `a` radians following
the right hand rule, meaning it's counter clockwise looking inward from
direction of `axis`.

* @see luanti/doc/lua_api.md > Coordinate System
* @see [luanti/doc/lua_api.md > Spatial Vectors](https://github.com/luanti-org/luanti/blob/5.13.0/doc/lua_api.md#spatial-vectors)
* @see [luanti/builtin/common/vector.lua](https://github.com/luanti-org/luanti/blob/5.13.0/builtin/common/vector.lua)
]]
---@nodiscard
---@param v vector
---@param axis vector
---@param angle number radians
---@return vec
function vector.rotate_around_axis(v, axis, angle) end

--[[
Returns a new rotation vector that would rotate +Z towards `forward` and +Y
towards `up`. `up` must be the intrinsic +Y of `forward`, determining the roll.

* @see luanti/doc/lua_api.md > Coordinate System
* @see [luanti/doc/lua_api.md > Spatial Vectors](https://github.com/luanti-org/luanti/blob/5.13.0/doc/lua_api.md#spatial-vectors)
* @see [luanti/builtin/common/vector.lua](https://github.com/luanti-org/luanti/blob/5.13.0/builtin/common/vector.lua)
]]
---@nodiscard
---@param forward vector
---@param up vector? #@default(*vector perpendicular to `forward` where roll is 0*) perpendicular to `forward`
---@return vec
function vector.dir_to_rotation(forward, up) end