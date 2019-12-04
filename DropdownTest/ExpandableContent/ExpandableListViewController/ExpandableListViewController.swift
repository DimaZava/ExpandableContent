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

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupInitialState()
    }

    // MARK: - Actions
    func insert(expandableContent: [ExpandViewable], at index: Int? = nil) {
        guard !expandableContent.isEmpty,
            (index ?? 0) >= 0 else { return }

        let position = index ?? content.endIndex
        let originalCollapseState = expandableContent.map { $0.isCollapsed }

        tableView.performBatchUpdates({
            content.insert(contentsOf: expandableContent, at: position)
            self.content[position..<position + expandableContent.count].forEach { $0.isCollapsed = false }
            tableView.insertSections(IndexSet(integersIn: position..<position + expandableContent.count),
                                     with: .none)
        }, completion: { isCompleted in
            if isCompleted {
                zip(self.content, originalCollapseState).forEach { $0.0.isCollapsed = $0.1 }
                self.tableView.reloadSections(IndexSet(integersIn: position..<position + expandableContent.count),
                                              with: .none)
            }
        })
    }

    func remove(at index: Int) {
        content.remove(at: index)
        tableView.deleteSections(IndexSet(integer: index), with: .left)
    }

    func removeContent() {
        content.removeAll()
        tableView.deleteSections(IndexSet(integersIn: content.startIndex..<content.endIndex), with: .left)
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
