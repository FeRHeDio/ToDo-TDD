//
//  ItemCellTests.swift
//  ToDoTests
//
//  Created by Fernando Putallaz on 03/06/2020.
//  Copyright © 2020 myOwn. All rights reserved.
//

import XCTest
@testable import ToDo

class ItemCellTest: XCTestCase {
    
    var tv: UITableView!
    let ds = FakeDS()
    var cell: ItemCell!

    override func setUp() {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let controller = sb.instantiateViewController(withIdentifier: "ItemListVC") as! ItemListVC
        
        controller.loadViewIfNeeded()
        
        tv = controller.tableView
        tv?.dataSource = ds
        
        cell = (tv?.dequeueReusableCell(withIdentifier: "ItemCell", for: IndexPath(row: 0, section: 0)) as! ItemCell)
    }

    override func tearDown() {
    }
    
    func test_HasNameInLabel() {
        XCTAssertTrue(cell.titleLabel.isDescendant(of: cell.contentView))
    }
    
    func test_HasLocationLabel() {
        XCTAssertTrue(cell.locationLabel.isDescendant(of: cell.contentView))
    }
    
    func test_HasDateLabel() {
        XCTAssertTrue(cell.dateLabel.isDescendant(of: cell.contentView))
    }
    
    func test_ConfigCell_SetTitleLabel() {
        cell.configCell(with: ToDoItem(title: "First Title"))
        XCTAssertEqual(cell.titleLabel.text, "First Title")
    }
    
    func test_ConfigCell_SetsDate() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        let date = dateFormatter.date(from: "03/06/2020")
        let timeStamp = date?.timeIntervalSince1970
        
        cell.configCell(with: ToDoItem(title: "New Title", timestamp: timeStamp))
        
        XCTAssertEqual(cell.dateLabel.text, "03/06/2020")
    }
    
    func test_ConfigCell_SetsLocationLabel() {
        
        cell.configCell(with: ToDoItem(title: "First Item", location: Location(name: "Some Place")))
     
        XCTAssertEqual(cell.locationLabel.text, "Some Place")
    }
    
    func test_Title_WhenItemIsChecked_OthersItemsAreEmpty() {
        let location = Location(name: "Somewhere")
        let item = ToDoItem(title: "Something to do", itemDescription: "Some thing to do", timestamp: 1234320023, location: location)
        cell.configCell(with: item, checked: true)
        
        let attributedString = NSAttributedString(
            string: "Something to do",
            attributes: [
            NSAttributedString.Key.strikethroughStyle: NSUnderlineStyle.single.rawValue
        ])
        
        XCTAssertEqual(cell.titleLabel.attributedText, attributedString)
        XCTAssertNil(cell.locationLabel.text)
        XCTAssertNil(cell.dateLabel.text)
        
    }

}


extension ItemCellTest {
    
    class FakeDS: NSObject, UITableViewDataSource {
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return 1
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            return UITableViewCell()
        }
    }
    
}
