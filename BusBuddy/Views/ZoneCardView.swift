//
//  ZoneCardView.swift
//  BusBuddy
//
//  Created by Winsome Tang on 2025-01-18.
//

import SwiftUI

struct ZoneCardView: View {
    let route: ZoneItem
    @State private var currentTime = Date()
    
    var body: some View {
        VStack(spacing: 0) {
            // Main route info
            HStack {
                // Locations
                VStack(alignment: .leading, spacing: 12) {
                    HStack(spacing: 15) {
                        // Using ZStack for circle
                        ZStack {
                            Circle()
                                .strokeBorder(Color.yellow, lineWidth: 3)
                                .frame(width: 15, height: 15)
                        }
                        
                        // Text in its own container
                        Text(route.startLocation)
                            .font(.system(size: 25))
                    }
                }
                
                Spacer()
                
                VStack(alignment: .trailing, spacing: 4) {
                    // Price with discount indicator
                    HStack {
                        Text(route.price)
                            .font(.system(size: 20, weight: .semibold))
                            .padding(.horizontal, 16)
                            .padding(.vertical, 8)
                            .background(route.isHighlighted ? Color.yellow.opacity(0.5) : Color.black)
                            .foregroundColor(route.isHighlighted ? .black : .white)
                            .cornerRadius(12)
                    }
                    
                    // Arrival time
                    Text("Arrives at \(route.arrivalTime)")
                        .font(.system(size: 14))
                        .foregroundColor(.gray)
                }
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 16)
        }
        .background(Color.white)
        .cornerRadius(16)
        .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 2)
    }
}

#Preview {
    ZoneCardView(route: ZoneItem(
        startLocation: "Home",
        distance: "12km",
        travelTime: "35 min",
        price: "35 mins",
        isHighlighted: true,
        arrivalTime: "11:35"
    ))
}
