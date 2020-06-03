//
//  ItemListViewControllerTest.swift
//  ToDoTests
//
//  Created by Fernando Putallaz on 27/05/2020.
//  Copyright © 2020 myOwn. All rights reserved.
//

import XCTest
@testable import ToDo

class ItemListVCTest: XCTestCase {

    var sut: ItemListVC!
    
    override func setUp() {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "ItemListVC")
        sut = (vc as! ItemListVC)
        sut.loadViewIfNeeded()
    }

    override func tearDown() {
    }

    func test_TableView_AfterViewDidLoad_IsNotNil() {
        XCTAssertNotNil(sut.tableView)
    }

    func test_LoadingView_SetsTableViewDataSource() {
        XCTAssertTrue(sut.tableView.dataSource is ItemListDataSource)
    }
    
    func test_LoadingView_SetsTableViewDelegate() {
        XCTAssertTrue(sut.tableView.delegate is ItemListDataSource)
    }
    
    func test_LoadingView_DataSourceAndDelegate_AreTheSame() {
        XCTAssertEqual(sut.tableView.dataSource as? ItemListDataSource,
                       sut.tableView.delegate as? ItemListDataSource)
    }
}
