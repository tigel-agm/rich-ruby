# Customization & Extensibility

Rich Ruby is designed to be modular. You can extend it by creating your own box styles, syntax lexers, and themes.

## 1. Custom Box Styles
You can create a custom `Box` by instantiating the class with a set of characters.

```ruby
MY_BOX = Rich::Box.new(
  top_left: "┏", top_right: "┓",
  bottom_left: "┗", bottom_right: "┛",
  horizontal: "━", vertical: "┃",
  cross: "╋"
)

panel = Rich::Panel.new("Custom Border", box: MY_BOX)
puts panel.render
```

## 2. Advanced Syntax Themes
Themes are simply Hashes mapping token types to `Rich::Style` objects.

```ruby
MY_THEME = {
  keyword: Rich::Style.new(color: "red", bold: true),
  string:  Rich::Style.new(color: "green"),
  comment: Rich::Style.new(color: "dim yellow"),
  text:    Rich::Style.new(color: "default")
}

syntax = Rich::Syntax.new(code, language: "ruby", theme: MY_THEME)
puts syntax.render
```

## 3. Adding a New Lexer
To add support for a new language, create a class inheriting from `Rich::BaseLexer` and register it in `Rich::Syntax::LEXERS`.

```ruby
class MyLanguageLexer < Rich::BaseLexer
  def tokenize(line, theme)
    # Return an array of Rich::Segment objects
    [Rich::Segment.new(line, style: theme[:text])]
  end
end

# Register it
Rich::Syntax::LEXERS["mylang"] = MyLanguageLexer.new
```

## 4. Custom Markup Tags
The `Rich::Markup` parser utilizes the `Rich::Style` parsing engine. If you want to create a shorthand tag, you can add it to the `Style` registry if implemented, or simply use combined strings.

Note: Rich Ruby aims to keep the core small. For complex custom components, we recommend composing existing `Panel`, `Table`, and `Text` objects.
