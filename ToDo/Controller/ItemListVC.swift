//
//  ItemListViewController.swift
//  ToDo
//
//  Created by Fernando Putallaz on 27/05/2020.
//  Copyright © 2020 myOwn. All rights reserved.
//

import UIKit

class ItemListVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet var dataProvider: (UITableViewDataSource & UITableViewDelegate)!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = dataProvider
        tableView.delegate = dataProvider
    }
    
}
