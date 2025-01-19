//
//  NavigationBar.swift
//  BusBuddy
//
//  Created by Michael Werbowy on 2025-01-18.
//


import SwiftUI

// Separate view for the omar/X button to isolate its animation behavior
struct ProfileButton: View {
    let isExpanded: Bool
    let action: () -> Void

    
    var body: some View {
        Button(action: action) {
            Group {
                if isExpanded {
                    ZStack {
                        Circle()
                            .stroke(Color.black, lineWidth: 1)
                            .frame(width: 48, height: 48)
                        Image(systemName: "xmark")
                            .font(.system(size: 20, weight: .bold))
                            .foregroundColor(.black)
                    }
                } else {
                    Image("omar")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 48, height: 48)
                        .clipShape(Circle())
                        .overlay(
                            Circle()
                                .stroke(Color.black, lineWidth: 1)
                        )
                }
            }
        }
        .transaction { t in
            t.animation = nil
        }
    }
}

struct NavigationBar: View {
    @State private var isExpanded = false
    @Binding var isMapViewActive: Bool
    let profile: Profile
    let onLogout: () -> Void
    
    private let busbuddyYellow = Color("BusBuddy_Yellow")
    private let barHeight: CGFloat = 72
    
    var body: some View {
        VStack(spacing: 0) {
            // Navigation controls
            HStack {
                ProfileButton(isExpanded: isExpanded) {
                    isExpanded.toggle()
                }
                
                Spacer()
                
                // Toggle/Signout button with disabled animation
                // Toggle button with custom styling
                Group {
                    if isExpanded {
                        Button(action: onLogout) {
                            ZStack {
                                Circle()
                                    .stroke(Color.black, lineWidth: 1) // Add circle around the button
                                    .frame(width: 48, height: 48)    // Match circle size
                                Image(systemName: "rectangle.portrait.and.arrow.right")
                                    .font(.system(size: 20, weight: .bold))
                                    .foregroundColor(.black)         // Set icon color to black
                            }
                        }
                    } else {
                        // Capsule-style Segmented Control
                        ZStack {
                            // Background capsule - now with a more contrasting background
                            Capsule()
                                .fill(Color.black)
                                .overlay(
                                    Capsule()
                                        .stroke(Color.black, lineWidth: 2.5)
                                )
                                .frame(width: 90, height: 32)
                            
                            // Sliding capsule for active state
                            Capsule()
                                .fill(Color("BusBuddy_Yellow"))
                                .frame(width: 45, height: 32)
                                .offset(x: isMapViewActive ? -22.5 : 22.5) // Retain final position
                                .animation(
                                    .interpolatingSpring(stiffness: 600, damping: 50), // Reduced overshooting
                                    value: isMapViewActive
                                )
                            
                            // Interactive buttons
                            HStack(spacing: 0) {
                                // Map Button
                                Button(action: {
                                    if !isMapViewActive {
                                        isMapViewActive.toggle()
                                    }
                                }) {
                                    Image(systemName: "map.fill")
                                        .foregroundColor(isMapViewActive ? .black : .white) // Foreground color for active/inactive
                                        .frame(width: 45, height: 32)
                                        .contentShape(Rectangle()) // Increases tappable area
                                }
                                
                                // List Button
                                Button(action: {
                                    if isMapViewActive {
                                        isMapViewActive.toggle()
                                    }
                                }) {
                                    Image(systemName: "list.bullet")
                                        .foregroundColor(!isMapViewActive ? .black : .white) // Foreground color for active/inactive
                                        .frame(width: 45, height: 32)
                                        .contentShape(Rectangle()) // Increases tappable area
                                }
                            }
                            .frame(width: 90, height: 32)
                        }
                    }
                }
                .transaction { t in
                    t.animation = .spring(response: 0.2, dampingFraction: 0.7)
                }


            }
            .padding(.horizontal, 16)
            .frame(height: barHeight)
            
            if isExpanded {
                // Profile content
                VStack(spacing: 16) {
                    // Name
                    Text("Omar Al-Dulaimi")
                        .font(.custom("Pally Variable", size: 32))
                        .bold()
                        .padding(.top, 8)
                    
                    // Profile Image
                    Image("omar")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 128, height: 128)
                        .clipShape(Circle())
                        .overlay(
                            Circle()
                                .stroke(Color.black, lineWidth: 2)
                        )
                    
                    // Email
                    Text(profile.email)
                        .font(.custom("Pally Variable", size: 16))
                        .foregroundColor(.gray)
                   
                    // Organization ID Section
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Organization ID")
                            .font(.custom("Pally Variable", size: 18))
                            .bold()
                        Text("SHER_TRAF")
                            .font(.custom("Pally Variable", size: 20))
                            .padding(12)
                            .frame(maxWidth: .infinity)
                            .background(
                                RoundedRectangle(cornerRadius: 32)
                                    .stroke(Color.black, lineWidth: 1)
                            )
                    }
                    .padding(.horizontal)
                    
                    // User ID Section
                    VStack(alignment: .leading, spacing: 4) {
                        Text("User ID")
                            .font(.custom("Pally Variable", size: 18))
                            .bold()
                        Text("Max5713")
                            .font(.custom("Pally Variable", size: 20))
                            .padding(12)
                            .frame(maxWidth: .infinity)
                            .background(
                                RoundedRectangle(cornerRadius: 32)
                                    .stroke(Color.black, lineWidth: 1)
                                
                            )
                    }
                    .padding(.horizontal)
                    
                   
                    
                    // Sync/Login Button
                    Button(action: onLogout) {
                        Text("Sync/Login")
                            .font(.custom("Pally Variable", size: 18))
                            .frame(maxWidth: .infinity)
                            .padding()
                            .foregroundStyle(Color.blue)
                            .bold()
//                            .colorInvert()
//                            .background(Color("BusBuddy_Yellow"))
                            .cornerRadius(32)
                    }
                    .padding(.horizontal)
                }
                .padding()
                .transition(AnyTransition.offset(y: -100).combined(with: .opacity))
            }
        }
        .background(
            Group {
                busbuddyYellow
                    .cornerRadius(36)
                    .overlay(
                        RoundedRectangle(cornerRadius: 36)
                            .stroke(Color.black, lineWidth: 1)
                    )
            }
        )
        .padding(.horizontal)
        .animation(.spring(response: 1, dampingFraction: 0.8), value: isExpanded)
    }
}
