---@meta _
-- DRAFT 1 DONE
-- lua_api.md: Class reference > `StorageRef`


--[[
`StorageRef`
------------

Mod metadata: per mod and world metadata, saved automatically.
Can be obtained via `core.get_mod_storage()` during load time.

WARNING: This storage backend is incapable of saving raw binary data due
to restrictions of JSON.

### Methods

* All methods in MetaDataRef

]]
---@class core.StorageRef : core.MetaDataRef