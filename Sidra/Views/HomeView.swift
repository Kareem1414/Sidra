//
//  HomeView.swift
//  Sidra
//
//  Created by AHMED ASSIRY on 16/05/1444 AH.
//

import SwiftUI

struct HomeView: View {
    
    @AppStorage("log_status") var logStatus : Bool = false
    
    @State var index = 0
    @State var show = false
    
    @State private var selection: String? = nil
    
    @AppStorage("colorkey") var storedColor: Color = .black
    
    var body: some View {
        
        NavigationView {
            
            ZStack {
                
                // Menu...
                
                HStack {
                    VStack(alignment: .leading) {
                        
                        Image("Image1")
                            .resizable()
                            .frame(width: 60, height: 60)
                            .clipShape(Circle())
                            .overlay(Circle().stroke(Color.white, lineWidth: 4))
                            .shadow(radius: 5)
                        
                        Text("Hi")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(.primary)
                            .padding(.top, 10)
                        
                        Text("Ahmed")
                            .fontWeight(.bold)
                            .font(.title)
                            .foregroundColor(.primary)
                        
                        VStack(alignment: .leading) {
                            
                            Button {
                                
                                self.index = 0
                                
                                // Animation View...
                                
                                // Each Time Tab is Clicked Menu Will be Closed...
                                
                                withAnimation {
                                    
                                    self.show.toggle()
                                    
                                }
                                
                            } label: {
                                
                                HStack(spacing: 12) {
                                    
                                    Image(systemName: "house")
                                        
                                    
                                    
                                    Text("Home")
                                        
                                }
                                .foregroundColor(.primary)
                                .padding(.vertical, 10)
                                .padding(.horizontal)
                                .background(self.index == 0 ? storedColor.opacity(0.2) : .clear)
                                .cornerRadius(10)
                                
                            }
                            .padding(.top, 20)
                            
                            
                            NavigationLink(destination: CalendarView(), tag: "A", selection: $selection) { EmptyView() }
                            
                            NavigationLink(destination: ServicesView(), tag: "B", selection: $selection) { EmptyView() }
                            
                            NavigationLink(destination: Settings(), tag: "C", selection: $selection) { EmptyView() }
                            
                            NavigationLink(destination: ProfileView(), tag: "D", selection: $selection) { EmptyView() }
                            
                            Button {
                                
                                //                                self.index = 2
                                selection = "A"
                                withAnimation {
                                    
                                    self.show.toggle()
                                    
                                }
                                
                            } label: {
                                
                                HStack(spacing: 12) {
                                    
                                    Image(systemName: "calendar")
                                        
                                    
                                    
                                    Text("Calendar")
                                        
                                }
                                .foregroundColor(.primary)
                                .padding(.vertical, 10)
                                .padding(.horizontal)
                                .background(self.index == 2 ? storedColor.opacity(0.2) : .clear)
                                .cornerRadius(10)
                            }
                            
                            Button {
                                
                                //                                self.index = 1
                                
                                selection = "B"
                                
                                withAnimation {
                                    
                                    self.show.toggle()
                                    
                                }
                                
                            } label: {
                                
                                HStack(spacing: 12) {
                                    
                                    Image(systemName: "tray.full")
                                        
                                    
                                    
                                    Text("Services")
                                        
                                }
                                .foregroundColor(.primary)
                                .padding(.vertical, 10)
                                .padding(.horizontal)
                                .background(self.index == 1 ? storedColor.opacity(0.2) : .clear)
                                .cornerRadius(10)
                                
                            }
                            
                            Button {
                                
                                //                                self.index = 1
                                
                                selection = "C"
                                
                                withAnimation {
                                    
                                    self.show.toggle()
                                    
                                }
                                
                            } label: {
                                
                                HStack(spacing: 12) {
                                    
                                    Image(systemName: "gearshape")
                                    
                                    Text("Settings")
                                        
                                }
                                .foregroundColor(.primary)
                                .padding(.vertical, 10)
                                .padding(.horizontal)
                                .background(self.index == 1 ? storedColor.opacity(0.2) : .clear)
                                .cornerRadius(10)
                                
                            }
                            
                        }
                        
                        Divider()
                            .frame(maxWidth: .infinity, maxHeight: 1)
                            .background(.gray.opacity(0.5))
                            .padding(.vertical, 30)
                        
                        Button {
                            
                            selection = "D"
                            withAnimation {
                                
                                self.show.toggle()
                                
                            }
                            
                        } label: {
                            
                            HStack(spacing: 12) {
                                
                                Image(systemName: "person.crop.circle")
                                
                                Text("Profile")
                                    
                            }
                            .foregroundColor(.primary)
                            .padding(.vertical, 10)
                            .padding(.horizontal)
                            .background(self.index == 2 ? storedColor.opacity(0.2) : .clear)
                            .cornerRadius(10)
                        }
                        
                        Spacer(minLength: 0)
                        
                        Button {
                            
                            withAnimation {
                                
                                self.show.toggle()
                                logStatus.toggle()
                                
                            }
                            
                        } label: {
                            
                            HStack(spacing: 12) {
                                
                                Image(systemName: "rectangle.portrait.and.arrow.forward")
                                    
                                Text("Sign out")
                                    
                            }
                            .foregroundColor(.primary)
                            .padding(.vertical, 10)
                            .padding(.horizontal)
                            
                        }
                        
                        Text("Last synced: 16 minutes ago")
                            .font(.system(size: 10))
                            .foregroundColor(.gray)
                            .padding(.leading)
                        
                    }
                    .padding(.top, 25)
                    .padding(.horizontal)
                    
                    Spacer(minLength: 0)
                    
                }
                .gesture(DragGesture(minimumDistance: 0, coordinateSpace: .local)
                    .onEnded({ value in
                        print(value.translation)
                        print(value.location)
                        print(value.time)
                        if value.translation.width < 0 {
                            // left
                            withAnimation {
                                self.show.toggle()
                            }
                            
                        }
                        
                        if value.translation.width > 0 {
                            // right
                            withAnimation {
                                self.show.toggle()
                            }
                        }
                    }))
                .padding(.top, UIApplication.shared.connectedScenes.flatMap { ($0 as? UIWindowScene)?.windows ?? [] }.first { $0.isKeyWindow }?.safeAreaInsets.top)
                .padding(.bottom, UIApplication.shared.connectedScenes.flatMap { ($0 as? UIWindowScene)?.windows ?? [] }.first { $0.isKeyWindow }?.safeAreaInsets.bottom)
                
                // MainView...
                
                VStack(spacing: 0) {
                    
                    //                HStack(spacing: 15) {
                    //
                    //                    Button {
                    //
                    //                        withAnimation {
                    //                            self.show.toggle()
                    //                        }
                    //
                    //                    } label: {
                    //                        Image(systemName: self.show ? "xmark" : "line.horizontal.3")
                    //                            .resizable()
                    //                            .frame(width: self.show ? 18 : 22, height: 18)
                    //                    }
                    //
                    //                    // Changing Name Based On Index...
                    //                    Text(self.index == 0 ? "Home" : (self.index == 1 ? "Cart" : (self.index == 2 ? "Favourites" : "Orders" )))
                    //                        .font(.title)
                    //                        .foregroundColor(.black.opacity(0.6))
                    //
                    //                    Spacer(minLength: 0)
                    //                }
                    //                .padding(.top, UIApplication.shared.connectedScenes.flatMap { ($0 as? UIWindowScene)?.windows ?? [] }.first { $0.isKeyWindow }?.safeAreaInsets.top)
                    //                .padding()
                    
                    GeometryReader { _ in
                        
                        VStack {
                            // Changing Views Based on Index...
                            VStack {
                                // Changing Views Based on Index...
                                switch self.index {
                                case 0:
                                    Home(showMenu: $show)
                                    
                                case 1:
                                    CalendarView()
                                    
                                case 2:
                                    CalendarView()
                                    
                                case 3:
                                    Settings()
                                    
                                default:
                                    Settings()
                                }
                            }
                            
                            
                            
                        }
                        
                    }
                }
                .background(.white)
                // Applying Corner Radius...
                .cornerRadius(self.show ? 30 : 0)
                // Shrinking And Moving View Right Side When Menu Button Is Clicked...
                .scaleEffect(self.show ? 0.9 : 1)
                .offset(x:self.show ? UIScreen.main.bounds.width / 2 : 0, y: self.show ? 15 : 0)
                // Rotating Slighlty...
                .rotationEffect(.init(degrees: self.show ? -5 : 0))
            }
            .background(Color(.systemGray5).edgesIgnoringSafeArea(.all))
            .edgesIgnoringSafeArea(.all)
            
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
