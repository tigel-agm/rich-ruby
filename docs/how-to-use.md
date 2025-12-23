# How-To Use Rich Ruby

This guide provides quick examples and tips for using Rich Ruby effectively, categorized by user level.

## 1. Beginner: Quick Start & Basic Styling

If you're new to Rich Ruby, the easiest way to start is using the `Rich.print` method and [Markup](README.md#text-and-markup).

### Styled Hello World
```ruby
require 'rich'

Rich.print("[bold red]ERROR:[/] Something went wrong!")
Rich.print("[green]SUCCESS:[/] Operation completed.")
Rich.print("[blue italic]INFO:[/] Processing data...")
```

### Simple Rules (Dividers)
Use rules to organize your terminal output.
```ruby
Rich.rule("Section 1")
puts "Content goes here"
Rich.rule(style: "dim")
```

---

## 2. Intermediate: Components & Layout

Once you're comfortable with basic printing, start using structured components like **Panels** and **Tables**.

### Grouping with Panels
Panels are great for highlights or error messages.
```ruby
panel = Rich::Panel.new(
  "Data backup complete.\nVerified 1,024 files.",
  title: "Backup Status",
  border_style: "cyan"
)
puts panel.render(max_width: 40)
```

### Organizing with Tables
Tables automatically calculate column widths.
```ruby
table = Rich::Table.new(title: "Inventory")
table.add_column("Item", header_style: "bold")
table.add_column("Stock", justify: :right)

table.add_row("Apples", "50")
table.add_row("Oranges", "12")
puts table.render(max_width: 30)
```

---

## 3. Advanced: Dynamic Content & Technical Control

For power users building complex CLI tools.

### Live Progress Bars
```ruby
bar = Rich::ProgressBar.new(total: 100)
100.times do |i|
  bar.update(i + 1)
  print "\r#{bar.render}"
  sleep 0.01
end
puts "" # New line after completion
```

### Code Highlighting
Perfect for dev tools or logging code snippets.
```ruby
code = "def hello; puts 'world'; end"
syntax = Rich::Syntax.new(code, language: "ruby", theme: :monokai)
puts syntax.render
```

### Technical Transparency & Limitations
- **Pure Ruby**: The entire library is implemented in Pure Ruby (with `Fiddle` for Windows API). This ensures portability but means performance may degrade with exceptionally large datasets (e.g., tables with 10,000+ rows).
- **Windows Integration**: On Windows, we directly interface with `kernel32.dll` to enable Virtual Terminal processing. This is robust but depends on modern Windows 10/11 features for the best experience.
- **Color Systems**: While we support TrueColor, the actual appearance depends on your terminal emulator's capabilities.

---

## Guide for Quick Reference

| Task | Tool to Use |
|------|-------------|
| Quick logging | `Rich.print` |
| Boxing content | `Rich::Panel` |
| List data | `Rich::Table` |
| File trees | `Rich::Tree` |
| Source code | `Rich::Syntax` |
| Formatted docs | `Rich::Markdown` |
