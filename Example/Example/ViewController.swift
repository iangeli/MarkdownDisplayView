//
//  ViewController.swift
//  CocoapodsMDExample
//
//  Created by 朱继超 on 12/19/25.
//

import UIKit
import MarkdownDisplayView
import Combine

final class ViewController: UIViewController {
    let tableView = UITableView(frame: .zero, style: .plain)

    var messages: [String] = []
    var cachedHeights: [Int: CGFloat] = [:]
    var cachedContents: [Int: MarkdownPreparedContent] = [:]

    var cancellables = Set<AnyCancellable>()
    let heightUpdateSubject = PassthroughSubject<Void, Never>()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground

        setupTableView()
        bindData()
        prepareMessages()
    }

    func prepareMessages() {
        messages = Self.messages

        let render = MarkdownRenderer(configuration: .default)
        messages.enumerated().forEach { index, value in
            let content = render.prepare(value, optional: .width(view.frame.width))
            let height = content.estimate?.heights.reduce(0, +) ?? 0
            self.cachedHeights[index] = height
            self.cachedContents[index] = content
            print("estimatedHeight", index, height)
        }

        tableView.reloadData()
    }

    func bindData() {
        heightUpdateSubject
            .throttle(for: .milliseconds(300), scheduler: DispatchQueue.main, latest: false)
            .sink { [weak self] _ in
                guard let self else { return }
                UIView.performWithoutAnimation {
                    self.tableView.beginUpdates()
                    self.tableView.endUpdates()
                } }
            .store(in: &cancellables)

        Timer.publish(every: 1.0, on: .main, in: .common)
            .autoconnect()
            .map { [weak self] _ in self?.cachedHeights }
            .removeDuplicates()
            .sink { value in
                print("---------------------------->")
                value?.sorted(by: { $0.key < $1.key })
                    .forEach { (key: Int, value: CGFloat) in
                        print(key, value)
                    }
                print("<----------------------------") }
            .store(in: &cancellables)
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        messages.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(withIdentifier: HistoryCell.self.description(), for: indexPath) as? HistoryCell
        else { return UITableViewCell() }

        cell.delegate = self

        if let model = cachedContents[indexPath.row] {
            cell.configure(content: model, containerWidth: tableView.frame.width)
        }
//        cell.configure(markdown: messages[indexPath.row])

        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        cachedHeights[indexPath.row] ?? tableView.estimatedRowHeight
    }
}

extension ViewController: HistoryCellDelegate {
    func historyCell(_ cell: HistoryCell, didChangeContentHeight newHeight: CGFloat) {
        print("content height changed:", self.tableView.indexPath(for: cell)?.row ?? -1, newHeight)
        guard
            let row = tableView.indexPath(for: cell)?.row,
            row < messages.count,
            let cached = cachedHeights[row],
            abs(cached - newHeight) > 0.1
        else { return }

        cachedHeights[row] = newHeight
        heightUpdateSubject.send()
    }
}

