//
//  ItemCellTests.swift
//  ToDoTests
//
//  Created by Tim Barrett on 7/21/18.
//  Copyright © 2018 Timothy Barrett. All rights reserved.
//

import XCTest
@testable import ToDo

class ItemCellTests: XCTestCase {
    
    var tableView: UITableView!
    var datasource: FakeDataSource!
    var cell: ItemCell!

    override func setUp() {
        super.setUp()
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "Item List View Controller") as! ItemListViewController
        controller.loadViewIfNeeded()
        
        tableView = controller.itemListTableView
        datasource = FakeDataSource()
        tableView?.dataSource = datasource
        
        cell = tableView?.dequeueReusableCell(withIdentifier: "ItemCell", for: IndexPath(row: 0, section: 0)) as? ItemCell
    }

    override func tearDown() {
        tableView = nil
        datasource = nil
        cell = nil
        super.tearDown()
    }

    func test_HasNameLabel() {
        
        XCTAssertTrue(cell.titleLabel.isDescendant(of: cell.contentView))
    }
    func test_HasLocationLabel() {
        
        XCTAssertTrue(cell.locationLabel.isDescendant(of: cell.contentView))
    }
    
    func test_HasDateLabel() {
        
        XCTAssertTrue(cell.dateLabel.isDescendant(of: cell.contentView))
    }
    
    func test_ConfigureCell_SetsTitle() {
        cell.configureCell(with: ToDoItem(title: "Foo"))
        
        XCTAssertEqual(cell.titleLabel.text!, "Foo")
    }
    
    func test_ConfigureCell_SetsDate() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        let date = dateFormatter.date(from: "08/27/2017")
        let timestamp = date!.timeIntervalSince1970
        
        cell.configureCell(with: ToDoItem(title: "Foo", timeStamp: timestamp))
        
        XCTAssertEqual(cell.dateLabel.text!, "08/27/2017")
    }
    
    func test_ConfigureCell_SetsLocation() {
        let location = Location(name: "Phoenix, Az.")
        cell.configureCell(with: ToDoItem(title: "Foo", location: location))
        
        XCTAssertEqual(cell.locationLabel.text, "Phoenix, Az.")
    }
    
    func test_Title_WhenItemIsChecked_IsStrokeThrough() {
        let location = Location(name: "Bar")
        let item = ToDoItem(title: "Foo", itemDescription: nil, timeStamp: 1456150025, location: location)
        
        cell.configureCell(with: item, checked: true)
        
        let attributedString = NSAttributedString(string: "Foo", attributes: [.strikethroughStyle: NSUnderlineStyle.single.rawValue])
        
        XCTAssertEqual(cell.titleLabel.attributedText, attributedString)
        XCTAssertNil(cell.locationLabel.text)
        XCTAssertNil(cell.dateLabel.text)
    }
}

extension ItemCellTests {
    class FakeDataSource: NSObject, UITableViewDataSource {
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return 1
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            return UITableViewCell()
        }
    }
}
