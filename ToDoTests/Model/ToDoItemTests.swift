//
//  ToDoItemTests.swift
//  ToDoTests
//
//  Created by Fernando Putallaz on 18/05/2020.
//  Copyright © 2020 myOwn. All rights reserved.
//

import XCTest
@testable import ToDo


class ToDoItemTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_Init_WhenGivenTitle_SetsTitle(){
        let item = ToDoItem(title: "Foo")
        XCTAssertEqual(item.title, "Foo", "Should set title")
    }
    
    func test_Init_WhenGivenDescription_SetsDescription() {
        let item = ToDoItem(title: "Foo", itemDescription: "Bar")
        XCTAssertEqual(item.itemDescription, "Bar", "Should set itemDescription")
    }
    
    func test_Init_SetsTimestamp() {
        let item = ToDoItem(title: "", timestamp: 0.0)
        XCTAssertEqual(item.timestamp, 0.0, "Should set timestamp")
    }
    
    func test_Init_WhenGivenLocation_SetsLocation() {
        let location = Location(name: "Foo Location")
        let item = ToDoItem(title: "", location: location)
        XCTAssertEqual(item.location?.name, location.name, "Should set location")
    }
    
    func test_EqualItems_AreEquals() {
        let first = ToDoItem(title: "Foo")
        let second = ToDoItem(title: "Foo")
        
        XCTAssertEqual(first, second)
    }
    
    func test_Items_WhenLocationDiffers_AreNotEqual() {
        let first = ToDoItem(title: "", location: Location(name: "Foo"))
        let second = ToDoItem(title: "", location: Location(name: "Bar"))
        
        XCTAssertNotEqual(first, second)
    }
    
    func test_Items_WhenOneLocationIsNil_AreNotEqual() {
        var first = ToDoItem(title: "Foo", location: Location(name: "Algo"))
        var second = ToDoItem(title: "Foo", location: nil)
        
        first = ToDoItem(title: "Foo", location: nil)
        second = ToDoItem(title: "Foo", location: Location(name: "Algo"))
        
        XCTAssertNotEqual(first, second)
    }
    
    func test_Items_WhenTimeStampsDiffer_AreNotEqual() {
        let first = ToDoItem(title: "Foo", timestamp: 0.0)
        let second = ToDoItem(title: "Foo", timestamp: 1.0)
        
        XCTAssertNotEqual(first, second)
    }
    
    func test_Items_WhenDescriptionsDiffer_AreNotEqual() {
        let first = ToDoItem(title: "Foo", itemDescription: "Some")
        let second  = ToDoItem(title: "Foo", itemDescription: "Thing")
        
        XCTAssertNotEqual(first, second)
    }
    
    func test_Items_WhenTitleDiffers_AreNotEqual() {
        let first = ToDoItem(title: "Foo")
        let second = ToDoItem(title: "Bar")
        
        XCTAssertNotEqual(first, second)
    }

    func test_Performance() {
        self.measure {
            _ = ToDoItem(title: "Hay caramba", itemDescription: "algo para poner", timestamp: 3.3)
        }
    }
    

}
