//
//  Driver.swift
//  BusBuddy
//
//  Created by alyssa verasamy on 2025-01-18.
//

struct Driver: Decodable {
    let id: Int
    let firstName: String
    let lastName: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case firstName = "first_name"
        case lastName = "last_name"
    }
}

