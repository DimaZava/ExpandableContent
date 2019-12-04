//
//  DataTableViewCell.swift
//  DropdownTest
//
//  Created by Dmitryj on 15.11.2019.
//  Copyright © 2019 lmc. All rights reserved.
//

import UIKit

class DataTableViewCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!

    func configure(_ dataModel: DataManagerModel) {
        titleLabel.text = dataModel.title
        contentLabel.text = dataModel.content
    }
}
