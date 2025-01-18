//
//  MapView.swift
//  BusBuddy
//
//  Created by Winsome Tang on 2025-01-18.
//

import SwiftUI
import MapKit

struct RouteStopCoordinates: Identifiable {
    var id: UUID
    let coordinate: CLLocationCoordinate2D
    let name: String
    let stopNumber: Int
    let routeNumber: Int
    let routeType: String
}

struct MapView: View {
    @State private var busStops: [RouteStopCoordinates] = []
    @State private var route: [CLLocationCoordinate2D] = []
    @State private var routeDirections: [MKRoute] = []
    @StateObject private var locationManager = LocationManager()
    @State private var position: MapCameraPosition = .userLocation(fallback: .automatic)
    
    var body: some View {
        Map(position: $position){
            ForEach(routeDirections, id: \.self) { routeSection in
                MapPolyline(routeSection)
                    .stroke(.red, lineWidth: 2)
            }
            ForEach(busStops) { busStop in
                Annotation(busStop.name, coordinate: busStop.coordinate, anchor: .center) {
                    Image(systemName: "circle.fill")
                        .foregroundStyle(.red)
                }
            }
            
        }
        .mapControls{
            MapUserLocationButton()
            MapPitchToggle()
        }
        .onAppear {
            locationManager.requestAuthorization()
        }
        .mapStyle(.standard(elevation: .flat))
        .task {
            await fetchBusStops()
        }
    }
    
    
        
    
    func fetchBusStops() async {
        do {
            let routeData: [RouteStops] = try await supabase
                .from("route_stops")
                .select("bus_stop (*), route_number, route_type, stop_number")
                .eq("route_type", value: "pickup")
                .order("stop_number", ascending: true)
                .execute()
                .value
            
                    
            for busStop in routeData {
                busStops.append(RouteStopCoordinates(id: UUID(), coordinate: CLLocationCoordinate2D(latitude: busStop.busStop.lat, longitude: busStop.busStop.lon), name: busStop.busStop.name, stopNumber: busStop.stopNumber, routeNumber: busStop.routeNumber, routeType: busStop.routeType))
                route.append(CLLocationCoordinate2D(latitude: busStop.busStop.lat, longitude: busStop.busStop.lon))
            }
            print(routeData)
            getDirections()
            
        } catch {
            debugPrint(error)
        }
        
    }
    
    func getDirections() {
        
        for i in 0...self.route.count-2 {
            let request = MKDirections.Request()
            request.source = MKMapItem(placemark: MKPlacemark(coordinate: self.route[i]))
            request.destination = MKMapItem(placemark: MKPlacemark(coordinate: self.route[i+1]))
            
            Task {
                let directions = MKDirections(request: request)
                let response = try? await directions.calculate()
                if response?.routes.first != nil {
                    routeDirections.append(response!.routes.first!)
                }
            
        }
        
            
            
        }
    }
}

#Preview {
    MapView()
}
