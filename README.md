# Luanti LuaLS Definitions
- **Status:** A bit incomplete for Luanti `5.13` and may have mistakes.
- **Last Luanti commit accounted for:** `5ab66da6` (`5.13.X`)
- **Target projects when testing:**
  - [Minetest Game (MTG)](https://github.com/luanti-org/minetest_game) commit `8fbfc14c`\
    With a custom LuaLS config (To be published).
- **Scheduled breaking changes**: Anytime, still in development.
  - This follows Luanti's minor releases, meaning we will schedule a breaking release when the target minor release is published.

# How to use
- Install [Lua Language Server, LuaLS](https://luals.github.io/) or [EmmyLua](https://github.com/EmmyLuaLs/emmylua-analyzer-rust) for your favourite text editor. Make sure it works first! ^v^
  - For VSCode users, you get first-class support with extra features enabled. So, please visit relevant first-party guides.
  - For Neovim users, you have many ways to configure your language server. As of 2025-08-25 there isn't any (easy and simple) setup that interactively asks you whether to enable an addon for a workspace/project.
- Manual setup for single library definitions (Recommended for one-off uses):
  - Git clone this repository.
  - In your personal project config, add entries below. Optionally, manually inject whatever is inside `config.json` > `"settings"` into your LuaLS config. That entry contains recommended settings for Luanti game and mod development.
    ```json
    {
      "workspace.library": ["/path/to/luanti-lsp-definitions/library"],
      // e.g. selecting this specifically from "settings.Lua" entry in config.json:
      "diagnostics.disable": [
        "lowercase-global"
      ],
    }
    ```
- Manual setup for collection of library definitions (Recommended for multiple library definition uses):
  - Git clone this repository into this file structure: `luals_addons/luanti-lsp-definitions`. This allows you to add more addons under the same directory, e.g. `luals_addons/busted` for the testing suite.
  - in your config, add entries below. The `Apply` value allows the LSP to read library definitions without asking, provided you matched the criteria to enable it.
    ```json
    {
      "workspace.checkThirdParty": "Apply",
      "workspace.userThirdParty": ["/path/to/luals_addons"]
    }
    ```
- Automatic setup: WIP as this project is still in development.

## Using this as a Luanti game/mod developer
After following the above instructions, in the context of annotations, you are left with two types of dependencies for your game/mod: Annotated dependencies and Un-annotated dependencies

- *Annotated dependencies* and *Un-annotated dependencies* as-is:
  - Game developers simply just include them in their project without any further additions.

  - Mod developers should put them inside a `.gitignore`d directory where you can safely fetch/clone your dependencies without distributing them.

  - You may notice errors due to how language server configurations are applied to the whole project instead of scoped to the dependencies. Unfortunately, this approach means that you're also inheriting any implementation detail diagnostics that come with the dependency. i.e. If your dependency ignored an error, you too will have to ignore that error.

  - Additionally, whatever language server configurations used by the dependency no longer applies. If they have a lenient diagnostics configuration and you don't, it's very likely you'll get more diagnostic messages than upstream maintainers.

- *Un-annotated dependencies* and you wish to annotate a separate library definition:
  - This is the *preferred* approach. This is because you're separating the implementation detail diagnostics from the annotations, the important information that downstream users like you want.

- *Un-annotated dependencies* and you wish to annotate its source code and a separate library definition:
  - This is the approach that would yield best results, but efforts are duplicated.


### Namespace reservation
If you use this library definition, you acknowledge that it reserves the type namespace `core.*` and `_.*`. Additionally, vector "primitive" types are also reserved.

It's recommended that you own annotations sit inside a namespace i.e. `<mod or game name>.MyType`

# File Structure
- `.luarc.json` is the default LuaLS project configuration. You're expected to override it with your editor's personal project configuration.
- (NYI) `.emmyrc.json` is the default EmmyLua project configuration. You're expected to override it with your editor's personal project configuration.
- `config.json` is this library definition's configuration file. The `"settings"` portion should be minimal to encourage the developer to decide their own language server configurations.
- `MAINTAINENCE.md` is the guide for maintaining this project. Please read it if you would like to contribute.
- `library/` has definition files related to engine API. There is a short description at the top of each file. The contents are arranged following `lua_api.md`
  - `library/classes/` has definition files related to classes.
  - `library/core/` has definition files related to the `core` namespace.
  - `library/defs/` has definition files catching the rest of the `lua_api.md` contents.

# Questions and Answers
## How do i extend types?
You can extend existing classes like so:
```lua
---@class core.ItemDef
---@field _mymod_rarity integer

--- Sometimes, you'll have to work with internal classes
---@class _.ObjectProperties.__base
---@field _mymod_power integer
```

However, it's expected that you need delve into this project's definitions as you're likely to extend the wrong type or an alias (cannot be extended using this technique).

Be on the lookout for scheduled breaking changes.

## Why not contribute to [`luanti-lls-definitions by @fgaz`](https://codeberg.org/fgaz/luanti-lls-definitions)?
For context, that is the existing solution before this library definition was conceived.

(by @frog) So i tried to use luanti-lls-definitions but those were really incomplete, and i didn't feel like contributing back to them\
And i felt like it would be easier to start from scratch than to attempt to complete them.

(by @corpserot) Well, there's a couple of reasons:
1. first and foremost that project uses an unreliable method to extract information from `lua_api.md` using TCL (seriously??)
2. @fgaz is very inactive in updating the definition files (check commits since project inception). It's very incomplete.
3. It uses EUPL license, which overcomplicates matters as it resembles closer to AGPLv3.0 than LGPLv2.1. Yet, it won't deter people that is already set on violating FOSS licenses. We don't use any definitions from that project, obviously.
4. I don't think @fgaz actually uses the definitions themself (dogfooding).