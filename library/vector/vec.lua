---@meta _
-- 2D and 3D plain vectors
-- luanti/doc/lua_api.md: Spatial Vectors

-- ---------------------------------- vec2 ---------------------------------- --

--[[
2D integer plain vector with xy components.
]]
---@class ivec2.xy
---@field x integer
---@field y integer

--[[
2D integer plain vector with xy components. Passing floats are unspecified.
]]
---@alias ivec2.xy.soft ivec2.xy | vec2.12

--[[
2D integer plain vector with 12 components.
]]
---@class ivec2.12
---@field [1] number
---@field [2] number

--[[
2D integer plain vector with either xy components, or 12 components
]]
---@alias ivec2 ivec2.xy | ivec2.12

--[[
2D integer plain vector with either xy components, or 12 components. Passing
floats are unspecified
]]
---@alias ivec2.soft ivec2 | vec2

--[[
2D plain vector with xy components.
]]
---@class vec2.xy
---@field x number
---@field y number

--[[
2D plain vector with 12 components.
]]
---@class vec2.12
---@field [1] number
---@field [2] number

--[[
2D plain vector with either xy components, or 12 components
]]
---@alias vec2 vec2.xy | vec2.12

-- ---------------------------------- vec3 ---------------------------------- --

--[[
3D integer plain vector with xyz components.
]]
---@class ivec3.xyz
---@field x integer
---@field y integer
---@field z integer

--[[
3D integer plain vector with 123 components.
]]
---@class ivec3.123
---@field [1] integer
---@field [2] integer
---@field [3] integer

--[[
3D integer plain vector with xyz components. Passing floats are unspecified
]]
---@alias ivec3.xyz.soft ivec3.xyz | vec3.xyz

--[[
3D integer plain vector with xyz components or 123 components.
]]
---@alias ivec3 ivec3.xyz | ivec3.123

--[[
3D integer plain vector with xyz components or 123 components. Passing floats
are unspecified
]]
---@alias ivec3.soft ivec3 | vec3

--[[
3D plain vector with xyz components.
]]
---@class vec3.xyz
---@field x number
---@field y number
---@field z number

--[[
3D plain vector with 123 components.
]]
---@class vec3.123
---@field [1] number
---@field [2] number
---@field [3] number

--[[
3D plain vector with xyz components or 123 components.
]]
---@alias vec3 vec3.xyz | vec3.123