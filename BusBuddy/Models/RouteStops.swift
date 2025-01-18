//
//  RouteStops.swift
//  BusBuddy
//
//  Created by alyssa verasamy on 2025-01-18.
//

struct RouteStops: Decodable {
    let busStop: BusStop
    let routeNumber: Int
    let routeType: String
    let stopNumber: Int
    // let scheduledTime: ?????
    
    enum CodingKeys: String, CodingKey {
        case busStop = "bus_stop"
        case routeNumber = "route_number"
        case routeType = "route_type"
        case stopNumber = "stop_number"
        //case scheduledTime = "scheduled_time"
    }
    
}
