//
//  ViewController.swift
//  HighWaters
//
//  Created by Jude on 02/03/2020.
//  Copyright © 2020 capsella.io. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MainViewController: UIViewController {
    
    @IBOutlet weak var mapView: MKMapView!
    
    private lazy var locationManager: CLLocationManager = {
        let manager  = CLLocationManager()
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.distanceFilter = kCLDistanceFilterNone
        manager.requestAlwaysAuthorization()
        
        return manager
    }()
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        locationManager.startUpdatingLocation()
        mapView.showsUserLocation = true
        mapView.delegate = self
        locationManager.delegate = self
    }
    
    
    
    @IBAction func addFloodPressed(_ sender: Any) {
        addFloodAnnotation()
    }
    
    
    func addFloodAnnotation(){
        
        guard let location = locationManager.location else {
            return
        }
        
        let annotation = MKPointAnnotation()
        annotation.title = "Flooded"
        annotation.subtitle = "Reported on Wed, 12:35:00 PM"
        annotation.coordinate = location.coordinate
        mapView.addAnnotation(annotation)
    }
    
    
}




extension MainViewController: CLLocationManagerDelegate, MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        guard annotation is MKPointAnnotation else { return nil }
        
        let identifier = "Annotation"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
        
        if annotationView == nil {
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView!.canShowCallout = true
        } else {
            annotationView!.annotation = annotation
        }
        
        return annotationView
    }
    
    
    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
        
        let region = MKCoordinateRegion(center: self.mapView.userLocation.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.08, longitudeDelta: 0.08))
        self.mapView.setRegion(region, animated: true)
    }
    
}
