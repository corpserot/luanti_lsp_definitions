---@meta _
-- High resolution persistent positional timer
-- luanti/doc/lua_api.md: Class reference > `NodeTimerRef`

--[[
High resolution persistent positional timer.

* @see [luanti/doc/lua_api.md > Class reference > `NodeTimerRef`](https://github.com/luanti-org/luanti/blob/5.14.0/doc/lua_api.md#nodetimerref)
* @see (Luanti C++) `ServerEnvironment::step()` > `ServerEnvironment::activateBlock()` > `MapBlock::step()`
* @see [luanit/src/nodetimer.cpp](https://github.com/luanti-org/luanti/blob/5.14.0/src/nodetimer.cpp)
* @see [luanit/src/script/lua_api/l_nodetimer.cpp](https://github.com/luanti-org/luanti/blob/5.14.0/src/script/lua_api/l_nodetimer.cpp)
]]
---@class core.NodeTimerRef
local NodeTimerRef = {}

--[[
Set this timer's state. Triggers the node's `.on_timer()` hook at the timer's
position after `timeout - elapsed` seconds.

* @see [luanti/doc/lua_api.md > Class reference > `NodeTimerRef`](https://github.com/luanti-org/luanti/blob/5.14.0/doc/lua_api.md#nodetimerref)
* @see [luanit/src/script/lua_api/l_nodetimer.cpp](https://github.com/luanti-org/luanti/blob/5.14.0/src/script/lua_api/l_nodetimer.cpp)
]]
---@param timeout number
---@param elapsed number
function NodeTimerRef:set(timeout, elapsed) end

--[[
Start this timer. Triggers the node's `.on_timer()` hook at the timer's
position after `timeout` seconds.

* @see [luanti/doc/lua_api.md > Class reference > `NodeTimerRef`](https://github.com/luanti-org/luanti/blob/5.14.0/doc/lua_api.md#nodetimerref)
* @see [luanit/src/script/lua_api/l_nodetimer.cpp](https://github.com/luanti-org/luanti/blob/5.14.0/src/script/lua_api/l_nodetimer.cpp)
]]
---@param timeout number
function NodeTimerRef:start(timeout) end

--[[
Stops this timer.

* @see [luanti/doc/lua_api.md > Class reference > `NodeTimerRef`](https://github.com/luanti-org/luanti/blob/5.14.0/doc/lua_api.md#nodetimerref)
* @see [luanit/src/script/lua_api/l_nodetimer.cpp](https://github.com/luanti-org/luanti/blob/5.14.0/src/script/lua_api/l_nodetimer.cpp)
]]
function NodeTimerRef:stop() end

--[[
Returns current timeout in seconds.

* @see [luanti/doc/lua_api.md > Class reference > `NodeTimerRef`](https://github.com/luanti-org/luanti/blob/5.14.0/doc/lua_api.md#nodetimerref)
* @see [luanit/src/script/lua_api/l_nodetimer.cpp](https://github.com/luanti-org/luanti/blob/5.14.0/src/script/lua_api/l_nodetimer.cpp)
]]
---@nodiscard
---@return number timeout
function NodeTimerRef:get_timeout() end

--[[
Returns current elapsed time in seconds.

* @see [luanti/doc/lua_api.md > Class reference > `NodeTimerRef`](https://github.com/luanti-org/luanti/blob/5.14.0/doc/lua_api.md#nodetimerref)
* @see [luanit/src/script/lua_api/l_nodetimer.cpp](https://github.com/luanti-org/luanti/blob/5.14.0/src/script/lua_api/l_nodetimer.cpp)
]]
---@nodiscard
---@return number elapsed
function NodeTimerRef:get_elapsed() end

--[[
Whether the timer has started.

* @see [luanti/doc/lua_api.md > Class reference > `NodeTimerRef`](https://github.com/luanti-org/luanti/blob/5.14.0/doc/lua_api.md#nodetimerref)
* @see [luanit/src/script/lua_api/l_nodetimer.cpp](https://github.com/luanti-org/luanti/blob/5.14.0/src/script/lua_api/l_nodetimer.cpp)
]]
---@nodiscard
---@return boolean started
function NodeTimerRef:is_started() end