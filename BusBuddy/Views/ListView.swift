//
//  ListView.swift
//  BusBuddy
//
//  Created by Winsome Tang on 2025-01-18.
//

import SwiftUI
import SwiftUI


struct ListView: View {
    let routes = [
        ZoneItem(startLocation: "Home",
                 distance: "12km", travelTime: "35 min", price: "$7.3", isHighlighted: true, arrivalTime: "11:35"),
        ZoneItem(startLocation: "Home",
                 distance: "12km", travelTime: "40 min", price: "$5.2",
                 isHighlighted: false, arrivalTime: "12:40"),
        ZoneItem(startLocation: "Home",
                 distance: "12km", travelTime: "45 min", price: "$5.0",
                 isHighlighted: false, arrivalTime: "01:15")
    ]
    
    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                ForEach(routes) { route in //not for looping the cirle line thing properly...
                    ZoneCardView(route: route)
                }
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 8)
        }
        .background(Color.gray.opacity(0.1))
    }
}

#Preview {
    ListView()
}
