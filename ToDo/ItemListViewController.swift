//
//  ItemListViewController.swift
//  ToDo
//
//  Created by Tim Barrett on 7/18/18.
//  Copyright © 2018 Timothy Barrett. All rights reserved.
//

import UIKit

class ItemListViewController: UIViewController {
    
    @IBOutlet weak var itemListTableView: UITableView!
    @IBOutlet weak var dataProvider: (UITableViewDelegate & UITableViewDataSource)!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
