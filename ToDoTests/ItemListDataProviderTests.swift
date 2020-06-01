//
//  ItemListDataProviderTests.swift
//  ToDoTests
//
//  Created by Fernando Putallaz on 27/05/2020.
//  Copyright © 2020 myOwn. All rights reserved.
//

import XCTest
@testable import ToDo

class ItemListDataProviderTests: XCTestCase {
    
    var sut: ItemListDataProvider!
    var tableView: UITableView!
    var controller: ItemListViewController!

    override func setUp() {
        super.setUp()
        
        sut = ItemListDataProvider()
        sut.itemManager = ItemManager()
        
        let sb = UIStoryboard(name: "Main", bundle: nil)
        controller = sb.instantiateViewController(withIdentifier: "ItemListViewController") as? ItemListViewController
        
        controller.loadViewIfNeeded()
        
        tableView = controller.tableView
        tableView.dataSource = sut
    }

    override func tearDown() {
    }

    func test_NumberOfSections_IsTwo() {
        let numberOfSections = tableView.numberOfSections
        XCTAssertEqual(numberOfSections, 2)
    }
    
    func test_NumberOfRows_Section1_IsToDoCount() {
        sut.itemManager?.add(ToDoItem(title: "Foo"))
        XCTAssertEqual(tableView.numberOfRows(inSection: 0), 1)
        
        sut.itemManager?.add(ToDoItem(title: "Bar"))
        tableView.reloadData()
        XCTAssertEqual(tableView.numberOfRows(inSection: 0), 2)
    }
    
    func test_NumberOfRows_Section2_IsToDoneCount() {
        sut.itemManager?.add(ToDoItem(title: "Foo"))
        sut.itemManager?.add(ToDoItem(title: "Bar"))
        sut.itemManager?.checkItem(at: 0)
        
        XCTAssertEqual(tableView.numberOfRows(inSection: 1), 1)
        
        sut.itemManager?.checkItem(at: 0)
        tableView.reloadData()
        
        XCTAssertEqual(tableView.numberOfRows(inSection: 1), 2)
    }
    
    func test_CellForRow_ReturnsItemCell() {
        
        sut.itemManager?.add(ToDoItem(title: "Foo"))
        tableView.reloadData()
        
        let cell = tableView.cellForRow(at: IndexPath(row: 0, section: 0))
        
        XCTAssertTrue(cell is ItemCell)
    }
    
    func test_CellForRow_DequeuesCellFromTableView() {
        
        let mockTable = MockTableView()
        mockTable.dataSource = sut
        mockTable.register(ItemCell.self, forCellReuseIdentifier: "ItemCell")
        
        sut.itemManager?.add(ToDoItem(title: "Some"))
        mockTable.reloadData()
        
        _ = mockTable.cellForRow(at: IndexPath(row: 0, section: 0))
            
        XCTAssertTrue(mockTable.cellGotDequed)
    }
    
    
    func test_CellForRow_CallsConfigCell() {
        
        let mockTableView = MockTableView()
        mockTableView.dataSource = sut
        
        mockTableView.register(MockItemCell.self, forCellReuseIdentifier: "ItemCell")
        
        let item = ToDoItem(title: "First")
        sut.itemManager?.add(item)
        mockTableView.reloadData()
        
        let cell = mockTableView.cellForRow(at: IndexPath(row: 0, section: 0)) as! MockItemCell
        
        XCTAssertTrue(cell.configCellGotCalled)
    }
}




extension ItemListDataProviderTests {
    
    class MockTableView: UITableView {
        var cellGotDequed = false
        
        override func dequeueReusableCell(withIdentifier identifier: String, for indexPath: IndexPath) -> UITableViewCell {
            cellGotDequed = true
            return super.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
        }
    }
    
    class MockItemCell: ItemCell {
        var configCellGotCalled = false
        
        override func configCell(with item: ToDoItem) {
            configCellGotCalled = true
        }
        
    }
}
