//
//  DetailVCests.swift
//  ToDoTests
//
//  Created by Fernando Putallaz on 09/06/2020.
//  Copyright © 2020 myOwn. All rights reserved.
//

import XCTest
@testable import ToDo

class DetailVCTests: XCTestCase {

    var sut: DetailVC!
    
    override func setUp() {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        sut = sb.instantiateViewController(withIdentifier: "DetailVC") as? DetailVC
        sut.loadViewIfNeeded()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func test_HasTitleLabel() {
        let titleLabelIsSubView = sut.titleLabel?.isDescendant(of: sut.view) ?? false
        XCTAssertTrue(titleLabelIsSubView)
    }
    
    func test_HasDueDateLabel() {
        let dueDateLabelIsSubView = sut.dueDateLabel?.isDescendant(of: sut.view) ?? false
        XCTAssertTrue(dueDateLabelIsSubView)
    }
    
    func test_HasLocationLabel() {
        
        let locationLabelIsSubView = sut.locationLabel?.isDescendant(of: sut.view) ?? false
        
        XCTAssertTrue(locationLabelIsSubView)
    }
    
    func test_HasDescriptionLabel() {
        
        let descriptionLabelIsSubView = sut.descriptionLabel?.isDescendant(of: sut.view) ?? false
        
        XCTAssertTrue(descriptionLabelIsSubView)
    }


}
