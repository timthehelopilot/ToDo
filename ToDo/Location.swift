//
//  Location.swift
//  ToDo
//
//  Created by Tim Barrett on 7/18/18.
//  Copyright © 2018 Timothy Barrett. All rights reserved.
//

import Foundation
import CoreLocation


struct Location: Equatable {
    let name: String
    let coordinate: CLLocationCoordinate2D?
}

extension Location {
    init(name: String) {
        self.name = name
        self.coordinate = nil
    }

}

extension CLLocationCoordinate2D: Equatable {
    public static func ==(lhs: CLLocationCoordinate2D, rhs: CLLocationCoordinate2D) -> Bool {
        if lhs.latitude == rhs.latitude && lhs.longitude == rhs.longitude {
            return true
        }
        return false
    }
}
