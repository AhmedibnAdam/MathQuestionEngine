//
//  LocationViewController.swift
//  MathQuestionEngine
//
//  Created by Adam on 08/01/2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//  Modify By:  * Ahmed Adam
//              * ibn.abuadam@gmail.com
//              * https://github.com/AhmedibnAdam

import UIKit
import MapKit

protocol ILocationViewController: class {
	var router: ILocationRouter? { get set }
}

class LocationViewController: UIViewController {
	var interactor: ILocationInteractor?
	var router: ILocationRouter?

	override func viewDidLoad() {
        super.viewDidLoad()
		// do someting...
    }
    @IBOutlet var mapView: MKMapView!
    
    private var locations: [MKPointAnnotation] = []
    
    private lazy var locationManager: CLLocationManager = {
      let manager = CLLocationManager()
      manager.desiredAccuracy = kCLLocationAccuracyBest
      manager.delegate = self
      manager.requestAlwaysAuthorization()
      manager.allowsBackgroundLocationUpdates = true
      return manager
    }()
    
    @IBAction func backAction(_ sender: UIButton) {
        self.dismiss()
    }
    @IBAction func enabledChanged(_ sender: UISwitch) {
      if sender.isOn {
        locationManager.startUpdatingLocation()
      } else {
        locationManager.stopUpdatingLocation()
      }
    }
    
  
}

extension LocationViewController: ILocationViewController {
	// do someting...
}

// MARK: - CLLocationManagerDelegate
extension LocationViewController: CLLocationManagerDelegate {
  
  func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    guard let mostRecentLocation = locations.last else {
      return
    }
    
    // Add another annotation to the map.
    let annotation = MKPointAnnotation()
    annotation.coordinate = mostRecentLocation.coordinate
    
    // Also add to our map so we can remove old values later
    self.locations.append(annotation)
    
    // Remove values if the array is too big
    while locations.count > 100 {
      let annotationToRemove = self.locations.first!
      self.locations.remove(at: 0)
      
      // Also remove from the map
      mapView.removeAnnotation(annotationToRemove)
    }
    
    if UIApplication.shared.applicationState == .active {
      mapView.showAnnotations(self.locations, animated: true)
    } else {
      print("App is backgrounded. New location is %@", mostRecentLocation)
    }
  }
  
}
