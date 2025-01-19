//
//  MainContentCardView.swift
//  BusBuddy
//
//  Created by Winsome Tang on 2025-01-18.
//
import SwiftUI
import MapKit
import Supabase

struct MainContentCardView: View {
    let myStop: RouteStopCoordinates?
    let currentBusLocation: CLLocationCoordinate2D
    @State private var busStops: [RouteStopCoordinates] = []
    @State private var countdownSeconds: Int = 7
    @State private var hasStartedCountdown: Bool = false
    private let barHeight: CGFloat = 64

    private var countdownText: String {
        "Bus arriving at your stop in \(countdownSeconds) second\(countdownSeconds != 1 ? "s" : "")!"
    }
    
    var body: some View {
        VStack {
            HStack {
                if let myCurrentStop = myStop {
                    if isAtDestination(currentBusLocation, myCurrentStop.coordinate) {
                        ZStack {
                            Text("Bus has arrived!")
                                .font(.custom("Pally Variable", size: 24))
                                .bold()
                                .foregroundColor(.black)
                                .padding()
                        }
                        
                    } else if isAtStop5Area(currentBusLocation) {
                        ZStack {
                            Text(countdownText)
                                .font(.custom("Pally Variable", size: 18))
                                .bold()
                                .foregroundColor(.black)
                                .padding()
                        }
                        .onAppear {
                            if !hasStartedCountdown {
                                hasStartedCountdown = true
                                Task {
                                    try? await Task.sleep(nanoseconds: 1_000_000_000)
                                    countdownSeconds = 6
                                    
                                    try? await Task.sleep(nanoseconds: 1_000_000_000)
                                    countdownSeconds = 5
                                    
                                    try? await Task.sleep(nanoseconds: 1_000_000_000)
                                    countdownSeconds = 4
                                    
                                    try? await Task.sleep(nanoseconds: 1_000_000_000)
                                    countdownSeconds = 3
                                    
                                    try? await Task.sleep(nanoseconds: 1_000_000_000)
                                    countdownSeconds = 2
                                    
                                    try? await Task.sleep(nanoseconds: 1_000_000_000)
                                    countdownSeconds = 1
                                    
                                    try? await Task.sleep(nanoseconds: 1_000_000_000)
                                    countdownSeconds = 0
                                }
                            }
                        }
                    } else {
                        ZStack {
                            Text("Bus is en route...")
                                .font(.custom("Pally Variable", size: 18))
                                .foregroundColor(.black)
                                .padding(.vertical, 32)
                        }
                    }
                } else {
                    ZStack {
                        Text("Loading schedule...")
                            .font(.custom("Pally Variable", size: 16))
                            .foregroundColor(.black)
                            .padding()
                    }
                }
            }
            .padding(.horizontal, 16)
            .frame(width: UIScreen.main.bounds.width - 32, height: barHeight)
            .background(Color("BusBuddy_Yellow"))
            .cornerRadius(36)
            .overlay(
                RoundedRectangle(cornerRadius: 36)
                    .stroke(Color.black, lineWidth: 1)
            )
            .offset(y: -32)
        }
        .task {
            await fetchBusStops()
        }
    }
    
    private func isAtStop5Area(_ location: CLLocationCoordinate2D) -> Bool {
        let stop5Coordinates: [CLLocationCoordinate2D] = [
            CLLocationCoordinate2D(latitude: 43.4717154771408, longitude: -79.7343110727563),
            CLLocationCoordinate2D(latitude: 43.4717154771409, longitude: -79.7343110727564),
            CLLocationCoordinate2D(latitude: 43.4717154771409, longitude: -79.7343110727564),
            CLLocationCoordinate2D(latitude: 43.47206794923277, longitude: -79.73324625903682),
            CLLocationCoordinate2D(latitude: 43.47286613910737, longitude: -79.73194896249389),
            CLLocationCoordinate2D(latitude: 43.474025883404714, longitude: -79.7301064251861),
            CLLocationCoordinate2D(latitude: 43.4746264423058, longitude: -79.7277247727561)
        ]
        
        return stop5Coordinates.contains { coordinate in
            isCoordinateMatch(location, coordinate)
        }
    }
    
    private func isAtDestination(_ location: CLLocationCoordinate2D, _ destination: CLLocationCoordinate2D) -> Bool {
        return isCoordinateMatch(location, destination)
    }
    
    private func isCoordinateMatch(_ coord1: CLLocationCoordinate2D, _ coord2: CLLocationCoordinate2D) -> Bool {
        // Using a small threshold for floating point comparison
        let threshold = 0.0000001
        return abs(coord1.latitude - coord2.latitude) < threshold &&
        abs(coord1.longitude - coord2.longitude) < threshold
    }
    
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
                busStops.append(RouteStopCoordinates(
                    id: UUID(),
                    coordinate: CLLocationCoordinate2D(
                        latitude: busStop.busStop.lat,
                        longitude: busStop.busStop.lon
                    ),
                    name: busStop.busStop.name,
                    stopNumber: busStop.stopNumber,
                    routeNumber: busStop.routeNumber,
                    routeType: busStop.routeType,
                    stopTime: busStop.stopTime
                ))
            }
        } catch {
            debugPrint("Error fetching bus stops: \(error)")
        }
    }
}
