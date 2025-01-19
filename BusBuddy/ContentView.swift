//
//  ContentView.swift
//  BusBuddy
//
//  Created by Michael Werbowy on 2025-01-17.
//

import SwiftUI
import Auth0

struct ContentView: View {
    
    @State private var isAuthenticated = false
    @State var userProfile = Profile.empty
    @State private var isMapViewActive = true
    
    var body: some View {
        if isAuthenticated {
            ZStack {
                if isMapViewActive {
                    MapView()  // Map as background
                } else {
                    ListView()
                }

                VStack {
                    NavigationBar(isMapViewActive: $isMapViewActive, profile: userProfile,
                                  onLogout: logout)  // Passing the binding here
                        .padding(.top, 8)
                    Spacer()
                }
            }
            
        } else {
            
            VStack(spacing: 24) {  // Added spacing for better visual hierarchy
                // Title section
                VStack(spacing: 8) {  // Inner VStack for title and tagline with closer spacing
                    Text("BusBuddy")
                        .font(.custom("Marker Felt", size: 36))  // Using Marker Felt to match image
                        .foregroundColor(.black)
                    
                    Text("Get dressed, we got the rest")
                        .font(.custom("Marker Felt", size: 18))
                        .foregroundColor(.black)
                }
                
                Spacer()  // Pushes content to top portion
                
                // Login button
                Button("Start") {  // Changed text to "Start" to match image
                    login()
                }
                .font(.custom("Marker Felt", size: 20))
                .foregroundColor(.black)
                .padding(
                )
//                .frame(maxWidth: .infinity)
                .frame(width: UIScreen.main.bounds.width - 32)
                .background(Color("BusBuddy_Yellow"))
                .cornerRadius(20)  // More rounded corners like in the image
                .overlay(
                    RoundedRectangle(cornerRadius: 36)
                        .stroke(Color.black, lineWidth: 1)
                )
                .padding(.horizontal, 40)  // Add some side padding to make button narrower
                
                // Bottom text
                Text("Bus-tings moves since 2025")
                    .font(.custom("Marker Felt", size: 14))
                    .foregroundColor(.black)
            }
            .padding()
            .frame(maxHeight: .infinity)  // Makes VStack take full height

            
        } // if isAuthenticated
        
    } // body
    
    
    // MARK: Custom views
    // ------------------
    
    struct UserImage: View {
        var urlString: String
        
        var body: some View {
            Group {
                if urlString.starts(with: "images/") {
                    // Local image from Assets
                    Image("omar")
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: 128)
                } else {
                    // Remote image (Auth0 profile picture)
                    AsyncImage(url: URL(string: urlString)) { image in
                        image
                            .frame(maxWidth: 128)
                    } placeholder: {
                        Image(systemName: "person.circle.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(maxWidth: 128)
                            .foregroundColor(.blue)
                            .opacity(0.5)
                    }
                }
            }
            .padding(40)
        }
    }
    
    // MARK: View modifiers
    // --------------------
    
    struct TitleStyle: ViewModifier {
        let titleFontBold = Font.title.weight(.bold)
        let navyBlue = Color(red: 0, green: 0, blue: 0.5)
        
        func body(content: Content) -> some View {
            content
                .font(titleFontBold)
                .foregroundColor(navyBlue)
                .padding()
        }
    }
    
    struct MyButtonStyle: ButtonStyle {
        let navyBlue = Color(red: 0, green: 0, blue: 0.5)
        
        func makeBody(configuration: Configuration) -> some View {
            configuration.label
                .padding()
                .background(navyBlue)
                .foregroundColor(.white)
                .clipShape(Capsule())
        }
    }
    
}


extension ContentView {
  
  func login() {
    Auth0
      .webAuth()
      .start { result in
        switch result {
          case .failure(let error):
            print("Failed with: \(error)")

          case .success(let credentials):
            self.isAuthenticated = true
            self.userProfile = Profile.from(credentials.idToken)
            print("Credentials: \(credentials)")
            print("ID token: \(credentials.idToken)")
        }
      }
  }
  
  func logout() {
    Auth0
      .webAuth()
      .clearSession { result in
        switch result {
          case .success:
            self.isAuthenticated = false
            self.userProfile = Profile.empty

          case .failure(let error):
            print("Failed with: \(error)")
        }
      }
  }
  
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
