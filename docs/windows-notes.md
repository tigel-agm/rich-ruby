# Windows Support & Environmental Notes

Rich Ruby is designed to be a first-class citizen on Windows.

## Windows Native Integration

We use Ruby's `Fiddle` to call Windows API functions directly. This avoids dependencies on external gems like `curses` or `win32-console`.

### Virtual Terminal Processing
When you initialize a `Rich::Console`, it attempts to enable `ENABLE_VIRTUAL_TERMINAL_PROCESSING` (0x0004) via `SetConsoleMode`. This allows the Windows Command Prompt and PowerShell to understand ANSI escape codes natively.

### Fallback Behavior
On older systems (legacy console), the library detects the lack of VT support and simplifies output to basic 16 colors using the Windows Console API where possible, or strips formatting to ensure readability.

## Known Environmental Artifacts

### `io-nonblock` Warning
You may see the following warning in your terminal:
`Ignoring io-nonblock-0.3.2 because its extensions are not built.`

**Transparency Note:**
This warning is related to the local Ruby environment's gem installation and is **not caused by Rich Ruby**. Rich Ruby has **zero external gem dependencies** and does not require `io-nonblock` for its core functionality.

To run tests without seeing this warning, use the `-W0` flag:
```bash
ruby -W0 -Ilib -Itest test/test_console.rb
```

## MSVC Compatibility
Rich Ruby is developed and tested on **Ruby 3.4.8 (MSVC)** compiled with Visual Studio 2026. It is fully compatible with MSVC-built Ruby runtimes.
