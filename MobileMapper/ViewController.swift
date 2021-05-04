//
//  ViewController.swift
//  MobileMapper
//
//  Created by David Siemionko on 4/28/21.
//  Copyright © 2021 David Siemionko. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    var parks: [MKMapItem] = []
    
    let locationManager = CLLocationManager()
    var currentLocation:CLLocation!
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.requestWhenInUseAuthorization()
        mapView.showsUserLocation = true
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        currentLocation = locations[0]
    }
    @IBAction func WhenZoomButtonPressed(_ sender: UIBarButtonItem) {
    
        let center = currentLocation.coordinate
        let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        let region = MKCoordinateRegion(center: center, span: span)
        mapView.setRegion(region, animated: true)
    
    }
    @IBAction func WhenSearchButtonPressed(_ sender: UIBarButtonItem){
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = "Parks"
        
        let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        request.region = MKCoordinateRegion(center: currentLocation.coordinate, span: span)
        
        let search = MKLocalSearch(request: request)
        search.start { (response, error) in
            guard let response = response else {return}
            print(response)
        }
        
    }
    
    
}

