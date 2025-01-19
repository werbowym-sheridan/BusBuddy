//
//  RouteCardView.swift
//  BusBuddy
//
//  Created by Hojin You on 2025-01-18.
//

import SwiftUI
import MapKit

var dateFormatter: DateFormatter {
    let formatter = DateFormatter()
    formatter.timeStyle = .short
    return formatter
}

struct RouteCardView: View {
    let stopName: String
    let travelTime: Int
    let arrivalTime: Date
    let isCurrentZone: Bool
    let stopNumber: Int
    
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                HStack(spacing: 8) {
                    ZStack{
                        Circle()
                            .fill(stopNumber == 6 ? Color.accentColor : Color.gray)
                            .frame(width: 16, height: 16)
                        Circle()
                            .stroke(stopNumber == 6 ? Color.accentColor : Color.gray, lineWidth: 2)
                            .frame(width: 16, height: 16)
                    }
//                    Circle()
//                        .stroke(Color.gray, lineWidth: 2)
//                        .fill(Color.gray)
//                        .frame(width: 16, height: 16)
                    Text(stopNumber == 6 ? "Your Zone" : "Zone \(stopNumber)")
//                        .font(.system(size: 18, weight: .medium))
                        .font(.custom("Pally Variable", size: 22))
                        .bold()
                }
                .padding(.bottom, 4)
            }
            Spacer()
            VStack(alignment:.trailing, spacing: 4) {
                Text("\(travelTime) mins")
//                    .font(.system(size: 16, weight: .medium))
                    .font(.custom("Pally Variable", size: 18))
                    .padding(.trailing)
                Text(dateFormatter.string(from: arrivalTime))
//                    .font(.system(size: 14, weight: .regular))
                    .font(.custom("Pally Variable", size: 16))
                    .foregroundColor(.secondary)
                    .padding(.trailing)
                
            }
        }
        .padding(16)
        .background(
            RoundedRectangle(cornerRadius: 36)
                .fill(isCurrentZone ? Color.busBuddyYellow : Color.gray.opacity(0.2))
        )
    }
}
