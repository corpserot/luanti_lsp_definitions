---@meta _
-- ObjectRef bone overrides
-- luanti/doc/lua_api.md: Class reference > `ObjectRef`)

--[[
`""` usually refers to the model's root bone, if defined
]]
---@alias core.Bone.name string

-- -------------------------- BoneOverride.property ------------------------- --

--[[
Bone override transformation parameters used in translation, rotation and scaling.
Specifies interpolation and whether changes is absolute or relative.

If `nil` or `{}`, does not override the property.

* @added 5.9.0
* @default `nil`
* @see [`core.BoneOverride.property.get`](lua://core.BoneOverride.property.get)
* @see [luanti/doc/lua_api.md > Class reference > ObjectRef > Methods](https://github.com/luanti-org/luanti/blob/5.14.0/doc/lua_api.md#methods)
* @see [luanti/doc/lua_api.md > Mods >> glTF](https://github.com/luanti-org/luanti/blob/5.14.0/doc/lua_api.md#gltf)
* @see [luanti/src/script/lua_api/l_object.cpp](https://github.com/luanti-org/luanti/blob/5.14.0/src/script/lua_api/l_object.cpp)
* @see [luanti/src/server/unit_cao.cpp](https://github.com/luanti-org/luanti/blob/5.14.0/src/server/unit_cao.cpp)
]]
---@alias core.BoneOverride.property.set
--- | core.BoneOverride.property.get
--- | _.BoneOverride.property.set

---@class _.BoneOverride.property.set
--[[
In the same coordinate system as the model. For rotations, it is in radians.

* @added 5.9.0
* @default `vector.new(0,0,0)` for translation and rotation
* @default `vector.new(1,1,1)` for scale.
* @see [luanti/doc/lua_api.md > Class reference > ObjectRef > Methods](https://github.com/luanti-org/luanti/blob/5.14.0/doc/lua_api.md#methods)
* @see [luanti/doc/lua_api.md > Mods >> glTF](https://github.com/luanti-org/luanti/blob/5.14.0/doc/lua_api.md#gltf)
* @see [luanti/src/script/lua_api/l_object.cpp](https://github.com/luanti-org/luanti/blob/5.14.0/src/script/lua_api/l_object.cpp)
* @see [luanti/src/server/unit_cao.cpp](https://github.com/luanti-org/luanti/blob/5.14.0/src/server/unit_cao.cpp)
]]
---@field vec vector?
--[[
Interpolation time between the previous override and this override.

* @added 5.9.0
* @default `0`
* @see [luanti/doc/lua_api.md > Class reference > ObjectRef > Methods](https://github.com/luanti-org/luanti/blob/5.14.0/doc/lua_api.md#methods)
* @see [luanti/doc/lua_api.md > Mods >> glTF](https://github.com/luanti-org/luanti/blob/5.14.0/doc/lua_api.md#gltf)
* @see [luanti/src/script/lua_api/l_object.cpp](https://github.com/luanti-org/luanti/blob/5.14.0/src/script/lua_api/l_object.cpp)
* @see [luanti/src/server/unit_cao.cpp](https://github.com/luanti-org/luanti/blob/5.14.0/src/server/unit_cao.cpp)
]]
---@field interpolation number?
--[[
Whether the transformation is absolute or relative, where relative to the
animated property:
- Translation for `position`
- Composition for `rotation`
- Per-axis multiplication for `scale`

* @added 5.9.0
* @compatibility <5.9.0 clients only support absolute position and rotation without interpolation
* @default `false`
* @see [luanti/doc/lua_api.md > Class reference > ObjectRef > Methods](https://github.com/luanti-org/luanti/blob/5.14.0/doc/lua_api.md#methods)
* @see [luanti/doc/lua_api.md > Mods >> glTF](https://github.com/luanti-org/luanti/blob/5.14.0/doc/lua_api.md#gltf)
* @see [luanti/src/script/lua_api/l_object.cpp](https://github.com/luanti-org/luanti/blob/5.14.0/src/script/lua_api/l_object.cpp)
* @see [luanti/src/server/unit_cao.cpp](https://github.com/luanti-org/luanti/blob/5.14.0/src/server/unit_cao.cpp)
]]
---@field absolute boolean?

--[[
Bone override transformation parameters used in translation, rotation and scaling.
Specifies interpolation and whether changes is absolute or relative.

* @added 5.9.0
* @see [`core.BoneOverride.property.set`](lua://core.BoneOverride.property.set)
* @see [luanti/doc/lua_api.md > Class reference > ObjectRef > Methods](https://github.com/luanti-org/luanti/blob/5.14.0/doc/lua_api.md#methods)
* @see [luanti/doc/lua_api.md > Mods >> glTF](https://github.com/luanti-org/luanti/blob/5.14.0/doc/lua_api.md#gltf)
* @see [luanti/src/script/lua_api/l_object.cpp](https://github.com/luanti-org/luanti/blob/5.14.0/src/script/lua_api/l_object.cpp)
* @see [luanti/src/server/unit_cao.cpp](https://github.com/luanti-org/luanti/blob/5.14.0/src/server/unit_cao.cpp)
]]
---@class core.BoneOverride.property.get
--[[
In the same coordinate system as the model. For rotations, it is in radians.

* @added 5.9.0
* @default `vector.new(0,0,0)` for translation and rotation
* @default `vector.new(1,1,1)` for scale.
* @see [luanti/doc/lua_api.md > Class reference > ObjectRef > Methods](https://github.com/luanti-org/luanti/blob/5.14.0/doc/lua_api.md#methods)
* @see [luanti/doc/lua_api.md > Mods >> glTF](https://github.com/luanti-org/luanti/blob/5.14.0/doc/lua_api.md#gltf)
* @see [luanti/src/script/lua_api/l_object.cpp](https://github.com/luanti-org/luanti/blob/5.14.0/src/script/lua_api/l_object.cpp)
* @see [luanti/src/server/unit_cao.cpp](https://github.com/luanti-org/luanti/blob/5.14.0/src/server/unit_cao.cpp)
]]
---@field vec vec
--[[
Interpolation time between the previous override and this override.

* @added 5.9.0
* @default `0`
* @see [luanti/doc/lua_api.md > Class reference > ObjectRef > Methods](https://github.com/luanti-org/luanti/blob/5.14.0/doc/lua_api.md#methods)
* @see [luanti/doc/lua_api.md > Mods >> glTF](https://github.com/luanti-org/luanti/blob/5.14.0/doc/lua_api.md#gltf)
* @see [luanti/src/script/lua_api/l_object.cpp](https://github.com/luanti-org/luanti/blob/5.14.0/src/script/lua_api/l_object.cpp)
* @see [luanti/src/server/unit_cao.cpp](https://github.com/luanti-org/luanti/blob/5.14.0/src/server/unit_cao.cpp)
]]
---@field interpolation number
--[[
Whether the transformation is absolute or relative, where relative to the
animated property:
- Translation for `position`
- Composition for `rotation`
- Per-axis multiplication for `scale`

* @added 5.9.0
* @compatibility <5.9.0 clients only support absolute position and rotation without interpolation
* @default `false`
* @see [luanti/doc/lua_api.md > Class reference > ObjectRef > Methods](https://github.com/luanti-org/luanti/blob/5.14.0/doc/lua_api.md#methods)
* @see [luanti/doc/lua_api.md > Mods >> glTF](https://github.com/luanti-org/luanti/blob/5.14.0/doc/lua_api.md#gltf)
* @see [luanti/src/script/lua_api/l_object.cpp](https://github.com/luanti-org/luanti/blob/5.14.0/src/script/lua_api/l_object.cpp)
* @see [luanti/src/server/unit_cao.cpp](https://github.com/luanti-org/luanti/blob/5.14.0/src/server/unit_cao.cpp)
]]
---@field absolute boolean


-- ------------------------------ BoneOverride ------------------------------ --

--[[
Bone override transformations using translation, rotation, scaling. Supports
animated interpolation.

* @added 5.9.0
* @see [luanti/doc/lua_api.md > Class reference > ObjectRef > Methods](https://github.com/luanti-org/luanti/blob/5.14.0/doc/lua_api.md#methods)
* @see [luanti/doc/lua_api.md > Mods >> glTF](https://github.com/luanti-org/luanti/blob/5.14.0/doc/lua_api.md#gltf)
* @see [luanti/src/script/lua_api/l_object.cpp](https://github.com/luanti-org/luanti/blob/5.14.0/src/script/lua_api/l_object.cpp)
* @see [luanti/src/server/unit_cao.cpp](https://github.com/luanti-org/luanti/blob/5.14.0/src/server/unit_cao.cpp)
]]
---@alias core.BoneOverride.set
--- | core.BoneOverride.get
--- | _.BoneOverride.set

---@class _.BoneOverride.set
--[[
Translation, by moving the position of the bone.

* @added 5.9.0
* @see [luanti/doc/lua_api.md > Class reference > ObjectRef > Methods](https://github.com/luanti-org/luanti/blob/5.14.0/doc/lua_api.md#methods)
* @see [luanti/doc/lua_api.md > Mods >> glTF](https://github.com/luanti-org/luanti/blob/5.14.0/doc/lua_api.md#gltf)
* @see [luanti/src/script/lua_api/l_object.cpp](https://github.com/luanti-org/luanti/blob/5.14.0/src/script/lua_api/l_object.cpp)
* @see [luanti/src/server/unit_cao.cpp](https://github.com/luanti-org/luanti/blob/5.14.0/src/server/unit_cao.cpp)
]]
---@field position core.BoneOverride.property.set?
--[[
Rotation of the bone.

* @added 5.9.0
* @see [luanti/doc/lua_api.md > Class reference > ObjectRef > Methods](https://github.com/luanti-org/luanti/blob/5.14.0/doc/lua_api.md#methods)
* @see [luanti/doc/lua_api.md > Mods >> glTF](https://github.com/luanti-org/luanti/blob/5.14.0/doc/lua_api.md#gltf)
* @see [luanti/src/script/lua_api/l_object.cpp](https://github.com/luanti-org/luanti/blob/5.14.0/src/script/lua_api/l_object.cpp)
* @see [luanti/src/server/unit_cao.cpp](https://github.com/luanti-org/luanti/blob/5.14.0/src/server/unit_cao.cpp)
]]
---@field rotation core.BoneOverride.property.set?
--[[
Scaling of the bone.

* @added 5.9.0
* @see [luanti/doc/lua_api.md > Class reference > ObjectRef > Methods](https://github.com/luanti-org/luanti/blob/5.14.0/doc/lua_api.md#methods)
* @see [luanti/doc/lua_api.md > Mods >> glTF](https://github.com/luanti-org/luanti/blob/5.14.0/doc/lua_api.md#gltf)
* @see [luanti/src/script/lua_api/l_object.cpp](https://github.com/luanti-org/luanti/blob/5.14.0/src/script/lua_api/l_object.cpp)
* @see [luanti/src/server/unit_cao.cpp](https://github.com/luanti-org/luanti/blob/5.14.0/src/server/unit_cao.cpp)
]]
---@field scale core.BoneOverride.property.set?

--[[
Bone override transformations using translation, rotation, scaling. Supports
animated interpolation.

* @added 5.9.0
* @see [luanti/doc/lua_api.md > Class reference > ObjectRef > Methods](https://github.com/luanti-org/luanti/blob/5.14.0/doc/lua_api.md#methods)
* @see [luanti/doc/lua_api.md > Mods >> glTF](https://github.com/luanti-org/luanti/blob/5.14.0/doc/lua_api.md#gltf)
* @see [luanti/src/script/lua_api/l_object.cpp](https://github.com/luanti-org/luanti/blob/5.14.0/src/script/lua_api/l_object.cpp)
* @see [luanti/src/server/unit_cao.cpp](https://github.com/luanti-org/luanti/blob/5.14.0/src/server/unit_cao.cpp)
]]
---@class core.BoneOverride.get
--[[
Translation, by moving the position of the bone.

* @added 5.9.0
* @see [luanti/doc/lua_api.md > Class reference > ObjectRef > Methods](https://github.com/luanti-org/luanti/blob/5.14.0/doc/lua_api.md#methods)
* @see [luanti/doc/lua_api.md > Mods >> glTF](https://github.com/luanti-org/luanti/blob/5.14.0/doc/lua_api.md#gltf)
* @see [luanti/src/script/lua_api/l_object.cpp](https://github.com/luanti-org/luanti/blob/5.14.0/src/script/lua_api/l_object.cpp)
* @see [luanti/src/server/unit_cao.cpp](https://github.com/luanti-org/luanti/blob/5.14.0/src/server/unit_cao.cpp)
]]
---@field position core.BoneOverride.property.get
--[[
Rotation of the bone.

* @added 5.9.0
* @see [luanti/doc/lua_api.md > Class reference > ObjectRef > Methods](https://github.com/luanti-org/luanti/blob/5.14.0/doc/lua_api.md#methods)
* @see [luanti/doc/lua_api.md > Mods >> glTF](https://github.com/luanti-org/luanti/blob/5.14.0/doc/lua_api.md#gltf)
* @see [luanti/src/script/lua_api/l_object.cpp](https://github.com/luanti-org/luanti/blob/5.14.0/src/script/lua_api/l_object.cpp)
* @see [luanti/src/server/unit_cao.cpp](https://github.com/luanti-org/luanti/blob/5.14.0/src/server/unit_cao.cpp)
]]
---@field rotation core.BoneOverride.property.get
--[[
Scaling of the bone.

* @added 5.9.0
* @see [luanti/doc/lua_api.md > Class reference > ObjectRef > Methods](https://github.com/luanti-org/luanti/blob/5.14.0/doc/lua_api.md#methods)
* @see [luanti/doc/lua_api.md > Mods >> glTF](https://github.com/luanti-org/luanti/blob/5.14.0/doc/lua_api.md#gltf)
* @see [luanti/src/script/lua_api/l_object.cpp](https://github.com/luanti-org/luanti/blob/5.14.0/src/script/lua_api/l_object.cpp)
* @see [luanti/src/server/unit_cao.cpp](https://github.com/luanti-org/luanti/blob/5.14.0/src/server/unit_cao.cpp)
]]
---@field scale core.BoneOverride.property.get


-- ---------------------------- ObjectRef methods --------------------------- --

---@class _.ObjectRef.__base
local ObjectRefBase

--[[
Sets limited state of the current bone override. Equivalent to:

```lua
obj:set_bone_override(bone, {
    position = {vec = position, absolute = true},
})
```

Undefined behaviour:
- Bone is not defined in the model

* @deprecated 5.9.0
* @see [`core.ObjectRef:set_bone_override()`](lua://_.ObjectRef.__base.set_bone_override)
* @see [luanti/doc/lua_api.md > Class reference > ObjectRef > Methods](https://github.com/luanti-org/luanti/blob/5.14.0/doc/lua_api.md#methods)
* @see [luanti/doc/lua_api.md > Mods >> glTF](https://github.com/luanti-org/luanti/blob/5.14.0/doc/lua_api.md#gltf)
* @see [luanti/src/script/lua_api/l_object.cpp](https://github.com/luanti-org/luanti/blob/5.14.0/src/script/lua_api/l_object.cpp)
* @see [luanti/src/server/unit_cao.cpp](https://github.com/luanti-org/luanti/blob/5.14.0/src/server/unit_cao.cpp)
]]
---@deprecated
---@param bone core.Bone.name? #@default(`""`) `""` usually refers to the model's root bone, if defined
---@param position vector? #@default(`(0,0,0)`)
---@param rotation vector? #@default(`(0,0,0)`) degrees
function ObjectRefBase:set_bone_position(bone, position, rotation) end

--[[
Returns limited state of the current bone override. Equivalent to:

```lua
local override = obj:get_bone_override(bone)
return override.position.vec, override.rotation.vec:apply(math.deg)
```

Undefined behaviour:
- Bone is not defined in the model
- Bone override does not exist

* @deprecated 5.9.0
* @see [`core.ObjectRef:get_bone_override()`](lua://_.ObjectRef.__base.get_bone_override)
* @see [luanti/doc/lua_api.md > Class reference > ObjectRef > Methods](https://github.com/luanti-org/luanti/blob/5.14.0/doc/lua_api.md#methods)
* @see [luanti/doc/lua_api.md > Mods >> glTF](https://github.com/luanti-org/luanti/blob/5.14.0/doc/lua_api.md#gltf)
* @see [luanti/src/script/lua_api/l_object.cpp](https://github.com/luanti-org/luanti/blob/5.14.0/src/script/lua_api/l_object.cpp)
* @see [luanti/src/server/unit_cao.cpp](https://github.com/luanti-org/luanti/blob/5.14.0/src/server/unit_cao.cpp)
]]
---@deprecated
---@nodiscard
---@param bone core.Bone.name
---@return vec position
---@return vec rotation degrees
function ObjectRefBase:get_bone_position(bone) end

--[[
Sets current bone override state.

Undefined behaviour:
- Bone is not defined in the model

* @added 5.9.0
* @see [luanti/doc/lua_api.md > Class reference > ObjectRef > Methods](https://github.com/luanti-org/luanti/blob/5.14.0/doc/lua_api.md#methods)
* @see [luanti/doc/lua_api.md > Mods >> glTF](https://github.com/luanti-org/luanti/blob/5.14.0/doc/lua_api.md#gltf)
* @see [luanti/src/script/lua_api/l_object.cpp](https://github.com/luanti-org/luanti/blob/5.14.0/src/script/lua_api/l_object.cpp)
* @see [luanti/src/server/unit_cao.cpp](https://github.com/luanti-org/luanti/blob/5.14.0/src/server/unit_cao.cpp)
]]
---@param bone core.Bone.name `""` usually refers to the model's root bone, if defined
---@param override core.BoneOverride.set?
function ObjectRefBase:set_bone_override(bone, override) end

--[[
Returns current bone override state.

Undefined behaviour:
- Bone is not defined in the model
- Bone override does not exist

* @added 5.9.0
* @see [luanti/doc/lua_api.md > Class reference > ObjectRef > Methods](https://github.com/luanti-org/luanti/blob/5.14.0/doc/lua_api.md#methods)
* @see [luanti/doc/lua_api.md > Mods >> glTF](https://github.com/luanti-org/luanti/blob/5.14.0/doc/lua_api.md#gltf)
* @see [luanti/src/script/lua_api/l_object.cpp](https://github.com/luanti-org/luanti/blob/5.14.0/src/script/lua_api/l_object.cpp)
* @see [luanti/src/server/unit_cao.cpp](https://github.com/luanti-org/luanti/blob/5.14.0/src/server/unit_cao.cpp)
]]
---@nodiscard
---@param bone core.Bone.name
---@return core.BoneOverride.get
function ObjectRefBase:get_bone_override(bone) end

--[[
Returns a table mapping bone names and their bone override states.

Undefined behaviour:
- Bones not defined in the model
- Bone overrides that has not exist yet.

* @added 5.9.0
* @see [luanti/doc/lua_api.md > Class reference > ObjectRef > Methods](https://github.com/luanti-org/luanti/blob/5.14.0/doc/lua_api.md#methods)
* @see [luanti/doc/lua_api.md > Mods >> glTF](https://github.com/luanti-org/luanti/blob/5.14.0/doc/lua_api.md#gltf)
* @see [luanti/src/script/lua_api/l_object.cpp](https://github.com/luanti-org/luanti/blob/5.14.0/src/script/lua_api/l_object.cpp)
* @see [luanti/src/server/unit_cao.cpp](https://github.com/luanti-org/luanti/blob/5.14.0/src/server/unit_cao.cpp)
]]
---@nodiscard
---@return table<string, core.BoneOverride.get>
function ObjectRefBase:get_bone_overrides() end