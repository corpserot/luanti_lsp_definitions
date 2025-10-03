---@meta _
-- Node drawtypes
-- luanti/doc/lua_api.md: Nodes > Node drawtypes
-- luanti/doc/lua_api.md: Definition tables > Node definition

-- ---------------------------- NodeDef.drawtype ---------------------------- --

--[[
Node drawtypes determines the subset of all type of visual rendering a node
supports. Highly intertwined with `tiles`, `special_tiles` and `paramtype2`.

- `normal`: Node-sized cube.
- `airlike`: Invisible. No texture.
- `liquid`: Culls faces bordering connected liquids.
- `flowingliquid`: Flowing `liquid` with various heights and slopes.
  `liquid_alternative_flowing` must be set to the node's own name.
- `glasslike`: Culls internal faces. Useful for transparent and semi-transparent tiles.
- `glasslike_framed`: Connected nodes are drawn as a framed single volume.
- `glasslike_framed_optional`: Switches between `glasslike`, `glasslike_framed`
- `allfaces`: Culls internal faces, but external faces of adjacent nodes are visible.
- `allfaces_optional`: Switches between `normal`, `glasslike`, `allfaces`
  according to client settings.
- `torchlike`: Single vertical texture.
- `signlike`: Single texture parallel to the mounted node's face.
- `plantlike`: Two vertical and diagonal textures at right-angles to each other,
  forming an X from above.
- `firelike`: On top of a node, appears as 6 textures. It combines the central 2
  as `plantlike` surrounded by 4 textures similar to a #. On other faces of a
  node, each of the 4 textures can appear if it can mount to adjacent node.
- `fencelike`: Node appears as a single vertical post. Horizontal bars connect nodes
- `raillike`: Automatically switches between 4 textures. Straight, curved,
  t-junction and crossing. Straights can become slopes.
- `nodebox`: Visual rendering defined by `node_box`.
- `mesh`: Static mesh provided by mods.
- `plantlike_rooted`: Base `normal` node with a `plantlike` part above it.
]]
---@alias core.NodeDef.drawtype
--- | "normal"
--- | "airlike"
--- | "liquid"
--- | "flowingliquid"
--- | "glasslike"
--- | "glasslike_framed"
--- | "glasslike_framed_optional"
--- | "allfaces"
--- | "allfaces_optional"
--- | "torchlike"
--- | "signlike"
--- | "plantlike"
--- | "firelike"
--- | "fencelike"
--- | "raillike"
--- | "nodebox"
--- | "mesh"
--- | "plantlike_rooted"

-- ----------------------------- NodeDef fields ----------------------------- --

---@class core.NodeDef
---@field drawtype core.NodeDef.drawtype?
