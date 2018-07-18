//
//  ToDoItem.swift
//  ToDo
//
//  Created by Tim Barrett on 7/15/18.
//  Copyright © 2018 Timothy Barrett. All rights reserved.
//

import Foundation

struct ToDoItem {
    let title: String
    let itemDescription: String?
    let timeStamp: Double?
}

extension ToDoItem {
    init(title: String) {
        self.title = title
        self.itemDescription = nil
        self.timeStamp = nil
    }
    
    init(title: String, timeStamp: Double) {
        self.title = title
        self.timeStamp = timeStamp
        self.itemDescription = nil
    }
    
    init(title: String, itemDescription: String) {
        self.title = title
        self.timeStamp = nil
        self.itemDescription = itemDescription
    }
}
