//
//  ListView.swift
//  BusBuddy
//
//  Created by Winsome Tang on 2025-01-18.
//

import SwiftUI
import MapKit

struct ListView: View {
    @State private var busStops: [RouteStopCoordinates] = [] // List of RouteStopCoordinates -> called busStops
    
    @State private var route: [CLLocationCoordinate2D] = [] // List of CLLocationCoordinate2D
    @State private var userLocation: CLLocationCoordinate2D? = nil
    
    
    
    
//    let routesDB = [
//        Route(routeNumber: 1, routeType: "test", driver: Driver(id: 2, firstName: "David", lastName: "Green"), bus: "Sharp 024", organization: Organization(id: UUID(uuidString: "test")!, name: "Sheridan College"), startLocation: <#T##BusStop#>, endLocation: <#T##BusStop#>)
//    ]
    
    var body: some View {
        ScrollView {
                    VStack(spacing: 16) {
                        // Custom connecting line with dots
                        ZStack(alignment: .top) {
                            // Connecting line
                            GeometryReader { geometry in
                                VStack(spacing: 0) {
                                    if busStops.count > 0 {
                                        Rectangle()
                                            .fill(Color.gray.opacity(0.5))
                                            .frame(width: 2)
                                            .frame(height: geometry.size.height * 0.97) // Adjust the multiplier to control line length
                                            .offset(x: 23, y: 20)
                                    }
                                }
                            }
                            
                            VStack(spacing: 16) {
                                ForEach(busStops) { stop in
                                    RouteCardView(
                                        stopName: stop.name,
                                        travelTime: calculateTravelTime(for: stop),
                                        arrivalTime: /*calculateArrivalTime(for: stop),*/
                                        stop.stopTime
                                        ,
                                        isCurrentZone: isUserZone(stop),
                                        stopNumber: stop.stopNumber
                                        
                                    )
                                }
                            }
                        }
                    }
                    .padding(.horizontal, 16)
                    .padding(.vertical, 8)
                }
                .background(Color.gray.opacity(0.1))
                .task {
                    await fetchBusStops()
                }
            }
//        ScrollView {
//            VStack(spacing: 16) {
////                ForEach(routes) { route in //not for looping the cirle line thing properly...
////                    ZoneCardView(route: route)
////                }
//            
//                ZStack(alignment: .leading) {
//                    Rectangle()
//                        .fill(Color.gray)
//                        .frame(width: 2)
//                        .padding(.leading, 23)
//                        .frame(maxHeight: .infinity)
//                    
//                    VStack(spacing: 16) {
//                        ForEach(busStops) { stop in
//                            RouteCardView(stopName: stop.name, travelTime: calculateTravelTime(for: stop), arrivalTime: calculateArrivalTime(for: stop), isCurrentZone: isUserZone(stop), stopNumber: stop.stopNumber)
//                        }
//                    }
//                }
//            }
//            .padding(.horizontal, 16)
//            .padding(.vertical, 8)
//        }
//        .background(Color.gray.opacity(0.1))
//        .task {
//            await fetchBusStops()
//        }
//    }
        
    
    func fetchBusStops() async {
        do {
            let routeData: [RouteStops] = try await supabase
                .from("route_stops")
                .select("bus_stop (*), route_number, route_type, stop_number, stop_time")
                .eq("route_type", value: "pickup")
                .order("stop_number", ascending: true)
                .execute()
                .value
                    
            for busStop in routeData {
                busStops.append(RouteStopCoordinates(id: UUID(), coordinate: CLLocationCoordinate2D(latitude: busStop.busStop.lat, longitude: busStop.busStop.lon), name: busStop.busStop.name, stopNumber: busStop.stopNumber, routeNumber: busStop.routeNumber, routeType: busStop.routeType, stopTime: busStop.stopTime))
                route.append(CLLocationCoordinate2D(latitude: busStop.busStop.lat, longitude: busStop.busStop.lon))
            }
            print(routeData)
            
        } catch {
            debugPrint(error)
        }
        
    }
    
    // Calculate travel time from first stop to current stop
        private func calculateTravelTime(for stop: RouteStopCoordinates) -> Int {
            guard let firstStop = busStops.first else { return 0 }
            
            var totalTime = 0
            for i in 0..<busStops.count {
                if busStops[i].stopNumber <= stop.stopNumber {
                    if i > 0 {
                        let distance = calculateDistance(
                            from: busStops[i-1].coordinate,
                            to: busStops[i].coordinate
                        )
                        // Assume average speed of 30 km/h
                        totalTime += Int((distance / 30.0) * 60)
                    }
                } else {
                    break
                }
            }
            return totalTime
        }
        
        // Calculate arrival time based on current time + travel time
        private func calculateArrivalTime(for stop: RouteStopCoordinates) -> String {
            let travelTime = calculateTravelTime(for: stop)
            let arrivalTime = Calendar.current.date(
                byAdding: .minute,
                value: travelTime,
                to: Date()
            )
            return arrivalTime?.formatted(date: .omitted, time: .shortened) ?? "N/A"
        }
        
        // Helper function to calculate distance between coordinates in kilometers
        private func calculateDistance(from start: CLLocationCoordinate2D, to end: CLLocationCoordinate2D) -> Double {
            let startLocation = CLLocation(latitude: start.latitude, longitude: start.longitude)
            let endLocation = CLLocation(latitude: end.latitude, longitude: end.longitude)
            let distanceInMeters = startLocation.distance(from: endLocation)
            return distanceInMeters / 1000.0
        }
        
    //hardcoded Omar's zone
    //    westfield trail & river glen
    private func isUserZone(_ stop: RouteStopCoordinates) -> Bool {
           return stop.stopNumber == 6
       }
    
}//struct




#Preview {
    ListView()
}
