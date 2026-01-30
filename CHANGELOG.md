# Changelog / 更新日志

All notable changes to this project will be documented in this file.

本项目的所有重要更改都将记录在此文件中。

## [1.6.0] - 2026-01-30

### Added / 新增
- 🎨 **Comprehensive Configuration Options / 全面配置项支持** - Added extensive customization for all Markdown elements / 新增所有 Markdown 元素的详细配置：
  - **LaTeX Formula / LaTeX 公式**: `latexFontSize`, `latexAlignment` (left/center/right), `latexBackgroundColor`, `latexPadding`
  - **Blockquote / 引用块**: `blockquoteBackgroundColor`, `blockquoteBarWidth`, `blockquoteContentSpacing`, `blockquoteContentPadding`
  - **Table / 表格**: `tableMinColumnWidth`, `tableMaxColumnWidth`, `tableRowHeight`, `tableCellPadding`, `tableSeparatorHeight`
  - **List / 列表**: `listItemSpacing`, `listMarkerMinWidth`, `listMarkerSpacing`
  - **Details / 折叠块**: `detailsSummaryFont`, `detailsSummaryTextColor`, `detailsSummaryMinHeight`, `detailsContentPadding`, `detailsSpacing`
  - **Syntax Highlighting / 代码高亮**: `syntaxColors`, `syntaxColorsDark` with `SyntaxHighlightColors` struct (keyword, string, number, comment, type, function, property, preprocessor) / 支持 `SyntaxHighlightColors` 结构体
  - **TOC / 目录**: `tocTextColor`

### Fixed / 修复
- `tableRowBackgroundColor`: Now properly applied to table rows / 现已正确应用于表格行

### Documentation / 文档
- Updated README with complete configuration options / 更新 README 完善所有配置选项文档

## [1.5.9] - 2026-01-26

### Added / 新增
- 🚀 **Typewriter Append Mode / 打字机追加模式** - Add `.append` mode with throttled height updates to reduce layout jumps during cell streaming / 新增 `.append` 模式，并对高度更新节流，减少 Cell 流式输出时的布局跳变
- ⚙️ **Streaming Config / 流式配置项** - Expose `typewriterTextMode`, `typewriterHeightUpdateInterval`, `streamMinModuleLength` / 提供 `typewriterTextMode`、`typewriterHeightUpdateInterval`、`streamMinModuleLength`
- 🧹 **Memory Cleanup / 内存清理** - Add cache clearing helpers and Mermaid WebView cleanup to reduce retained memory / 增加缓存清理与 Mermaid WebView 释放逻辑，降低页面退出后的驻留内存

### Changed / 变更
- 🧪 **Example Update / 示例更新** - AI chat stream uses safer LaTeX normalization (code regions ignored) and recommended config / AI 对话流式 LaTeX 规范化更安全（忽略代码区域），并给出推荐配置

## [1.5.8] - 2026-01-23

### Documentation / 文档
- 📝 **Docs Update / 文档更新** - Refresh README content / 更新 README 内容

### Fixed / 修复
- 🐛 **SPM Fix / SPM 修复** - Fix simulator build error in Swift Package Manager example project / 修复 Swift Package Manager 示例在模拟器上的编译问题

## [1.5.2] - 2026-01-08

### Fixed / 修复
- 🐛 **Crash Fix / 崩溃修复** - Serialize `swift-markdown` parsing to avoid `cmark_parser_attach_syntax_extension` race crash in concurrent renders / 串行化 `swift-markdown` 解析，避免并发渲染触发崩溃

### Added / 新增
- 🧹 **Reuse Safety / 复用安全** - Add `resetForReuse()` to clear internal caches/state for `UITableViewCell` reuse scenarios / 新增 `resetForReuse()` 清理内部缓存与状态，适配 `UITableViewCell` 复用场景
- 🧪 **Example Update / 示例更新** - Add crash reproduction screen and incremental row insert demo for table view usage / 增加崩溃复现页面与表格场景的逐条插入演示

## [1.5.1] - 2026-01-07

### Fixed / 修复
- 🐛 **Bug Fix** - Fixed potential crash when processing Unicode characters (emoji, CJK characters) in streaming mode / 修复流式渲染处理 Unicode 字符（emoji、中日韩字符）时可能崩溃的问题
  - `MarkdownStreamBuffer.extractModule`: Use safe string index with `limitedBy` to prevent out-of-bounds crash / 使用 `limitedBy` 安全获取字符串索引，防止越界崩溃
  - `TypewriterEngine.calculateDelay`: Use safe string index to prevent crash when calculating delay for special characters / 使用安全索引获取字符，防止计算特殊字符延迟时崩溃

## [1.5.0] - 2026-01-04

### Added / 新增
- 🚀 **Real Streaming Support / 真流式渲染支持** - New `MarkdownStreamBuffer` for intelligent real-time streaming from network/LLM APIs / 新增 `MarkdownStreamBuffer` 智能流式缓冲器，支持网络/LLM API 实时流式渲染
  - Smart module detection: automatically detects complete Markdown blocks (headings, code blocks, tables, LaTeX) / 智能模块检测：自动识别完整的 Markdown 块
  - Handles incomplete structures: waits for closing tags before rendering / 未闭合结构处理：等待闭合标签后再渲染
  - Incremental rendering: renders complete modules immediately while buffering incomplete content / 增量渲染：完整模块立即渲染，未完成内容继续缓冲
- 💫 **Smart Waiting Indicator / 智能等待动画** - In real streaming mode, automatically shows waiting animation when TypewriterEngine queue is empty and no network data arrives / 真流式模式下，当 TypewriterEngine 队列为空且网络数据未到达时，自动显示等待动画

### Changed / 变更
- 🏗️ **Code Refactoring / 代码重构** - Extracted `MarkdownTextViewTK2`, `MarkdownStreamBuffer`, and `TypewriterEngine` into separate files for better maintainability / 将相关类提取到独立文件，提升代码可维护性

### Fixed / 修复
- 🐛 **Streaming Fixes / 流式修复** - Multiple fixes for real streaming mode stability and rendering issues / 多项真流式模式稳定性和渲染问题修复

## [1.4.1] - 2026-01-02

### Fixed / 修复
- 🐛 **Bug Fix** - Fixed code blocks not rendering properly in real streaming mode when content arrives in multiple chunks / 修复真流式模式下代码块分块到达时无法正确渲染的问题

## [1.4.0] - 2025-12-31

### Added / 新增
- 🚀 **Instant Loading / 秒开优化** - Significantly optimized loading speed with ultra-fast first screen rendering / 大幅优化加载速度，首屏渲染极速完成
- 🔌 **Enhanced Custom Extensions / 自定义扩展增强** - New `MarkdownCodeBlockRenderer` protocol for custom code block rendering (e.g., Mermaid diagrams) / 新增代码块渲染器协议，支持 Mermaid 等图表渲染
- 🎨 **Mermaid Support / Mermaid 支持** - Example project now includes Mermaid diagram renderer supporting flowcharts, mind maps, and more / 示例项目新增 Mermaid 图表渲染器

### Performance / 性能
- ⚡ **CPU Optimization / CPU 优化** - Streaming mode with nested style rendering now uses much less CPU (iPhone 17 Pro simulator peak < 56%, average 30%) / 流式模式下 CPU 使用率大幅降低

## [1.0.0] - 2025-12-15

### Added / 新增
- 🎉 Initial release / 首次发布
- ✅ Full Markdown syntax support / 完整 Markdown 语法支持
- ✅ 20+ language code highlighting / 20+ 种语言代码高亮
- ✅ Automatic table of contents generation / 自动目录生成
- ✅ Dark mode support / 深色模式支持
- ✅ High-performance asynchronous rendering / 高性能异步渲染
