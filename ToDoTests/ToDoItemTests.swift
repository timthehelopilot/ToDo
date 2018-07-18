//
//  ToDoItemTests.swift
//  ToDoTests
//
//  Created by Tim Barrett on 7/15/18.
//  Copyright © 2018 Timothy Barrett. All rights reserved.
//

import XCTest
import CoreLocation
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
    
    func test_Init_WhenGivenLocation_SetsLocation() {
        let location = Location(name: "Foo")
        let item = ToDoItem(title: "", location: location)
        
        XCTAssertEqual(item.location?.name, location.name, "should set location")
    }
    
    func test_EqualItems_AreEqual() {
        let first = ToDoItem(title: "Foo")
        let second = ToDoItem(title: "Foo")
        
        XCTAssertEqual(first, second)
    }
}
