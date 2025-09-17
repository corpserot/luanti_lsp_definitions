---@meta _
-- DRAFT 1 DONE
-- lua_api.md: Lua Voxel Manipulator

-- ------------------------------- constructor ------------------------------ --

--[[
WIPDOC
]]
---@param pmin vector
---@param pmax vector
---@return VoxelArea
---@nodiscard
function VoxelArea(pmin, pmax) end

--[[
WIPDOC
]]
---@nodiscard
---@param arg {MinEdge:vector, MaxEdge:vector}
---@return VoxelArea
function VoxelArea:new(arg) end

-- -------------------------------- VoxelArea ------------------------------- --

--[[
WIPDOC
]]
---@class VoxelArea
VoxelArea = {}

--[[
WIPDOC
]]
---@nodiscard
---@return vector
function VoxelArea:getExtent() end

--[[
WIPDOC
]]
---@nodiscard
---@return vector
function VoxelArea:getVolume() end

--[[
* `index(x, y, z)`: returns the index of an absolute position in a flat array
  starting at `1`.
    * `x`, `y` and `z` must be integers to avoid an incorrect index result.
    * The position (x, y, z) is not checked for being inside the area volume,
      being outside can cause an incorrect index result.
    * Useful for things like `VoxelManip`, raw Schematic specifiers,
      `ValueNoiseMap:get2d`/`3dMap`, and so on.
]]
---@nodiscard
---@param x number
---@param y number
---@param z number
---@return number
function VoxelArea:index(x, y, z) end

--[[
* `indexp(p)`: same functionality as `index(x, y, z)` but takes a vector.
    * As with `index(x, y, z)`, the components of `p` must be integers, and `p`
      is not checked for being inside the area volume.
]]
---@nodiscard
---@param p vector
---@return number
function VoxelArea:indexp(p) end

--[[
* `position(i)`: returns the absolute position vector corresponding to index
  `i`.
]]
---@param i number
---@return vector
function VoxelArea:position(i) end

--[[
WIPDOC
]]
---@nodiscard
---@param x number
---@param y number
---@param z number
---@return boolean
function VoxelArea:contains(x, y, z) end

--[[
WIPDOC
]]
---@nodiscard
---@param p vector
---@return boolean
function VoxelArea:containsp(p) end

--[[
WIPDOC
]]
---@nodiscard
---@param i number
---@return boolean
function VoxelArea:containsi(i) end

--[[
WIPDOC
]]
---@nodiscard
---@param minx number
---@param miny number
---@param minz number
---@param maxx number
---@param maxy number
---@param maxz number
---@return function
function VoxelArea:iter(minx, miny, minz, maxx, maxy, maxz) end

--[[
WIPDOC
]]
---@nodiscard
---@param minp vector
---@param maxp vector
---@return function
function VoxelArea:iterp(minp, maxp) end
