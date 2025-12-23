# Troubleshooting & FAQ

Common issues and solutions when working with Rich Ruby.

## 1. Character Encoding & Unicode
**Problem**: CJK characters (Chinese, Japanese, Korean) or emojis appear as blocks or distorted.
**Solution**: 
- Ensure your terminal emulator has a font that supports these characters (e.g., Cascadia Code, JetBrains Mono, or a Nerd Font).
- On Windows, ensure your shell environment is set to UTF-8. In PowerShell/CMD, run: `chcp 65001`.
- Rich Ruby uses `Rich::Cells` to calculate width, but if the terminal font doesn't match the expected Unicode width, the layout might look slightly off.

## 2. Colors Not Appearing
**Problem**: Output is plain text with no color.
**Solution**:
- Check if your terminal supports ANSI colors.
- If you are piping output (e.g., `ruby script.rb > log.txt`), Rich Ruby automatically disables color. Use `Rich::Console.new(force_terminal: true)` to override this.
- If on Windows, Rich Ruby attempts to enable VT Processing. If it fails (e.g., very old Win 10), it will downgrade to basic 16-color mode via Console API.

## 3. The `io-nonblock` Warning
**Problem**: `Ignoring io-nonblock-0.3.2 because its extensions are not built.`
**Solution**:
- This is a Ruby environment issue, not a Rich Ruby bug. Rich Ruby has **zero dependencies**.
- You can ignore it, or run your scripts with `ruby -W0` to silence it.

## 4. Performance in Large Loops
**Problem**: The script feels slow when printing thousands of lines.
**Solution**:
- Standard terminal I/O is slow. Try batching your output or using the `Rich::Live` display (if available in your version) to update only changed lines.
- Avoid re-creating `Rich::Console` instances inside tight loops; use the global `Rich.get_console` instead.

## 5. Dark Mode vs. Light Mode
**Problem**: Text is invisible because it's too bright/dark for the background.
**Solution**:
- Avoid using hardcoded colors like `white` or `black` for main content.
- Use `default` color or theme-aware colors.
- Rich Ruby doesn't currently detect the terminal's background color (as many terminals don't support the query), so providing high-contrast themes like `:monokai` or `:dracula` is the best practice for user accessibility.
