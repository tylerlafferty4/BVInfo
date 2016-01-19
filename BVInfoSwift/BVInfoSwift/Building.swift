//
//  Building.swift
//  BVInfoSwift
//
//  Created by Tyler Lafferty on 12/13/15.
//  Copyright © 2015 Tyler Lafferty. All rights reserved.
//

import Foundation
import MapKit

class Building : NSObject, MKAnnotation {
    let title: String?
    let subtitle: String?
    let mycoordinate: CLLocationCoordinate2D?
    
    init(title: String, subtitle: String, coordinate: CLLocationCoordinate2D) {
        self.title = title
        self.subtitle = subtitle
        self.mycoordinate = coordinate

    }
    
    var coordinate: CLLocationCoordinate2D {
        return mycoordinate!
    }
}