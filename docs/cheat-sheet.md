# Rich Ruby Cheat Sheet

A quick visual reference for markup, styles, and colors.

## 1. Markup Tags
Commonly used tags in `[tag]content[/tag]` syntax.

| Tag | Result |
|-----|--------|
| `[bold]` | **Bold Text** |
| `[dim]` | Dimmed Text |
| `[italic]` | *Italic Text* |
| `[u]` or `[underline]` | <u>Underline</u> |
| `[strike]` | ~~Strikethrough~~ |
| `[reverse]` | Inverse Background/Foreground |
| `[red]` | Red Foreground |
| `[on blue]` | Blue Background |
| `[#ff5500]` | Hex Color |

## 2. Color Keywords
Standard 16-color names supported by almost all terminals.

- `black`, `red`, `green`, `yellow`, `blue`, `magenta`, `cyan`, `white`
- `bright_black`, `bright_red`, `bright_green`, etc.

## 3. Component Comparison

| Component | best for... |
|-----------|-------------|
| **Panel** | Single focus messages, headers, or boxed content. |
| **Table** | Columns of data, spreadsheets, or grid layouts. |
| **Tree** | File systems, dependency graphs, or nested lists. |
| **Syntax** | Code snippets in logs or documentation. |
| **JSON** | Debugging API responses or config files. |
| **Markdown**| Rendering READMEs or rich terminal helps. |

## 4. Quick API Snippets

### Print with Style
```ruby
Rich.print("[yellow]Wait...[/] [bold green]Success![/]")
```

### Create a Rule (Divider)
```ruby
Rich.rule("Chapter 1", style: "cyan")
```

### Inspect a Ruby Object
```ruby
puts Rich::Pretty.to_s(some_hash)
```
