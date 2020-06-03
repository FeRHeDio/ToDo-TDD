//
//  ItemListDataProviderTests.swift
//  ToDoTests
//
//  Created by Fernando Putallaz on 27/05/2020.
//  Copyright © 2020 myOwn. All rights reserved.
//

import XCTest
@testable import ToDo

class ItemListDataSourceTest: XCTestCase {
    
    var sut: ItemListDataSource!
    var tableView: UITableView!
    var controller: ItemListVC!

    override func setUp() {
        super.setUp()
        
        sut = ItemListDataSource()
        sut.itemManager = ItemManager()
        
        let sb = UIStoryboard(name: "Main", bundle: nil)
        controller = sb.instantiateViewController(withIdentifier: "ItemListVC") as? ItemListVC
        
        controller.loadViewIfNeeded()
        
        tableView = controller.tableView
        tableView.dataSource = sut
        tableView.delegate = sut
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
        let mockTable = MockTV.mockTableView(withDataSource: sut)
        
        sut.itemManager?.add(ToDoItem(title: "Some"))
        mockTable.reloadData()
        
        _ = mockTable.cellForRow(at: IndexPath(row: 0, section: 0))
            
        XCTAssertTrue(mockTable.cellGotDequed)
    }
    
    
    func test_CellForRow_CallsConfigCell() {
        let mockTableView = MockTV.mockTableView(withDataSource: sut)
        let item = ToDoItem(title: "First")
        
        sut.itemManager?.add(item)
        mockTableView.reloadData()
        
        let cell = mockTableView.cellForRow(at: IndexPath(row: 0, section: 0)) as! MockItemCell
        
        XCTAssertEqual(cell.catchedItem, item)
    }
    
    func test_CellForRow_Section2_CallConfigCellWithDoneItem() {
        let mockTableView = MockTV.mockTableView(withDataSource: sut)
        
        let first = ToDoItem(title: "First")
        sut.itemManager?.add(first)
        
        let second = ToDoItem(title: "Second")
        sut.itemManager?.add(second)
        
        sut.itemManager?.checkItem(at: 1)
        
        mockTableView.reloadData()
        
        let cell = mockTableView.cellForRow(at: IndexPath(row: 0, section: 1)) as! MockItemCell
        XCTAssertEqual(cell.catchedItem, second)
    }
    
    func test_DeleteButton_InFirstSection_ShowsTitleCheck() {
        let deleteButtonTitle = tableView.delegate?.tableView?(tableView, titleForDeleteConfirmationButtonForRowAt: IndexPath(row: 0, section: 0))
        
        XCTAssertEqual(deleteButtonTitle, "Check")
    }
    
    func test_DeleteButton_InSecondSection_ShowsTitleUncheck() {
        let deleteButtonTitle = tableView.delegate?.tableView?(tableView, titleForDeleteConfirmationButtonForRowAt: IndexPath(row: 0, section: 1))
        
        XCTAssertEqual(deleteButtonTitle, "Uncheck")
    }
    
    func test_CheckingAnItem_CheckItInTheItemManager() {
        let first = ToDoItem(title: "First")
        sut.itemManager?.add(first)
        
        tableView.dataSource?.tableView?(tableView, commit: .delete, forRowAt: IndexPath(row: 0, section: 0))
        
        XCTAssertEqual(sut.itemManager?.toDoCount, 0)
        XCTAssertEqual(sut.itemManager?.doneCount, 1)
        XCTAssertEqual(tableView.numberOfRows(inSection: 0), 0)
        XCTAssertEqual(tableView.numberOfRows(inSection: 1), 1)
    }
    
    func test_UncheckingAnItem_UnchecksItInTheItemManager() {
        let first = ToDoItem(title: "First")
        sut.itemManager?.add(first)
        
        sut.itemManager?.checkItem(at: 0)
        tableView.reloadData()
        
        tableView.dataSource?.tableView?(tableView, commit: .delete, forRowAt: IndexPath(row: 0, section: 1))
        
        XCTAssertEqual(sut.itemManager?.toDoCount, 1)
        XCTAssertEqual(sut.itemManager?.doneCount, 0)
        XCTAssertEqual(tableView.numberOfRows(inSection: 0), 1)
        XCTAssertEqual(tableView.numberOfRows(inSection: 1), 0)
    }
        
}


extension ItemListDataSourceTest {
    
    class MockTV: UITableView {
        
        var cellGotDequed = false
        
        class func mockTableView(withDataSource dataSource: UITableViewDataSource) -> MockTV {
            
            let mockTV = MockTV(frame: CGRect(x: 0, y: 0, width: 320, height: 480), style: .plain)
            
            mockTV.dataSource = dataSource
            mockTV.register(MockItemCell.self, forCellReuseIdentifier: "ItemCell")
            
            return mockTV
            
        }
        
        override func dequeueReusableCell(withIdentifier identifier: String, for indexPath: IndexPath) -> UITableViewCell {
            cellGotDequed = true
            return super.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
        }
        
    }
    
    class MockItemCell: ItemCell {
        var catchedItem: ToDoItem?
        
        override func configCell(with item: ToDoItem, checked: Bool = false) {
            catchedItem = item
        }
    }
}
