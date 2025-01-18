//
//  RoutePathView.swift
//  BusBuddy
//
//  Created by Winsome Tang on 2025-01-18.
//

import SwiftUI

struct RoutePathView: View {
    var body: some View {
        VStack(spacing: 0) {
            // Start circle (yellow)
            Circle()
                .fill(Color.yellow)
                .frame(width: 16, height: 16)
            
            // Gradient line
            Rectangle()
                .fill(
                    LinearGradient(
                        gradient: Gradient(colors: [Color.yellow, Color.black]),
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )
                .frame(width: 3, height: 40)
            
            // End circle (black)
            Circle()
                .fill(Color.black)
                .frame(width: 16, height: 16)
        }
    }
}

#Preview {
    RoutePathView()
}
