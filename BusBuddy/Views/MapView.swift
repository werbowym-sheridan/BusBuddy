//
//  MapView.swift
//  BusBuddy
//
//  Created by Winsome Tang on 2025-01-18.
//

import SwiftUI
import MapKit

struct BusStopCoordinates {
    let coordinate: CLLocationCoordinate2D
    let name: String
}

struct MapView: View {
    @State var busStops: [BusStopCoordinates] = []
    @StateObject private var locationManager = LocationManager()
    @State private var position: MapCameraPosition = .userLocation(fallback: .automatic)
    
    var body: some View {
        Map(position: $position){
            
        }
        .mapControls{
            MapUserLocationButton()
            MapPitchToggle()
        }
        .onAppear {
            locationManager.requestAuthorization()
        }
        .mapStyle(.standard(elevation:.realistic))
        .task {
            await fetchBusStops()
        }
    }
        
    
    func fetchBusStops() async {
        do {
            let busStopData: [BusStop] = try await supabase
                .from("bus_stop")
                .select("*")
                .execute()
                .value
                    
            for busStop in busStopData {
                busStops.append(BusStopCoordinates(coordinate: CLLocationCoordinate2D(latitude: busStop.lat, longitude: busStop.lon), name: busStop.name))
            }
            
        } catch {
            debugPrint(error)
        }
        
    }
}

#Preview {
    MapView()
}
