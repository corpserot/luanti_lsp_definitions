---@meta _
-- DRAFT 1 DONE
-- lua_api.md: 'core' namespace reference > Logging

--[[
Unofficial note: I made it deprecated because this should NOT be in any production code, and you should use something better tbh, like dbg.pp (from lars's dbg mod)
* Equivalent to `core.log(table.concat({...}, "\t"))`
]]
---@param ... any
---@deprecated
---@return nil
function core.debug(...) end

--[[
WIPDOC
]]
---@param loglevel "none"|"error"|"warning"|"action"|"info"|"verbose"
---@param text string
---@return nil
function core.log(loglevel, text) end

--[[
WIPDOC
]]
---@param text string
---@return nil
function core.log(text) end