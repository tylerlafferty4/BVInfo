//
//  MapViewController.swift
//  BVInfoSwift
//
//  Created by Tyler Lafferty on 12/13/15.
//  Copyright © 2015 Tyler Lafferty. All rights reserved.
//

import UIKit
import MapKit

class MapPoint {
    
    var lat: CLLocationDegrees!
    var long: CLLocationDegrees!
    
    init(lat : CLLocationDegrees, long : CLLocationDegrees) {
        self.lat = lat
        self.long = long
    }
}
class MapViewController: UIViewController {

    @IBOutlet var mapView : MKMapView!
    let regionRadius: CLLocationDistance = 1000
    
    var SSA = MapPoint(lat: 42.641378, long: -95.210377)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Map"
        // set initial location in Honolulu
        let initialLocation = CLLocation(latitude: 42.641942, longitude: -95.207359)
        centerMapOnLocation(initialLocation)
        
        // show artwork on map
        let artwork = Building(title: "Test", subtitle: "Test", coordinate: CLLocationCoordinate2D(latitude: 42.641942, longitude: -95.207359))
        let ssa = Building(title: "Social Science and Art", subtitle: "SSA", coordinate: CLLocationCoordinate2D(latitude: SSA.lat, longitude: SSA.long))
        
        mapView.addAnnotation(artwork)
        mapView.addAnnotation(ssa)
    }
    
    func centerMapOnLocation(_ location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,
            regionRadius * 2.0, regionRadius * 2.0)
        mapView.setRegion(coordinateRegion, animated: true)
    }
 }
