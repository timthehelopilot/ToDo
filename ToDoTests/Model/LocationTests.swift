//
//  LocationTests.swift
//  ToDoTests
//
//  Created by Tim Barrett on 7/18/18.
//  Copyright © 2018 Timothy Barrett. All rights reserved.
//

import XCTest
import CoreLocation 
@testable import ToDo

class LocationTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func test_Init_SetsCoordinate() {
        let coordinate = CLLocationCoordinate2D(latitude: 1, longitude: 2)
        let location = Location(name: "", coordinate: coordinate)
        
        XCTAssertEqual(location.coordinate?.latitude, coordinate.latitude)
        XCTAssertEqual(location.coordinate?.longitude, coordinate.longitude)
    }
    
    func test_Init_SetsName() {
        let location = Location(name: "Foo")
        
        XCTAssertEqual(location.name, "Foo")
    }
    
    func test_CLLocationEquality() {
        let locationOne = CLLocationCoordinate2D(latitude: 36.45671, longitude: 36.45675)
        let locationTwo = CLLocationCoordinate2D(latitude: 36.45671, longitude: 36.45675)
        
        XCTAssertEqual(locationOne, locationTwo)
    }

}
