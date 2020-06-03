//
//  ItemManagerTests.swift
//  ToDoTests
//
//  Created by Fernando Putallaz on 24/05/2020.
//  Copyright © 2020 myOwn. All rights reserved.
//

import XCTest
@testable import ToDo

class ItemManagerTest: XCTestCase {
    
    var sut: ItemManager!

    override func setUp() {
        super.setUp()
        sut = ItemManager()
    }

    override func tearDown() {
        super.tearDown()
        sut = nil
    }

    func test_ToDoCount_Initially_isZero() {
        XCTAssertEqual(sut.toDoCount, 0)
    }
    
    func test_DoneCount_Initially_IsZero() {
        XCTAssertEqual(sut.doneCount, 0)
    }
 
    func test_AddItem_IncreasesToDoCountToOne() {
        sut.add(ToDoItem(title: ""))
        XCTAssertEqual(sut.toDoCount, 1)
    }
    
    func test_ItemAt_ReturnsAddedItem() {
        let item = ToDoItem(title: "Pedro")
        sut.add(item)
        
        let returnedItem = sut.item(at: 0)
        XCTAssertEqual(returnedItem.title, item.title)
    }
    
    func test_CheckItemAt_ChangesCount() {
        sut.add(ToDoItem(title: ""))
        
        sut.checkItem(at: 0)
        
        XCTAssertEqual(sut.toDoCount, 0)
        XCTAssertEqual(sut.doneCount, 1)
    }
    
    func test_CheckItemAt_RemovesItemFromToDoItems() {
        let first = ToDoItem(title: "Learn TDD")
        let second = ToDoItem(title: "Learn SwiftUI")
    
        sut.add(first)
        sut.add(second)
        
        sut.checkItem(at: 0)
        
        XCTAssertEqual(sut.item(at: 0).title, "Learn SwiftUI")
    }
    
    func test_DoneItemAt_ReturnsCheckedItem() {
        let item = ToDoItem(title: "Learn SwiftUI")
        sut.add(item)
        
        sut.checkItem(at: 0)
        let returnedItem = sut.doneItem(at: 0)
        
        XCTAssertEqual(returnedItem.title, item.title)
    }
    
    func test_Items_RemoveAll_ShouldBeZero() {
        sut.add(ToDoItem(title: "Learn SwiftUI"))
        sut.add(ToDoItem(title: "Learn TDD"))
        sut.checkItem(at: 0)
        
        XCTAssertEqual(sut.toDoCount, 1)
        XCTAssertEqual(sut.doneCount, 1)
        
        sut.removeAll()
        
        XCTAssertEqual(sut.toDoCount, 0)
        XCTAssertEqual(sut.doneCount, 0)
    }
    
    func test_Add_WhenItemExists_DoesNotCount(){
        sut.add(ToDoItem(title: "Learn SwiftUI"))
        sut.add(ToDoItem(title: "Learn SwiftUI"))
        
        XCTAssertEqual(sut.toDoCount, 1)
    }

}
