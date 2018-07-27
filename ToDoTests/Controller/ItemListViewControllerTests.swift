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
    var addButton: UIBarButtonItem!
    var action: Selector!
    var inputViewController: InputViewController!

    override func setUp() {
        super.setUp()
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        sut = storyboard.instantiateViewController(withIdentifier: "Item List View Controller") as? ItemListViewController
        sut.loadViewIfNeeded()
        addButton = sut.navigationItem.rightBarButtonItem
        action = addButton.action
        UIApplication.shared.keyWindow?.rootViewController = sut
        sut.performSelector(onMainThread: action, with: addButton, waitUntilDone: true)
        inputViewController = sut.presentedViewController as? InputViewController
    }

    override func tearDown() {
        sut = nil
        addButton = nil
        action = nil
        inputViewController = nil
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
    
    func test_ItemListViewController_HasAddBarButtonWithSelfAsTarget() {
        let target = sut.navigationItem.rightBarButtonItem?.target
        
        XCTAssertEqual(target as? UIViewController, sut)
    }
    
    func test_AddItem_PresentsAddItemViewController() {
        
        XCTAssertNotNil(sut.presentedViewController)
        XCTAssertTrue(sut.presentedViewController is InputViewController)
        XCTAssertNotNil(inputViewController.titleTextField)
    }
    
    func test_ItemListVC_SharesItemManagerWithInputVC() {

        guard let inputItemManager = inputViewController.itemManager else {
            XCTFail()
            return
        }
        
        XCTAssertTrue(sut.itemManager === inputItemManager)
    }
}
