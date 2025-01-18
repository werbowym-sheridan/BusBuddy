//
//  Bus.swift
//  BusBuddy
//
//  Created by alyssa verasamy on 2025-01-18.
//

struct Bus: Decodable {
    let licensePlate: String
    let capacity: Int
    
    enum CodingKeys: String, CodingKey {
        case licensePlate = "license_plate"
        case capacity
    }
}
