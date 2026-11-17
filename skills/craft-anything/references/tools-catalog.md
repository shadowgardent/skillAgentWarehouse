# Craft Anything — Complete Tools Catalog, Naming Rules & Clean-Room Allowlist

Craft Anything registers **299 built-in engine tools** across 17 toolsets in `crates/engine`, plus **14 AI/Rebuild/Asset tools** in `crates/ai/src/rebuild/tools.rs` and **4 Setup tools** in `crates/setup/src/tools.rs` (**317 tools total**).

---

## 1. Tool ID Naming Law (`docs/tool-ids.md`)

Every tool has one ID across the CLI, MCP server, Investigator, and Builder prompts.

### Pattern: `<area>_<object>_<action>`
- **Three words** joined by underscores (`_`).
- **`<area>`**: The kind of target or subsystem (`core`, `native`, `apple`, `formats`, `managed`, `android`, `java`, `adb`, `web`, `js`, `runtime`, `frida`, `app`, `db`, `project`, `projects`, `engines`, `plugins`, `settings`, `setup`, `rebuild`, `assets`, `ai`).
- **`<object>`**: Singular when acting on one thing (`native_function_decompile`), plural when listing or searching many (`native_functions_list`, `core_strings_search`).
- **`<action>`**: Present-tense verb at the end (`open`, `show`, `list`, `read`, `write`, `search`, `inspect`, `decompile`, `capture`, `compare`, `check`, `verify`, `record`, `update`, `export`, `install`, `delete`).
- **Four words (`<area>_<group>_<object>_<action>`)** only when an area has a distinct sub-domain (`managed_dotnet_types`, `managed_wasm_imports`, `apple_macho_headers`, `formats_pe_resources`, `engines_ghidra_status`).
- **Two words (`<object>_<action>`)** only for app-wide settings and project lists (`settings_get`, `settings_set`, `projects_list`, `project_create`).
- **No aliases**: A tool has one ID everywhere.

---

## 2. Clean-Room Mode Allowlist (`crates/engine/src/clean_room.rs`)

By default (`deep_mode = false`), only the **95 Clean-room tools** below (plus the AI/Setup layer tools) are visible and callable. Calling any Deep-mode tool in Clean-room mode returns an error explaining that the tool inspects internal code/files and requires Deep mode (`--deep` or `settings_set` `deep_mode = true`).

```text
# Project & Working Memory (36 tools)
core_tools_catalog, core_tool_describe, core_investigation_show, core_brief_write,
core_plan_update, core_hypothesis_record, core_hypothesis_update, core_finding_record,
core_unknown_add, core_unknown_edit, core_evidence_list, core_evidence_get,
core_evidence_browse, core_annotation_add, core_annotations_list, core_rename_symbol,
core_renames_list, core_bookmark_add, core_bookmarks_list, core_tag_add, core_tags_list,
core_Graph_show, core_graph_query, core_report_generate, core_report_save,
core_handoff_write, core_journal_read, core_Export_bundle, core_ask_user,
core_approval_request, core_inbox_list, core_inbox_wait, core_inbox_answer,
core_target_open, core_target_overview, core_file_detect,

# Live Website Study from Outside (18 tools)
web_site_open, web_site_crawl, web_page_dom, web_page_styles, web_page_assets,
web_page_Screenshot, web_page_accessibility, web_page_interact, web_page_watch,
web_page_states_capture, web_site_capture, web_capture_compare, web_har_inspect,
web_openapi_infer, web_graphql_introspect, web_websocket_inspect, web_cookie_audit,
web_csp_analyze,

# Running Program Observation from Outside (7 tools)
runtime_run_observe, runtime_process_tree, runtime_env_inspect, runtime_files_watch,
runtime_network_capture, runtime_http_record, runtime_tls_inspect,

# Android Device Outside Observation via ADB (10 tools)
adb_devices_list, adb_device_info, adb_packages_list, adb_package_path,
adb_logcat_read, adb_activity_start, adb_ui_dump, adb_screenshot_take,
adb_shell_run, adb_port_forward,

# Desktop Window / Accessibility / Clean-Room Claim Check (13 tools)
app_window_capture, app_ui_tree_read, app_state_model_infer, app_feature_matrix,
app_permissions_map, app_data_flows, app_telemetry_detect, app_crypto_audit,
app_rebuild_brief, app_rebuild_scaffold, app_rebuild_claim_check,
app_cleanroom_handoff, app_graphs_compare,

# Projects, Settings, Engines & Plugins Management (25 tools)
projects_list, project_create, project_open, project_delete, project_archive_export,
project_archive_import, project_assets_allow, assets_budget_show, assets_image_generate,
assets_model_generate, engines_status_list, engines_doctor_run, engines_engine_install,
engines_engine_uninstall, plugins_wasm_list, plugins_wasm_load, plugins_wasm_call,
plugins_checks_list, plugins_check_run, plugins_mcp_list, plugins_mcp_connect,
plugins_mcp_call, plugins_mcp_disconnect, settings_get, settings_set,

# AI / Rebuild / Setup Layer Tools (18 tools)
rebuild_start, rebuild_status, rebuild_continue, rebuild_stop,
assets_key_status, assets_key_set, assets_key_remove,
ai_models_list, ai_model_set,
setup_plan, setup_apply, setup_doctor, setup_uninstall
```

*(Note: lowercase IDs in all calls: `core_graph_show`, `core_export_bundle`, `web_page_screenshot`.)*

---

## 3. AI, Rebuild, Asset Key & Setup Layer Tools (18 Tools)

Registered in `crates/ai/src/rebuild/tools.rs` and `crates/setup/src/tools.rs`:

| Tool ID | Title | Summary |
|---|---|---|
| `rebuild_start` | Rebuild a website, app or game | Run the full `study → build → check → refine` loop (`target`, `request`, `projects_dir`, `project_folder`, `existing: "edit"\|"start-from"`, `backend`, `rounds`, `unattended`, `build_with`, `generate_assets`, `wait`). |
| `rebuild_status` | Check a rebuild project | Read a project folder's `craft.json`, `build-progress.json`, current step, similarity score, check reports, and open questions. |
| `rebuild_continue` | Follow up or resume a rebuild | Send a follow-up request (`message`) or resume a paused/interrupted run (`resume: true`) in `project_folder`. |
| `rebuild_stop` | Stop a running rebuild | Stop a background rebuild run started with `wait: false`. |
| `assets_key_status` | Check the fal.ai key | Check whether a `fal.ai` key is stored for generating game images and 3D models. |
| `assets_key_set` | Save a fal.ai key | Store the `fal.ai` API key in the OS credential store (`key` or `key_env`). |
| `assets_key_remove` | Remove the fal.ai key | Delete the stored `fal.ai` API key. |
| `ai_models_list` | List models for an AI backend | List available models (and thinking depths for OpenCode) for a backend. |
| `ai_model_set` | Set the model for an AI backend | Set the model and optional thinking depth (`low`, `medium`, `high`, `xhigh`, `max`) or `default: true`. |
| `setup_plan` | Plan connecting agent apps | Preview config file changes and skill installation across coding-agent clients without writing (`clients`, `all_detected`, `skill`). |
| `setup_apply` | Connect agent apps | Back up client configs, register Craft Anything's MCP server, and install the skill (`EXECUTES_FOREIGN_CODE` consent). |
| `setup_doctor` | Check the setup | Check binary installation, client MCP registrations, external engines, and AI backend reachability. |
| `setup_uninstall` | Disconnect agent apps | Remove Craft Anything's MCP entries and managed skill files from all clients. |

---

## 4. Complete Catalog of All 299 Engine Tools (by Toolset)

### 4.1 Core (`core` — 48 tools)

| Tool ID | Mode | Summary |
|---|---|---|
| `core_tools_catalog` | Clean | List available tools filtered by toolset, keyword, or effect flags. |
| `core_tool_describe` | Clean | Full JSON Schema and metadata for a single tool by ID. |
| `core_investigation_show` | Clean | Current investigation state: target, brief, plan, counts of evidence, hypotheses, findings, unknowns. |
| `core_brief_write` | Clean | Write or update the investigation brief (goal, scope, constraints, questions). |
| `core_plan_update` | Clean | Replace the ordered investigation plan (steps with status and notes). |
| `core_hypothesis_record` | Clean | Record a new testable hypothesis with predictions. |
| `core_hypothesis_update` | Clean | Update a hypothesis status (`proposed`, `testing`, `supported`, `refuted`, `inconclusive`) and attach supporting/refuting `ev_...` IDs. |
| `core_finding_record` | Clean | Record a verified finding with required `ev_...` citations and confidence (`high`, `medium`, `low`). |
| `core_unknown_add` | Clean | Record an explicit unknown or gap in understanding, with a suggested next step. |
| `core_unknown_edit` | Clean | Resolve, reprioritize, or remove an unknown by ID or question text. |
| `core_evidence_list` | Clean | List recorded evidence items (`ev_...`) with kind, summary, tool, and timestamp. |
| `core_evidence_get` | Clean | Retrieve the full record and payload of an evidence item by ID. |
| `core_evidence_browse` | Clean | Page through array fields of a stored evidence item (`offset`, `limit`, `field`, `filter`). |
| `core_annotation_add` | Clean | Attach a human or agent note to an address, offset, symbol, or file path. |
| `core_annotations_list` | Clean | List all annotations in the current workspace. |
| `core_rename_symbol` | Clean | Record a meaningful name for a function, symbol, or address across the workspace. |
| `core_renames_list` | Clean | List all symbol/address renames in the workspace. |
| `core_bookmark_add` | Clean | Bookmark an important address, offset, or location with a label. |
| `core_bookmarks_list` | Clean | List all bookmarks in the workspace. |
| `core_tag_add` | Clean | Attach a categorical tag to an evidence item, function, or file. |
| `core_tags_list` | Clean | List all tags in the workspace. |
| `core_graph_show` | Clean | Summarize the program graph (nodes and edges by kind). |
| `core_graph_query` | Clean | Query nodes, neighbors, or shortest paths in the program graph. |
| `core_report_generate` | Clean | Generate a structured Markdown investigation report citing all findings, hypotheses, unknowns, and evidence. |
| `core_report_save` | Clean | Save a Markdown report to `reports/<name>.md` in the workspace. |
| `core_handoff_write` | Clean | Write a session handoff summary (done, next steps, blockers, key evidence) for future sessions. |
| `core_journal_read` | Clean | Read the chronological tool/event journal (`offset`, `limit`). |
| `core_export_bundle` | Clean | Export a portable JSON bundle of workspace state, findings, and evidence metadata. |
| `core_ask_user` | Clean | Ask the user a clarifying question with optional multiple-choice options via the workspace inbox. |
| `core_approval_request` | Clean | Request explicit user approval for an action outside the workspace. |
| `core_inbox_list` | Clean | List pending and answered user questions/approval requests. |
| `core_inbox_wait` | Clean | Wait for a user answer to a pending inbox request ID. |
| `core_inbox_answer` | Clean | Submit an answer to a pending inbox request ID. |
| `core_target_open` | Clean | Set the primary target file or directory for the workspace and index its basic metadata. |
| `core_target_overview` | Clean | High-level overview of the open target (type, size, architecture, hashes, format summary). |
| `core_file_detect` | Clean | Identify file format by magic bytes and structural signatures (not file extension). |
| `core_hashes_compute` | Deep | Compute MD5, SHA-1, SHA-256, and SHA-512 hashes of a file or byte range. |
| `core_bytes_read` | Deep | Read raw bytes (hex + ASCII preview) from a file at `offset` and `length` (max 64 KiB). |
| `core_bytes_search` | Deep | Search a file for exact byte sequences, hex patterns (with `??` wildcards), or UTF-8/UTF-16 strings. |
| `core_strings_extract` | Deep | Extract printable ASCII and UTF-16LE/BE strings with file offsets and sections. |
| `core_strings_search` | Deep | Search extracted strings by substring or regex, or classify URLs, paths, keys, and errors. |
| `core_entropy_map` | Deep | Compute Shannon entropy across fixed-size blocks to spot packed, encrypted, or compressed regions. |
| `core_byte_histogram` | Deep | Count frequency of all 256 byte values across a file or range. |
| `core_files_diff` | Deep | Structural and byte-level comparison between two files. |
| `core_directory_tree` | Deep | Walk a directory tree with file sizes, detected formats, and depth/count bounds. |
| `core_archive_extract` | Deep | Safely extract an archive (ZIP, tar, gzip, xz, 7z) into a workspace staging folder. |
| `core_hexdump_slice` | Deep | Formatted canonical hex+ASCII dump of a file slice. |
| `core_magic_scan` | Deep | Scan a file for embedded magic signatures at arbitrary offsets (carving preview). |

### 4.2 Native Binaries (`native` — 46 tools, all Deep mode)

| Tool ID | Summary |
|---|---|
| `native_binary_summary` | Parse ELF, PE, or Mach-O headers: architecture, endianness, entry point, image base, subsystem, security mitigations. |
| `native_sections_list` | List sections with virtual address, file offset, size, permissions, and Shannon entropy. |
| `native_segments_list` | List program headers / load segments and memory mappings. |
| `native_symbols_list` | List symbol table entries (dynamic and static) with demangled names and addresses. |
| `native_imports_list` | List imported libraries and functions (IAT / PLT / GOT / dyld binds) categorized by capability. |
| `native_exports_list` | List exported functions and data symbols with addresses and ordinals. |
| `native_relocations_list` | List relocation entries with type, address, and target symbol. |
| `native_Dynamic_tags` | List ELF `.dynamic` tags, PE data directories, or Mach-O load commands (`native_dynamic_tags`). |
| `native_functions_list` | Discover and list functions (from symbols, call targets, prologue scan, exception tables, or Ghidra) with address and size. |
| `native_function_disassemble` | Disassemble a function or address range (`x86`, `x86_64`, `arm64`, `arm`, `riscv`, `mips`) with branch targets and comments. |
| `native_function_decompile` | Decompile a native function to readable C-like pseudocode (uses Ghidra when installed, built-in structured decompiler otherwise). |
| `native_cfg_build` | Build the Control Flow Graph (basic blocks and conditional/unconditional edges) of a function. |
| `native_callgraph_build` | Build the caller/callee call graph across the binary and populate the workspace graph. |
| `native_xrefs_to` | Find code and data cross-references (`CALL`, `JMP`, RIP-relative / ADRP loads) pointing to an address. |
| `native_xrefs_from` | Find all outgoing calls, jumps, and data references from a function or address range. |
| `native_strings_xrefs` | Match extracted strings to the functions and instructions that reference them. |
| `native_constants_scan` | Scan instructions for notable immediate constants (magic numbers, crypto constants, port numbers, flags). |
| `native_syscalls_find` | Locate direct system call instructions (`syscall`, `svc #0`, `int 0x80`) and infer syscall numbers. |
| `native_crypto_constants` | Scan binary sections for known cryptographic S-boxes, IVs, and constants (AES, SHA, ChaCha20, RSA, CRC). |
| `native_mitigations_check` | Check security hardening: PIE/ASLR, NX/DEP, stack canaries, RELRO, Control Flow Guard, Pointer Authentication. |
| `native_compiler_detect` | Identify compiler, language runtime (Rust, Go, C++, MSVC, Clang, GCC, Zig), and packer/protector hints. |
| `native_eh_frame_parse` | Parse `.eh_frame` / `.pdata` unwind tables to recover exact function boundaries in stripped binaries. |
| `native_vtables_find` | Detect C++ virtual method tables (vtables) and reconstruct method pointer arrays. |
| `native_rtti_recover` | Recover C++ Run-Time Type Information (Itanium ABI and MSVC RTTI class names and hierarchies). |
| `native_go_metadata` | Parse Go `pclntab` to recover function names, source file paths, line numbers, and Go types in stripped Go binaries. |
| `native_rust_metadata` | Extract Rust compiler version, crate dependencies (`cargo` metadata / panic strings), and demangled symbols. |
| `native_objc_metadata` | Extract Objective-C classes, selectors, protocols, and instance variables from `__objc_*` sections. |
| `native_swift_metadata` | Extract Swift type descriptors, protocols, field offsets, and demangled Swift symbols. |
| `native_tls_callbacks` | List PE Thread Local Storage (TLS) callbacks and ELF `.init_array` / `.fini_array` constructors. |
| `native_resources_list` | List embedded native resources (PE `.rsrc` icons, manifests, version info, string tables). |
| `native_debug_info` | Inspect DWARF sections, PDB path/GUID (`RSDS`), or Mach-O `LC_UUID` debug links. |
| `native_dwarf_types` | Recover struct, union, enum, and function signatures from DWARF debug info when present. |
| `native_stack_frame` | Analyze stack pointer adjustments and local variable stack frame layout of a function. |
| `native_switch_tables` | Detect and recover jump tables / switch-case dispatch targets inside a function. |
| `native_idioms_recognize` | Recognize compiler idioms (division by multiplication, `memcpy`/`memset` inlines, string ops). |
| `native_function_signature` | Infer calling convention, parameter count, register arguments, and return usage of a function. |
| `native_similarity_hash` | Compute structural / instruction-mnemonic hashes of functions to match across stripped builds. |
| `native_binary_diff` | Diff two versions of a native binary at the section, symbol, and function level. |
| `native_patch_preview` | Preview assembling/patching bytes at a virtual address or file offset without mutating the original target. |
| `native_ patch_apply` | Write a patched copy of the binary to the workspace (`native_patch_apply`). |
| `native_va_to_offset` | Convert between Virtual Address (VA), Relative Virtual Address (RVA), and raw file offset. |
| `native_pointer_table` | Read an array of pointer-sized values at a virtual address and resolve target symbols/strings. |
| `native_struct_overlay` | Overlay a C-style field layout onto bytes at a virtual address or file offset. |
| `native_ghidra_decompile` | Explicitly decompile a function via headless Ghidra (caches the Ghidra project in workspace). |
| `native_ghidra_types` | Export recovered data types and function prototypes from the workspace's Ghidra project. |
| `native_ghidra_script` | Run a bounded read-only Ghidra analysis query against the target binary. |

### 4.3 Apple / macOS / iOS (`apple` — 14 tools, all Deep mode)

| Tool ID | Summary |
|---|---|
| `apple_bundle_inspect` | Inspect a `.app`, `.framework`, `.kext`, or `.ipa` bundle structure, executable, and resources. |
| `apple_plist_read` | Parse XML or binary `.plist` files (`Info.plist`, entitlements, preferences) to JSON. |
| `apple_universal_inspect` | Inspect fat / Universal Mach-O headers and list architecture slices (`x86_64`, `arm64`, `arm64e`). |
| `apple_macho_headers` | Detailed Mach-O load commands, `LC_MAIN`, rpaths, dylib dependencies, and UUIDs. |
| `apple_codesign_verify` | Parse embedded `LC_CODE_SIGNATURE` SuperBlob, certificates, Team ID, and CodeDirectory hashes. |
| `apple_entitlements_read` | Extract embedded XML/DER entitlements from a Mach-O code signature. |
| `apple_dyld_info` | Inspect dyld rebase, bind, weak bind, lazy bind, and export trie tables. |
| `apple_objc_classes` | List Objective-C classes, methods (`+`/`-`), ivars, and protocols with implementation addresses. |
| `apple_swift_types` | List Swift structs, classes, enums, and protocol conformances from `__swift5_*` sections. |
| `apple_assets_car_inspect` | Parse compiled Apple Asset Catalogs (`Assets.car` / BOM format) and list named images/colors/data. |
| `apple_nib_inspect` | Parse compiled Interface Builder `.nib` (`NIBArchive` / keyed archives) view hierarchies and outlets. |
| `apple_strings_read` | Parse localized `.strings` and `.stringsdict` files (UTF-8, UTF-16, or binary plist). |
| `apple_pkg_inspect` | Inspect macOS `.pkg` (XAR) installers, `PackageInfo`, BOM bill-of-materials, and scripts. |
| `apple_dmg_inspect` | Inspect Apple Disk Images (`.dmg` UDIF / trailer / partition layout). |

### 4.4 Formats, Archives, Firmware & Captures (`formats` — 24 tools, all Deep mode)

| Tool ID | Summary |
|---|---|
| `formats_container_detect` | Deep container & sub-format identification (archives, installers, disk images, game packs, media). |
| `formats_archive_list` | List entries in ZIP, TAR, GZIP, BZIP2, XZ, ZSTD, 7z, or RAR archives with sizes and CRCs. |
| `formats_archive_read` | Read or extract a single member from an archive without unpacking everything. |
| `formats_pe_resources` | Parse Windows PE `.rsrc` tree: icons, dialogs, menus, `RT_MANIFEST`, and `VS_VERSIONINFO`. |
| `formats_msi_inspect` | Parse Windows Installer `.msi` (OLE Compound File / CFB) streams and tables. |
| `formats_asar_inspect` | Parse Electron `.asar` archives: read JSON header tree and extract packaged JS/HTML/assets. |
| `formats_wasm_summary` | Summarize a `.wasm` module: sections, imports, exports, functions, memory, and custom sections. |
| `formats_pdf_inspect` | Inspect PDF object tree, streams, metadata, embedded files, and JavaScript actions. |
| `formats_office_inspect` | Inspect OOXML (`.docx`, `.xlsx`, `.pptx`) or OLE2 documents, macros, and embedded relationships. |
| `formats_image_metadata` | Read PNG, JPEG, WebP, GIF, BMP, TIFF, ICO dimensions, chunks, EXIF, and text metadata. |
| `formats_media_containers` | Parse MP4/MOV (`ftyp`/`moov` boxes), Matroska/WebM, WAV/RIFF, or Ogg container structure. |
| `formats_protobuf_decode` | Decode raw Protocol Buffers wire format bytes without a `.proto` schema (wire types & nested messages). |
| `formats_msgpack_decode` | Decode MessagePack, CBOR, or BSON binary payloads to JSON. |
| `formats_flatbuffers_inspect` | Inspect FlatBuffers root tables, vtables, and strings. |
| `formats_firmware_scan` | Scan firmware images for bootloaders, filesystems (SquashFS, JFFS2, CramFS, UBI, romfs), kernels, and certificates. |
| `formats_firmware_carve` | Carve an embedded filesystem or compressed stream out of a firmware image at a given offset. |
| `formats_uf2_parse` | Parse UF2 microcontroller flashing images into contiguous memory segments and family IDs. |
| `formats_intelhex_parse` | Parse Intel HEX (`.hex`) or Motorola S-Record (`.srec`) firmware files into binary segments. |
| `formats_pcap_summary` | Parse `.pcap` / `.pcapng` packet captures: protocols, endpoints, conversations, and DNS/HTTP summaries. |
| `formats_pcap_streams` | Reassemble TCP/UDP streams from a `.pcap` or `.pcapng` file. |
| `formats_tls_certs` | Parse X.509 certificates (DER or PEM): subject, issuer, SANs, validity, public key, and signature algorithm. |
| `formats_jwt_inspect` | Decode and inspect JWT / JWS headers and claims (without forging signatures). |
| `formats_font_inspect` | Parse TrueType/OpenType (`.ttf`, `.otf`, `.woff`, `.woff2`) font tables, family names, and glyph metrics. |
| `formats_game_archive` | Detect and list game data archives (PAK, WAD, VPK, PCK, UnityFS/AssetBundle, RGSS, RPA). |

### 4.5 Managed Run-Times: .NET, Python, WebAssembly (`managed` — 12 tools, all Deep mode)

| Tool ID | Summary |
|---|---|
| `managed_dotnet_summary` | Parse .NET CLR metadata (`BSJB`): assembly name, target framework, entry point, module references. |
| `managed_dotnet_types` | List .NET namespaces, classes, interfaces, structs, and enums with methods and fields. |
| `managed_dotnet_methods` | List methods of a .NET type with signatures, RVA, and IL byte sizes. |
| `managed_dotnet_disassemble` | Disassemble CIL / MSIL bytecode of a .NET method with resolved metadata tokens. |
| `managed_dotnet_decompile` | Decompile a .NET type or method to C# (uses `ilspycmd` if installed, built-in CIL lifter otherwise). |
| `managed_dotnet_strings` | Read the .NET `#US` (user strings) and `#Strings` metadata heaps. |
| `managed_dotnet_resources` | List and extract embedded .NET `ManifestResource` streams and `.resources` entries. |
| `managed_wasm_imports` | List WebAssembly imported modules, functions, tables, memories, and globals. |
| `managed_wasm_exports` | List WebAssembly exported functions, memories, tables, and globals. |
| `managed_wasm_disassemble` | Disassemble a WebAssembly function body into WAT (WebAssembly Text) instructions. |
| `managed_python_pyc` | Parse Python `.pyc` bytecode headers, code objects, constants, names, and disassembled opcodes. |
| `managed_pyinstaller_unpack` | Detect and list/extract PyInstaller (`MEI\x0c\x0b\x0a\x0b\x0e`) CArchive bundles and embedded `.pyc` files. |

### 4.6 Android APK / DEX (`android` — 14 tools, all Deep mode)

| Tool ID | Summary |
|---|---|
| `android_apk_summary` | Overview of an APK/AAB/XAPK: package name, version, SDK levels, DEX count, native `.so` libraries, signing status. |
| `android_manifest_read` | Decode binary `AndroidManifest.xml` (AXML): activities, services, receivers, providers, permissions, intent filters. |
| `android_permissions_analyze` | Map requested Android permissions to capabilities and risk levels. |
| `android_resources_table` | Parse `resources.arsc`: resource IDs (`0x7f...`), configurations, strings, and styles. |
| `android_dex_summary` | Summarize `classes*.dex` headers, string/type/proto/field/method counts, and multidex layout. |
| `android_dex_classes` | List classes across all DEX files with package filtering, superclass, interfaces, and method counts. |
| `android_dex_methods` | List methods in a DEX class with descriptors, access flags, and Dalvik code offsets. |
| `android_dex_strings` | Search or list strings across `classes*.dex` string tables. |
| `android_method_disassemble` | Disassemble Dalvik bytecode (`smali`-style) for an Android method. |
| `android_class_decompile` | Decompile an Android class to Java (uses JADX when installed, built-in DEX decompiler otherwise). |
| `android_signing_verify` | Inspect APK v1 (JAR), v2, and v3 signing blocks and signer certificates. |
| `android_native_libs` | List bundled `lib/<abi>/*.so` native libraries and their JNI `Java_*` / `JNI_OnLoad` exports. |
| `android_deeplinks_list` | Extract all `intent-filter` deep links, custom URL schemes, and App Links from the manifest. |
| `android_network_config` | Inspect `network_security_config.xml` (cleartext traffic rules, pinned certificates, trust anchors). |

### 4.7 Java / JVM (`java` — 8 tools, all Deep mode)

| Tool ID | Summary |
|---|---|
| `java_jar_inspect` | Inspect a `.jar`, `.war`, or `.ear`: `META-INF/MANIFEST.MF`, main class, packages, and service providers. |
| `java_class_inspect` | Parse `.class` bytecode (magic `0xCAFEBABE`): major/minor JDK version, access flags, superclass, interfaces, fields, methods, attributes. |
| `java_constant_pool` | Dump the constant pool of a `.class` file (`Utf8`, `Class`, `Methodref`, `Fieldref`, `String`, `InvokeDynamic`). |
| `java_method_disassemble` | Disassemble JVM bytecode instructions of a method with constant pool resolution and exception tables. |
| `java_class_decompile` | Decompile a `.class` or `.jar` class to Java source (uses Vineflower when installed, built-in JVM decompiler otherwise). |
| `java_annotations_read` | Read `RuntimeVisibleAnnotations` and `RuntimeInvisibleAnnotations` on classes, methods, and fields (Spring/JAX-RS routes, etc.). |
| `java_serialization_inspect` | Parse Java Object Serialization streams (`0xACED0005`) into class descriptors and field values. |
| `java_jmod_inspect` | Inspect Java 9+ `.jmod` or `modules` image containers and `module-info.class` descriptors. |

### 4.8 Android ADB Live Device (`adb` — 10 tools, all Clean-room allowed)

| Tool ID | Summary |
|---|---|
| `adb_devices_list` | List connected Android devices and emulators via `adb devices -l`. |
| `adb_device_info` | Read device properties (`getprop`: model, Android version, ABI, security patch). |
| `adb_packages_list` | List installed packages (`pm list packages`) with optional filter. |
| `adb_package_path` | Get the on-device APK path (`pm path`) for a package. |
| `adb_logcat_read` | Read a bounded snapshot of `logcat` filtered by tag, PID, or priority. |
| `adb_activity_start` | Start an exported activity or intent on the device (`MUTATES_DEVICE` consent). |
| `adb_ui_dump` | Dump the current screen's accessibility UI hierarchy (`uiautomator dump`). |
| `adb_screenshot_take` | Capture a PNG screenshot from the connected Android device (`screencap -p`). |
| `adb_shell_run` | Run a bounded command via `adb shell` (`EXECUTES_FOREIGN_CODE` + `MUTATES_DEVICE` consent). |
| `adb_port_forward` | Set up or list `adb forward` TCP port forwards. |

### 4.9 Live Browser & Website Study (`browser` / `web_*` — 19 tools: 18 Clean-room + 1 Deep)

| Tool ID | Mode | Summary |
|---|---|---|
| `web_site_open` | Clean | Fetch a URL and inspect HTTP status, headers, title, meta tags, links, scripts, and stylesheets. |
| `web_site_crawl` | Clean | Crawl internal links up to a bounded page/depth limit and map the site's route structure. |
| `web_page_dom` | Clean | Render the page in headless Chromium and extract the live DOM tree, landmarks, headings, and controls. |
| `web_page_styles` | Clean | Extract computed CSS styles, colour palette, font families/sizes, spacing tokens, and layout boxes. |
| `web_page_assets` | Clean | List images, SVGs, fonts, stylesheets, and media loaded by the page. |
| `web_page_screenshot` | Clean | Capture full-page or viewport PNG screenshots at specified widths (`1440`, `768`, `390`, etc.). |
| `web_page_accessibility` | Clean | Extract the accessibility tree (roles, accessible names, states, unnamed control warnings). |
| `web_page_interact` | Clean | Perform scripted interactions in headless Chromium (`click`, `hover`, `type`, `select`, `scroll`, `press_key`, `wait_ms`) and observe changes. |
| `web_page_watch` | Clean | Watch a live page in Chromium for `seconds` (up to 60s), recording mutations, network requests, console logs, and timers. |
| `web_page_states_capture` | Clean | Automatically click menus, tabs, accordions, and dialog triggers at a given viewport (`1440×900` or `390×844`) and capture each state's diff & screenshot. |
| `web_site_capture` | Clean | Complete multi-viewport study capture (`widths: [1440, 768, 390]`, `noise_pass: true`): saves `desktop.png`, `tablet.png`, `phone.png`, and `page.json`. |
| `web_capture_compare` | Clean | Compare a rebuilt site against a captured reference (`page.json` + screenshots), returning visual, text, and structure similarity plus design notes. |
| `web_page_js_analyze` | **Deep** | Inspect all loaded scripts, globals, event listeners, custom elements, state stores, and timers on a live page. |
| `web_har_inspect` | Clean | Parse a `.har` (HTTP Archive) file: endpoints, status codes, timings, headers, and JSON payloads. |
| `web_openapi_infer` | Clean | Infer an OpenAPI 3.0 specification from observed HTTP/HAR traffic. |
| `web_graphql_introspect` | Clean | Inspect GraphQL queries/mutations from traffic or run a standard introspection query against an endpoint. |
| `web_websocket_inspect` | Clean | Inspect WebSocket upgrade handshakes and message frames from a capture. |
| `web_cookie_audit` | Clean | Audit `Set-Cookie` attributes (`HttpOnly`, `Secure`, `SameSite`, domain, expiration). |
| `web_csp_analyze` | Clean | Parse and evaluate `Content-Security-Policy` headers and directives. |

### 4.10 JavaScript & Bundles (`javascript` / `js_*` — 12 tools, all Deep mode)

| Tool ID | Summary |
|---|---|
| `js_bundle_inspect` | Detect bundler (Webpack, Vite/Rollup, Parcel, esbuild, Metro/Hermes) and list module chunks. |
| `js_sourcemap_unpack` | Parse `.map` source maps (or inline `sourceMappingURL`) and reconstruct original TypeScript/JS source files. |
| `js_ast_outline` | Parse JS/TS with `oxc` and outline functions, classes, exports, imports, and React components. |
| `js_beautify_slice` | Format/pretty-print a minified JavaScript file or byte/line slice using `oxc`. |
| `js_webpack_modules` | Extract individual modules and module IDs from a Webpack bundle (`__webpack_modules__` / `webpackChunk`). |
| `js_strings_extract` | Extract string literals, template literals, URLs, API paths, and GraphQL queries from JS AST. |
| `js_api_routes` | Scan JS/TS bundles for `fetch`, `axios`, `XMLHttpRequest`, WebSocket, and router path definitions. |
| `js_env_keys` | Find referenced environment variables (`process.env.*`, `import.meta.env.*`, `NEXT_PUBLIC_*`) and public config objects. |
| `js_deobfuscate_const` | Fold constant expressions, hex/unicode escapes, and string-array lookups in obfuscated JS. |
| `js_callgraph_extract` | Build a function-to-function call graph from JavaScript/TypeScript AST. |
| `js_electron_inspect` | Analyze an Electron app's `package.json`, main process entry, preload scripts, `contextBridge`, and `ipcMain`/`ipcRenderer` channels. |
| `js_hermes_inspect` | Detect and inspect React Native Hermes bytecode (`c61fbc03...`) headers and string tables. |

### 4.11 Runtime & Dynamic Observation (`runtime` — 12 tools: 7 Clean-room + 5 Deep)

| Tool ID | Mode | Summary |
|---|---|---|
| `runtime_run_observe` | Clean | Run an executable with args/stdin inside a bounded timeout and capture exit code, stdout, and stderr (`EXECUTES_FOREIGN_CODE` consent). |
| `runtime_process_tree` | Clean | Inspect running process tree, PID, command line, and open ports. |
| `runtime_env_inspect` | Clean | Inspect environment variables and working directory of a process or launch config. |
| `runtime_files_watch` | Clean | Observe filesystem reads/writes inside a directory during a bounded run. |
| `runtime_network_capture` | Clean | Capture TCP/UDP connections and packet summaries during a bounded run. |
| `runtime_http_record` | Clean | Record HTTP/HTTPS requests and responses via local proxy (`mitmdump` when available). |
| `runtime_tls_inspect` | Clean | Inspect TLS handshakes, SNI hostnames, ALPN protocols, and server certificates. |
| `runtime_trace_syscalls` | **Deep** | Trace system calls or dynamic library calls of a target process (`EXECUTES_FOREIGN_CODE` consent). |
| `runtime_memory_regions` | **Deep** | List virtual memory mappings (`/proc/<pid>/maps` / `vmmap` / `VirtualQueryEx`) of a target process. |
| `runtime_memory_dump` | **Deep** | Read a bounded slice of process memory at an address (`EXECUTES_FOREIGN_CODE` consent). |
| `runtime_debugger_run` | **Deep** | Run a bounded non-interactive GDB or LLDB command batch (breakpoints, backtrace, registers). |
| `runtime_crash_triage` | **Deep** | Parse a crash log, minidump (`.dmp`), or Apple `.ips` crash report and symbolize stack frames. |

### 4.12 Frida Dynamic Instrumentation (`frida` — 8 tools, all Deep mode, require `EXECUTES_FOREIGN_CODE` consent)

| Tool ID | Summary |
|---|---|
| `frida_Status_check` | Check Frida CLI/server availability and version (`frida_status_check`). |
| `frida_processes_list` | List attachable processes on host or USB device via Frida. |
| `frida_modules_list` | List loaded shared libraries/modules and base addresses in a target process. |
| `frida_exports_list` | List live exported functions of a loaded module in a target process. |
| `frida_hook_function` | Attach a bounded `Interceptor.attach` trace to specified functions and log arguments/return values. |
| `frida_objc_trace` | Trace Objective-C method calls matching a class/selector pattern (`+[Class method]`). |
| `frida_java_trace` | Trace Android Java/Kotlin method calls on a connected device via Frida. |
| `frida_script_run` | Run a user-reviewed Frida JavaScript snippet for a bounded duration and capture `send()` messages. |

### 4.13 Application Synthesis & Clean-Room Rebuild (`application` / `app_*` — 14 tools: 13 Clean-room + 1 Deep)

| Tool ID | Mode | Summary |
|---|---|---|
| `app_window_capture` | Clean | Capture a PNG screenshot of a running desktop application window (`capture/window.png`). |
| `app_ui_tree_read` | Clean | Read the native desktop accessibility / UI automation tree (controls, roles, labels, bounds) to `capture/ui-tree.json`. |
| `app_architecture_map` | **Deep** | Synthesize a component/module architecture map from imports, classes, and call graphs. |
| `app_state_model_infer` | Clean | Infer data models, entities, and state transitions from observed UI, storage, or API schemas. |
| `app_feature_matrix` | Clean | Build a structured matrix of user-visible features, screens, commands, and evidence IDs. |
| `app_permissions_map` | Clean | Summarize all OS, browser, or mobile permissions and capabilities used by the target. |
| `app_data_flows` | Clean | Trace how user inputs, files, and network payloads flow through the application. |
| `app_telemetry_detect` | Clean | Identify analytics, crash reporting, feature flags, and third-party tracking endpoints. |
| `app_crypto_audit` | Clean | Audit observed cryptographic usage, TLS configurations, token storage, and key handling. |
| `app_rebuild_brief` | Clean | Generate a clean-room specification brief (`REBUILD_BRIEF.md`) describing behavior without copying source code. |
| `app_rebuild_scaffold` | Clean | Scaffold a clean project directory structure from an investigation's feature matrix and brief. |
| `app_rebuild_claim_check` | Clean | Verify whether claims in a rebuild specification are backed by recorded `ev_...` evidence IDs. |
| `app_cleanroom_handoff` | Clean | Export a clean-room handoff package (behavioral specs, UI tree, API schemas, zero decompiled code). |
| `app_graphs_compare` | Clean | Compare the program/feature graphs of two workspaces (e.g., original target vs rebuilt application). |

### 4.14 Databases & Local Storage (`database` / `db_*` — 8 tools, all Deep mode)

| Tool ID | Summary |
|---|---|
| `db_sqlite_schema` | Read SQLite database header, tables, columns, indexes, triggers, and `CREATE` statements. |
| `db_sqlite_query` | Run a read-only `SELECT` query (with row limit) against a SQLite database file. |
| `db_sqlite_carve` | Scan SQLite freelist pages and unallocated space for deleted/historical records. |
| `db_leveldb_scan` | Read keys and values from a LevelDB directory (`MANIFEST`, `.ldb`/`.sst`, `.log`). |
| `db_indexeddb_inspect` | Inspect Chromium/Electron IndexedDB (`*.indexeddb.leveldb`) databases, object stores, and records. |
| `db_realm_inspect` | Inspect mobile Realm (`.realm`) database headers, table names, and string columns. |
| `db_redis_rdb` | Parse Redis `.rdb` dump snapshots into databases, keys, types, and values. |
| `db_keychain_plist` | Inspect non-encrypted plist/JSON credential or preference stores in app data folders. |

### 4.15 Projects & Game Asset Generation (`projects` — 10 tools, all Clean-room allowed)

| Tool ID | Summary |
|---|---|
| `projects_list` | List all recent and saved Craft Anything project workspaces. |
| `project_create` | Create a new project workspace folder (`craft.json`, `capture/`, `app/`, `evidence/`, `reports/`). |
| `project_open` | Open an existing project workspace folder. |
| `project_delete` | Delete a project workspace folder (`MAY_DISCARD_DATA` consent). |
| `project_archive_export` | Package a project workspace into a single portable `.craft.zip` archive. |
| `project_archive_import` | Unpack a `.craft.zip` archive into a project workspace folder. |
| `project_assets_allow` | Enable or disable paid `fal.ai` game asset generation (`allow: bool`, optional `budget_usd`) for the project. |
| `assets_budget_show` | Show the project's asset generation budget, spent amount in USD, remaining balance, and generated assets list. |
| `assets_image_generate` | Generate a 2D game texture, sprite, skybox, or concept image via `fal.ai` (`nano-banana-pro`, `flux-dev`, `flux-schnell`) within the project budget. |
| `assets_model_generate` | Turn a generated or reference PNG into a textured `.glb` 3D mesh via `fal.ai` (`tripo-p1`, `$0.40` untextured / `$0.50` textured, `48..=20000` faces). |

### 4.16 External Engines, Plugins & Settings (`setup` toolset in engine — 17 tools: 15 Clean-room + 2 Deep)

| Tool ID | Mode | Summary |
|---|---|---|
| `engines_status_list` | Clean | List all 18 optional external engines (`ghidra`, `adb`, `jadx`, `apktool`, `chromium`, etc.), whether found, version, and path. |
| `engines_doctor_run` | Clean | Run health checks on external engines, workspace permissions, and plugin folders. |
| `engines_engine_install` | Clean | Download, verify SHA-256 against pinned manifest, and unpack a managed engine (`adb`, `jadx`, `apktool`, `vineflower`, `rizin`). |
| `engines_engine_uninstall` | Clean | Remove a managed engine from Craft Anything's engine store. |
| `engines_ghidra_status` | **Deep** | Check Ghidra 12.1.4 and Temurin JDK 21 installation status in Deep mode. |
| `engines_ghidra_ensure` | **Deep** | Download, verify SHA-256, and unpack Ghidra 12.1.4 + Temurin JDK 21 automatically. |
| `plugins_wasm_list` | Clean | List loaded WebAssembly tool plugins (`*.wasm` implementing `craft-anything:plugin/tools`). |
| `plugins_wasm_load` | Clean | Load a `.wasm` plugin file into the Wasmtime sandbox (fuel-bounded, zero host capability imports). |
| `plugins_wasm_call` | Clean | Call a tool exported by a loaded `.wasm` plugin. |
| `plugins_checks_list` | Clean | List loaded WebAssembly build-check plugins (`*.wasm` implementing `craft-anything:plugin/checks`). |
| `plugins_check_run` | Clean | Run a check plugin against a project's `app/` directory. |
| `plugins_mcp_list` | Clean | List connected external MCP plugin servers. |
| `plugins_mcp_connect` | Clean | Spawn and connect an external MCP server (`EXECUTES_FOREIGN_CODE` consent). |
| `plugins_mcp_call` | Clean | Call a tool on a connected external MCP server. |
| `plugins_mcp_disconnect` | Clean | Disconnect an external MCP server. |
| `settings_get` | Clean | Read current application settings (`deep_mode`, `projects_dir`, `build.good_enough`, `tool_paths`, etc.). |
| `settings_set` | Clean | Update a setting key (`deep_mode`, `projects_dir`, `good_enough`, tool path overrides). |

### 4.17 Build & Rebuild Verification (`build` — 13 tools, all Deep mode / internal check helpers)

| Tool ID | Summary |
|---|---|
| `build_project_detect` | Detect build system in `app/` (`Cargo.toml`, `package.json`, `pyproject.toml`, `.uproject`, `project.godot`, `ProjectSettings/ProjectVersion.txt`, `index.html`). |
| `build_compile_run` | Run the appropriate compiler/bundler (`cargo check`, `npm run build`, `python -m py_compile`, engine headless build) and parse structured diagnostics. |
| `build_test_run` | Run the project's test suite (`cargo test`, `npm test`, `pytest`) and collect pass/fail counts. |
| `build_static_serve` | Serve a static website build on a random loopback port (`127.0.0.1:<port>`) for visual checking. |
| `build_screenshot_run` | Run the built app/game with `--screenshot <file.png>` and verify a non-blank PNG is produced. |
| `build_selftest_run` | Run the built game with `--self-test <file.json>` and verify `passed == true` and `"move"`, `"act"`, `"hud"` steps pass. |
| `build_mechanics_verify` | Check `app/mechanics.json` constants against literals in `app/` source files. |
| `build_console_compare` | Run original and rebuilt console apps with `[]`, `["--help"]`, `["--version"]` and compute output word overlap. |
| `build_visual_compare` | Compute layout + SSIM perceptual similarity between two images or viewport captures. |
| `build_uitree_compare` | Check that controls from `capture/ui-tree.json` are present in the rebuilt app. |
| `build_credits_verify` | Verify `app/CREDITS.md` and `PRIVATE_USE_NOTE` in `app/README.md` for Deep-mode game rebuilds. |
| `build_progress_read` | Read `reports/build-progress.json` for a rebuild project. |
| `build_progress_write` | Write or update `reports/build-progress.json`. |
