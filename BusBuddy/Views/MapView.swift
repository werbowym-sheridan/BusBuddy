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

var busLocations: [CLLocationCoordinate2D] = [
    CLLocationCoordinate2D(latitude: 43.4580882791521, longitude: -79.7102449034395), // stop 1: McCraney St W & Oxford Ave
    CLLocationCoordinate2D(latitude: 43.4580882791521, longitude: -79.7102449034395), // stop 1: McCraney St W & Oxford Ave
    CLLocationCoordinate2D(latitude: 43.4580882791522, longitude: -79.7102449034396), // stop 1: McCraney St W & Oxford Ave
    CLLocationCoordinate2D(latitude: 43.4580882791522, longitude: -79.7102449034396), // stop 1: McCraney St W & Oxford Ave
    CLLocationCoordinate2D(latitude: 43.45871806470659, longitude: -79.7113754490123),
    CLLocationCoordinate2D(latitude: 43.45987007921755, longitude: -79.71235540075546),
    CLLocationCoordinate2D(latitude: 43.46101434035842, longitude: -79.71421943939731),
    CLLocationCoordinate2D(latitude: 43.46142410433586, longitude: -79.71491179682256),
    CLLocationCoordinate2D(latitude: 43.4622004990633, longitude: -79.715993128574), // stop 2: Oxford Ave & Old Upper Middle Rd W
    CLLocationCoordinate2D(latitude: 43.4622004990633, longitude: -79.715993128574), // stop 2: Oxford Ave & Old Upper Middle Rd W
    CLLocationCoordinate2D(latitude: 43.4622004990634, longitude: -79.715993128575), // stop 2: Oxford Ave & Old Upper Middle Rd W
    CLLocationCoordinate2D(latitude: 43.4622004990634, longitude: -79.715993128575), // stop 2: Oxford Ave & Old Upper Middle Rd W
    CLLocationCoordinate2D(latitude: 43.46306313229381, longitude: -79.71694626202289),
    CLLocationCoordinate2D(latitude: 43.4638362432537, longitude: -79.71844814458576),
    CLLocationCoordinate2D(latitude: 43.46444699392158, longitude: -79.71935353478324),
    CLLocationCoordinate2D(latitude: 43.46429237409516, longitude: -79.72059977801993),
    CLLocationCoordinate2D(latitude: 43.46442380099008, longitude: -79.72346507181406),
    CLLocationCoordinate2D(latitude: 43.464532034690436, longitude: -79.72564866005712),
    CLLocationCoordinate2D(latitude: 43.4649364039855, longitude: -79.7268517304272), // stop 3: River Oaks Blvd W & McDowell Ave
    CLLocationCoordinate2D(latitude: 43.4649364039855, longitude: -79.7268517304272), // stop 3: River Oaks Blvd W & McDowell Ave
    CLLocationCoordinate2D(latitude: 43.4649364039856, longitude: -79.7268517304273), // stop 3: River Oaks Blvd W & McDowell Ave
    CLLocationCoordinate2D(latitude: 43.4649364039856, longitude: -79.7268517304273), // stop 3: River Oaks Blvd W & McDowell Ave
    CLLocationCoordinate2D(latitude: 43.46422279502796, longitude: -79.72789615835308),
    CLLocationCoordinate2D(latitude: 43.4630322076516, longitude: -79.72908914308388),
    CLLocationCoordinate2D(latitude: 43.461857059447, longitude: -79.7304099476849),
    CLLocationCoordinate2D(latitude: 43.462379675982994, longitude: -79.73143192400903),
    CLLocationCoordinate2D(latitude: 43.4631438778865, longitude: -79.73273862125735),
    CLLocationCoordinate2D(latitude: 43.463860308401735, longitude: -79.73406412004118),
    CLLocationCoordinate2D(latitude: 43.464303808740304, longitude: -79.73591605785971),
    CLLocationCoordinate2D(latitude: 43.465268371466, longitude: -79.735880364093), // stop 4: River Glen Blvd & Marlatt Dr
    CLLocationCoordinate2D(latitude: 43.465268371466, longitude: -79.735880364093), // stop 4: River Glen Blvd & Marlatt Dr
    CLLocationCoordinate2D(latitude: 43.465268371467, longitude: -79.735880364094), // stop 4: River Glen Blvd & Marlatt Dr
    CLLocationCoordinate2D(latitude: 43.465268371467, longitude: -79.735880364094), // stop 4: River Glen Blvd & Marlatt Dr
    CLLocationCoordinate2D(latitude: 43.46633022279118, longitude: -79.73591605782957),
    CLLocationCoordinate2D(latitude: 43.46760607823457, longitude: -79.73601006482544),
    CLLocationCoordinate2D(latitude: 43.46851348844566, longitude: -79.73601946552503),
    CLLocationCoordinate2D(latitude: 43.46942088508366, longitude: -79.73587845507537),
    CLLocationCoordinate2D(latitude: 43.47052611666243, longitude: -79.73511699840887),
    CLLocationCoordinate2D(latitude: 43.4717154771408, longitude: -79.7343110727563), // stop 5: River Glen Blvd & New Wood Dr
    CLLocationCoordinate2D(latitude: 43.4717154771408, longitude: -79.7343110727563), // stop 5: River Glen Blvd & New Wood Dr
    CLLocationCoordinate2D(latitude: 43.4717154771409, longitude: -79.7343110727564), // stop 5: River Glen Blvd & New Wood Dr
    CLLocationCoordinate2D(latitude: 43.4717154771409, longitude: -79.7343110727564), // stop 5: River Glen Blvd & New Wood Dr
    CLLocationCoordinate2D(latitude: 43.47206794923277, longitude: -79.73324625903682),
    CLLocationCoordinate2D(latitude: 43.47286613910737, longitude: -79.73194896249389),
    CLLocationCoordinate2D(latitude: 43.474025883404714, longitude: -79.7301064251861),
    CLLocationCoordinate2D(latitude: 43.4746264423058, longitude: -79.7277247727561), // stop 6: Westfield Tr & River Glen Blvd
    CLLocationCoordinate2D(latitude: 43.4746264423058, longitude: -79.7277247727561), // stop 6: Westfield Tr & River Glen Blvd
    CLLocationCoordinate2D(latitude: 43.4746264423059, longitude: -79.7277247727562), // stop 6: Westfield Tr & River Glen Blvd
    CLLocationCoordinate2D(latitude: 43.4746264423059, longitude: -79.7277247727562), // stop 6: Westfield Tr & River Glen Blvd
    CLLocationCoordinate2D(latitude: 43.475110565298294, longitude: -79.72664696748991),
    CLLocationCoordinate2D(latitude: 43.47594282371329, longitude: -79.72572569893046),
    CLLocationCoordinate2D(latitude: 43.47634530522821, longitude: -79.72522746185238),
    CLLocationCoordinate2D(latitude: 43.47693196842963, longitude: -79.72393956581824),
    CLLocationCoordinate2D(latitude: 43.47686375207468, longitude: -79.72226624129185),
    CLLocationCoordinate2D(latitude: 43.4767709640785, longitude: -79.7208330797963), // stop 7: Glenashton Dr & Grand Ravine Dr
    CLLocationCoordinate2D(latitude: 43.4767709640785, longitude: -79.7208330797963), // stop 7: Glenashton Dr & Grand Ravine Dr
    CLLocationCoordinate2D(latitude: 43.4767709640786, longitude: -79.7208330797964), // stop 7: Glenashton Dr & Grand Ravine Dr
    CLLocationCoordinate2D(latitude: 43.4767709640786, longitude: -79.7208330797964), // stop 7: Glenashton Dr & Grand Ravine Dr
    CLLocationCoordinate2D(latitude: 43.47635894864399, longitude: -79.71958704164278),
    CLLocationCoordinate2D(latitude: 43.47631119675078, longitude: -79.71781030942095),
    CLLocationCoordinate2D(latitude: 43.47665910254176, longitude: -79.71572335388488),
    CLLocationCoordinate2D(latitude: 43.47707522251832, longitude: -79.71448246153948),
    CLLocationCoordinate2D(latitude: 43.47663181588579, longitude: -79.7141252349552),
    CLLocationCoordinate2D(latitude: 43.47617476256684, longitude: -79.71377740907049), // stop 8: post's corners
    CLLocationCoordinate2D(latitude: 43.47617476256684, longitude: -79.71377740907049), // stop 8: post's corners
    CLLocationCoordinate2D(latitude: 43.47617476256685, longitude: -79.71377740907050), // stop 8: post's corners
    CLLocationCoordinate2D(latitude: 43.47617476256685, longitude: -79.71377740907050), // stop 8: post's corners
    CLLocationCoordinate2D(latitude: 43.47617476256685, longitude: -79.71377740907050), // stop 8: post's corners
    CLLocationCoordinate2D(latitude: 43.47617476256685, longitude: -79.71377740907050), // stop 8: post's corners
    CLLocationCoordinate2D(latitude: 43.47617476256685, longitude: -79.71377740907050), // stop 8: post's corners
    CLLocationCoordinate2D(latitude: 43.47617476256684, longitude: -79.71377740907049) // stop 8: post's corners
]


struct MapView: View {
    @State private var busStops: [RouteStopCoordinates] = []
    @State private var route: [CLLocationCoordinate2D] = []
    @State private var routeDirections: [MKRoute] = []
    @StateObject private var locationManager = LocationManager()
    @State private var position: MapCameraPosition = .userLocation(fallback: .automatic)
    @State private var myStop: RouteStopCoordinates? = nil
    @State private var stopsPassed: Int = 0
    @State private var routeAtBus = false
    @State var timeRemaining = 70
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        Map(position: $position){
            ForEach(routeDirections, id: \.self) { routeSection in
                MapPolyline(routeSection)
                    .stroke(.black, lineWidth: 2)
            }
            Annotation("", coordinate: busLocations[70-timeRemaining], anchor: .center) {
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
            
            ForEach(busStops) { busStop in
                if busStop.name == myStop!.name {
                    Annotation(busStop.name, coordinate: busStop.coordinate, anchor: .bottom) {
                        Image(systemName: "drop.fill")
                            .font(.system(size: 50))
                            .foregroundStyle(.yellow)
                            .rotationEffect(.degrees(180))
                        }
                    Annotation(busStop.name, coordinate: busStop.coordinate, anchor: .center) {
                        Image(systemName: "circle.fill")
                            .foregroundStyle(.yellow)
                            .font(.system(size: 10))
                    }
                } else {
                    if busStop.stopNumber <= stopsPassed {
                        Annotation(busStop.name, coordinate: busStop.coordinate, anchor: .center) {
                            Image(systemName: "circle.fill")
                                .foregroundStyle(.black)
                                .font(.system(size: 12))
                        }
                    } else {
                        Annotation(busStop.name, coordinate: busStop.coordinate, anchor: .center) {
                            Image(systemName: "circle.fill")
                                .foregroundStyle(.black)
                                .font(.system(size: 12))
                        }
                        
                    }
                }
                
            }
            
        }
        .onReceive(timer) { _ in
            if timeRemaining > 0 {
                timeRemaining -= 1
            }
            print(busLocations[70-timeRemaining])
            print(route[stopsPassed])
            if busLocations[70-timeRemaining].latitude == route[stopsPassed].latitude && busLocations[70-timeRemaining].longitude == route[stopsPassed].longitude {
                stopsPassed += 1
                print(stopsPassed)
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
