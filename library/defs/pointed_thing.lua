---@meta _
-- DRAFT 1 DONE
-- lua_api.md: Representations of simple things

--[[
WIPDOC
]]
---@class core.PointedThing
--[[
WIPDOC
]]
---@field type "nothing"|"node"|"object"
--[[
WIPDOC
]]
---@field under vector
--[[
WIPDOC
]]
---@field above vector
--[[
WIPDOC
]]
---@field ref core.ObjectRef
--[[
Only raycast supports this
* `pointed_thing.intersection_point`: The absolute world coordinates of the
  point on the selection box which is pointed at. May be in the selection box
  if the pointer is in the box too.
]]
---@field intersection_point vector
--[[
Only raycast supports this
* `pointed_thing.box_id`: The ID of the pointed selection box (counting starts
  from 1).
]]
---@field box_id integer
--[[
Only raycast supports this
* `pointed_thing.intersection_normal`: Unit vector, points outwards of the
  selected selection box. This specifies which face is pointed at.
  Is a null vector `vector.zero()` when the pointer is inside the selection box.
  For entities with rotated selection boxes, this will be rotated properly
  by the entity's rotation - it will always be in absolute world space.
]]
---@field intersection_normal vector
