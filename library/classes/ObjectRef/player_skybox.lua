---@meta _
-- DRAFT 1 DONE
-- lua_api.md: Class reference > `ObjectRef`

-- -------------------- PlayerSkyParameters.regular.color ------------------- --

--[[
WIPDOC
]]
---@class core.PlayerSkyParameters.regular.color.set
--[[
WIPDOC
]]
---@field day_sky core.ColorSpec?
--[[
WIPDOC
]]
---@field day_horizon core.ColorSpec?
--[[
WIPDOC
]]
---@field dawn_sky core.ColorSpec?
--[[
WIPDOC
]]
---@field dawn_horizon core.ColorSpec?
--[[
WIPDOC
]]
---@field night_sky core.ColorSpec?
--[[
WIPDOC
]]
---@field night_horizon core.ColorSpec?
--[[
WIPDOC
]]
---@field indoors core.ColorSpec?
--[[
WIPDOC
]]
---@field fog_sun_tint core.ColorSpec?
--[[
WIPDOC
]]
---@field fog_moon_tint core.ColorSpec?
--[[
WIPDOC
]]
---@field fog_tint_type "custom"|"default"|nil

--[[
WIPDOC
]]
---@class core.PlayerSkyParameters.regular.color.get
--[[
WIPDOC
]]
---@field day_sky core.ColorSpec
--[[
WIPDOC
]]
---@field day_horizon core.ColorSpec
--[[
WIPDOC
]]
---@field dawn_sky core.ColorSpec
--[[
WIPDOC
]]
---@field dawn_horizon core.ColorSpec
--[[
WIPDOC
]]
---@field night_sky core.ColorSpec
--[[
WIPDOC
]]
---@field night_horizon core.ColorSpec
--[[
WIPDOC
]]
---@field indoors core.ColorSpec
--[[
WIPDOC
]]
---@field fog_sun_tint core.ColorSpec
--[[
WIPDOC
]]
---@field fog_moon_tint core.ColorSpec
--[[
WIPDOC
]]
---@field fog_tint_type "custom"|"default"


-- ------------------------- PlayerSkyParameters.fog ------------------------ --

--[[
WIPDOC
]]
---@class core.PlayerSkyParameters.fog.set
--[[
WIPDOC
]]
---@field fog_distance integer?
--[[
WIPDOC
]]
---@field fog_start number?
--[[
WIPDOC
]]
---@field fog_color core.ColorSpec?

--[[
WIPDOC
]]
---@class core.PlayerSkyParameters.fog.get
--[[
WIPDOC
]]
---@field fog_distance integer
--[[
WIPDOC
]]
---@field fog_start number
--[[
WIPDOC
]]
---@field fog_color core.ColorSpec



-- ----------------------- PlayerSkyParameters.__base ----------------------- --

--[[
WIPDOC
]]
---@class _.PlayerSkyParameters.__base.set
--[[
WIPDOC
]]
---@field base_color core.ColorSpec?
--[[
WIPDOC
]]
---@field body_orbit_tilt number?
--[[
WIPDOC
]]
---@field textures {}?
--[[
WIPDOC
]]
---@field clouds boolean?
--[[
WIPDOC
]]
---@field fog core.PlayerSkyParameters.fog.set?

--[[
WIPDOC
]]
---@class _.PlayerSkyParameters.__base.get
--[[
WIPDOC
]]
---@field base_color core.ColorSpec
--[[
WIPDOC
]]
---@field body_orbit_tilt number
--[[
WIPDOC
]]
---@field textures {}
--[[
WIPDOC
]]
---@field clouds boolean
--[[
WIPDOC
]]
---@field fog core.PlayerSkyParameters.fog.get

-- ----------------------- PlayerSkyParameters.regular ---------------------- --

--[[
WIPDOC
]]
---@class core.PlayerSkyParameters.regular.set : _.PlayerSkyParameters.__base.set
--[[
WIPDOC
]]
---@field type "regular"
--[[
WIPDOC
]]
---@field sky_color core.PlayerSkyParameters.regular.color.set?

--[[
WIPDOC
]]
---@class core.PlayerSkyParameters.regular.get : _.PlayerSkyParameters.__base.get
--[[
WIPDOC
]]
---@field type "regular"
--[[
WIPDOC
]]
---@field sky_color core.PlayerSkyParameters.regular.color.get

-- ----------------------- PlayerSkyParameters.skybox ----------------------- --

--[[
WIPDOC
]]
---@class core.PlayerSkyParameters.skybox.textures.strict
--[[
WIPDOC
]]
---@field [1] string
--[[
WIPDOC
]]
---@field [2] string
--[[
WIPDOC
]]
---@field [3] string
--[[
WIPDOC
]]
---@field [4] string
--[[
WIPDOC
]]
---@field [5] string
--[[
WIPDOC
]]
---@field [6] string

--[[
WIPDOC
]]
---@class core.PlayerSkyParameters.skybox.set : _.PlayerSkyParameters.__base.set
--[[
WIPDOC
]]
---@field type "skybox"
--[[
WIPDOC
]]
---@field textures string[]|core.PlayerSkyParameters.skybox.textures.strict?

--[[
WIPDOC
]]
---@class core.PlayerSkyParameters.skybox.get : _.PlayerSkyParameters.__base.get
--[[
WIPDOC
]]
---@field type "skybox"
--[[
WIPDOC
]]
---@field textures string[]|core.PlayerSkyParameters.skybox.textures.strict

-- ------------------------ PlayerSkyParameters.plain ----------------------- --

--[[
WIPDOC
]]
---@class core.PlayerSkyParameters.plain.set : _.PlayerSkyParameters.__base.set
--[[
WIPDOC
]]
---@field type "plain"

--[[
WIPDOC
]]
---@class core.PlayerSkyParameters.plain.get : _.PlayerSkyParameters.__base.get
--[[
WIPDOC
]]
---@field type "plain"


-- --------------------------- PlayerSkyParameters -------------------------- --

---@alias core.PlayerSkyParameters.set
--- | core.PlayerSkyParameters.regular.set
--- | core.PlayerSkyParameters.skybox.set
--- | core.PlayerSkyParameters.plain.set

---@alias core.PlayerSkyParameters.get
--- | core.PlayerSkyParameters.regular.get
--- | core.PlayerSkyParameters.skybox.get
--- | core.PlayerSkyParameters.plain.get

-- ---------------------------- PlayerRef methods --------------------------- --

---@class core.PlayerRef
local PlayerRef

--[[
WIPDOC
]]
---@param sky_parameters core.PlayerSkyParameters.set
function PlayerRef:set_sky(sky_parameters) end

--[[
* `get_sky(as_table)`:
    * `as_table`: boolean that determines whether the deprecated version of this
    function is being used.
        * `true` returns a table containing sky parameters as defined in `set_sky(sky_parameters)`.
        * Deprecated: `false` or `nil` returns base_color, type, table of textures,
        clouds.
]]
---@param as_table boolean
---@return core.PlayerSkyParameters.get
function PlayerRef:get_sky(as_table) end

--[[
* `get_sky_color()`:
    * Deprecated: Use `get_sky(as_table)` instead.
    * returns a table with the `sky_color` parameters as in `set_sky`.
]]
---@return core.PlayerSkyParameters.get
function PlayerRef:get_sky_color() end