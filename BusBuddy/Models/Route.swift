//
//  Route.swift
//  BusBuddy
//
//  Created by alyssa verasamy on 2025-01-18.
//

struct Route: Decodable {
    let routeNumber: Int
    let routeType: String
    let driver: Driver
    let bus: String
    let organization: Organization
    let startLocation: BusStop
    let endLocation: BusStop
    
    enum CodingKeys: String, CodingKey {
        case routeNumber = "route_number"
        case routeType = "route_type"
        case driver
        case bus
        case organization
        case startLocation = "start_location"
        case endLocation = "end_location"
    }
}
