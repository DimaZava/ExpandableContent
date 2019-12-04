//
//  ExpandableContentView.swift
//  AirLST
//
//  Created by Dmitryj on 18.11.2019.
//  Copyright © 2019 AirLST. All rights reserved.
//

import UIKit

protocol ExpandableContentViewDelegate: AnyObject {
    func didToggleShowMode(for view: ExpandViewable)
}

class ExpandableContentView<T: ExpandContentManagable>: NSObject, ExpandViewable {

    // MARK: - Properties
    var manager: T
    var showModeSelectionGestureRecognizer: UITapGestureRecognizer?
    var configurationBlock: ((UITapGestureRecognizer, UIView, inout ((Bool) -> Void)) -> Void)

    // ExpandViewable
    var isCollapsed = true {
        didSet {
            toggleBlock(isCollapsed)
        }
    }
    var headerView = UIView()
    var contentTableView = SelfSizedTableView()
    var toggleBlock: ((Bool) -> Void) = { _ in }
    weak var delegate: ExpandableContentViewDelegate?

    // MARK: - Lifecycle
    init(manager: T, configurationBlock: @escaping (UITapGestureRecognizer, UIView, inout ((Bool) -> Void)) -> Void) {
        self.manager = manager

        contentTableView.register(nibWithCellClass: manager.ContentCellType)
        contentTableView.dataSource = manager
        contentTableView.delegate = manager

        contentTableView.separatorStyle = .none
        contentTableView.alwaysBounceVertical = false

        self.configurationBlock = configurationBlock
        super.init()

        let showModeSelectionGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(toggleShowMode))
        self.showModeSelectionGestureRecognizer = showModeSelectionGestureRecognizer

        configurationBlock(showModeSelectionGestureRecognizer, headerView, &toggleBlock)
    }

    // MARK: - Actions
    @objc
    private func toggleShowMode() {
        toggleBlock(isCollapsed)
        isCollapsed.toggle()
        delegate?.didToggleShowMode(for: self)
    }
}
