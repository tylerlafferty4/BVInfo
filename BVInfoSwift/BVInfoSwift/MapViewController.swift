//
//  MapViewController.swift
//  BVInfoSwift
//
//  Created by Tyler Lafferty on 12/13/15.
//  Copyright © 2015 Tyler Lafferty. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController {

    @IBOutlet var mapView : MKMapView!
    let regionRadius: CLLocationDistance = 1000
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Map"
        // set initial location in Honolulu
        let initialLocation = CLLocation(latitude: 42.641942, longitude: -95.207359)
        centerMapOnLocation(initialLocation)
        
        // show artwork on map
        let artwork = Building(title: "Test", subtitle: "Test", coordinate: CLLocationCoordinate2D(latitude: 42.641942, longitude: -95.207359))
        
        mapView.addAnnotation(artwork)
    }
    
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,
            regionRadius * 2.0, regionRadius * 2.0)
        mapView.setRegion(coordinateRegion, animated: true)
    }
 }
