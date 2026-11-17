# Craft Anything — Complete Rebuild Workflow, Prompts, Contracts & Verification Checks

This reference contains every prompt, contract, study algorithm, stack recipe, and verification check from `crates/ai/src/rebuild/`. Use it both when driving `rebuild_start` / `craft-anything-cli rebuild` and when acting directly as the **Study Agent**, **Extractor Agent**, or **Builder Agent**.

---

## 1. The 4-Stage Rebuild Pipeline (`crates/ai/src/rebuild/mod.rs`)

1. **`Step::Study`**:
   - Runs target-specific outside captures (`WebsiteKind::study`, `AppKind::study`, `GameKind::study`).
   - If the target has internal structure or Deep mode is on, runs an AI Study turn (`study::study_prompt`) which writes `capture/study.md` (and `capture/how-it-works.md` for websites in Deep mode).
   - For games in Deep mode with an **Extractor** backend configured (`craft-anything-cli ai extractor <name>`), runs an extraction pass (`study::extract_prompt`) that unpacks original textures, sounds, models, and maps into `app/Original/` and documents them in `app/Original/MANIFEST.md`.
2. **`Step::Build`**:
   - Writes the initial build brief (`brief::first_prompt`, or `brief::followup_prompt` if continuing, or `brief::continue_prompt` if resuming an interrupted run) and invokes the Builder agent in `ws.build_root()` (`app/`, or `ws.root` when `--existing edit`).
3. **`Step::Check`**:
   - Runs the target kind's ordered check suite (`check::Check`) plus `self_check::check` (which scans for placeholder strings, missing files, and runs any loaded WASM check plugins from `plugins_checks_list`).
   - Saves a human-readable report to `reports/check-round-<N>.md` and updates `reports/build-progress.json`.
   - Default `good_enough` similarity threshold: **90.0%** (`settings.build.good_enough`).
4. **`Step::Refine`**:
   - If any check fails or visual similarity is below `good_enough` (and `round <= max_rounds`, default `2`), sends `brief::refine_prompt` with the exact check report and screenshot paths so the Builder fixes every named issue.

---

## 2. Exact Builder Contracts & Rules (`crates/ai/src/rebuild/brief.rs`)

### 2.1 Core Builder Rules (`RULES`)

```markdown
## Rules
- Build inside `app/` (or the current build root if editing in place). Everything needed to build and run must live there.
- Make a real, working result that runs right away — no `TODO` comments, no `"coming soon"` screens, no stub handlers for things the person asked for.
- Keep third-party dependencies to a minimum; prefer what the chosen stack already includes. Every extra package is another thing that can fail to install or compile.
- Leave a short `README.md` at the root of `app/` saying what it is and the exact command to run it.
```

### 2.2 Clean-Room Outside Study Contracts

#### `WEBSITE_FROM_OUTSIDE` (Websites in Clean-room mode)
```markdown
## How to use the capture
`capture/` was taken from a real browser at three widths: `desktop.png` (1440 px), `tablet.png` (768 px), and `phone.png` (390 px), with `page.json` holding the computed styles, colours, fonts, spacing, landmarks, headings, controls, and image boxes.
- Look at `capture/desktop.png`, `capture/tablet.png`, and `capture/phone.png` before writing code, and again after building.
- Match the exact background and text colours (`page.json`), font family, font sizes, line heights, border radii, and padding.
- Build every section in the same vertical and horizontal order as `page.json`, with the same number of cards/items per row at desktop, tablet, and phone widths.
- Make sure there is no horizontal scrollbar (`overflow-x`) at 1440 px, 768 px, or 390 px.
- If `capture/states.json` exists, wire up every interactive state (menus, tabs, modals, dropdowns, accordions) so clicking the trigger produces the captured state.
- If `capture/routes/` exists, include every captured route (`capture/routes/<slug>/`) and wire navigation links between them.
```

#### `PROGRAM_FROM_OUTSIDE` (Apps & Games in Clean-room mode)
```markdown
## Studying from the outside
Craft Anything is in Clean-room mode: study and rebuild from what the program shows on the outside (`capture/window.png`, `capture/ui-tree.json`, `capture/study.md`, and `reference/`) without reading its internal code or private files.
- Match the window layout, panels, toolbars, controls, and labels recorded in `capture/window.png` and `capture/ui-tree.json`.
- Every named button, menu item, tab, input field, and shortcut in `capture/ui-tree.json` should exist and work in your build.
```

### 2.3 Deep-Mode Decompilation Contract (`DECOMPILE_FIRST`)

Used for Apps and Games when Deep mode is enabled:

```markdown
## Decompile before you write
Deep mode is on. Do not guess how the original works from its window title or file names:
1. List and decompile the core functions/classes (`native_functions_list` → `native_function_decompile`, `managed_dotnet_decompile`, `java_class_decompile`, or `android_class_decompile`) and read its data files before writing gameplay or application logic.
2. Pull the real numbers, formulas, state machines, and file formats straight from the decompiled code and data files.
3. Record every number and formula you found in `app/MECHANICS.md` and `app/mechanics.json` citing the function or file it came from.
```

### 2.4 Mandatory Game & Deep App Contracts

#### `MECHANICS_CONTRACT` (`app/MECHANICS.md` + `app/mechanics.json`)
```markdown
## Mechanics sheet (`app/MECHANICS.md` and `app/mechanics.json`)
Write two files before or alongside the code:
1. `app/MECHANICS.md` — a clear human-readable sheet of every constant, formula, timer, speed, physics rule, and state transition.
2. `app/mechanics.json` — machine-checked JSON:
```json
{
  "format_version": 1,
  "constants": [
    {
      "name": "player_walk_speed",
      "value": 240.0,
      "unit": "px/s",
      "source": "from Player::Update (0x140012a40)"
    }
  ]
}
```
- Every constant whose `"source"` does NOT contain `"estimated"` MUST appear as a literal number in your code under `app/` (checked to 7 significant figures).
- In Deep mode, constants must come from decompiled code or data files, not `"estimated"`, whenever the original has them.
```

#### `SCREENSHOT_CONTRACT` (`--screenshot <file.png>`)
```markdown
## Screenshot flag (`--screenshot <file.png>`)
Your built program MUST accept `--screenshot <file.png>` on the command line:
- Start directly into the real main window or an active in-game scene populated with representative content (skip title-screen waits or modal prompts).
- Run for ~120 frames so layout, textures, lighting, and HUD settle.
- Save the rendered window to `<file.png>` as a valid, non-blank PNG image and exit with status `0`.
```

#### `SELF_TEST_CONTRACT` (`--self-test <file.json>` — Mandatory for Games)
```markdown
## Self-test flag (`--self-test <file.json>`)
Your built game MUST accept `--self-test <file.json>` on the command line:
- Run ~180 frames of synthetic input exercising the core gameplay loop without needing a human at the keyboard.
- Must test and record at least these three steps in order:
  1. `"move"` — feed movement input and assert the player/camera/cursor position actually changed.
  2. `"act"` — feed the primary action (jump, shoot, place, select, attack, interact) and assert game state changed.
  3. `"hud"` — assert the HUD / score / health / status readout reflects the state change.
- Write `<file.json>` with this exact shape and exit `0`:
```json
{
  "format_version": 1,
  "passed": true,
  "frames": 180,
  "steps": [
    { "name": "move", "passed": true, "detail": "player moved from (0,0) to (18.4, 0)" },
    { "name": "act",  "passed": true, "detail": "fired projectile id=1, ammo 30 -> 29" },
    { "name": "hud",  "passed": true, "detail": "HUD ammo label updated to '29 / 30'" }
  ]
}
```
```

#### `PRIVATE_USE_NOTE` & `CREDITS.md` (Deep-Mode Games)
When rebuilding a game in Deep mode:
1. Write `app/CREDITS.md` crediting the original game's creators, engine, and any original assets reused from `app/Original/`.
2. Place this exact blockquote at the very top of `app/README.md`:
```markdown
> **Private study & personal use.** This rebuild was made with Craft Anything's Deep mode from a copy of the original on this computer. Any original art, audio, levels, or close ports of code belong to their creators — keep this build for your own personal use and study, and do not share or redistribute files taken from the original.
```

#### `RUNS_BRIEF` (Console Applications)
```markdown
## Console behaviour
This is a command-line program. Make sure running it with no arguments, with `--help`, and with `--version` exits cleanly and prints help/version/output matching what `capture/study.md` recorded from the original.
```

#### `API_BUILDER` (When an API LLM rather than a CLI coding agent is building)
When the Builder is a direct API backend (`anthropic`, `openai`, `openrouter`, `openai_compatible`) rather than an `AgentCli` (`claude-code`, `codex`, `opencode`, `antigravity`), it writes files using fenced blocks with `file:` headers (` ```tsx file:src/App.tsx `), which Craft Anything unpacks into `app/` and then checks.

---

## 3. Study Prompts & Extractor Prompts (`crates/ai/src/rebuild/study.rs`)

### 3.1 Study Prompt (`study_prompt`)
The Study agent's job is to inspect the target and write `capture/study.md` (not to build the app yet):
- **Clean-room mode**: Use only outside observation tools (`core_target_overview`, `core_file_detect`, `web_site_open`, `web_page_dom`, `web_page_styles`, `app_window_capture`, `app_ui_tree_read`, `runtime_run_observe`). Summarize every screen, control, colour, font, CLI flag, and user-visible behavior in `capture/study.md`.
- **Deep mode**:
  - For **Websites**: Write `capture/how-it-works.md` using `web_page_js_analyze` and a 10-second `web_page_watch` session—document client state, timers, animations, keyboard/mouse handlers, custom elements, and network calls.
  - For **Apps & Games**: Decompile key functions (`native_functions_list`, `native_function_decompile`, `managed_dotnet_decompile`, `java_class_decompile`, `android_class_decompile`), inspect data/config/level archives (`formats_game_archive`, `formats_archive_list`), and write a thorough `capture/study.md` with exact constants, formulas, file formats, and controls.

### 3.2 Extractor Prompt (`extract_prompt` — Deep-Mode Games)
When an Extractor backend is set (`craft-anything-cli ai extractor <name>`), it runs between `Study` and `Build`:
- Inspects the original game's folders and archives (`formats_game_archive`, `formats_archive_list`, `core_archive_extract`).
- Copies or unpacks reusable textures (`.png`, `.jpg`, `.dds`, `.tga`), audio (`.wav`, `.ogg`, `.mp3`), 3D models (`.gltf`, `.glb`, `.obj`, `.fbx`), fonts, and level/data tables into `app/Original/`.
- Writes `app/Original/MANIFEST.md` listing every extracted file, its format/dimensions, and what part of the game uses it so the Builder can load them directly via `extract_brief`.

---

## 4. Target Kinds & Automated Checks (`crates/ai/src/rebuild/kinds/`)

### 4.1 Website Checks (`WebsiteKind` — `crates/ai/src/rebuild/kinds/website.rs`)

`WebVisualCheck` runs against `capture/page.json` and `capture/{desktop,tablet,phone}.png`:
1. **Builds & serves the site**: If `package.json` has a `build` script, runs `npm install` + `npm run build` and serves `dist/` / `build/` / `out/` (or serves `app/` directly for Plain HTML & CSS) on `127.0.0.1:<port>`.
2. **Multi-width capture**: Opens the served URL in headless Chromium at **1440 px**, **768 px**, and **390 px**.
3. **Overall similarity score**:
   - At each width: `60% * layout_similarity + 40% * ssim_perceptual_similarity` (masking volatile video/carousel regions detected by `noise_pass`).
   - Weighted across desktop, tablet, and phone; also factors in text likeness (word Dice similarity) and DOM skeleton structure LCS similarity.
   - Default pass threshold: **≥ 90%**.
4. **Specific actionable design notes** (reported to Builder in `refine_prompt`):
   - **Background or text colour mismatch**: RGB channel diff `> 3` (reports exact `#rrggbb` of original vs built).
   - **Font family mismatch**: Primary body font family differs from original.
   - **Body font size mismatch**: Diff `> 2.0 px`.
   - **Sideways scroll (`overflow-x`)**: `page_w > viewport_w + 1` at 1440, 768, or 390 px.
   - **Heading sizes**: `h1`/`h2`/`h3` size differs by `> 3.0 px`.
   - **Section padding / max-width / items per row**: Block padding differs by `> 6 px`, container `max_w` differs by `> 40 px`, or multi-column `per_row` count doesn't match (e.g., 3 cards per row on desktop vs 1 stacked column).
   - **Missing text or headings**: Lists specific headings or words from the original missing in the build.
   - **Missing images or broken assets**: Count of visible images or failed HTTP requests.
   - **Health & Accessibility**: New console errors, unnamed interactive controls, `<img>` missing `alt`, or `<html>` missing `lang`.
   - **Interactive states (`capture/states.json`)**: Re-runs each captured click/tab/menu trigger on desktop (`1440×900`) and phone (`390×844`) and checks that the page changes and matches `capture/state-*.png`.
   - **Routes (`capture/routes/<slug>/`)**: Checks every captured sub-route URL on the served build.

### 4.2 Desktop & Console App Checks (`AppKind` — `crates/ai/src/rebuild/kinds/app.rs`)

1. **`BuildCheck`**: Runs the stack's compile check (`cargo check`, `npm run build`, `python3 -m py_compile`).
2. **`RunsCheck` (`kinds/runs.rs`)**:
   - For console apps: executes the built binary with `[]`, `["--help"]`, and `["--version"]`.
   - Compares exit codes and requires **≥ 80% word overlap** (`dice_words`) against the original's output.
3. **`ScreenshotCheck` (`kinds/screenshot.rs`)**:
   - For GUI apps: runs the binary with `--screenshot <temp.png>` (timeout 60s).
   - Rejects missing files, tiny files, or blank/solid-colour images (requires **> 1% of pixels** to differ from the corner background colour).
   - If `reference/` or `capture/window.png` exists, computes layout + SSIM similarity and saves a side-by-side comparison to `capture/check-round-<N>/`.
   - If `capture/ui-tree.json` exists, checks that every named control label in `ui-tree.json` is present in `app/` source files.
4. **`DeepOnly(MechanicsCheck)` (`kinds/mechanics.rs`)**:
   - In Deep mode, verifies `app/MECHANICS.md` and `app/mechanics.json` exist and every non-estimated constant appears in `app/` source code.

### 4.3 Game Checks (`GameKind` — `crates/ai/src/rebuild/kinds/game.rs`)

#### 12 Detected Game Engines (`detect_engine`)
Craft Anything inspects files and signatures to identify the original game's engine:
1. **Unreal Engine** (`.uproject`, `.pak`, `Engine/Binaries`, `UE4`/`UE5` signatures)
2. **Unity** (`UnityPlayer.dll`, `Managed/Assembly-CSharp.dll`, `globalgamemanagers`, `data.unity3d`)
3. **Godot** (`project.godot`, `.pck`, `godot` binary signatures)
4. **Source Engine** (`gameinfo.txt`, `.vpk`, `hl2`/`source` signatures)
5. **GameMaker** (`data.win`, `game.ios`, `game.unx`, `FORM` + `GEN8`)
6. **RPG Maker** (`Game.rgss*`, `www/data/System.json`, `data/System.rmmz`)
7. **Ren'Py** (`renpy/`, `.rpa`, `.rpy`, `.rpyc`)
8. **MonoGame / XNA** (`MonoGame.Framework.dll`, `Microsoft.Xna.Framework.dll`, `.xnb`)
9. **LÖVE (Love2D)** (`.love`, `main.lua` + `conf.lua`)
10. **CryEngine** (`game.cryproject`, `.pak` with CryEngine headers)
11. **Cocos2d / Cocos Creator** (`libcocos2d`, `project.json` + `res/import`)
12. **Cube Engine / Sauerbraten** (`packages/`, `.ogz`, `sauerbraten`/`cube2` signatures)

#### Ordered Checks for Games
1. **`BuildCheck`**: Compiles the Unreal, Unity, Godot, or `Rust + macroquad` project in `app/`.
2. **`MechanicsCheck` (`kinds/mechanics.rs`)**:
   - Requires both `app/MECHANICS.md` and `app/mechanics.json`.
   - Parses `constants` array; every entry whose `source` does not contain `"estimated"` must have its numeric value `abs()` (formatted up to 7 significant digits) present as a number token in `app/` source code.
   - In Deep mode, fails if all constants are marked `"estimated"`.
3. **`ScreenshotCheck` (`kinds/screenshot.rs`)**:
   - Runs the built game with `--screenshot <file.png>`, verifies a non-blank rendered frame, and compares against `reference/` or `capture/window.png` if present.
4. **`SelfTestCheck` (`kinds/self_test.rs`)**:
   - Runs the built game with `--self-test <file.json>`.
   - Parses `<file.json>` and verifies:
     - `passed == true`
     - `frames >= 60`
     - Required steps **`"move"`**, **`"act"`**, and **`"hud"`** are all present and each has `passed == true` and non-empty `detail`.
5. **`DeepOnly(CreditsCheck)`**:
   - Verifies `app/CREDITS.md` exists and is non-empty, and `app/README.md` starts with the Private-Use Note (`PRIVATE_USE_NOTE`).

### 4.4 Self-Check & WASM Check Plugins (`crates/ai/src/rebuild/self_check.rs`)
On every check round across all target kinds:
- Scans source files in `app/` for unfinished placeholders (`TODO:`, `FIXME:`, `unimplemented!()`, `todo!()`, `"coming soon"`).
- Runs any loaded WASM check plugins (`plugins_checks_list` / `plugins_check_run`) that match the target kind.

---

## 5. Stacks & UI Libraries Catalog (`crates/ai/src/rebuild/stacks.toml`)

See [`resources/stacks.toml`](../resources/stacks.toml) for the full TOML definition. Summary of the 12 stacks and 2 UI libraries:

| Stack Name | Kind | When Chosen by Default | Build Check Command |
|---|---|---|---|
| **Builder's choice** | Any | When user explicitly selects no fixed stack | Auto-detected from `app/` |
| **Plain HTML and CSS** | Website | **Default for Websites** (zero build step; `app/index.html` opens directly) | Checks `index.html` exists |
| **React + TypeScript (Vite)** | Website / App | When user asks for React or Vite | `npm install` → `npm run build` |
| **Next.js + TypeScript** | Website / App | When user asks for Next.js | `npm install` → `npm run build` |
| **Rust + egui (eframe)** | App | **Default for Desktop GUI Apps** (`eframe = "0.31"`, `image = "0.25"`) | `cargo check` |
| **Rust (console)** | App | **Default for Console Apps** (detected via `subsystem: "console"` or CLI request) | `cargo check` |
| **Electron** | App | When user asks for Electron | `npm install` |
| **Python** | App | When user asks for Python | `python3 -m py_compile` |
| **Rust + macroquad** | Game | **Default for Games** when Unreal/Unity/Godot is not selected or installed (`macroquad = "0.4"`) | `cargo check` |
| **Unreal Engine** | Game | When target is Unreal (or `--build-with unreal`) and Unreal Editor is installed | Headless Unreal build target |
| **Unity** | Game | When target is Unity (or `--build-with unity`) and Unity Editor is installed | Headless Unity `-batchmode -quit` |
| **Godot** | Game | When target is Godot (or `--build-with godot`) and `godot` is installed (`project.godot`, `config_version=5`, Forward+ or Compatibility) | `godot --headless --quit` |

**Optional UI Libraries** (automatically added when mentioned in user request):
- **Tailwind CSS** (`tailwindcss`)
- **shadcn/ui** (`shadcn` / Radix primitives + Tailwind)
