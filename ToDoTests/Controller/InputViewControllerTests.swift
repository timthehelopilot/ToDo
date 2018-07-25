//
//  InputViewControllerTests.swift
//  ToDoTests
//
//  Created by Tim Barrett on 7/24/18.
//  Copyright © 2018 Timothy Barrett. All rights reserved.
//

import XCTest
import CoreLocation
@testable import ToDo

class InputViewControllerTests: XCTestCase {
    
    var sut: InputViewController!

    override func setUp() {
        super.setUp()
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        sut = storyboard.instantiateViewController(withIdentifier: "Input View Controller") as? InputViewController
        sut.loadViewIfNeeded()
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func test_HasTitleTextField() {
        let titleTextFieldIsSubview = sut.titleTextField.isDescendant(of: sut.view)
        
        XCTAssertTrue(titleTextFieldIsSubview)
    }
    
    func test_HasDateTextField() {
        let dateTextFieldIsSubview = sut.dateTextField.isDescendant(of: sut.view)
        
        XCTAssertTrue(dateTextFieldIsSubview)
    }
    
    func test_HasLocationTextField() {
        let locationTextFieldIsSubview = sut.locationTextField.isDescendant(of: sut.view)
        
        XCTAssertTrue(locationTextFieldIsSubview)
    }
    
    func test_HasAddressTextField() {
        let addressTextFieldIsSubview = sut.addressTextField.isDescendant(of: sut.view)
        
        XCTAssertTrue(addressTextFieldIsSubview)
    }
    
    func test_HasDescriptionTextField() {
        let descriptionTextFieldIsSubview = sut.descriptionTextField.isDescendant(of: sut.view)
        
        XCTAssertTrue(descriptionTextFieldIsSubview)
    }
    
    func test_HasSaveButton() {
        let saveButtonIsSubview = sut.saveButton.isDescendant(of: sut.view)
        
        XCTAssertTrue(saveButtonIsSubview)
    }
    
    func test_HasCancelButton() {
        let cancelButtonIsSubview = sut.cancelButton.isDescendant(of: sut.view)
        
        XCTAssertTrue(cancelButtonIsSubview)
    }
}

extension InputViewControllerTests {
    class MockGeocoder: CLGeocoder {
        
        var completionHandler: CLGeocodeCompletionHandler?
        
        override func geocodeAddressString(_ addressString: String, completionHandler: @escaping CLGeocodeCompletionHandler) {
            self.completionHandler = completionHandler
        }
    }
    
    class MockPlacemark: CLPlacemark {
        
        var mockCoordinate: CLLocationCoordinate2D?
        
        override var location: CLLocation? {
            guard let coordinate = mockCoordinate else { return CLLocation() }
            return CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
        }
    }
}
