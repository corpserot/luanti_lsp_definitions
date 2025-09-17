---@meta _
-- DRAFT 1 DONE
-- lua_api.md: Definition tables > Privilege definition

-- TODO default/builtin privileges

--[[
WIPDOC
]]
---@class core.PrivilegeSet : {[string]:boolean}

-- ------------------------------ PrivilegeDef ------------------------------ --

--[[
WIPDOC
]]
---@class core.PrivilegeDef
--[[
WIPDOC
]]
---@field description string?
--[[
WIPDOC
]]
---@field give_to_singleplayer boolean?
--[[
Whether to grant the privilege to the server admin.
Uses value of 'give_to_singleplayer' by default.
]]
---@field give_to_admin boolean?
--[[
Note that the above two callbacks will be called twice if a player is
responsible, once with the player name, and then with a nil player
name.
Return true in the above callbacks to stop register_on_priv_grant or
revoke being called.
]]
---@field on_grant? fun(name:string, granter_name:string): boolean?
--[[
Note that the above two callbacks will be called twice if a player is
responsible, once with the player name, and then with a nil player
name.
Return true in the above callbacks to stop register_on_priv_grant or
revoke being called.
]]
---@field on_revoke? fun(name:string, revoker_name:string): boolean?
