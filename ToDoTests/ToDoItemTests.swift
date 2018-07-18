//
//  ToDoItemTests.swift
//  ToDoTests
//
//  Created by Tim Barrett on 7/15/18.
//  Copyright © 2018 Timothy Barrett. All rights reserved.
//

import XCTest
@testable import ToDo

class ToDoItemTests: XCTestCase {

    override func setUp() {
        super.setUp()
        
    }

    override func tearDown() {
        
        super.tearDown()
    }
    
    func test_Init_WhenGivenTitle_SetsTitle() {
        let item = ToDoItem(title: "Foo")
        
        XCTAssertEqual(item.title, "Foo", "should set title")
    }
    
    func test_Init_WhenGivenDescription_SetsDescription() {
        let item = ToDoItem(title: "", itemDescription: "Bar")
        
        XCTAssertEqual(item.itemDescription, "Bar", "should set itemDescription")
    }

    func test_Init_SetsTimeStamp() {
        let item = ToDoItem(title: "", timeStamp: 0.0)
        
        XCTAssertEqual(item.timeStamp, 0.0, "should set timestamo")
    }
}
