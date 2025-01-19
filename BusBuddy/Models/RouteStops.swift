//
//  RouteStops.swift
//  BusBuddy
//
//  Created by alyssa verasamy on 2025-01-18.
//
import Foundation

struct RouteStops: Decodable {
    let busStop: BusStop
    let routeNumber: Int
    let routeType: String
    let stopNumber: Int
    let stopTime: Date
    // let scheduledTime: ?????
    
    enum CodingKeys: String, CodingKey {
        case busStop = "bus_stop"
        case routeNumber = "route_number"
        case routeType = "route_type"
        case stopNumber = "stop_number"
        case stopTime = "stop_time"
        //case scheduledTime = "scheduled_time"
    }
    
    init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            
            busStop = try container.decode(BusStop.self, forKey: .busStop)
            routeNumber = try container.decode(Int.self, forKey: .routeNumber)
            routeType = try container.decode(String.self, forKey: .routeType)
            stopNumber = try container.decode(Int.self, forKey: .stopNumber)
            
            // Custom date decoding
            let dateString = try container.decode(String.self, forKey: .stopTime)
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
            
            guard let date = formatter.date(from: dateString) else {
                throw DecodingError.dataCorruptedError(forKey: .stopTime,
                      in: container,
                      debugDescription: "Invalid date format")
            }
            
            self.stopTime = date
        }
}
