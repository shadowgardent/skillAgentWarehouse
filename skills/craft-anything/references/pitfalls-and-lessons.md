# Craft Anything — Engineering Pitfalls, Lessons & Coding-Agent Adapters

This reference preserves every hard-won rule from `docs/pitfalls.md` along with the coding-agent CLI adapter details (`docs/claude-code.md`, `docs/codex.md`, `docs/opencode.md`, and `crates/ai/src/cli_agents/adapters/antigravity.rs`).

---

## 1. Hard-Won Engineering Lessons (`docs/pitfalls.md`)

### 1.1 Git & Repository Hygiene
- **Never commit large binaries, build artifacts, or real user targets**: Keep test fixtures tiny and synthetic (crafted byte headers in tests or small fixtures generated in `tempfile::tempdir()`).
- **Check `git status` and diff before committing**: Ensure temporary workspace folders, `.craft-anything.bak` files, and screenshots aren't staged accidentally.

### 1.2 Writing Tests
- **Never touch real user configuration files in tests**:
  - Tools like `setup_apply`, `setup_uninstall`, or settings writers must be tested against fake `Host` / `tempdir()` paths or tested only for registration, consent gating, and schema validation (see `crates/setup/src/tools.rs`).
- **Don't rely on optional external tools being installed on CI**:
  - Tests must pass whether or not Ghidra, JADX, ADB, Frida, Godot, Unity, or Unreal are installed on the machine. Gate live integration checks cleanly or test command construction and output parsing deterministically.
- **Test pins and tables at compile/unit-test time**:
  - Every `ExternalEngine` in `crates/engines/src/table.rs` is checked by unit tests to ensure unique lowercase IDs, HTTPS URLs (never `"latest"`), and 64-char lowercase hex SHA-256 digests.
  - Every `stacks.toml` and `assets.toml` change is verified by parser tests.

### 1.3 Building, Processes & Cross-Platform Pitfalls
- **Windows process & path handling**:
  - On Windows, many CLI tools and engines (`analyzeHeadless.bat`, `jadx.bat`, `apktool.bat`, `vineflower.bat`, `npm.cmd`, `npx.cmd`) are `.bat` or `.cmd` wrappers, not `.exe`. `ExternalEngine::exes_windows` explicitly lists `.exe`, `.bat`, and `.cmd` names.
  - Browsers (`chrome.exe`, `msedge.exe`, `brave.exe`) and Ghidra (`/opt/ghidra`, `/usr/share/ghidra`) rarely put themselves on `PATH`. Always check `known_install_paths()` after `PATH`.
- **Never let a child process hang forever**:
  - Every subprocess (`runtime_run_observe`, `cargo check`, `npm run build`, `--screenshot`, `--self-test`, headless Chromium, Ghidra, CLI coding agents) must run with a bounded timeout, kill-on-drop / tree-kill on cancellation, and bounded stdout/stderr readers so a chatty child cannot OOM or deadlock pipes.
- **Archive & decompression bombs**:
  - Never unpack an archive into memory without size and file-count limits. Reject path traversal (`..` or leading `/`) in ZIP/TAR/single-file unpackers (verified by `a_single_file_pin_installs_and_is_found_by_its_name` in `table.rs`).

### 1.4 Rebuild & Check Loop Pitfalls
- **Volatile website regions ruin naive pixel diffs**:
  - Live websites have carousels, clocks, ads, and video backgrounds. Always use `noise_pass: true` in `web_site_capture` so regions that change between two captures of the same page are masked out during `WebVisualCheck`, and combine structural layout similarity (60%) with perceptual SSIM (40%).
- **Sideways scroll (`overflow-x`) is the #1 responsive layout bug**:
  - Rebuilt websites frequently overflow horizontally at `390 px` (phone) or `768 px` (tablet). `WebVisualCheck` explicitly checks `page_w > w + 1` at all three widths and flags it for the Builder.
- **Blank or title-screen screenshots pass naive exit-code checks**:
  - A game or GUI app that exits `0` on `--screenshot` while writing a solid black/grey frame (because it rendered 1 frame before assets loaded) must be caught. `ScreenshotCheck` requires waiting ~120 frames and verifies that `> 1%` of pixels differ from the corner background colour.
- **Unused `mechanics.json` numbers**:
  - An agent might write a great `MECHANICS.md` and `mechanics.json` and then hardcode completely different placeholder numbers in the code. `MechanicsCheck` parses every non-estimated constant in `app/mechanics.json` and verifies that its numeric literal (up to 7 significant digits) actually appears in the source files under `app/`.
- **Games that render a static scene but can't be played**:
  - A static 3D scene passes `--screenshot` but isn't a game. `SelfTestCheck` (`--self-test <file.json>`) forces the build to run 180 frames of synthetic input and prove that `"move"`, `"act"`, and `"hud"` all work and mutate state.

### 1.5 Agent Tooling & Schema Pitfalls
- **`#[serde(deny_unknown_fields)]` on every tool input struct**:
  - Without `deny_unknown_fields`, an LLM calling `{"file": "/path"}` instead of `{"path": "/path"}` gets a confusing "missing field" or silent default instead of learning the exact field name.
- **Strip `_craft` before schema validation**:
  - Over MCP, `_craft` (`{"consent": true}`) is transport metadata handled by `crates/mcp/src/lib.rs` before passing parameters to `Engine::call`.

---

## 2. Coding-Agent CLI Backend Adapters (`crates/ai/src/cli_agents/adapters/`)

Craft Anything can drive external CLI coding agents as the **Builder** or **Investigator** backend (`BackendKind::AgentCli`).

### 2.1 Antigravity Adapter (`crates/ai/src/cli_agents/adapters/antigravity.rs`)
- **Adapter ID**: `antigravity`
- **Executables searched**: `agy`, `antigravity` (plus standard install locations on Windows `%LOCALAPPDATA%\Programs\Antigravity\bin\agy.cmd`, macOS `/Applications/Antigravity.app/Contents/Resources/app/bin/agy`, Linux `/usr/bin/agy`).
- **Invocation**: Runs in the target workspace folder (`--project-folder` / `app/`) with Craft Anything's MCP server registered in `~/.gemini/antigravity/mcp_config.json` and the `craft-anything` skill installed in `~/.gemini/config/skills/craft-anything/`.

### 2.2 Claude Code Adapter (`docs/claude-code.md`, `adapters/claude_code.rs`)
- **Executable**: `claude`
- **Flags**: `-p` (headless print mode), `--output-format stream-json`, `--verbose`, `--dangerously-skip-permissions` (scoped to the rebuild workspace `app/` directory so it can write and compile files unattended).
- **Model & Effort**: Supports `--model <model>` and `--effort low|medium|high|xhigh|max` (`craft-anything-cli ai effort claude-code <level>`).
- **Cost & Token accounting**: Parses `stream-json` `result` events; distinguishes subscription usage (marked `cost_is_estimate: true`, `"about $X at API prices (an estimate, not a bill)"`) from direct API billing.

### 2.3 OpenAI Codex Adapter (`docs/codex.md`, `adapters/codex.rs`)
- **Executable**: `codex`
- **Flags**: `codex exec --json --full-auto -C <workdir> "<prompt>"` (or `--model <m>`).
- **Stream parsing**: Reads JSONL events (`item.completed`, `agent_message`, `command_execution`, `turn.completed`) to emit live `AgentEvent::TextDelta`, `ToolStarted`, and token usage.

### 2.4 OpenCode Adapter (`docs/opencode.md`, `adapters/opencode.rs`)
- **Executable**: `opencode`
- **Flags**: `opencode run --format json` (supports `opencode models` catalog discovery and `--variant low|medium|high|xhigh|max` thinking depth via `craft-anything-cli ai model opencode <model> --thinking <depth>`).
