//
//  ItemListDataProviderTests.swift
//  ToDoTests
//
//  Created by Tim Barrett on 7/18/18.
//  Copyright © 2018 Timothy Barrett. All rights reserved.
//

import XCTest
@testable import ToDo

class ItemListDataProviderTests: XCTestCase {
    
    var sut: ItemListDataProvider!
    var tableView: UITableView!
    var controller: ItemListViewController!
    
    override func setUp() {
        super.setUp()
        
        sut = ItemListDataProvider()
        sut.itemManager = ItemManager()
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        controller = storyboard.instantiateViewController(withIdentifier: "Item List View Controller") as? ItemListViewController
        
        controller.loadViewIfNeeded()
        
        tableView = controller.itemListTableView
        tableView.dataSource = sut
    }

    override func tearDown() {
        
        sut = nil
        tableView = nil
        super.tearDown()
    }

    func test_NumberOfSections_IsTwo() {

        let numberOfSections = tableView.numberOfSections
        XCTAssertEqual(numberOfSections, 2)
    }
    
    func test_NumberOfRows_InFirstSection_IsToDoCount() {
        
        sut.itemManager?.add(ToDoItem(title: "Foo"))
        
        XCTAssertEqual(tableView.numberOfRows(inSection: 0), 1)
        
        sut.itemManager?.add(ToDoItem(title: "Bar"))
        tableView.reloadData()
     
        XCTAssertEqual(tableView.numberOfRows(inSection: 0), 2)
    }
    
    func test_NumberOfRows_InSecondSection_IsDoneCount() {
        sut.itemManager?.add(ToDoItem(title: "Foo"))
        sut.itemManager?.add(ToDoItem(title: "Bar"))
        sut.itemManager?.checkItem(at: 0)
        
        XCTAssertEqual(tableView.numberOfRows(inSection: 1), 1)
        
        sut.itemManager?.checkItem(at: 0)
        tableView.reloadData()
        
        XCTAssertEqual(tableView.numberOfRows(inSection: 1), 2)
    }
    
    func test_CellForRow_ReturnsItemCell() {
        sut.itemManager?.add(ToDoItem(title: "Foo"))
        tableView.reloadData()
        
        let cell = tableView.cellForRow(at: IndexPath(row: 0, section: 0))
        
        XCTAssertTrue(cell is ItemCell)
    }
    
    func test_CellForRow_DequeuesCellFromTableview() {
        let mockTableView = MockTableView()
        mockTableView.delegate = sut
        mockTableView.dataSource = sut
        mockTableView.register(ItemCell.self, forCellReuseIdentifier: "ItemCell")
        
        sut.itemManager?.add(ToDoItem(title: "Foo"))
        mockTableView.reloadData()
        
        _ = mockTableView.cellForRow(at: IndexPath(row: 0, section: 0))
        
        XCTAssertTrue(mockTableView.cellWasDequeued)
    }
    
    func test_CellForRow_CallsConfigureCell() {
        let mockTableView = MockTableView()
        mockTableView.dataSource = sut
        mockTableView.register(MockItemCell.self, forCellReuseIdentifier: "ItemCell")
        
        let item = ToDoItem(title: "Foo")
        sut.itemManager?.add(item)
        mockTableView.reloadData()
        
        let cell = mockTableView.cellForRow(at: IndexPath(row: 0, section: 0)) as! MockItemCell
        
        XCTAssertEqual(cell.catchedItem, item)
    }
}

extension ItemListDataProviderTests {
    class MockTableView: UITableView {
        var cellWasDequeued = false
        
        override func dequeueReusableCell(withIdentifier identifier: String, for indexPath: IndexPath) -> UITableViewCell {
            
            cellWasDequeued = true
            
            return super.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
        }
    }
    
    class MockItemCell: ItemCell {
        var catchedItem: ToDoItem?
        
        override func configureCell(with item: ToDoItem) {
            catchedItem = item
        }
    }
}
