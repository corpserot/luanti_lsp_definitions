---@meta

--- This one was my first one and it was NOT fun i don't recomend doing this

---@class vectorlib
--[[
(Unofficial note: This is easy to miss: Manually constructed vector tables are deprecated and highly discouraged. Unofficial-er possibly-going-against-advice note: It makes sense to still manually construct tables for performance reasons)

Spatial Vectors
===============

Luanti stores 3-dimensional spatial vectors in Lua as tables of 3 coordinates,
and has a class to represent them (`vector.*`), which this chapter is about.
For details on what a spatial vectors is, please refer to Wikipedia:
https://en.wikipedia.org/wiki/Euclidean_vector.

Spatial vectors are used for various things, including, but not limited to:

* any 3D spatial vector (x/y/z-directions)
* Euler angles (pitch/yaw/roll in radians) (Spatial vectors have no real semantic
  meaning here. Therefore, most vector operations make no sense in this use case.)

Note that they are *not* used for:

* n-dimensional vectors where n is not 3 (ie. n=2)
* arrays of the form `{num, num, num}`

The API documentation may refer to spatial vectors, as produced by `vector.new`,
by any of the following notations:

* `(x, y, z)` (Used rarely, and only if it's clear that it's a vector.)
* `vector.new(x, y, z)`
* `{x=num, y=num, z=num}` (Even here you are still supposed to use `vector.new`.)


Compatibility notes
-------------------

Vectors used to be defined as tables of the form `{x = num, y = num, z = num}`.
Since version 5.5.0, vectors additionally have a metatable to enable easier use.
Note: Those old-style vectors can still be found in old mod code. Hence, mod and
engine APIs still need to be able to cope with them in many places.

Manually constructed tables are deprecated and highly discouraged. This interface
should be used to ensure seamless compatibility between mods and the Luanti API.
This is especially important to callback function parameters and functions overwritten
by mods.
Also, though not likely, the internal implementation of a vector might change in
the future.
In your own code, or if you define your own API, you can, of course, still use
other representations of vectors.

Vectors provided by API functions will provide an instance of this class if not
stated otherwise. Mods should adapt this for convenience reasons.

Special properties of the class
-------------------------------

Vectors can be indexed with numbers and allow method and operator syntax.

All these forms of addressing a vector `v` are valid:
`v[1]`, `v[3]`, `v.x`, `v[1] = 42`, `v.y = 13`
Note: Prefer letter over number indexing for performance and compatibility reasons.

Where `v` is a vector and `foo` stands for any function name, `v:foo(...)` does
the same as `vector.foo(v, ...)`, apart from deprecated functionality.

`tostring` is defined for vectors, see `vector.to_string`.

The metatable that is used for vectors can be accessed via `vector.metatable`.
Do not modify it!

All `vector.*` functions allow vectors `{x = X, y = Y, z = Z}` without metatables.
Returned vectors always have a metatable set.
]]
vector = {}

-- Unofficial notes:
-- Please treat vectors like they are immutable as much as you can, unless for performance reasons, in that case get rid of that metatable
-- Example:
--[[
local x_coords = {}
local y_coords = {}
local z_coords = {}

local vec_t = {}

....

vec_t.x = x_coords[n]
vec_t.y = y_coords[n]
vec_t.z = z_coords[n]

This will probably drastically reduce on garbage collector use, as vectors are HORRIBLE for it
]]
---@class vector: vectorlib
---@field x number
---@field y number
---@field z number
----@field protected [number] number you know... i don't know how to make this deprecated, so i'm just not going to include it in here, you should NOT!! index vectors like that
---@operator unm(vector):vector
---@operator add(vector):vector
---@operator sub(vector):vector
---@operator div(vector):vector
---@operator mul(vector):vector

--- Returns a new vector `(a, b, c)`
---@nodiscard
---@param a number
---@param b number?
---@param c number?
---@return vector
function vector.new(a, b, c) end

--- `vector.new(v)` does the same as `vector.copy(v)`
---@deprecated
---@nodiscard
---@param a vector
---@return vector
function vector.new(a) end

--- `vector.new()` does the same as `vector.zero()`
---@deprecated
---@nodiscard
---@return vector
function vector.new() end

--- Returns a new vector `(0, 0, 0)`
---@nodiscard
---@return vector
function vector.zero() end

--- Returns a new vector of length 1, pointing into a direction chosen uniformly at random.
---@nodiscard
---@return vector
function vector.random_direction() end

--- Returns a copy of the vector `v`.
---@param v vector
---@return vector
---@nodiscard
function vector.copy(v) end

--[[
Returns v, np, where v is a vector read from the given string s and np is the next position in the string after the vector.
Returns nil on failure.
]]
---@nodiscard
---@param s string Has to begin with a substring of the form `"(x, y, z)"`. Additional spaces, leaving away commas, and adding an additional comma to the end is allowed.
---@param init number? Starts looking for the vector at this string index
---@return vector? v, number? np
function vector.from_string(s, init) end

--- Returns a string of the form `"(x, y, z)"`
--- `tostring(v)` does the same
---@nodiscard
---@param v vector
---@return string
function vector.to_string(v) end

--[[
Returns a vector of length 1 with direction p1 to p2.
If p1 and p2 are identical, returns (0, 0, 0).
]]
---@nodiscard
---@param p1 vector
---@param p2 vector
---@return vector
function vector.direction(p1, p2) end

--[[
Returns zero or a positive number, the distance between p1 and p2.
]]
---@nodiscard
---@param p1 vector
---@param p2 vector
---@return number
function vector.distance(p1, p2) end

-- Returns zero or a positive number, the length of vector v.
---@nodiscard
---@param v vector
---@return number
function vector.length(v) end

-- Returns a vector of length 1 with direction of vector v.
-- If v has zero length, returns (0, 0, 0).
---@param v vector
---@return vector
---@nodiscard
function vector.normalize(v) end

---@param v vector
---@return vector
---@nodiscard
---Returns a vector, each dimension rounded down.
function vector.floor(v) end

---@param v vector
---@return vector
---@nodiscard
---Returns a vector, each dimension rounded up.
function vector.ceil(v) end

---@param v vector
---@return vector
---@nodiscard
---Returns a vector, each dimension rounded to the nearest integer.
--- At a multiple of 0.5, rounds away from zero.
function vector.round(v) end

--- Returns a vector where `math.sign` was called for each component
---@return vector
---@nodiscard
---@param v vector
---@param tolerance number?
function vector.sign(v, tolerance) end

-- You know, at this point, just direct the user to use `vector.apply` OMG

--- Returns a vector with absolute values for each component
---@param v vector
---@return vector
---@nodiscard
function vector.abs(v) end

--- Applies `func` to each component
---@nodiscard
---@param v vector
---@param func fun(n: number): number
---@param ... any Optional arguments passed to `func`
---@return vector
function vector.apply(v, func, ...) end

--- Returns a vector where the function `func` has combined both components of `v` and `w` for each component
---@nodiscard
---@param v vector
---@param w vector
---@param func fun(x:number, y:number):number
---@return vector
function vector.combine(v, w, func) end

--- Returns true if the vectors are identical, false if not
---@param v1 vector
---@param v2 vector
---@nodiscard
---@return boolean
function vector.equals(v1, v2) end

--- Returns in order minp, maxp vectors of the cuboid defined by v1, v2.
--- (Unofficial note: In other words, the first vector that gets returned will be smaller than the second, yknow it sorts them)
---@param v1 vector
---@param v2 vector
---@nodiscard
---@return vector, vector
function vector.sort(v1, v2) end

--- Returns the angle between v1 and v2 in radians
---@nodiscard
---@return number # in radians
---@param v1 vector
---@param v2 vector
function vector.angle(v1, v2) end

-- Returns the dot product
---@nodiscard
---@return number
---@param v1 vector
---@param v2 vector
function vector.dot(v1, v2) end

-- Returns the cross product
---@nodiscard
---@return vector
---@param v1 vector
---@param v2 vector
function vector.cross(v1, v2) end

--- Returns the sum of vectors `v` and `(x,y,z)`
---@return vector
---@nodiscard
---@param v vector
---@param x number
---@param y number
---@param z number
function vector.offset(v, x, y, z) end

--- Checks if `v` is a vector, returns false even for tables like {x=,y=,z=}, has to be created with a vector function
---@param v vector
---@nodiscard
---@return boolean
function vector.check(v) end

--- Checks if `pos` is inside an area formed by `min` and `max`
--- `min` and `max` are inclusive
--- If min is bigger than max on some axis, function always returns false.
--- You can use vector.sort if you have two vectors and don't know which are the minimum and the maximum.
---@nodiscard
---@param pos vector
---@param min vector
---@param max vector
---@return boolean
function vector.in_area(pos, min, max) end

--[[
Returns a random integer position in area formed by min and max
min and max are inclusive.
You can use vector.sort if you have two vectors and don't know which are the minimum and the maximum.
]]
---@nodiscard
---@return vector
---@param min vector
---@param max vector
function vector.random_in_area(min, max) end

-- FINALLY, that was a LOT

---@nodiscard
---@param v vector
---@param x vector|number
---@return vector
function vector.add(v, x) end

---@nodiscard
---@param v vector
---@param x vector|number
---@return vector
function vector.subtract(v, x) end

---@nodiscard
---@param v vector
---@param x number
---@return vector
function vector.multiply(v, x) end

---@nodiscard
---@param v vector
---@param x number
---@return vector
function vector.divide(v, x) end

---@deprecated
---@class vector.Schur
---@field x vector
---@field y vector
---@field z vector

--- Unofficial note: Haha i know you did this and were confused
--- Anyway, this returns the schur product
---@deprecated
---@nodiscard
---@param v vector
---@param x vector
---@return vector.Schur
function vector.multiply(v, x) end

--- Unofficial note: Haha i know you did this and were confused
--- Anyway, this returns the schur quotient
---@deprecated
---@nodiscard
---@param v vector
---@param x vector
---@return vector.Schur
function vector.divide(v, x) end

--[[
Applies the rotation r to v and returns the result.
vector.rotate(vector.new(0, 0, 1), r) and vector.rotate(vector.new(0, 1, 0), r) return vectors pointing forward and up relative to an entity's rotation r.
]]
---@nodiscard
---@param v vector
---@param r vector Rotation vector {x=<pitch>, y=<yaw>, z=<roll>}
---@return vector
function vector.rotate(v, r) end

--- Returns v1 rotated around axis v2 by a radians according to the right hand rule.
---@nodiscard
---@param v1 vector
---@param v2 vector
---@param a number radians
---@return vector
function vector.rotate_around_axis(v1, v2, a) end

--[[
Returns a rotation vector for direction pointing forward using up as the up vector.
If up is omitted, the roll of the returned vector defaults to zero.
Otherwise direction and up need to be vectors in a 90 degree angle to each other.
]]
---@nodiscard
---@param up vector?
---@param direction vector
---@return vector
function vector.dir_to_rotation(direction, up) end
