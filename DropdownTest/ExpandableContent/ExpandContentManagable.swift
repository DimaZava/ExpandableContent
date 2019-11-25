//
//  ExpandContentManagable.swift
//  AirLST
//
//  Created by Dmitryj on 14/08/2019.
//  Copyright © 2019 AirLST. All rights reserved.
//

import UIKit

protocol ExpandContentManagable: AnyObject, UITableViewDelegate, UITableViewDataSource {
    associatedtype Item
    associatedtype CellType

    var ContentCellType: CellType.Type { get }
    var items: [Item] { get set }
}

protocol ExpandViewable: AnyObject {
    var isCollapsed: Bool { get set }
    var headerView: UIView { get set }
    var contentTableView: SelfSizedTableView { get set }
    var delegate: ExpandableContentViewDelegate? { get set }
}
