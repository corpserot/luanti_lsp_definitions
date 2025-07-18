# luanti_lsp_definitions 0.0.1
## State: Will have mistakes, report them, will have breaking changes 

Mostly complete lua lsp definitions for the luanti game engine.

### How to use:
- Install the [lua language server](https://luals.github.io/) in your favourite text editor
- Download `bundled.lua` from [the releases page](https://github.com/TheEt1234/luanti_lsp_definitions/releases), or this entire repository
   - Be aware of licensing 
   - **These lsp definitions are NOT suitable for old projects**, but you can* use lsp rename to get rid of the deprecation warnings for `minetest.*`
      - *in [specific situations](https://github.com/appgurueu/modlib), where the lsp is get confused, this is a bad idea
- Put it in your project and you are done

So i tried to use luanti-lls-definitions but those were really incomplete, and i didn't feel like contributing back to them
And i felt like it would be easier to start from scratch than to attempt to complete them.

My source for all of this API information is [lua_api.md](https://github.com/luanti-org/luanti/blob/master/doc/lua_api.md) and i have copy pasted a lot from it

### Guidelines
- Attempt to use the most intuitive, or C++ name
    - Bad:
        - `vector.Vector` for vectors
        - `core.Node` for nodes
        - `vector` - for the `vector.*` library
        - `string` for colorstrings
    - Good?:
        - `vector` - meaning an actual vector
        - `vectorlib` - the `vector.*` library
        - `MapNode` - for the `{node=, param2=, param1=}` structure
        - `MapNodeOpt` - for the `{node=?, param2=?, param1=?}` structure
- Annotations can be opinionated (Marking things ---@deprecated to avoid usage in production and have unofficial notes which may sometimes be unfunny) 
- Sometimes hide the internal types, like in `handle = core.sound_play(...)`, you don't need to know that the handle is a number (I think? i haven't checked), you just need to know that it's a sound handle (`---@class sound_handle`, or similar), and it's more useful that way
- No discarding of `success` booleans
    - Silent failures are the worst
