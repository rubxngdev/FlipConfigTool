# Flip Configuration Tool

A Windows command-line tool that lets you quickly toggle between **Independent Flip** and **Legacy Flip** (enable/disable Fullscreen Optimizations) for any game, without digging through the executable's compatibility properties.

## What is this?

Windows automatically decides which presentation model a game uses in fullscreen:

- **Independent Flip** — Fullscreen Optimizations (FSO) enabled. This is Windows' default behavior and generally offers lower latency on most modern systems.
- **Legacy Flip** — Fullscreen Optimizations disabled (DFSO / true "exclusive fullscreen"). Some games and setups benefit from this mode, especially when combined with G-Sync/FreeSync in exclusive fullscreen.

Which mode is best depends on the game, the GPU driver, and the control panel used. This tool doesn't decide for you — it just lets you switch between both in seconds, applying the change directly to the Windows registry on a per-application basis.

## Requirements

- Windows 10 / 11
- No administrator privileges required (the modified key lives under `HKCU`, not `HKLM`)

## Usage

1. Run `flip_configuration_tool.bat`.
2. Press `1` to continue.
3. Select the game's main executable (`.exe`) through the file picker.
4. Choose the configuration you want to apply:
   - `[1]` Independent Flip (restores default behavior / FSO)
   - `[2]` Legacy Flip (disables FSO)
   - `[3]` Select another game
   - `[0]` Exit
5. Fully restart the game for the change to take effect.

After applying a configuration, the tool returns to the menu with the same `.exe` still selected, so you can switch between modes without reselecting the file.

## How to check what mode Windows is actually using

Choosing "Legacy Flip" or "Independent Flip" in the registry doesn't guarantee the game will honor that preference — it also depends on the game itself and the driver. To verify **which presentation model Windows is actually using** for each application, it's recommended to use **PresentMon**, which exposes this information per process while the game is running.

## Credits

- **[rubxngdev](https://github.com/rubxngdev)** — development of this tool.
- **amitxv** — for their tuning guide and for pointing out the use of PresentMon as a method to verify the active presentation model per application. Their GitHub profile is private, so no direct link is included.
- **[GameTechDev/PresentMon](https://github.com/GameTechDev/PresentMon)** — the original graphics performance capture and analysis tool for Windows, developed by Intel, used to verify the presentation mode per application.

## Notice

This tool modifies the Windows registry (`HKCU\Software\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\Layers`). If the selected application already had other compatibility layers manually configured (e.g. "Run as administrator" or DPI settings), these will be overwritten when applying Legacy Flip, or removed when restoring Independent Flip. Use it with this behavior in mind.
