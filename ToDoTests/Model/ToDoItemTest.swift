//
//  ToDoItemTests.swift
//  ToDoTests
//
//  Created by Fernando Putallaz on 18/05/2020.
//  Copyright © 2020 myOwn. All rights reserved.
//

import XCTest
@testable import ToDo


class ToDoItemTest: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_Init_GivenTitle_SetsTitle(){
        let item = ToDoItem(title: "Learn TDD")
        XCTAssertEqual(item.title, "Learn TDD", "Should set title")
    }
    
    func test_Init_GivenDescription_SetsDescription() {
        let item = ToDoItem(title: "Learn TDD", itemDescription: "Learn about the fundamentals of TDD")
        XCTAssertEqual(item.itemDescription, "Learn about the fundamentals of TDD", "Should set itemDescription")
    }
    
    func test_Init_SetsTimestamp() {
        let item = ToDoItem(title: "", timestamp: 0.0)
        XCTAssertEqual(item.timestamp, 0.0, "Should set timestamp")
    }
    
    func test_Init_GivenLocation_SetsLocation() {
        let location = Location(name: "Foo Location")
        let item = ToDoItem(title: "", location: location)
        XCTAssertEqual(item.location?.name, location.name, "Should set location")
    }
    
    func test_EqualItems_AreEquals() {
        let first = ToDoItem(title: "Learn TDD")
        let second = ToDoItem(title: "Learn TDD")
        
        XCTAssertEqual(first, second)
    }
    
    func test_Items_LocationDiffers_AreNotEqual() {
        let first = ToDoItem(title: "", location: Location(name: "At the bar"))
        let second = ToDoItem(title: "", location: Location(name: "At the kitchen"))
        
        XCTAssertNotEqual(first, second)
    }
    
    func test_Items_OneLocationIsNil_AreNotEqual() {
        var first = ToDoItem(title: "Learn TDD", location: Location(name: "Srilanka"))
        var second = ToDoItem(title: "Learn TDD", location: nil)
        
        first = ToDoItem(title: "Learn TDD", location: nil)
        second = ToDoItem(title: "Learn TDD", location: Location(name: "Srilanka"))
        
        XCTAssertNotEqual(first, second)
    }
    
    func test_Items_TimeStampsDiffer_AreNotEqual() {
        let first = ToDoItem(title: "Learn TDD", timestamp: 0.0)
        let second = ToDoItem(title: "Learn TDD", timestamp: 1.0)
        
        XCTAssertNotEqual(first, second)
    }
    
    func test_Items_DescriptionsDiffer_AreNotEqual() {
        let first = ToDoItem(title: "Learn TDD", itemDescription: "Some")
        let second  = ToDoItem(title: "Learn TDD", itemDescription: "Thing")
        
        XCTAssertNotEqual(first, second)
    }
    
    func test_Items_TitleDiffers_AreNotEqual() {
        let first = ToDoItem(title: "Learn TDD")
        let second = ToDoItem(title: "Learn SwiftUI")
        
        XCTAssertNotEqual(first, second)
    }

    func test_Performance() {
        self.measure {
            _ = ToDoItem(title: "Read & Practice", itemDescription: "Follow along", timestamp: 3.3)
        }
    }
    

}
