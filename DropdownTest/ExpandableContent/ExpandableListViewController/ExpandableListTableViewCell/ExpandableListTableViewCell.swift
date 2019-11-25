//
//  ExpandableListTableViewCell.swift
//  AirLST
//
//  Created by Dmitryj on 12/08/2019.
//  Copyright © 2019 AirLST. All rights reserved.
//

import UIKit

final class ExpandableListTableViewCell: UITableViewCell {
    
    func configure(with view: UIView) {
        addSubview(view)
        view.fillToSuperview()
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        removeSubviews()
    }
}
