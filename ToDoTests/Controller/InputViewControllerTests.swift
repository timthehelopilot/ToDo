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
    var placemark: MockPlacemark!

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
    
    func test_Save_UsesGeocoderToGetCoordinateFromAddress() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        
        let timestamp = 1456038000.0
        let date = Date(timeIntervalSince1970: timestamp)
        
        sut.titleTextField.text = "Foo"
        sut.dateTextField.text = dateFormatter.string(from: date)
        sut.locationTextField.text = "Bar"
        sut.addressTextField.text = "Infinite Loop 1, Cupertino"
        sut.descriptionTextField.text = "Baz"
        
        let mockGeocoder = MockGeocoder()
        sut.geocoder = mockGeocoder
        
        sut.itemManager = ItemManager()
        
        sut.save()
        
        placemark = MockPlacemark()
        let coordinate = CLLocationCoordinate2D(latitude: 37.3316851, longitude: -122.0300674)
        
        placemark.mockCoordinate = coordinate
        mockGeocoder.completionHandler?([placemark], nil)
        
        let item = sut.itemManager?.item(at: 0)
        
        let testItem = ToDoItem(title: "Foo", itemDescription: "Baz", timeStamp: timestamp, location: Location(name: "Bar", coordinate: coordinate))
        
        XCTAssertEqual(item, testItem)
    }
    
    func test_SaveButtonHasSaveAction() {
        let saveButton = sut.saveButton
        
        guard let actions = saveButton?.actions(forTarget: sut, forControlEvent: .touchUpInside) else { XCTFail() ; return }
        
        XCTAssertTrue(actions.contains("save"))
    }
    
    func test_Geocoder_FetchCoordinates() {
        let geocodeExpectation = expectation(description: "Geocoder")
        let address = "Infinite Loop 1, Cupertino"
        CLGeocoder().geocodeAddressString(address) { (placemarks, error) in
            
            let coordinate = placemarks?.first?.location?.coordinate
            guard let latitude = coordinate?.latitude else {
                XCTFail()
                return
            }
            
            guard let longitude = coordinate?.longitude else {
                XCTFail()
                return
            }
            
            XCTAssertEqual(latitude, 37.3316, accuracy: 0.001)
            XCTAssertEqual(longitude, -122.0300, accuracy: 0.001)
            
            geocodeExpectation.fulfill()
        }
        
       waitForExpectations(timeout: 3, handler: nil)
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
