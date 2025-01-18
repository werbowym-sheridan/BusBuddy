//
//  LocationManager.swift
//  BusBuddy
//
//  Created by Winsome Tang on 2025-01-18.
//
import Foundation
import CoreLocation
import MapKit
class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate { //Separate class for location management.
    private let manager = CLLocationManager()
    @Published var authorizationStatus: CLAuthorizationStatus?
    
    override init() {
        super.init()
        manager.delegate = self
    }
    
    func requestAuthorization() {
        print("Requesting authorization...")
        manager.requestWhenInUseAuthorization()
    }
    
    // Add these delegate methods
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        authorizationStatus = manager.authorizationStatus
        print("Authorization status changed to: \(manager.authorizationStatus.rawValue)")
        
        switch manager.authorizationStatus {
        case .notDetermined:
            print("Status: Not Determined")
        case .restricted:
            print("Status: Restricted")
        case .denied:
            print("Status: Denied")
        case .authorizedWhenInUse:
            print("Status: Authorized When in Use")
        case .authorizedAlways:
            print("Status: Authorized Always")
        @unknown default:
            print("Status: Unknown")
        }
    }
}
