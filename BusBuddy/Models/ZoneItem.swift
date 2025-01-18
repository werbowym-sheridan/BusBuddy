//
//  ZoneItem.swift
//  BusBuddy
//
//  Created by Winsome Tang on 2025-01-18.
//

import Foundation

struct ZoneItem: Identifiable { //change the names
    let id = UUID()
    let startLocation: String
    let distance: String
    let travelTime: String
    let price: String
    let isHighlighted: Bool
    let arrivalTime: String
}
