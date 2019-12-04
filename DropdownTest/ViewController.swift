//
//  ViewController.swift
//  DropdownTest
//
//  Created by Dmitryj on 15.11.2019.
//  Copyright © 2019 lmc. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var contentContainerView: UIView!

    var expandableListViewController: ExpandableListViewController?

    override func viewDidLoad() {
        super.viewDidLoad()
        expandableListViewController = ExpandableListViewController()
        configureExpandableViews()
    }

    func configureExpandableViews() {

        guard let expandableListViewController = self.expandableListViewController else { return }
        //let expandableActionsView = configureBookingObjectsView()

        addChildViewController(expandableListViewController, toContainerView: contentContainerView)
        expandableListViewController.view.anchor(top: contentContainerView.topAnchor,
                                                 left: contentContainerView.leftAnchor,
                                                 bottom: contentContainerView.bottomAnchor,
                                                 right: contentContainerView.rightAnchor,
                                                 topConstant: 16,
                                                 leftConstant: 8)

        let dataView1 = configureExpandableDataView(with: DataContainer(content:[
            DataItem(title: "Item 1", content: "Content 1"),
            DataItem(title: "Item 2", content: "Content 2"),
            DataItem(title: "Item 3", content: "Content 3"),
            DataItem(title: "Item 4", content: "Content 4"),
            DataItem(title: "Item 5", content: "Content 5"),
            DataItem(title: "Item 6", content: "Content 6")
        ]))
//        dataView1.toggleShowMode()

        let dataView2 = configureExpandableDataView(with: DataContainer(content:[
            DataItem(title: "Item 12", content: "Content 12"),
            DataItem(title: "Item 22", content: "Content 22"),
            DataItem(title: "Item 32", content: "Content 32Content 32Content 32Content 32Content 32Content 32Content 32Content 32Content 32Content 32Content 32Content 32Content 32Content 32Content 32Content 32Content 32Content 32Content 32Content 32Content 32Content 32Content 32Content 32Content 32"),
            DataItem(title: "Item 42", content: "Content 42"),
            DataItem(title: "Item 52", content: "Content 52"),
            DataItem(title: "Item 62", content: "Content 62")
        ]))
        //dataView2.toggleShowMode()

        DispatchQueue.global(qos: .background).asyncAfter(deadline: .now() + 0.1) {
            DispatchQueue.main.async {
                let dataView3 = self.configureExpandableDataView(with: DataContainer(content:[
                    DataItem(title: "Item 13", content: "Content 13Content 13Content 13Content 13Content 13Content 13Content 13Content 13Content 13Content 13Content 13Content 13Content 13Content 13Content 13Content 13Content 13Content 13Content 13Content 13Content 13Content 13"),
                    DataItem(title: "Item 23", content: "Content 23"),
                    DataItem(title: "Item 33", content: "Content 33"),
                    DataItem(title: "Item 43", content: "Content 43"),
                    DataItem(title: "Item 53", content: "Content 53"),
                    DataItem(title: "Item 63", content: "Content 63Content 63Content 63Content 63Content 63Content 63Content 63Content 63Content 63Content 63Content 63Content 63Content 63Content 63Content 63Content 63Content 63Content 63Content 63Content 63Content 63Content 63Content 63Content 63Content 63")
                ]))
                dataView3.isCollapsed = false

                let dataView4 = self.configureExpandableDataView(with: DataContainer(content:[
                    DataItem(title: "Item 14", content: "Content 14"),
                    DataItem(title: "Item 24", content: "Content 24"),
                    DataItem(title: "Item 34", content: "Content 34Content 34Content 34Content 34Content 34Content 34Content 34Content 34Content 34Content 34Content 34Content 34Content 34Content 34Content 34Content 34Content 34Content 34Content 34Content 34Content 34Content 34Content 34Content 34Content 34Content 34Content 34Content 34Content 34Content 34Content 34Content 34Content 34Content 34Content 34Content 34Content 34Content 34Content 34Content 34"),
                    DataItem(title: "Item 44", content: "Content 44"),
                    DataItem(title: "Item 54", content: "Content 54"),
                    DataItem(title: "Item 64", content: "Content 64")
                ]))
                dataView4.isCollapsed = false
                self.expandableListViewController?.insert(expandableContent: [dataView3, dataView4], at: 0)
            }
        }

        expandableListViewController.insert(expandableContent: [dataView1, dataView2])
    }

    func configureExpandableDataView(with container: DataContainer) -> ExpandableContentView<DataManager> {
        return ExpandableContentView(manager: DataManager(with: container)) { gestureRecognizer, headerView, toggleBlock in

            let headlineLabel = UILabel()
            headlineLabel.text = "Headline"
            headlineLabel.textColor = UIColor.label
            headlineLabel.font = headlineLabel.font.withSize(18)

            let labelDropdown = UILabel()
            labelDropdown.text = "UP"

            headerView.addSubviews([headlineLabel, labelDropdown])
            headlineLabel.anchor(top: headerView.topAnchor,
                                 left: headerView.leftAnchor,
                                 bottom: headerView.bottomAnchor,
                                 topConstant: 8,
                                 leftConstant: 0,
                                 bottomConstant: 8)
            labelDropdown.anchor(top: headerView.topAnchor,
                                 bottom: headerView.bottomAnchor,
                                 right: headerView.rightAnchor,
                                 topConstant: 8,
                                 bottomConstant: 8,
                                 rightConstant: 8)

            headerView.addGestureRecognizer(gestureRecognizer)
            toggleBlock = { isCollapsed in
                labelDropdown.text = isCollapsed ? "DOWN" : "UP"
            }
        }
    }
}
