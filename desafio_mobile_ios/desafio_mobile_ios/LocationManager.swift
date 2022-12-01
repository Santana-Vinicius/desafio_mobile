//
//  LocationManager.swift
//  desafio_mobile_ios
//
//  Created by Vinicius Araujo on 29/11/22.
//

import Foundation
import CoreLocation
import MapKit

class LocationManager: NSObject, ObservableObject {
    @Published var region: MKCoordinateRegion = .brasiliaRegion
    @Published var showAlert: Bool = false
    var location: CLLocation?
    private let locationManager = CLLocationManager()

    override init() {
        super.init()

        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = kCLDistanceFilterNone
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        locationManager.delegate = self
    }
}

extension LocationManager: CLLocationManagerDelegate {

    func locationManager(
        _ manager: CLLocationManager,
        didUpdateLocations locations: [CLLocation]
    ) {
        guard let location = locations.last else { return }
        DispatchQueue.main.async {
            self.region = .init(
                center: location.coordinate ,
                span: .init(latitudeDelta: 0.5, longitudeDelta: 0.5)
            )
        }
    }
    
    @MainActor
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .notDetermined, .restricted, .denied:
            showAlert = true
        case .authorizedAlways, .authorizedWhenInUse:
            showAlert = false
        @unknown default:
            break
        }
        
    }
}
