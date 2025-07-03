---@alias Tile string|{name:string, backface_culling:boolean?, animation: TileAnimation?, align_style: ("node"|"world"|"user")?, scale:integer}

---@class TileAnimation: table
---@field type "vertical_frames"|"sheet_2d"
---@field aspect_w integer?
---@field aspect_h integer?
---@field length number?
---@field frames_w integer?
---@field frames_h integer?
---@field frame_length number?
