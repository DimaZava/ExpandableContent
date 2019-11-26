//
//  DataManager.swift
//  DropdownTest
//
//  Created by Dmitryj on 15.11.2019.
//  Copyright © 2019 lmc. All rights reserved.
//

import UIKit

class DataManager: NSObject, ExpandContentManagable {
    typealias CellType = DataTableViewCell

    // MARK: - Properties
    let ContentCellType = DataTableViewCell.self
    var items = [DataManagerModel]()

    // MARK: - Lifecycle
    init(with container: DataContainer) {
        super.init()
        items = container.content.map { DataManagerModel(title: $0.title, content: $0.content) }
    }
}

extension DataManager: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withClass: ContentCellType, for: indexPath)
        cell.configure(items[indexPath.row])
        return cell
    }
}
