//
//  SmartStreamingShortViewController.swift
//  CocoapodsMDExample
//
//  Created by 朱继超 on 12/20/25.
//

import UIKit
import MarkdownDisplayView

final class SmartStreamingShortViewController: UIViewController {

    private let scrollableMarkdownView = ScrollableMarkdownViewTextKit()
    private var streamTimer: Timer?
    private var hasStarted = false
    private var currentChunkIndex = 0

    private let streamChunks: [String] = [
        "# 智能流式（短文本示例）\n",
        "这是一个**短文本**示例，用于演示 SmartBuffer 的自动分块能力。\n\n",
        "## 核心特性\n- 自动识别完整模块\n- 避免 Markdown 语法被截断\n- 适合小段文本实时追加\n\n",
        "```swift\nlet message = \"Hello, Smart Stream\"\nprint(message)\n```\n\n",
        "> 结束：这一行会作为完整块展示。\n"
    ]

    private lazy var closeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("关闭", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .medium)
        button.addTarget(self, action: #selector(closeTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "智能流式短文本"
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        label.backgroundColor = .systemBackground
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupUI()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        startStreamingIfNeeded()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        stopStreaming()
    }

    private func setupUI() {
        view.addSubview(titleLabel)
        view.addSubview(closeButton)
        view.addSubview(scrollableMarkdownView)

        scrollableMarkdownView.translatesAutoresizingMaskIntoConstraints = false
        scrollableMarkdownView.alwaysBounceVertical = true

        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
            titleLabel.heightAnchor.constraint(equalToConstant: 44),

            closeButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
            closeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            closeButton.heightAnchor.constraint(equalToConstant: 44),

            scrollableMarkdownView.topAnchor.constraint(equalTo: closeButton.bottomAnchor, constant: 8),
            scrollableMarkdownView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollableMarkdownView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollableMarkdownView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    private func startStreamingIfNeeded() {
        guard !hasStarted else { return }
        hasStarted = true

        currentChunkIndex = 0
        scrollableMarkdownView.markdownView.beginRealStreaming(
            autoScrollBottom: true,
            useSmartBuffer: true
        )

        streamTimer?.invalidate()
        streamTimer = Timer.scheduledTimer(withTimeInterval: 0.2, repeats: true) { [weak self] timer in
            guard let self else {
                timer.invalidate()
                return
            }

            if self.currentChunkIndex < self.streamChunks.count {
                let chunk = self.streamChunks[self.currentChunkIndex]
                self.scrollableMarkdownView.markdownView.appendStreamData(chunk)
                self.currentChunkIndex += 1
            } else {
                timer.invalidate()
                self.streamTimer = nil
                self.scrollableMarkdownView.markdownView.endRealStreaming()
            }
        }
    }

    private func stopStreaming() {
        streamTimer?.invalidate()
        streamTimer = nil
    }

    @objc private func closeTapped() {
        stopStreaming()
        dismiss(animated: true)
    }
}
