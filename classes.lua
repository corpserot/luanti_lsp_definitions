--- CLASS REFERENCE
---@meta
--- "Misc.", "Helpers", "Utils", "Class reference"
--- what will be their next invention

-- Unofficial note:
-- > Class named "AreaStore"
-- > Look inside
-- > No store
-- ???
--
-- Anyway, the official docs:
-- `AreaStore`
-- -----------
--
-- AreaStore is a data structure to calculate intersections of 3D cuboid volumes
-- and points. The `data` field (string) may be used to store and retrieve any
-- mod-relevant information to the specified area.
--
-- Despite its name, mods must take care of persisting AreaStore data. They may
-- use the provided load and write functions for this.
--
---@class AreaStore
AreaStore = {}

--- Unofficial note: I am aware that "Luanti" isn't a valid AreaStore type, but that makes it default to Luanti functions so, is it not accurate?
-- * `AreaStore(type_name)`
--     * Returns a new AreaStore instance
--     * `type_name`: optional, forces the internally used API.
--         * Possible values: `"LibSpatial"` (default).
--         * When other values are specified, or SpatialIndex is not available,
--           the custom Luanti functions are used.
---@param type "LibSpatial"|"Luanti"|any
---@return AreaStore
function AreaStore(type) end

-- * `get_area(id, include_corners, include_data)`
--     * Returns the area information about the specified ID.
--     * Returned values are either of these:
--       ```lua
--       nil  -- Area not found
--       true -- Without `include_corners` and `include_data`
--       {
--           min = pos, max = pos -- `include_corners == true`
--           data = string        -- `include_data == true`
--       }
--       ```
---@param id number
---@param include_corners boolean
---@param include_data boolean
---@return boolean|{min:vector?,max:vector?,data:string?}
function AreaStore:get_area(id, include_corners, include_data) end

-- * `get_areas_for_pos(pos, include_corners, include_data)`
--     * Returns all areas as table, indexed by the area ID.
--     * Table values: see `get_area`.
---@param pos vector
---@param include_corners boolean
---@param include_data boolean
---@return boolean|table<integer,{min:vector?,max:vector?,data:string?}>
function AreaStore:get_areas_for_pos(pos, include_corners, include_data) end

-- * `get_areas_in_area(corner1, corner2, accept_overlap, include_corners, include_data)`
--     * Returns all areas that contain all nodes inside the area specified by`
--       `corner1 and `corner2` (inclusive).
--     * `accept_overlap`: if `true`, areas are returned that have nodes in
--       common (intersect) with the specified area.
--     * Returns the same values as `get_areas_for_pos`.
---@param pos1 vector
---@param pos2 vector
---@param accept_overlap boolean
---@param include_corners boolean
---@param include_data boolean
---@return boolean|table<integer,{min:vector?,max:vector?,data:string?}>
function AreaStore:get_areas_in_area(pos1, pos2, accept_overlap, include_corners, include_data) end

-- * `insert_area(corner1, corner2, data, [id])`: inserts an area into the store.
--     * Returns the new area's ID, or nil if the insertion failed.
--     * The (inclusive) positions `corner1` and `corner2` describe the area.
--     * `data` is a string stored with the area.
--     * `id` (optional): will be used as the internal area ID if it is a unique
--       number between 0 and 2^32-2.
---@param corner1 vector
---@param corner2 vector
---@param data string
---@param id integer?
---@return integer?
function AreaStore:insert_area(corner1, corner2, data, id) end

-- * `reserve(count)`
--     * Requires SpatialIndex, no-op function otherwise.
--     * Reserves resources for `count` many contained areas to improve
--       efficiency when working with many area entries. Additional areas can still
--       be inserted afterwards at the usual complexity.
---@param count integer
function AreaStore:reserve(count) end

-- * `remove_area(id)`: removes the area with the given id from the store, returns
--   success.
---@nodiscard
---@param id number
---@return boolean
function AreaStore:remove_area(id) end

-- * `set_cache_params(params)`: sets params for the included prefiltering cache.
--   Calling invalidates the cache, so that its elements have to be newly
--   generated.
--     * `params` is a table with the following fields:
--       ```lua
--       {
--           enabled = boolean,   -- Whether to enable, default true
--           block_radius = int,  -- The radius (in nodes) of the areas the cache
--                                -- generates prefiltered lists for, minimum 16,
--                                -- default 64
--           limit = int,         -- The cache size, minimum 20, default 1000
--       }
--       ```
---@param params {enabled:boolean, block_radius:integer, limit:integer}
function AreaStore:set_cache_params(params) end

-- * `to_string()`: Experimental. Returns area store serialized as a (binary)
--   string.
---@return string
function AreaStore:to_string() end

-- * `to_file(filename)`: Experimental. Like `to_string()`, but writes the data to
--   a file.
---@param filename string
function AreaStore:to_file(filename) end

-- * `from_string(str)`: Experimental. Deserializes string and loads it into the
--   AreaStore.
--   Returns success and, optionally, an error message.
---@param str string
function AreaStore:from_string(str) end

-- * `from_file(filename)`: Experimental. Like `from_string()`, but reads the data
--   from a file.
---@param filename string
function AreaStore:from_file(filename) end
