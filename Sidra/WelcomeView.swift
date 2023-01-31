//
//  WelcomeView.swift
//  Sidra
//
//  Created by AHMED ASSIRY on 29/02/1444 AH.
//

import SwiftUI

struct WelcomeView: View {
    
    @AppStorage("log_status") var logStatus : Bool = false
    
    // MARK: Current Slide Index
    @State var currentIndex : Int = 0
    
    var totalSlides : Int = 4
    
    @State var notification : Bool = false
    
    @StateObject var locationDataManager = LocationDataManager()
    @StateObject var notificationManager = NotificationManager()
    @StateObject var trackingManager = TrackingManager()
    
    var body: some View {
        GeometryReader {
            
            let size = $0.size
            
            // MARK: Movable Slide
            let offset = -CGFloat(currentIndex) * size.width
            
            if currentIndex == 4 {
                LottieView(animationName: "4",
                           loopMode: .loop,
                           contentMode: .scaleAspectFill)
                .ignoresSafeArea()
                .animation(.easeInOut(duration: 0.5), value: currentIndex)
                
            }

            
            HStack(spacing: 0) {
                
                ForEach(0...totalSlides, id: \.self) { index in
                    
                    let isLastSlide = (currentIndex == totalSlides)
                    
                    VStack(spacing: 16) {
                        
                        // MARK: Top Nav Bar
                        HStack {
                            Button("Back") {
                                if currentIndex > 0 {
                                    currentIndex -= 1
                                    
                                }
                            }
                            .opacity(1...(totalSlides - 1) ~= currentIndex ? 1 : 0)
                            
                            Spacer(minLength: 0)
                            
                            Button("Skip") {
                                currentIndex = totalSlides - 1
                                
                            }
                            .opacity(currentIndex > totalSlides - 2 ? 0 : 1)
                        }
                        .animation(.easeInOut, value: currentIndex)
                        .tint(.gray)
                        .fontWeight(.bold)
                        .padding(.horizontal)
                        
                        switch index {
                        case 0:
                            
                            VStack {
                                
                                LottieView(animationName: "11",
                                           loopMode: .loop,
                                           contentMode: .scaleAspectFill)
                                .frame(width: size.width / 1.1, height: size.width / 1.3)
                                .offset(x: offset)
                                .animation(.easeInOut(duration: 0.5), value: currentIndex)
                                
                                Text("Manage your Day in 3 simple Steps")
                                    .font(.title.bold())
                                    .multilineTextAlignment(.center)
                                    .padding(.bottom)
                                    .offset(x: offset)
                                    .animation(.easeInOut(duration: 0.5).delay(0.1), value: currentIndex)
                                
                                ScrollView(.vertical, showsIndicators: false) {
                                    VStack(alignment: .leading) {
                                        
                                        HStack(spacing: 16) {
                                            Text("1")
                                                .foregroundColor(.white)
                                                .font(.system(size: 14).bold())
                                                .padding(6)
                                                .background(
                                                    Circle()
                                                        .fill(.blue)
                                                    
                                                )
                                            
                                            Text("Add your activities to the timeline.")
                                                .font(.system(size: 14))
                                                .foregroundColor(.gray)
                                                
                                        }
                                        
                                        HStack(spacing: 16) {
                                            Text("2")
                                                .foregroundColor(.white)
                                                .font(.system(size: 14).bold())
                                                .padding(6)
                                                .background(
                                                    Circle()
                                                        .fill(.blue)
                                                    
                                                )
                                            Text("Organize the tasks and events for your activities.")
                                                .font(.system(size: 14))
                                                .foregroundColor(.gray)
                                                
                                        }
                                        
                                        HStack(spacing: 16) {
                                            Text("3")
                                                .foregroundColor(.white)
                                                .font(.system(size: 14).bold())
                                                .padding(6)
                                                .background(
                                                    Circle()
                                                        .fill(.blue)
                                                    
                                                )
                                            
                                            Text("Complete your planned tasks and events.")
                                                .font(.system(size: 14))
                                                .foregroundColor(.gray)
                                                
                                        }
                                        
                                        HStack(spacing: 16) {
                                            Text("4")
                                                .foregroundColor(.white)
                                                .font(.system(size: 14).bold())
                                                .padding(6)
                                                .background(
                                                    Circle()
                                                        .fill(.blue)
                                                    
                                                )
                                            
                                            Text("Add, Sync, Edit, Delete dirctly.")
                                                .font(.system(size: 14))
                                                .foregroundColor(.gray)
                                                
                                        }
                                        
                                        HStack(spacing: 16) {
                                            Text("5")
                                                .foregroundColor(.white)
                                                .font(.system(size: 14).bold())
                                                .padding(6)
                                                .background(
                                                    Circle()
                                                        .fill(.blue)
                                                    
                                                )
                                            
                                            Text("Complete your planned tasks and events throughout the day.")
                                                .font(.system(size: 14))
                                                .foregroundColor(.gray)
                                                
                                        }
                                    }
                                }
                                
                                .padding(.horizontal, 16)
                                .offset(x: offset)
                                .animation(.easeInOut(duration: 0.5).delay(0.2), value: currentIndex)
                            }
                            
                        case 1:
                            
                            VStack(spacing: 8) {
                                
                                LottieView(animationName: "12",
                                           loopMode: .loop,
                                           contentMode: .scaleAspectFill)
                                .frame(width: size.width / 1.1, height: size.width / 1.3)
                                .offset(x: offset)
                                .animation(.easeInOut(duration: 0.5), value: currentIndex)
                                
                                Text("Sync your settings")
                                    .font(.title.bold())
                                    .offset(x: offset)
                                    .animation(.easeInOut(duration: 0.5).delay(0.1), value: currentIndex)
                                
                                Label("iCloud", systemImage: "externaldrive.fill.badge.icloud")
                                    .foregroundColor(.blue).bold()
                                
                                    .offset(x: offset)
                                    .animation(.easeInOut(duration: 0.5).delay(0.1), value: currentIndex)
                                
                                Text("One of the greatest powers of Apple's iOS platform is the diversity of built-in frameworks. There are many gems to be found which provide easy-to-use but advanced functionality. One of these examples is the Vision framework which was introduced in iOS 11.")
                                    .font(.system(size: 14))
                                    .multilineTextAlignment(.center)
                                    .padding(.horizontal)
                                    .foregroundColor(.gray)
                                    .offset(x: offset)
                                    .animation(.easeInOut(duration: 0.5).delay(0.2), value: currentIndex)
                            }
                            
                        case 2:
                            
                            VStack {
                                
                                LottieView(animationName: "7",
                                           loopMode: .loop,
                                           contentMode: .scaleAspectFill)
                                .frame(width: size.width / 1.1, height: size.width / 1.3)
                                .offset(x: offset)
                                .animation(.easeInOut(duration: 0.5), value: currentIndex)
                                
                                Text("Receive Package")
                                    .font(.title.bold())
                                    .padding(.bottom)
                                    .offset(x: offset)
                                    .animation(.easeInOut(duration: 0.5).delay(0.1), value: currentIndex)
                                
                                Text("The goal we want to achieve in this tutorial is to implement an on-device text recognition app, which allows our code to work even without internet connection. In addition we want to be able to scan documents right from our camera feed and extract the text from there.")
                                    .font(.system(size: 14))
                                    .multilineTextAlignment(.center)
                                    .padding(.horizontal, 15)
                                    .foregroundColor(.gray)
                                    .offset(x: offset)
                                    .animation(.easeInOut(duration: 0.5).delay(0.2), value: currentIndex)
                            }
                            
                        case 3:
                            
                            VStack(alignment: .leading, spacing: 4) {
                                
                                Text("Need Permissions")
                                    .font(.title.bold())
                                    .padding(.horizontal)
                                    .offset(x: offset)
                                    .animation(.easeInOut(duration: 0.5).delay(0.1), value: currentIndex)
                                
                                Text("In order for you use certain features of this app, you need to give permissions. See description for each permission.")
                                    .font(.system(size: 14))
                                    .foregroundColor(.gray)
                                    .padding([.horizontal, .bottom])
                                    .offset(x: offset)
                                    .animation(.easeInOut(duration: 0.5).delay(0.2), value: currentIndex)
                                
                                VStack(spacing: 0) {
                                    ScrollView(.vertical, showsIndicators: false) {
                                        VStack {
                                            HStack {
                                                Image(systemName: "bell.fill")
                                                    .font(.system(size: 28))
                                                    .foregroundColor(.blue)
                                                    .padding(.trailing, 8)
                                                
                                                VStack(alignment: .leading) {
                                                    Text("Notifications")
                                                    Text("Allow to send notifications")
                                                        .font(.caption2)
                                                        .foregroundColor(.gray)
                                                }
                                                
                                                Spacer()
                                                
                                                Button {
                                                    
                                                    UISelectionFeedbackGenerator().selectionChanged()
                                                    
                                                    notificationManager.requestAuthorization()
                                                    
                                                } label: {
                                                    Text(notificationManager.authorizationStatus != .authorized ? "ALLOW" : "Done")
                                                        .font(.system(size: 13).bold())
                                                        .padding(6)
                                                        .padding(.horizontal, 8)
                                                        .foregroundColor(notificationManager.authorizationStatus == .authorized ? .white : .blue)
                                                        .background(
                                                            Capsule()
                                                                .fill(notificationManager.authorizationStatus == .authorized ? .green : Color(.systemGray5))
                                                        )
                                                }
                                                
                                            }
                                            .padding()
                                            .padding(.top, 8)
                                            
                                            Divider()
                                            
                                            HStack {
                                                Image(systemName: "location.fill.viewfinder")
                                                    .font(.system(size: 26))
                                                    .foregroundColor(.blue)
                                                    .padding(.trailing, 8)
                                                
                                                VStack(alignment: .leading) {
                                                    Text("Location")
                                                    Text("Allow to access your location")
                                                        .font(.caption2)
                                                        .foregroundColor(.gray)
                                                }
                                                
                                                Spacer()
                                                
                                                Button {
                                                    
                                                    UISelectionFeedbackGenerator().selectionChanged()
                                                    
                                                    locationDataManager.locationManager.requestWhenInUseAuthorization()
                                                    
                                                } label: {
                                                    Text(locationDataManager.authorizationStatus != .authorizedWhenInUse ?  "ALLOW" : "Done")
                                                        .font(.system(size: 13).bold())
                                                        .padding(6)
                                                        .padding(.horizontal, 8)
                                                        .foregroundColor(locationDataManager.authorizationStatus == .authorizedWhenInUse ? .white : .blue)
                                                        .background(
                                                            Capsule()
                                                                .fill(locationDataManager.authorizationStatus == .authorizedWhenInUse ? .green : Color(.systemGray5))
                                                        )
                                                }
                                            }
                                            .padding()
                                            
                                            Divider()
                                        }
                                        
                                        HStack {
                                            Image(systemName: "arrow.left.arrow.right.circle.fill")
                                                .font(.system(size: 27))
                                                .foregroundColor(.blue)
                                                .padding(.trailing, 8)
                                            
                                            VStack(alignment: .leading) {
                                                Text("Tracking")
                                                Text("Allow to track your data")
                                                    .font(.caption2)
                                                    .foregroundColor(.gray)
                                            }
                                            
                                            Spacer()
                                            
                                            Button {
                                                UISelectionFeedbackGenerator().selectionChanged()
                                                trackingManager.requestPermission()
                                            } label: {
                                                Text(trackingManager.authorizationStatus != .authorized ? "ALLOW" : "Done")
                                                    .font(.system(size: 13).bold())
                                                    .padding(6)
                                                    .padding(.horizontal, 8)
                                                    .foregroundColor(trackingManager.authorizationStatus == .authorized ? .white : .blue)
                                                    .background(
                                                        Capsule()
                                                            .fill(trackingManager.authorizationStatus == .authorized ? .green : Color(.systemGray5))
                                                    )
                                            }
                                        }
                                        .padding()
                                        .padding(.bottom, 8)
                                        
                                        
                                    }
                                    
                                    Divider()
                                    
                                    Text("Permission are necessary for all the features and functions to work properly. If not allowed, you have to enable permissions in settings")
                                        .font(.caption)
                                        .foregroundColor(.gray)
                                        .padding()
                                    
                                }
                                .background(Color(.systemGray6))
                                .cornerRadius(16)
                                .padding(.horizontal, 24)
                                //                                .padding(.vertical, 16)
                                .cornerRadius(16)
                                .offset(x: offset)
                                .animation(.easeInOut(duration: 0.5).delay(0.3), value: currentIndex)
                                
                            }
                            
                        default:
                            
                            
                            
                            VStack(spacing: 24) {
                                LottieView(animationName: "13",
                                           loopMode: .playOnce ,
                                           contentMode: .scaleAspectFill)
                                .frame(width: size.width / 2, height: size.width / 2)
                                .offset(x: offset)
                                .animation(.easeInOut(duration: 0.5), value: currentIndex)
                                
                                
                                Text("Well Done!")
                                    .font(.title.bold())
                                    .padding(.bottom)
                                    .offset(x: offset)
                                    .animation(.easeInOut(duration: 0.5).delay(0.1), value: currentIndex)
                                
                                Text("All the steps are complete and you can begin using the app now")
                                    .font(.system(size: 14))
                                    .multilineTextAlignment(.center)
                                    .padding(.horizontal, 15)
                                    .foregroundColor(.gray)
                                    .offset(x: offset)
                                    .animation(.easeInOut(duration: 0.5).delay(0.2), value: currentIndex)
                            }
                            
                            
                            
                        }
                        
                        Spacer(minLength: 0)
                        
                        // MARK: Next / Login Button
                        VStack(spacing: 16) {
                            
                            if currentIndex < 3 || (notificationManager.authorizationStatus == .authorized && locationDataManager.authorizationStatus == .authorizedWhenInUse && trackingManager.authorizationStatus == .authorized) {
                                Button {
                                    
                                    UISelectionFeedbackGenerator().selectionChanged()
                                    
                                    if currentIndex < totalSlides {
                                        currentIndex += 1
                                    } else {
                                        logStatus.toggle()
                                    }
                                    
                                } label: {
                                    
                                    Text(currentIndex == 0 ? "Get Started" : currentIndex < totalSlides ? "Next" : "Start Using the App")
                                        .fontWeight(.bold)
                                        .foregroundColor(.white)
                                        .padding(.vertical, currentIndex < totalSlides ? 12 : 16)
                                        .frame(maxWidth: .infinity)
                                        .background(
                                            RoundedRectangle(cornerRadius: 8, style: .continuous)
                                                .fill(.blue)
                                        )
                                        .padding(.horizontal, currentIndex < totalSlides ? 100 : 30)
                                }
                                
                            }
                            
                            if currentIndex > totalSlides - 1 {
                                HStack(spacing: 32) {
                                    
                                    Text("Terms of Service")
                                    
                                    Text("Privacy Policy")
                                    
                                }
                                .font(.caption2)
                                .underline(true, color: .primary)
                            }
                        }
                        .padding(.horizontal)
                        
                    }
                    .animation(.easeInOut.delay(0.4), value: isLastSlide)
                    .frame(width: size.width, height: size.height)
                    
                    
                    
                }
            }
            .frame(width: size.width * CGFloat(totalSlides), alignment: .leading)
            
        }
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
    }
}
