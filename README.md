# Rich Ruby (rich-ruby)

A Pure Ruby library for rich text and beautiful formatting in the terminal.

Rich Ruby provides an elegant API for creating stylish terminal output with colors,
tables, panels, trees, progress bars, syntax highlighting, and more. It is inspired
by the Python Rich library but is a complete Ruby-native implementation.

---

## Table of Contents

1. [Features](#features)
2. [Requirements](#requirements)
3. [Installation](#installation)
4. [Quick Start](#quick-start)
5. [Usage Guide](#usage-guide)
   - [Colors and Styles](#colors-and-styles)
   - [Text and Markup](#text-and-markup)
   - [Panels](#panels)
   - [Tables](#tables)
   - [Trees](#trees)
   - [Progress Bars and Spinners](#progress-bars-and-spinners)
   - [Syntax Highlighting](#syntax-highlighting)
   - [Markdown Rendering](#markdown-rendering)
   - [JSON Output](#json-output)
6. [API Reference](#api-reference)
7. [Testing](#testing)
8. [License](#license)

---

## Features

- **Colors**: Full support for 16-color, 256-color, and TrueColor (24-bit) terminals
- **Styles**: Bold, italic, underline, strikethrough, blink, reverse, and more
- **Markup**: Simple markup syntax like `[bold red]text[/]` for inline styling
- **Panels**: Bordered boxes with titles and subtitles
- **Tables**: Data tables with column alignment and styling
- **Trees**: Hierarchical tree views with different guide styles
- **Progress**: Animated progress bars and spinners
- **Syntax**: Code syntax highlighting for Ruby, Python, JavaScript, SQL, and more
- **Markdown**: Render Markdown documents in the terminal
- **Windows**: Full Windows Console API support with automatic ANSI enabling
- **Zero Dependencies**: Pure Ruby with no external gem dependencies

---

## Requirements

This library was developed and tested on:

- **Ruby**: 3.4.8 (MSVC build)
- **Platform**: Windows 10 64-bit (21H2)
- **Compiler**: Visual Studio 2026 (MSVC)

The library should work on:

- Ruby 3.0 or later
- Windows, macOS, Linux
- Any terminal supporting ANSI escape codes

### Windows Native Support

For Windows users, the library provides **native integration** with the Windows Console API using [Fiddle](https://ruby-doc.org/stdlib/libdoc/fiddle/rdoc/Fiddle.html). This allows it to:

1.  **Enable ANSI/VT Processing**: Automatically configures the console to handle ANSI escape codes, even on older versions of Windows 10.
2.  **Fallback to Console API**: On legacy systems where ANSI is not supported, it uses the Windows Console API (e.g., `SetConsoleTextAttribute`) to provide color and styling.
3.  **Accurate Console Dimensions**: Uses native API calls to determine the exact width and height of the console window.
4.  **Hardware Features**: Full control over cursor visibility, window titles, and screen clearing via native calls.

This works out-of-the-box with Windows Terminal, PowerShell, and the classic Command Prompt.

---

## Installation

### From RubyGems

```bash
gem install rich-ruby
```

### From source

```bash
git clone https://github.com/tigel-agm/rich-ruby.git
cd rich
gem build rich-ruby.gemspec
gem install rich-ruby-0.1.0.gem
```

### In your Gemfile

```ruby
gem 'rich-ruby'
```

---

## Quick Start

```ruby
require 'rich'

# Simple styled output
Rich.print("[bold cyan]Hello[/] [yellow]World![/]")

# Create a console instance for more control
console = Rich::Console.new
console.print("Welcome!", style: "bold green")

# Display a panel
panel = Rich::Panel.new(
  "This is important information.",
  title: "Notice",
  border_style: "cyan"
)
puts panel.render(max_width: 50)

# Display a table
table = Rich::Table.new(title: "Users")
table.add_column("Name", header_style: "bold")
table.add_column("Role")
table.add_row("Alice", "Admin")
table.add_row("Bob", "User")
puts table.render(max_width: 40)
```

---

## Documentation

For more detailed information, check out our guides:

- [**How-To Use**](docs/how-to-use.md): Tiered guide for all levels.
- [**Troubleshooting & FAQ**](docs/troubleshooting.md): Solutions for common issues.
- [**Customization**](docs/customization.md): Learn how to extend the library.
- [**Cheat Sheet**](docs/cheat-sheet.md): Quick reference for styles and colors.
- [**Windows Notes**](docs/windows-notes.md): Technical details on Windows support.
- [**Architecture**](docs/architecture.md): Internal design and data flow.
- [**Test Report**](docs/test-report.md): Verification and performance results.

---

## Usage Guide

### Colors and Styles

Rich Ruby supports multiple color systems:

```ruby
# Standard 16 colors
style = Rich::Style.parse("red")
style = Rich::Style.parse("bright_blue")

# 256-color palette
style = Rich::Style.parse("color(42)")

# TrueColor (24-bit)
style = Rich::Style.parse("#ff5500")
style = Rich::Style.parse("rgb(255, 85, 0)")

# Background colors
style = Rich::Style.parse("white on blue")
style = Rich::Style.parse("black on #ffcc00")
```

Available text attributes:

| Attribute | Description |
|-----------|-------------|
| `bold` | Bold text |
| `dim` | Dimmed text |
| `italic` | Italic text |
| `underline` | Underlined text |
| `underline2` | Double underline |
| `overline` | Overlined text |
| `blink` | Blinking text |
| `reverse` | Reversed colors |
| `conceal` | Hidden text |
| `strike` | Strikethrough |

Combine multiple attributes:

```ruby
style = Rich::Style.parse("bold italic red on white")
```

### Text and Markup

The markup syntax provides an easy way to style text inline:

```ruby
# Basic markup
Rich.print("[bold]Bold text[/bold]")
Rich.print("[red]Red text[/red]")

# Shorthand close tag
Rich.print("[bold]Bold text[/]")

# Nested styles
Rich.print("[bold][red]Bold and red[/red][/bold]")

# Combined styles
Rich.print("[bold italic cyan on black]Styled[/]")

# In strings
text = Rich::Markup.parse("Name: [cyan]Alice[/] Age: [yellow]30[/]")
puts Rich::Segment.render(text.to_segments)
```

### Panels

Create bordered panels to highlight content:

```ruby
# Simple panel
panel = Rich::Panel.new("Hello World")
puts panel.render(max_width: 40)

# Panel with title and subtitle
panel = Rich::Panel.new(
  "Important information goes here.",
  title: "Alert",
  subtitle: "Read carefully",
  border_style: "red",
  title_style: "bold white"
)
puts panel.render(max_width: 50)

# Different box styles
panel = Rich::Panel.new("Content", box: Rich::Box::DOUBLE)
panel = Rich::Panel.new("Content", box: Rich::Box::ROUNDED)
panel = Rich::Panel.new("Content", box: Rich::Box::HEAVY)
panel = Rich::Panel.new("Content", box: Rich::Box::ASCII)
```

### Tables

Create formatted data tables:

```ruby
# Create a table
table = Rich::Table.new(title: "Sales Report", border_style: "blue")

# Add columns with styling
table.add_column("Product", header_style: "bold cyan")
table.add_column("Price", justify: :right, header_style: "bold cyan")
table.add_column("Quantity", justify: :center)

# Add data rows
table.add_row("Widget", "$10.00", "100")
table.add_row("Gadget", "$25.50", "50")
table.add_row("Gizmo", "$5.99", "200")

# Render
puts table.render(max_width: 60)
```

Column justification options: `:left`, `:center`, `:right`

### Trees

Display hierarchical data:

```ruby
# Create a tree
tree = Rich::Tree.new("Project", style: "bold yellow")

# Add nodes
src = tree.add("src/", style: "bold")
src.add("main.rb", style: "green")
src.add("config.rb", style: "green")

lib = tree.add("lib/")
lib.add("utils.rb")

tree.add("README.md", style: "cyan")

# Render
puts tree.render
```

Different guide styles:

```ruby
tree = Rich::Tree.new("Root", guide: Rich::TreeGuide::ASCII)
tree = Rich::Tree.new("Root", guide: Rich::TreeGuide::ROUNDED)
tree = Rich::Tree.new("Root", guide: Rich::TreeGuide::BOLD)
```

### Progress Bars and Spinners

Show progress for long-running tasks:

```ruby
# Progress bar
bar = Rich::ProgressBar.new(total: 100, width: 40)

100.times do |i|
  bar.update(i + 1)
  print "\rProgress: #{bar.render}"
  sleep(0.05)
end
puts ""

# Spinner
spinner = Rich::Spinner.new(frames: Rich::ProgressStyle::DOTS)

20.times do
  print "\r#{spinner.frame} Loading..."
  spinner.advance
  sleep(0.1)
end
puts "\rDone!        "
```

Available spinner styles:
- `Rich::ProgressStyle::DOTS`
- `Rich::ProgressStyle::LINE`
- `Rich::ProgressStyle::CIRCLE`
- `Rich::ProgressStyle::BOUNCE`

### Syntax Highlighting

Highlight source code:

```ruby
code = <<~RUBY
  def greet(name)
    puts "Hello, #{name}!"
  end
RUBY

# Basic highlighting
syntax = Rich::Syntax.new(code, language: "ruby")
puts syntax.render

# With line numbers
syntax = Rich::Syntax.new(code, language: "ruby", line_numbers: true)
puts syntax.render

# With a theme
syntax = Rich::Syntax.new(code, language: "python", theme: :monokai)
syntax = Rich::Syntax.new(code, language: "javascript", theme: :dracula)
```

Supported languages: Ruby, Python, JavaScript, SQL, JSON, YAML, Bash

Available themes: `:default`, `:monokai`, `:dracula`

### Markdown Rendering

Render Markdown in the terminal:

```ruby
markdown = <<~MD
  # Welcome

  This is **bold** and *italic* text.

  ## Features

  - Item one
  - Item two

  ```ruby
  puts "Code block"
  ```

  | Column A | Column B |
  |----------|----------|
  | Value 1  | Value 2  |
MD

md = Rich::Markdown.new(markdown)
puts md.render(max_width: 70)
```

Supported Markdown elements:
- Headings (H1-H6)
- Bold, italic, strikethrough
- Inline code
- Code blocks with language
- Ordered and unordered lists
- Blockquotes
- Tables
- Links
- Horizontal rules

### JSON Output

Pretty-print JSON with syntax highlighting:

```ruby
data = {
  "name" => "Alice",
  "age" => 30,
  "active" => true,
  "roles" => ["admin", "user"]
}

puts Rich::JSON.to_s(data)

# Highlight existing JSON string
json_str = '{"key": "value"}'
puts Rich::JSON.highlight(json_str)
```

---

## API Reference

### Core Classes

| Class | Description |
|-------|-------------|
| `Rich::Console` | Main console interface |
| `Rich::Color` | Color representation and parsing |
| `Rich::Style` | Text style with color and attributes |
| `Rich::Segment` | Styled text segment |
| `Rich::Text` | Rich text with spans |
| `Rich::Markup` | Markup parser |

### Components

| Class | Description |
|-------|-------------|
| `Rich::Panel` | Bordered panel |
| `Rich::Table` | Data table |
| `Rich::Tree` | Tree view |
| `Rich::ProgressBar` | Progress bar |
| `Rich::Spinner` | Animated spinner |
| `Rich::Syntax` | Syntax highlighter |
| `Rich::Markdown` | Markdown renderer |
| `Rich::JSON` | JSON formatter |

### Module Methods

```ruby
Rich.print(*objects, style: nil)  # Print with markup support
Rich.print_json(data)              # Print formatted JSON
Rich.rule(title)                   # Print horizontal rule
Rich.get_console                   # Get global console instance
Rich.reconfigure(**options)        # Reconfigure global console
```

---

## Testing

Run the full test suite:

```bash
cd rich
ruby -W0 -Ilib -Itest -e "Dir['test/test_*.rb'].each { |f| require_relative f }"
```

> [!TIP]
> Use the `-W0` flag to suppress environmental warnings (like the `io-nonblock` extension warning) for a cleaner test output.

Or with Rake (if rake is available):

```bash
rake test
```

Run individual test files:

```bash
ruby -W0 -Ilib -Itest test/test_color.rb
ruby -W0 -Ilib -Itest test/test_style.rb
```

Run stress tests:

```bash
ruby examples/stress_test.rb
```

---

## Project Structure

```
rich/
  lib/
    rich.rb           # Main entry point
    rich/
      color.rb        # Color handling
      style.rb        # Text styles
      text.rb         # Rich text
      markup.rb       # Markup parser
      panel.rb        # Panel component
      table.rb        # Table component
      tree.rb         # Tree component
      progress.rb     # Progress bars and spinners
      syntax.rb       # Syntax highlighting
      markdown.rb     # Markdown rendering
      json.rb         # JSON formatting
      console.rb      # Console interface
      ...
  test/
    test_*.rb         # Test files
  examples/
    demo.rb           # Basic demo
    showcase.rb       # Interactive showcase
    stress_test.rb    # Stress tests
```

---

## License

This project is licensed under the MIT License.

This means:
- You can use, modify, and distribute this software for any purpose
- You can use it in commercial projects
- You must include the original copyright and license notice

See the [LICENSE](LICENSE) file for the full license text.

---

## Credits

This library is an original Ruby implementation inspired by the concepts of the
Python Rich library by Will McGugan [https://github.com/willmcgugan]. All code is original and written specifically
for Ruby.

Developed on Ruby 3.4.8 (MSVC) on Windows 10 64-bit (21H2) with Visual Studio 2026.

---

## Contributing

Contributions are welcome! Please:

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Add tests for new functionality
5. Submit a pull request

All contributions must be compatible with the MIT license.
