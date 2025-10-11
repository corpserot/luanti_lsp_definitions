# Luanti LSP Definitions
- **Status:** All symbols are typed but may change. DRAFT 2 is in progress towards completing hover documents (see [issue#6](https://github.com/corpserot/luanti_lsp_definitions/issues/6))
- **Luanti commit coverage:** `6d1a2080` (`5.14.X`)
- **Target projects when testing:**
  - Each project has a custom private language server config. Please open an issue if you want its contents.
  - [Minetest Game (MTG)](https://github.com/luanti-org/minetest_game) commit `ac2bc0f5`
  - [Age of Mending](https://codeberg.org/Age_of_Mending/Age_of_Mending) commit `eff2c7fa`
  - [SkyBlock: Zero](https://github.com/ChefZander/skyblock_zero/) frog's branch
- **Scheduled breaking changes**: Anytime, still in development.
<!--
  - This follows Luanti's minor releases, meaning we will schedule a breaking release when the target minor release is published.
  - Breaking changes matters for writing annotations on top of Luanti luadef. Otherwise, it's inconsequential meaning you don't have to care about this if you merely want type checking.
  - All changes, breaking or otherwise, are recorded in `CHANGELOG.md`
-->

# Why use this?
This Luadef (lua definition library) enables a lua language server to operate with Luanti APIs and types. This in turn allows for limited IDE-like capabilities in any editor supporting the Language Server Protocol including but not limited to:
- Typed annotation system called LuaCATS/EmmyLua annotations a la JSDoc annotations bringing gradual type system into Lua. In this case, definition files in this Luadef are similar to Typescript declaration files.
- Real-time diagnostics through semantic analysis, replacing [luacheck](https://github.com/mpeterv/luacheck) completely.
- Autocompletion and hover information for API symbols, types, fields and more.
- Built-in cross-referencing, though currently support is prioritized for LuaLS's syntax instead of EmmyLua.

However, there is a real impact to consider for existing Luanti projects wishing to adopt this. Both language servers together with this Luadef (or any Luadef!) will push you towards interacting with the annotation system. While you get annotations for Luanti APIs, there are no information for your project's APIs (and very likely, equally for your dependencies). This results in noisy diagnostics on code that you *know* works correctly. However, there are ways to deal with this but it will involve effort on your end nonetheless. Please read further.

# How to install?
- Install [Lua Language Server, LuaLS](https://luals.github.io/) or [EmmyLua](https://github.com/EmmyLuaLs/emmylua-analyzer-rust) for your favourite text editor. Make sure it works first! ^v^
  - (LuaLS) For VSCode users, you get first-class support with extra features enabled. So, please visit relevant first-party guides.
  - (LuaLS) For Neovim users, you have many ways to configure your language server. As of 2025-08-25 there isn't any (easy and simple) setup that interactively asks you whether to enable an addon for a workspace/project.
  - (LuaLS) Suggested language server configs:
    ```jsonc
    {
      // Remove the comments in your config.
      // Do not expand alias as e.g. `core.Formspec` would show up as `string` if false
      "Lua.hover.expandAlias": false,
      // LuaLS *should* tell you if the table shape doesn't match the type
      "Lua.type.checkTableShape": true,
      // *Don't* cast numbers as integers
      "Lua.type.castNumberToInteger": false,
      // Optional: infer larger literal table type
      "Lua.type.inferTableSize": 16
    }
    ```
  - (EmmyLua) This language server is much younger than LuaLS, and written from scratch in Rust. While it is much, much faster than LuaLS, it also has yet to resolve some issues making the experience quite rough.
  - (EmmyLua) For VSCode users, you get first-class support with the official extension and equal features to any other LSP capable editor. Notably, there is no friendly addon UI, so you'll be on the same level playing field as any other users not using VSCode.
  - (EmmyLua) For Neovim users, there are sparse instructions provided in EmmyLua's documentation but for troubleshooting language servers in general you will have to seek for other resources.

There are a couple methods to setup this Luadef.

- (not working yet! See [issue#32](https://github.com/corpserot/luanti_lsp_definitions/issues/32)) With Lux:
  - First install [`lux`](https://github.com/lumen-oss/lux/).
  - Setup your lux project with: `lx new .` or `lx new my-project-name`
  - Add this Luadef in your dev dependency: `lx add --dev github:corpserot/luanti_lsp_definitions`\
    Lux will update your `.luarc.json` file accordingly

- Manual setup for multiple Luadefs:
  - Prepare a directory where you'll store your personal collections of Luadefs. It will be referred to as `third_party/` here.
  - Git clone this repository, and perhaps any other Luadefs you are interested on into `third_party/`.\
  e.g. [LuaUnit Luadefs](https://github.com/serg3295/luaunit)
  - In your personal project config, add entries below. Pre-defined settings in this Luadef will need to be applied manually, if desired.
  ```json
  // .luarc.json
  {
    // Only booleans, "Ask" and "Disable" work in VSCode
    "workspace.checkThirdParty": "Apply",
    // You can use environment variables like this: ${env:HOME}
    "workspace.userThirdParty": ["/path/to/third_party/"]
  }
  ```

- Manual setup for single Luadef:
  - Git clone this repository.
  - In your personal project config, add entries below. Pre-defined settings in this Luadef will need to be applied manually, if desired.
  ```json
  // .luarc.json or .emmyrc.json
    {
      "workspace.library": ["/path/to/luanti-lsp-definitions/library"],
    }
    ```

# How to use?

Please read the friendly [`GUIDE.md`](https://github.com/corpserot/luanti_lsp_definitions/blob/master/GUIDE.md) as this Luadef has some unique interpretations and conventions you should be aware of. But please, finish reading this README first.

# Goals
The main goal of this Luadef is to write a high quality source of annotation data with not just types but also documentation with the intended audience being experienced game or mod developers. This Luadef will follow these principles in guiding it towards that goal:

1. Anything not explicitly specified in `luanti/doc/lua_api.md` or any other documents (i.e. `luanti/builtin/settingtypes.txt` for documentation of all settings) is considered *undefined behaviour*.
2. Restrictive annotations to the above specifications is unadvised for the time being. Unless API specifications gets an overhaul with clear boundaries on expected and unexpected behaviour, a softer approach is taken focused on intent.
   - Efforts can be made to reduce and minimize this subjectivity, until the subjective additions blur just enough to be simple objective derivations of the API specification.
3. Implementation details may assist in discovering the actual intent of the specifications, but cannot be relied upon. They don't upheld in the contract between Luanti API and game/mod developer.
4. Codebase impact matters, as existing projects decide whether adopting this is worth the effort or not. What is practiced should be taken account of.

# Acknowledgements
There are a couple projects that was developed with similar ideas that I (corpserot) remember seeing. I would like to show my appreciation for their efforts with this simple acknowledgement in chronological order of discovery. Note that this project only look at Luanti's source code along with its documents, meaning I don't use any information elsewhere (it's unnecessary anyways). Please don't bother me about licensing from these other projects.

1. Special acknowledgemen to [luanti_lsp_definitions](https://github.com/TheEt1234/luanti_lsp_definitions) by TheEt1234. The direct ancestor of this project. Licensed 0BSD, but it mixed in a lot of LGPLv2.1 contents from Luanti. Thusly, it would have been LGPLv2.1.
2. [luanti-lls-definitions](https://codeberg.org/fgaz/luanti-lls-definitions) by fgaz introduced me to LuaCATS. Licensed EUPLv1.2-or-later.
3. [Typescript-to-lua](https://typescripttolua.github.io/) approach by jordan4ibanez in his game, [Crafter](https://github.com/jordan4ibanez/crafter). The Luanti API is defined in [`minetest-api.d.ts`](https://github.com/jordan4ibanez/crafter/blob/main/minetest-api.d.ts) Perhaps the most developed typed representation of Luanti API before this project. Licensed GPLv3.
4. [luanti-api](https://git.minetest.land/archie/luanti-api/) by archie. Licensed GPLv3. Public around the same timeframe as my Luadef.
5. [luanti-ide-helper](https://github.com/Voxrame/luanti-ide-helper/) by Team Lord. Licensed MIT. Public after both luanti-api and my Luadef.

# Quick Q&A
## Can i use Luacheck with this?
No.

## Can i use LuaDoc/LDoc with this?
No. You should use the language server's documentation generator instead ([LuaLS](https://luals.github.io/wiki/export-docs/)) ([EmmyLua](https://github.com/EmmyLuaLs/emmylua-analyzer-rust/tree/main/crates/emmylua_doc_cli))

## Can I use [Luanti Tools VSCode(ium) extension](https://marketplace.visualstudio.com/items?itemName=GreenXenith.minetest-tools) together with this?
Probably wait until the developer (GreenXenith) is made aware about this project. There's no reason it wouldn't work however.

## Should I use LuaLS or EmmyLua?
(Personal opinion) You should use LuaLS for the time being as it is a far more developed project. But please do check out EmmyLua from time to time. [LuaLS development has stalled](https://github.com/LuaLS/lua-language-server/graphs/contributors) greatly since early 2024 and is not expected to recover as issues continue to pile. Here is [the same graph for EmmyLua](https://github.com/EmmyLuaLs/emmylua-analyzer-rust/graphs/contributors). More important than these numbers are the commit contents, and you may judge them on your own.

## Which EmmyLua?
[EmmyLua-IntelliJ](https://github.com/EmmyLua/IntelliJ-EmmyLua) first started as a plugin for the IntelliJ IDEA. It is written in Java and Kotlin. Lua-language-server (LuaLS) later gained popularity on VSCode. Later, people involved in the original EmmyLua project created a language server, now under the [EmmyLuaLs](https://github.com/EmmyLuaLs/) team. It is written in Rust. The IntelliJ plugin has pretty much stalled development, not so different from LuaLS.

## Why doesn't LuaLS/EmmyLua work the way I want it to?
Both language servers have their own various limitations. You can see more in [issue#4](https://github.com/corpserot/luanti_lsp_definitions/issues/4). It is not an exhaustive list.
- (LuaLS) table literals are analyzed in limited capacity. You can configure this with [`type.checkTableShape`](https://luals.github.io/wiki/settings/#typechecktableshape) and [`type.inferTableSize`](https://luals.github.io/wiki/settings/#typeinfertablesize).
- (LuaLS) functions passed as parameters don't get analyzed at all for correct signature.

## I am trying to adopt this in an existing project, but the diagnostics are too noisy and not helpful!
You can tell the language server to ignore/exclude files:
- (LuaLS) [Use `"workspace.ignoreDir"`](https://luals.github.io/wiki/settings/#workspaceignoredir)
- (EmmyLua) [Use `"workspace.ignoreDir"` or `"workspace.ignoreGlobs"`](https://github.com/EmmyLuaLs/emmylua-analyzer-rust/blob/main/docs/config/emmyrc_json_EN.md#%EF%B8%8F-workspace---workspace-configuration)

Or, if you prefer to just ignore everything for now and enable it one by one:

- Bash:
  ```sh
  # Run this from the root project directory to obtain a list of lua filenames you can paste right into the JSON config
  find . -type f -name '*.lua' | sed 's|^\./||' | sort | sed 's|^|\"|' | sed 's|$|\",|'
  ```

- Powershell:
  ```pwsh
  # Run this from the root project directory to obtain a list of lua filenames you can paste right into the JSON config
  Get-ChildItem -Recurse -Filter *.lua | ForEach-Object { '"' + $_.FullName.Replace((Get-Location).Path + '\', '').Replace('\', '/') + '",' }
  ```

## If i use this, do i have to use a LGPL-compliant license for my game/mod?
***Disclaimer: I am not a lawyer, and nothing in this material should be taken as legal advice. It may even be inaccurate. No attorney–client relationship is created by your use of this information provided for informative purposes. You should not act or rely on any information provided here without seeking the advice of a qualified attorney licensed in your jurisdiction. I disclaim all liability for actions you take or fail to take based on any content provided.***

You may skip this if you're well-informed about copyleft software licenses.

The answer is very unlikely... well, it depends. You can embed or use this library definition alongside your game/mod. However, please don't copy-paste contents of this library definition straight into your code. Particularly, the documentation text itself has to be treated a bit more carefully.

**Example:** Person A wrote a mod with a permissive license like MIT or 0BSD. If person A carelessly include contents of this library definition into the mod's `init.lua`, then a portion of that file is at risk of being subjected to LGPL terms due to documentation text.

If you would like to modify or derive contents of this library definition, it's recommended to treat your derived work like a separate module from your game/mod. It could be simply a separate directory or file.

**Example:** Person A, being careful this time, copy-pastes parts of this library definition into a separate definition file `.defs.lua`. This would help isolate where LGPL terms apply.