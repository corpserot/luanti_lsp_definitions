---@meta _
-- DRAFT 1 DONE
-- lua_api.md: Definition tables > `ParticleSpawner` definition

--[[
WIPDOC
]]
---@class core.ParticleTexture.tablefmt
--[[
WIPDOC
]]
---@field  name string
--[[
WIPDOC
]]
---@field  alpha number?
--[[
WIPDOC
]]
---@field  alpha_tween core.ParticleSpawner.tween.float?
--[[
WIPDOC
]]
---@field  scale core.ParticleSpawner.vec2?
--[[
WIPDOC
]]
---@field  scale_tween core.ParticleSpawner.tween.vec2?
--[[
WIPDOC
]]
---@field  blend "alpha"|"clip"|"add"|"screen"|"sub"?
--[[
WIPDOC
]]
---@field  animation core.TileAnimationDef?

--[[
WIPDOC
]]
---@class core.ParticleTexture.stringfmt

--[[
WIPDOC
]]
---@alias core.ParticleTexture
--- | core.ParticleTexture.tablefmt
--- | core.ParticleTexture.stringfmt