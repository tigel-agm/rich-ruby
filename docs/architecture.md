# Architecture & Data Flow

This document explains how Rich Ruby processes text and components to generate terminal output.

## 1. High-Level Concept

Rich Ruby follows a pipeline:
**Input (Markup/Object) -> Text/Segments -> Console Options -> ANSI String -> Terminal**

## 2. Core Entities

### `Rich::Console`
The "brain" of the library. It holds state about the terminal's width, height, and color capabilities. It acts as the orchestrator for all rendering.

### `Rich::Text`
A representation of text that includes "Spans" (range of characters + a Style). This is an intermediate format before splitting into segments.

### `Rich::Segment`
The lowest-level rendering unit. A segment is a simple string paired with a `Rich::Style`.
- When you render any component (Table, Panel, etc.), it ultimately breaks down into a list of `Segments`.
- Segments are responsible for generating the final ANSI escape codes via `Segment.render`.

### `Rich::Style`
Encapsulates foreground color, background color, and attributes (bold, etc.). Styles are **immutable**. Combining styles (`style1 + style2`) creates a new style object.

## 3. The Rendering Pipeline

1. **Measurement**: Components (like `Table`) calculate the required width of each cell using `Rich::Cells.cell_len`.
2. **Layout**: Wrapping and alignment logic is applied to fit the `max_width`.
3. **Segmentation**: The component converts its visual structure into `Rich::Segment` objects.
4. **ANSI Generation**: The `Console` takes the segments and joins them into a single string containing escape sequences.
5. **Output**: The string is written to `$stdout` (or the configured output stream).

## 4. Windows Integration Logic

In `lib/rich/win32_console.rb`, we use `Fiddle` to interface with `kernel32.dll`:

- **VT Processing**: We call `GetConsoleMode` and `SetConsoleMode` to enable ANSI support.
- **Size Detection**: We call `GetConsoleScreenBufferInfo` to get accurate dimensions without relying on environment variables.

## 5. Extensibility

Developers can create new components by implementing a `render` (or `to_segments`) method that returns a collection of `Rich::Segment` objects. This ensures that any new component automatically inherits font-width calculation and color-downgrade support.
