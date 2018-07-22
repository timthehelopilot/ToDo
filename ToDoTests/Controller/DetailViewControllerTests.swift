//
//  DetailViewControllerTests.swift
//  ToDoTests
//
//  Created by Tim Barrett on 7/21/18.
//  Copyright © 2018 Timothy Barrett. All rights reserved.
//

import XCTest
@testable import ToDo

class DetailViewControllerTests: XCTestCase {
    
    var sut: DetailViewController!

    override func setUp() {
        super.setUp()
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        sut = storyboard.instantiateViewController(withIdentifier: "Detail View Controller") as? DetailViewController
        sut.loadViewIfNeeded()
    }

    override func tearDown() {
        
        super.tearDown()
    }
    
    func test_hasTitleLabel() {
        let titleLabelIsSubview = sut.titleLabel.isDescendant(of: sut.view)
        
        XCTAssertTrue(titleLabelIsSubview)
    }
    
    func test_HasDateLabel() {
        let dateLabelIsSubview = sut.dateLabel.isDescendant(of: sut.view)
        
        XCTAssertTrue(dateLabelIsSubview)
    }
    
    func test_HasLocationLabel() {
        let locationLabelIsSubview = sut.locationLabel.isDescendant(of: sut.view)
        
        XCTAssertTrue(locationLabelIsSubview)
    }
    
    func test_HasDescriptionLabel() {
        let descriptionLabelIsSubview = sut.dateLabel.isDescendant(of: sut.view)
        
        XCTAssertTrue(descriptionLabelIsSubview)
    }
    
    func test_HasMapView() {
        let mapViewIsSubview = sut.mapView.isDescendant(of: sut.view)
        
        XCTAssertTrue(mapViewIsSubview)
    }
}
