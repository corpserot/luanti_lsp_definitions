---@meta _
-- DRAFT 1 DONE
-- lua_api.md: Spatial Vectors

---@class _.vec.__base : core.VectorLib
---@field metatable core.VectorLib
---@operator unm(vector):vector
---@operator add(vector):vector
---@operator sub(vector):vector
---@operator div(vector):vector
---@operator mul(vector):vector

--[[
WIPDOC
]]
---@class veci: vec3i.xyz, _.vec.__base

--[[
WIPDOC
]]
---@class vec: vec3.xyz, _.vec.__base

--[[
WIPDOC
]]
---@alias vectori
--- | vec3i.xyz
--- | veci

--[[
WIPDOC
]]
---@alias vector
--- | vec3.xyz
--- | vec