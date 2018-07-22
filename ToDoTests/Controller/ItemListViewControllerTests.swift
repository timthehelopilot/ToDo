//
//  ItemListViewControllerTests.swift
//  ToDoTests
//
//  Created by Tim Barrett on 7/18/18.
//  Copyright © 2018 Timothy Barrett. All rights reserved.
//

import XCTest
@testable import ToDo

class ItemListViewControllerTests: XCTestCase {
    
    var sut: ItemListViewController!

    override func setUp() {
        super.setUp()
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        sut = storyboard.instantiateViewController(withIdentifier: "Item List View Controller") as? ItemListViewController
        sut.loadViewIfNeeded()
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    func test_TableViewIsNotNilAfterViewDidLoad() {
        
       XCTAssertNotNil(sut.itemListTableView)
    }
    
    func test_LoadingView_SetsTableViewDataDelegateAndDataSource() {

        XCTAssertTrue(sut.itemListTableView.delegate is ItemListDataProvider)
        XCTAssertTrue(sut.itemListTableView.dataSource is ItemListDataProvider)
    }
    
    func test_LoadingView_DataSourceEqualDelegate() {
        
        XCTAssertEqual(sut.itemListTableView.delegate as? ItemListDataProvider, sut.itemListTableView.dataSource as? ItemListDataProvider)
    }
}
