//
//  ExpandableListViewController.swift
//  AirLST
//
//  Created by Dmitryj on 07/08/2019.
//  Copyright © 2019 AirLST. All rights reserved.
//

import UIKit

class ExpandableListViewController: UIViewController {

    // MARK: - Constants
    let tableView = SelfSizedTableView()

    // MARK: - Variables
    private (set) var content = [ExpandViewable]()
    private var ifNeedsToUpdateLayout = false

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupInitialState()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        guard !content.isEmpty,
            !ifNeedsToUpdateLayout else { return }

        ifNeedsToUpdateLayout = true
        forceUpdateLayout()
    }

    // MARK: - Actions
    func insert(expandableContent: [ExpandViewable], at index: Int? = nil) {
        guard !expandableContent.isEmpty,
            (index ?? 0) >= 0 else { return }

        let position = index ?? content.endIndex
        content.insert(contentsOf: expandableContent, at: position)
        tableView.insertSections(IndexSet(integersIn: position..<position + expandableContent.count), with: .automatic)
        ifNeedsToUpdateLayout = false
    }

    func removeContent() {
        content.removeAll()
        tableView.deleteSections(IndexSet(integersIn: content.startIndex..<content.endIndex), with: .none)
    }
}

private extension ExpandableListViewController {

    func setupInitialState() {
        view.addSubview(tableView)
        tableView.fillToSuperview()
        tableView.alwaysBounceVertical = false
        tableView.register(nibWithCellClass: ExpandableListTableViewCell.self)
        tableView.delegate = self
        tableView.dataSource = self
    }

    func forceUpdateLayout() {
        // Hacky way to force updating of inner self sizing table views
        let originalCollapseState = content.map { $0.isCollapsed }
        content.forEach { $0.isCollapsed = false }
        tableView.performBatchUpdates ({
            self.tableView.reloadSections(IndexSet(integersIn: self.content.startIndex..<self.content.endIndex), with: .none)
            zip(content, originalCollapseState).forEach { $0.0.isCollapsed = $0.1 }
            self.tableView.reloadSections(IndexSet(integersIn: self.content.startIndex..<self.content.endIndex), with: .none)
        })
    }
}

// MARK: - ExpandableContentViewDelegate
extension ExpandableListViewController: ExpandableContentViewDelegate {

    func didToggleShowMode(for view: ExpandViewable) {
        guard let indexToUpdate = content.firstIndex(where: { $0 === view }) else { return }
        tableView.reloadSections(IndexSet(integer: indexToUpdate), with: .automatic)
    }
}

extension ExpandableListViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let expandableContent = content[section]
        expandableContent.delegate = self
        return expandableContent.headerView
    }
}

// MARK: - UITableViewDataSource
extension ExpandableListViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return content.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return content[section].isCollapsed ? 0 : 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withClass: ExpandableListTableViewCell.self, for: indexPath)
        let expandableContent = content[indexPath.section]
        cell.configure(with: expandableContent.contentTableView)
        return cell
    }
}
