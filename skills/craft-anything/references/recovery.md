<!-- craft-anything skill reference -->
# Recovering when Craft Anything MCP tools are unavailable

If the `craft-anything` MCP tools (`core_target_open`, `native_functions_list`, `web_site_open`, …) are not in your tool list:

1. **Check the CLI on `PATH`**:
   ```sh
   craft-anything-cli --version
   craft-anything-cli doctor --json
   ```
   If `craft-anything-cli` is not on `PATH`, look in `~/.cargo/bin/craft-anything-cli` (or `%USERPROFILE%\.cargo\bin\craft-anything-cli.exe` on Windows), `/usr/local/bin/craft-anything-cli`, or `/Applications/Craft Anything.app/Contents/MacOS/craft-anything-cli`.

2. **Register the MCP server and skill for your client**:
   ```sh
   craft-anything-cli setup --all-detected --yes
   ```
   Or target a single client with `craft-anything-cli setup --client claude_code --yes` (other client IDs: `codex`, `cursor`, `windsurf`, `zed`, `opencode`, `gemini_cli`, `copilot`, `kiro`, `continue_dev`, `antigravity`). Restart the client after running `setup` so it reloads its MCP server list.

3. **Use the CLI directly in the meantime** — every MCP tool is available as a one-shot CLI call with identical JSON input and output:
   ```sh
   craft-anything-cli list --json
   craft-anything-cli describe core_target_open --json
   craft-anything-cli call core_target_open '{"path":"/abs/path/to/target"}' --json
   ```
   Pass `--project <dir>` to keep evidence, notes, and working memory across calls in a shared project folder, and pass `--deep` when the user has enabled Deep mode for that target.

---

## Supported Coding-Agent Clients & Config Locations

`craft-anything-cli setup` and `setup_plan` / `setup_apply` / `setup_doctor` / `setup_uninstall` manage these 11 clients (always backing up modified config files to `<file>.craft-anything.bak` first):

| Client ID | Display Name | Config Path (macOS / Linux / Windows) | Format & Key | Skill Directory |
|---|---|---|---|---|
| `claude_code` | Claude Code | `~/.claude.json` | JSON `mcpServers` | `~/.claude/skills/craft-anything/` |
| `codex` | OpenAI Codex | `~/.codex/config.toml` | TOML `mcp_servers` | `~/.agents/skills/craft-anything/` |
| `cursor` | Cursor | `~/.cursor/mcp.json` | JSON `mcpServers` | `~/.cursor/skills/craft-anything/` |
| `windsurf` | Windsurf | `~/.codeium/windsurf/mcp_config.json` | JSON `mcpServers` | `~/.codeium/windsurf/skills/craft-anything/` |
| `zed` | Zed | macOS: `~/Library/Application Support/Zed/settings.json`<br>Linux: `~/.config/zed/settings.json`<br>Windows: `%APPDATA%\Zed\settings.json` | JSONC `context_servers` | *(MCP only)* |
| `opencode` | OpenCode | `~/.config/opencode/opencode.json` | JSON `mcp` (`type: "local"`, `command: [...]`) | `~/.config/opencode/skills/craft-anything/` |
| `gemini_cli` | Gemini CLI | `~/.gemini/settings.json` | JSON `mcpServers` | `~/.gemini/skills/craft-anything/` |
| `copilot` | GitHub Copilot CLI | `~/.copilot/mcp-config.json` | JSON `mcpServers` | `~/.copilot/skills/craft-anything/` |
| `kiro` | Kiro | `~/.kiro/settings/mcp.json` | JSON `mcpServers` | `~/.kiro/skills/craft-anything/` |
| `continue_dev` | Continue | `~/.continue/config.json` | JSON `experimental.modelContextProtocolServers` | *(MCP only)* |
| `antigravity` | Antigravity (`agy`) | `~/.gemini/antigravity/mcp_config.json` | JSON `mcpServers` | `~/.gemini/config/skills/craft-anything/` |

---

## Full CLI Subcommands Reference (`craft-anything-cli`)

```sh
# 1. List and describe tools
craft-anything-cli list [--toolset <name>] [--search <query>] [--deep] [--json|--md|--text]
craft-anything-cli describe <tool_id> [--json|--md|--text]

# 2. Call any tool directly
craft-anything-cli call <tool_id> ['<json_params>'] [--project <dir>] [--deep] [--allow-run] [--json|--md|--text]

# 3. Full headless Study -> Build -> Check -> Refine workflow
craft-anything-cli rebuild <target_or_-> "<request>" \
  [--projects-dir <dir> | --project-folder <dir> [--existing edit|start-from] | --continue-in <dir> [--resume]] \
  [--backend <name>] [--rounds 2] [--unattended] [--build-with <engine_or_stack>] [--generate-assets] [--deep]

# 4. Headless Investigator chat
craft-anything-cli chat "<question>" [--target <path>] [--backend <name>] [--beginner] [--deep] [--allow-run] [--jsonl]

# 5. Manage AI backends & roles
craft-anything-cli ai list
craft-anything-cli ai detect
craft-anything-cli ai add <name> --kind <anthropic|openai|openrouter|openai_compatible|agent_cli> [--model <m>] [--base-url <u>] [--ssh-host <h>] [--key-env <VAR> | --key-stdin]
craft-anything-cli ai remove <name>
craft-anything-cli ai on <name> | off <name>
craft-anything-cli ai program <name> [<path>]
craft-anything-cli ai model <name> [<model>] [--thinking low|medium|high|xhigh|max | --default]
craft-anything-cli ai effort <name> [low|medium|high|xhigh|max|default]
craft-anything-cli ai builder [<name>]
craft-anything-cli ai extractor [<name>]
craft-anything-cli ai test <name>

# 6. Setup, Doctor, Uninstall & MCP server
craft-anything-cli setup [--dry-run] [--client <id>...] [--all-detected] [--yes] [--no-skill]
craft-anything-cli doctor [--client <id>...] [--json]
craft-anything-cli uninstall
craft-anything-cli mcp [--project <dir>] [--deep]
```

---

## External Engines Table (`crates/engines/src/table.rs`)

Craft Anything works out of the box with its built-in Rust parsers and disassemblers, and automatically uses or installs these 18 optional external engines when available:

| Engine ID | Name | Needed For | Install Mode | Executables (Unix / Windows) |
|---|---|---|---|---|
| `ghidra` | Ghidra (pinned 12.1.4) | Deep mode: richer decompiled code | Guided (`engines_ghidra_Ensure` + Temurin JDK 21) | `analyzeHeadless` / `analyzeHeadless.bat` |
| `adb` | Android platform tools (r37.0.1) | Android devices: apps, logs, screenshots | Pinned download (`engines_engine_install`) | `adb` / `adb.exe` |
| `jadx` | JADX (v1.5.6) | Decompiling Android apps to Java (needs Java) | Pinned download (`engines_engine_install`) | `jadx` / `jadx.bat` |
| `apktool` | Apktool (v3.0.3) | Decoding Android resources (needs Java) | Pinned download (`engines_engine_install`) | `apktool` / `apktool.bat` |
| `chromium` | Chromium-based browser | Studying websites in a live browser | Manual (auto-detected in standard Chrome/Edge/Brave/Chromium paths) | `chromium`, `google-chrome`, `chrome`, `msedge`, `brave` |
| `frida` | Frida | Tracing apps while they run | Manual | `frida` / `frida.exe` |
| `gdb` | GDB | Debugging native programs | Manual | `gdb` / `gdb.exe` |
| `lldb` | LLDB | Debugging Apple apps | Manual | `lldb` / `lldb.exe` |
| `mitmdump` | mitmproxy (`mitmdump`) | Recording an app's network traffic | Manual | `mitmdump` / `mitmdump.exe` |
| `binwalk` | Binwalk | Firmware carving (a second opinion) | Manual | `binwalk` / `binwalk.exe` |
| `unblob` | Unblob | Firmware unpacking (a second opinion) | Manual | `unblob` |
| `ilspy` | ILSpy CLI (`ilspycmd`) | .NET decompiling (a second opinion) | Manual | `ilspycmd` / `ilspycmd.exe` |
| `java` | Java runtime (Temurin JDK 21) | Runs Ghidra, JADX, Apktool, Vineflower | Guided (installed automatically with Ghidra) | `java` / `java.exe` |
| `tshark` | Wireshark (`tshark`) | Reading packet captures (a second opinion) | Manual | `tshark` / `tshark.exe` |
| `objdump` | `objdump` (GNU or LLVM) | Disassembly (a second opinion) | Manual | `objdump`, `llvm-objdump` |
| `rizin` | Rizin (v0.9.1 static on Win x64) | Disassembly (a second opinion) | Pinned on Windows x64 / Manual elsewhere | `rizin` / `rizin.exe` |
| `rtl433` | `rtl_433` | Decoding radio recordings | Manual | `rtl_433` / `rtl_433.exe` |
| `vineflower` | Vineflower (1.12.0 `.jar`) | Decompiling Java classes and JARs (needs Java) | Pinned download (`engines_engine_install`) | `vineflower` / `vineflower.bat` |
