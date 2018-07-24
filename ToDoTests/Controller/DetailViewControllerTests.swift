//
//  DetailViewControllerTests.swift
//  ToDoTests
//
//  Created by Tim Barrett on 7/21/18.
//  Copyright © 2018 Timothy Barrett. All rights reserved.
//

import XCTest
import CoreLocation
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
    
    func test_SettingItemInfo_SetsTextToLabels() {
        let coordinate = CLLocationCoordinate2DMake(51.2277, 6.773500000000034)
        
        let location = Location(name: "Foo", coordinate: coordinate)
        let item = ToDoItem(title: "Bar", itemDescription: "Baz", timeStamp: 1456150025, location: location)
        
        let itemManager = ItemManager()
        itemManager.add(item)
        
        sut.itemInfo = (itemManager, 0)
        sut.beginAppearanceTransition(true, animated: true)
        sut.endAppearanceTransition()
        XCTAssertEqual(sut.titleLabel.text, "Bar")
        XCTAssertEqual(sut.dateLabel.text, "02/22/2016")
        XCTAssertEqual(sut.locationLabel.text, "Foo")
        XCTAssertEqual(sut.descriptionLabel.text, "Baz")
        XCTAssertEqual(sut.mapView.centerCoordinate, coordinate)
    }
    
    func test_CheckItem_ChecksItemInItemManager() {
        let itemManager  = ItemManager()
        itemManager.add(ToDoItem(title: "Foo"))
        
        sut.itemInfo = (itemManager, 0)
        sut.checkItem()
        
        XCTAssertEqual(itemManager.toDoCount, 0)
        XCTAssertEqual(itemManager.doneCount, 1)
    }
}
