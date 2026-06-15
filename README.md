# MarkdownDisplayView

A powerful iOS Markdown rendering component built on TextKit 2, providing smooth rendering performance and rich customization options. It also enables the streaming rendering of Markdown format in AI question-and-answer scenarios.

> 🚀 **MarkdownDisplayView delivers streaming rendering effects comparable to leading AI terminal iOS clients like ChatGPT, Claude, Doubao, DeepSeek, and Grok, while offering even richer customization features and configuration options.**

## Contents

- [Effects Showcase](#effects-showcase)
- [Demo Effects](#demo-effects)
- [Features](#features)
- [Requirements](#requirements)
- [Installation](#installation)
- [Quick Start](#quick-start)
- [Custom Configuration](#custom-configuration)
- [Table of Contents](#table-of-contents)
- [Supported Markdown Syntax](#supported-markdown-syntax)
- [Complete Example](#complete-example)
- [Performance Optimization](#performance-optimization)
- [Advanced Usage](#advanced-usage)
- [Custom Extensions](#custom-extensions)
- [Troubleshooting](#troubleshooting)
- [Changelog](#changelog)
- [Contributing](#contributing)
- [License](#license)
- [Author](#author)
- [Acknowledgments](#acknowledgments)
- [Contact](#contact)

## Effects Showcase

## Demo Effects

### Normal Rendering
![Normal Rendering](./Effects/normal.gif)

### Streaming Rendering
- Simulated streaming

![Streaming Rendering](./Effects/streaming.gif)

- Chat with AI model

Config.local.json structure:

```jsonc
// {
//   "host": "https://api.deepseek.com",
//   "path": "/chat/completions",
//   "apiKey": "",
//   "model": "deepseek-chat",
//   "systemPrompt": "You are a helpful assistant.",
//   "temperature": 0.7,
//   "stream": true,
//   "timeoutSeconds": 30
// }
```

![AIChat](./Effects/ChatWithAIModel.gif)

## Features
- 🚀 **High-Performance Rendering** — Based on TextKit 2, supports asynchronous rendering, incremental updates, streaming rendering, etc. **Instant loading** with ultra-fast first screen rendering.
- ⚡ **Low CPU Usage** — Streaming mode supports nested style rendering with CPU peak < 56% on iPhone 17 Pro simulator, averaging only 30%.
- 🎨 **Full Markdown Support** — Formula of LaTeX protocol, Headings, lists, tables, code blocks (with horizontal scrolling), blockquotes, images, and more.
- 🌈 **Syntax Highlighting** — Supports syntax highlighting for 20+ programming languages (Swift, Python, JavaScript, etc.).
- 📑 **Automatic Table of Contents** — Automatically extracts headings to generate an interactive TOC.
- 🎯 **Highly Customizable** — Comprehensive configuration for fonts, colors, spacing, etc.
- 🔌 **Custom Extensions** — Support for custom inline syntax parsing and code block renderers (e.g., Mermaid diagrams).
- 🔗 **Event Callbacks** — Link taps, image taps, TOC navigation.
- 📱 **Native iOS** — Built with UIKit and TextKit 2 for excellent performance.
- 🌓 **Dark Mode** — Built-in light and dark theme configurations.
- 📳 **Haptic Feedback** — Supports synchronized haptic feedback during streaming output for enhanced interaction experience.

## Requirements
- iOS 15.0+ (due to TextKit 2 requirement)
- Swift 5.9+
- Xcode 16.0+

## Installation
### Swift Package Manager
#### Method 1: Add via Xcode
1. Open your project in Xcode.
2. Choose `File` → `Add Package Dependencies...`
3. Enter the repository URL: `https://github.com/zjc19891106/MarkdownDisplayView.git`
4. Select the version and click `Add Package`.

#### Method 2: In Package.swift
Add the dependency in `Package.swift`:
```swift
dependencies: [
    .package(url: "https://github.com/zjc19891106/MarkdownDisplayView.git", from: "1.7.5")
]
```

## Quick Start

### Basic Usage

```swift
import UIKit
import MarkdownDisplayView

class ViewController: UIViewController {

    private let markdownView = ScrollableMarkdownViewTextKit()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Add to view hierarchy
        view.addSubview(markdownView)
        markdownView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            markdownView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            markdownView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            markdownView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            markdownView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])

        // Set Markdown content
        markdownView.markdown = """
        # Welcome to MarkdownDisplayView

        This is a **powerful** Markdown rendering component.

        ## Key Features
        - Full Markdown syntax support
        - Code syntax highlighting
        - Automatic table of contents generation
        - Asynchronous image loading

        ### Code Example

        ```swift
        let message = "Hello, World!"
        print(message)
        ```

        [Visit GitHub](https://github.com)
        """
    }
}
```

### Handle Link Taps

```swift
markdownView.onLinkTap = { url in
    if UIApplication.shared.canOpenURL(url) {
        UIApplication.shared.open(url)
    }
}
```

### Handle Image Taps

```swift
markdownView.onImageTap = { imageURL in
    print("Image tapped: \(imageURL)")
    // You can implement image preview functionality here
}
```

## Custom Configuration

### Using Preset Themes

```swift
// Use default light theme
markdownView.configuration = .default

// Use dark theme
markdownView.configuration = .dark
```

### Custom Configuration

```swift
var config = MarkdownConfiguration.default

// Custom fonts
config.bodyFont = .systemFont(ofSize: 17)
config.h1Font = .systemFont(ofSize: 32, weight: .bold)
config.codeFont = .monospacedSystemFont(ofSize: 15, weight: .regular)

// Custom colors
config.textColor = .label
config.linkColor = .systemBlue
config.linkUnderlineEnabled = false    // Disable link underline
config.codeBackgroundColor = .systemGray6
config.blockquoteTextColor = .secondaryLabel

// Custom spacing
config.paragraphSpacing = 16
config.headingSpacing = 20
config.imageMaxHeight = 500
config.lineSpacing = MarkdownLineSpacingConfiguration(
    body: 6,
    heading: 8,
    quote: 6,
    codeBlock: 4
)

// Apply configuration
markdownView.configuration = config
```

### Complete Configuration Options

#### Font Configuration

```swift
public var bodyFont: UIFont              // Body font
public var h1Font: UIFont                // H1 heading font
public var h2Font: UIFont                // H2 heading font
public var h3Font: UIFont                // H3 heading font
public var h4Font: UIFont                // H4 heading font
public var h5Font: UIFont                // H5 heading font
public var h6Font: UIFont                // H6 heading font
public var codeFont: UIFont              // Code font
public var blockquoteFont: UIFont        // Blockquote font
```

#### Color Configuration

```swift
public var textColor: UIColor                          // Text color
public var headingColor: UIColor                       // Heading color
public var linkColor: UIColor                          // Link color
public var linkUnderlineEnabled: Bool                  // Whether links display underline (default: true)
public var codeTextColor: UIColor                      // Code text color
public var codeBackgroundColor: UIColor                // Code background color
public var blockquoteTextColor: UIColor                // Blockquote text color
public var blockquoteBarColor: UIColor                 // Blockquote border color
public var tableBorderColor: UIColor                   // Table border color
public var tableHeaderBackgroundColor: UIColor         // Table header background
public var tableRowBackgroundColor: UIColor            // Table row background
public var tableAlternateRowBackgroundColor: UIColor   // Table alternate row background
public var horizontalRuleColor: UIColor                // Horizontal rule color
public var imagePlaceholderColor: UIColor              // Image placeholder color
public var footnoteColor: UIColor                      // Footnote color
public var tocTextColor: UIColor                       // TOC text color
public var detailsSummaryTextColor: UIColor            // Details summary text color
```

#### Spacing Configuration

```swift
public var paragraphSpacing: CGFloat       // Paragraph spacing
public var headingSpacing: CGFloat         // Heading spacing
public var listIndent: CGFloat             // List indentation
public var codeBlockPadding: CGFloat       // Code block padding
public var blockquoteIndent: CGFloat       // Blockquote indentation
public var imageMaxHeight: CGFloat         // Maximum image height
public var imagePlaceholderHeight: CGFloat // Image placeholder height
```

#### Line Spacing Configuration

```swift
public var lineSpacing: MarkdownLineSpacingConfiguration // Role-based line spacing config

public struct MarkdownLineSpacingConfiguration {
    public var body: CGFloat
    public var heading: CGFloat
    public var quote: CGFloat
    public var codeBlock: CGFloat
}
```

#### LaTeX Formula Configuration

```swift
public var latexFontSize: CGFloat          // LaTeX formula font size (default: 22)
public var latexAlignment: NSTextAlignment // LaTeX formula alignment (.left, .center, .right)
public var latexBackgroundColor: UIColor   // LaTeX formula background color
public var latexPadding: CGFloat           // LaTeX formula padding (default: 20)
```

#### Blockquote Configuration

```swift
public var blockquoteBackgroundColor: UIColor  // Blockquote background color
public var blockquoteBarWidth: CGFloat         // Blockquote left bar width (default: 4)
public var blockquoteContentSpacing: CGFloat   // Blockquote content spacing (default: 8)
public var blockquoteContentPadding: CGFloat   // Blockquote content padding (default: 12)
```

#### Table Configuration

```swift
public var tableMinColumnWidth: CGFloat    // Table minimum column width (default: 80)
public var tableMaxColumnWidth: CGFloat    // Table maximum column width (default: 200)
public var tableRowHeight: CGFloat         // Table row height (default: 44)
public var tableCellPadding: CGFloat       // Table cell padding (default: 16)
public var tableSeparatorHeight: CGFloat   // Table separator height (default: 1)
public var autoFixMalformedTables: Bool    // Auto-fix malformed table text from streaming/LLM output (default: true)
```

#### List Configuration

```swift
public var listItemSpacing: CGFloat        // List item spacing (default: 4)
public var listMarkerMinWidth: CGFloat     // List marker minimum width (default: 20)
public var listMarkerSpacing: CGFloat      // List marker to content spacing (default: 4)
public var listTopPadding: CGFloat         // Whole-list top padding (default: 0)
public var listBottomPadding: CGFloat      // Whole-list bottom padding (default: 0)
```

#### Details (Collapsible) Configuration

```swift
public var detailsSummaryFont: UIFont          // Details summary font
public var detailsSummaryTextColor: UIColor    // Details summary text color
public var detailsSummaryMinHeight: CGFloat    // Details summary minimum height (default: 40)
public var detailsContentPadding: CGFloat      // Details content padding (default: 12)
public var detailsSpacing: CGFloat             // Details internal spacing (default: 8)
```

#### Syntax Highlighting Configuration

```swift
public var syntaxColors: SyntaxHighlightColors      // Syntax highlighting colors (light theme)
public var syntaxColorsDark: SyntaxHighlightColors  // Syntax highlighting colors (dark theme)

// SyntaxHighlightColors structure
public struct SyntaxHighlightColors {
    public var keyword: UIColor       // Keyword color
    public var string: UIColor        // String color
    public var number: UIColor        // Number color
    public var comment: UIColor       // Comment color
    public var type: UIColor          // Type color
    public var function: UIColor      // Function color
    public var property: UIColor      // Property color
    public var preprocessor: UIColor  // Preprocessor color

    public static var xcode: SyntaxHighlightColors      // Xcode light theme
    public static var xcodeDark: SyntaxHighlightColors  // Xcode dark theme
}
```

#### Streaming Haptic Feedback Configuration

```swift
public var streamingHapticFeedbackStyle: StreamingHapticFeedbackStyle  // Haptic feedback style (default: .none)
public var streamingHapticMinInterval: TimeInterval                    // Minimum interval between haptics (default: 0.05s)

// StreamingHapticFeedbackStyle enum
public enum StreamingHapticFeedbackStyle {
    case none    // No haptic feedback (default)
    case light   // Light haptic feedback
    case medium  // Medium haptic feedback
    case heavy   // Heavy haptic feedback
    case soft    // Soft haptic feedback (iOS 13+)
    case rigid   // Rigid haptic feedback (iOS 13+)
}

// Usage example
var config = MarkdownConfiguration.default
config.streamingHapticFeedbackStyle = .light  // Enable light haptic feedback
config.streamingHapticMinInterval = 0.05      // 50ms minimum interval
markdownView.configuration = config
```

## Table of Contents

### Get Auto-Generated TOC

```swift
// Markdown content automatically parses headings to generate TOC
let tocItems = markdownView.tableOfContents

for item in tocItems {
    print("Level \(item.level): \(item.title)")
}
```

### Generate TOC View

```swift
// Automatically generate clickable TOC view
let tocView = markdownView.generateTOCView()

// Add to interface
view.addSubview(tocView)
```

### Scroll to Heading

```swift
// Scroll to corresponding position when TOC item is tapped
markdownView.onTOCItemTap = { item in
    markdownView.scrollToTOCItem(item)
}
```

## Supported Markdown Syntax

### Headings

```markdown
# H1 Heading
## H2 Heading
### H3 Heading
#### H4 Heading
##### H5 Heading
###### H6 Heading
```

### Text Formatting

```markdown
**Bold text**
*Italic text*
***Bold and italic***
~~Strikethrough~~
`Inline code`
```

### Lists

#### Unordered Lists

```markdown
- Item 1
- Item 2
  - Nested item 2.1
  - Nested item 2.2
```

#### Ordered Lists

```markdown
1. First item
2. Second item
   1. Nested 2.1
   2. Nested 2.2
```

#### Task Lists

```markdown
- [x] Completed task
- [ ] Pending task
```

### Links and Images

```markdown
[Link text](https://example.com)
![Image description](https://example.com/image.png)
```

### Blockquotes

```markdown
> This is a blockquote
> Can contain multiple lines
>> Nested blockquotes are supported
```

### Code Blocks

Supported programming languages for syntax highlighting:

- Swift, Objective-C
- JavaScript, TypeScript, Python, Ruby
- Java, Kotlin, Go, Rust
- C, C++, Shell, SQL
- HTML, CSS, JSON, YAML
- And more...

````markdown
```swift
func greet(name: String) -> String {
    return "Hello, \(name)!"
}
print(greet(name: "World"))
```
````

### Tables

```markdown
| Column1 | Column2 | Column3 |
|---------|---------|---------|
| A1      | B1      | C1      |
| A2      | B2      | C2      |
```

### Horizontal Rules

```markdown
---
***
___
```

### Details (Collapsible Sections)

```html
<details>
<summary>Click to expand</summary>

This is the collapsed content
Can contain any Markdown syntax

</details>
```

### Footnotes

```markdown
This is text with a footnote[^1]

[^1]: This is the footnote content
```

## Complete Example

Check out the complete example project in the `Example/ExampleForMarkdown` directory, which includes:

- All Markdown syntax rendering effects
- Custom configuration examples
- Event callback handling
- Performance testing

Run the example project:

```bash
cd Example/ExampleForMarkdown
open ExampleForMarkdown.xcodeproj
```

## Performance Optimization

- **Asynchronous Rendering** - Markdown parsing and rendering execute in background queue, not blocking the main thread
- **Incremental Updates** - Uses Diff algorithm, only updates changed parts
- **Lazy Image Loading** - Images load asynchronously with caching mechanism
- **Regex Caching** - Syntax highlighting regex expressions are cached and reused
- **View Reuse** - Efficient view update strategy

## Advanced Usage

### Using Core View Directly (Without Scrolling)

```swift
let markdownView = MarkdownViewTextKit()
// You need to manage the scroll container yourself
```

### Monitor Height Changes

```swift
let markdownView = MarkdownViewTextKit()

markdownView.onHeightChange = { newHeight in
    print("Content height changed to: \(newHeight)")
    // Can be used to dynamically adjust container height
}
// Set link tap callback
markdownView.onLinkTap = { [weak self] url in
    // Handle link tap
    if UIApplication.shared.canOpenURL(url) {
        UIApplication.shared.open(url)
    }
}
markdownView.onImageTap = { imageURL in
    // Get image if already loaded
    _ = ImageCacheManager.shared.image(for: imageURL)
}
markdownView.onTOCItemTap = { item in
    print("title:\(item.title), level:\(item.level), id:\(item.id)")
}
```

### Using Scrollable View (Recommended)

```swift
let scrollableView = ScrollableMarkdownViewTextKit()
view.addSubview(scrollableMarkdownView)

scrollableMarkdownView.translatesAutoresizingMaskIntoConstraints = false

NSLayoutConstraint.activate([
    scrollableMarkdownView.topAnchor.constraint(
                equalTo: view.topAnchor, constant: 88),
    scrollableMarkdownView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
    scrollableMarkdownView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
    scrollableMarkdownView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
])
// Built-in UIScrollView, automatically handles scrolling
scrollableMarkdownView.onLinkTap = { [weak self] url in
    // Handle link tap
    if UIApplication.shared.canOpenURL(url) {
        UIApplication.shared.open(url)
    }
}
scrollableMarkdownView.onImageTap = { imageURL in
    // Get image if already loaded
    _ = ImageCacheManager.shared.image(for: imageURL)
}
scrollableMarkdownView.onTOCItemTap = { item in
    print("title:\(item.title), level:\(item.level), id:\(item.id)")
}
scrollableMarkdownView.markdown = sampleMarkdown
// Back to table of contents
scrollableMarkdownView.backToTableOfContentsSection()
```

### Streaming Markdown Display

- Other aspects are consistent with the scrollable markdown view above

```Swift
    // Difference is in displaying content
    private func loadSampleMarkdown() {
        // Streaming render (typewriter effect)
        scrollableMarkdownView.startStreaming(
            sampleMarkdown,
            unit: .word,
            unitsPerChunk: 2,
            interval: 0.1,
        )
    }

    // If you need to show all content immediately (e.g., user clicks skip)
    @objc private func skipButtonTapped() {
        scrollableMarkdownView.markdownView.finishStreaming()
    }
```

### Real-Time Streaming (LLM/Network APIs) - New in 1.5.0

For real-time streaming from LLM APIs (like ChatGPT, Claude) where content arrives in chunks:

```Swift
class ChatViewController: UIViewController {
    private let scrollableMarkdownView = ScrollableMarkdownViewTextKit()

    // Start real streaming mode
    func startLLMStream() {
        scrollableMarkdownView.markdownView.startRealStreaming()
    }

    // Append chunks as they arrive from the API
    func onChunkReceived(_ chunk: String) {
        scrollableMarkdownView.markdownView.appendStreamContent(chunk)
    }

    // Call when stream completes
    func onStreamComplete() {
        scrollableMarkdownView.markdownView.finishStreaming()
    }
}
```

Recommended configuration for streaming AI chat in table/collection cells:

```Swift
var config = MarkdownConfiguration.default
config.typewriterTextMode = .append
config.typewriterHeightUpdateInterval = 20
config.streamMinModuleLength = 20
scrollableMarkdownView.markdownView.configuration = config
```

**Key Features**:
- **Smart Buffering**: Automatically buffers incomplete Markdown structures (unclosed code blocks, tables, LaTeX)
- **`isPlainText()` Detection**: `MarkdownStreamBuffer` detects non-Markdown content
- **Faster Plain Text Streaming**: For plain text without Markdown markers, module submission can happen at `\n` boundaries instead of strictly waiting for `\n\n`
- **Markdown Behavior Unchanged**: Markdown content still waits for `\n\n` paragraph boundaries
- **Incremental Rendering**: Renders complete modules immediately while buffering incomplete content
- **Typewriter Effect**: Smooth character-by-character animation for rendered content

## Custom Extensions

MarkdownDisplayKit supports custom extensions to add your own Markdown syntax and rendering.

### Built-in Video Extension

Register the video extension in `AppDelegate`:

```swift
import MarkdownDisplayKit

func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    // Register video extension
    MarkdownCustomExtensionManager.shared.registerVideoExtension()
    return true
}
```

**Syntax**: `[video:filename]`

```markdown
## Video Demo

[video:myVideo]

Supported formats: .mov, .mp4, .m4v
```

**Features**:
- Auto-generates video thumbnail
- Displays video duration
- Click to play with QuickLook

### Creating Custom Extensions

Implement three protocols to create your own extension:

#### 1. Custom Parser

```swift
class MentionParser: MarkdownCustomParser {
    let identifier = "mention"
    let pattern = "@([a-zA-Z0-9_]+)"  // Regex pattern

    func parse(match: NSTextCheckingResult, in text: String) -> CustomElementData? {
        guard let range = Range(match.range(at: 1), in: text) else { return nil }
        let username = String(text[range])

        return CustomElementData(
            type: "mention",
            rawText: "@\(username)",
            payload: ["username": username]
        )
    }
}
```

#### 2. Custom View Provider

```swift
class MentionViewProvider: MarkdownCustomViewProvider {
    let supportedType = "mention"

    func createView(
        for data: CustomElementData,
        configuration: MarkdownConfiguration,
        containerWidth: CGFloat
    ) -> UIView {
        let label = UILabel()
        label.text = data.rawText
        label.textColor = .systemBlue
        label.font = configuration.bodyFont
        label.backgroundColor = UIColor.systemBlue.withAlphaComponent(0.1)
        label.layer.cornerRadius = 4
        label.sizeToFit()
        return label
    }

    func calculateSize(
        for data: CustomElementData,
        configuration: MarkdownConfiguration,
        containerWidth: CGFloat
    ) -> CGSize {
        let text = data.rawText as NSString
        let size = text.size(withAttributes: [.font: configuration.bodyFont])
        return CGSize(width: size.width + 8, height: size.height + 4)
    }
}
```

#### 3. Custom Action Handler

```swift
class MentionActionHandler: MarkdownCustomActionHandler {
    let supportedType = "mention"

    func handleTap(data: CustomElementData, sourceView: UIView, presentingViewController: UIViewController?) {
        guard let username = data.payload["username"] else { return }
        print("Navigate to user profile: \(username)")
    }
}
```

#### 4. Register Extensions

```swift
let manager = MarkdownCustomExtensionManager.shared
manager.register(parser: MentionParser())
manager.register(viewProvider: MentionViewProvider())
manager.register(actionHandler: MentionActionHandler())
```

### Supported Custom Syntax Patterns

| Extension | Syntax | Description |
|-----------|--------|-------------|
| Video | `[video:filename]` | Embed video with QuickLook playback |
| Mention* | `@username` | User mention (example) |
| Emoji* | `::emoji_name::` | Custom emoji (example) |

*Example implementations, not included by default

### Code Block Renderers

In addition to inline syntax extensions, you can also create custom code block renderers for specific languages:

#### Mermaid Diagram Renderer Example

```swift
public final class MermaidRenderer: MarkdownCodeBlockRenderer {
    public let supportedLanguage = "mermaid"

    public func renderCodeBlock(
        code: String,
        configuration: MarkdownConfiguration,
        containerWidth: CGFloat
    ) -> UIView {
        // Use WKWebView to render Mermaid diagrams
        let view = MermaidWebView(code: code, frame: ...)
        return view
    }

    public func calculateSize(
        code: String,
        configuration: MarkdownConfiguration,
        containerWidth: CGFloat
    ) -> CGSize {
        // Estimate height based on diagram type
        return CGSize(width: containerWidth - 32, height: estimatedHeight)
    }
}
```

#### Register Code Block Renderer

```swift
let manager = MarkdownCustomExtensionManager.shared
manager.register(codeBlockRenderer: MermaidRenderer())
```

**Supported Diagram Types** (via Mermaid.js):
- Flowchart (flowchart/graph)
- Sequence Diagram (sequenceDiagram)
- Class Diagram (classDiagram)
- State Diagram (stateDiagram)
- Gantt Chart (gantt)
- Mind Map (mindmap)

## Troubleshooting

### 1. Build Error: Cannot find UIKit

**Problem**: Build fails when using `swift build` on macOS

**Solution**: This library only supports iOS platform, must be built in Xcode targeting iOS simulator or device

### 2. Images Not Displaying

**Problem**: Images in Markdown don't display

**Causes**:

- Image URL is invalid or inaccessible
- Network permissions not configured

**Solutions**:

- Check network permission configuration in Info.plist
- Use valid image URLs

### 3. Swift Concurrency Warnings

**Problem**: Sendable-related warnings appear

**Solution**: Library is built with Swift 5.9 to avoid strict concurrency checking

## Contributing

Issues and Pull Requests are welcome!

Before submitting a PR, please ensure:

- Code compiles successfully
- Follows existing code style
- Adds necessary tests

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Acknowledgments

- [swift-markdown](https://github.com/swiftlang/swift-markdown) - Markdown parsing library
- [KaTeX](https://github.com/KaTeX/KaTeX) - Math formula rendering fonts
- Apple TextKit 2 - High-performance text rendering framework
- Gemini3 Pro&Claude&Grok&GPT
- All contributors and users
- All friends who provided suggestions and feedback

