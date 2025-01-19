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
    @State private var myStop: RouteStopCoordinates? = nil
    @State private var busPosition = CLLocationCoordinate2D(latitude: 43.467873743656746, longitude: -79.73600568746207)
    @State private var stopsPassed: Int = 0
    @State private var routeAtBus = false
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            Map(position: $position) {
                ForEach(routeDirections, id: \.self) { routeSection in
                    MapPolyline(routeSection)
                        .stroke(.red, lineWidth: 2)
                }
                ForEach(busStops) { busStop in
                    if busStop.name == myStop!.name {
                        Annotation(busStop.name, coordinate: busStop.coordinate, anchor: .center) {
                            Image(systemName: "circle.fill")
                                .font(.system(size: 20))
                                .foregroundStyle(.green)
                        }
                    } else {
                        Annotation(busStop.name, coordinate: busStop.coordinate, anchor: .center) {
                            Image(systemName: "circle.fill")
                                .foregroundStyle(.red)
                        }
                    }
                }
                Annotation("", coordinate: busPosition, anchor: .center) {
                    ZStack {
                        Circle()
                            .fill(.yellow)
                            .frame(width: 60, height: 60)
                        
                        Image(systemName: "bus.fill")
                            .resizable()
                            .aspectRatio(1.0, contentMode: .fit)
                            .frame(width: 30, height: 30)
                            .foregroundColor(.black)
                    }
                }
            }
            .mapStyle(.standard(elevation: .flat))
            .mapControls {
                VStack {
                    MapUserLocationButton()
                    MapPitchToggle()
                }
                .offset(y: 200)
            }
        }
        .onAppear {
            locationManager.requestAuthorization()
        }
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
                if busStop.stopNumber == 4 {
                    route.append(busPosition)
                }
                if busStop.stopNumber == 6 {
                    myStop = RouteStopCoordinates(id: UUID(), coordinate: CLLocationCoordinate2D(latitude: busStop.busStop.lat, longitude: busStop.busStop.lon), name: busStop.busStop.name, stopNumber: busStop.stopNumber, routeNumber: busStop.routeNumber, routeType: busStop.routeType)
                }
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
