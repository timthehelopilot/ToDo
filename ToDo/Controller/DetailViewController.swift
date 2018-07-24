//
//  DetailViewControllerTests.swift
//  ToDo
//
//  Created by Tim Barrett on 7/21/18.
//  Copyright © 2018 Timothy Barrett. All rights reserved.
//

import UIKit
import MapKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var mapView: MKMapView!
    
    var itemInfo: (ItemManager, Int)?
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/yyyy"
        return formatter
    }()

    override func viewWillAppear(_ animated: Bool) {
        
        guard let itemInfo = itemInfo else { return }
        let item = itemInfo.0.item(at: itemInfo.1)
        
        titleLabel.text = item.title
        locationLabel.text = item.location?.name
        descriptionLabel.text = item.itemDescription
        
        if let timestamp = item.timeStamp {
            let date = Date(timeIntervalSince1970: timestamp)
            dateLabel.text = dateFormatter.string(from: date)
        }
        
        if let coordinate = item.location?.coordinate {
            mapView.region = MKCoordinateRegion(center: coordinate, span: MKCoordinateSpan(latitudeDelta: 100, longitudeDelta: 100))
            mapView.centerCoordinate = coordinate
        }
    }
    
    func checkItem() {
        if let itemInfo = itemInfo {
            itemInfo.0.checkItem(at: itemInfo.1)
        }
    }
}
