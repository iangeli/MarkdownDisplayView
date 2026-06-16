//
//  HistoryCell.swift
//  ExampleForMarkdown
//
//  Created by hares on 2026/6/15.
//

import Foundation
import UIKit
import MarkdownDisplayView

protocol HistoryCellDelegate: AnyObject {
    func historyCell(_ cell: HistoryCell, didChangeContentHeight newHeight: CGFloat)
}

final class HistoryCell: UITableViewCell {
    private lazy var markdownView: MarkdownViewTextKit = {
        let v = MarkdownViewTextKit()
        v.clipsToBounds = true
        v.onHeightChange = { [weak self] newHeight in
            guard let self else { return }
            self.delegate?.historyCell(self, didChangeContentHeight: newHeight)
        }
        return v
    }()

    weak var delegate: HistoryCellDelegate?

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        contentView.clipsToBounds = true

        makeConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(content: MarkdownPreparedContent, containerWidth: CGFloat) {
        markdownView.setPreparedContent(content, containerWidth: containerWidth)
    }

    func configure(markdown: String) {
        markdownView.markdown = markdown
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        delegate = nil
        markdownView.resetForReuse()
    }

    func makeConstraints() {
        markdownView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(markdownView)
        NSLayoutConstraint.activate([
            markdownView.topAnchor.constraint(equalTo: contentView.topAnchor),
            markdownView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            markdownView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            markdownView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
}
