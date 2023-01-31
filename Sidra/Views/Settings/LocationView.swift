//
//  LocationView.swift
//  Sidra
//
//  Created by AHMED ASSIRY on 09/05/1444 AH.
//

import SwiftUI
import MapKit

struct LocationView: View {
    
    @StateObject var locationDataManager = LocationDataManager()
    @State private var autoLocation = true
    
//    @State private var region = MKCoordinateRegion(
//        center: CLLocationCoordinate2D(latitude: 40.83834587046632, longitude: 14.254053016537693),
//        span: MKCoordinateSpan(latitudeDelta: 0.03, longitudeDelta: 0.03)
//    )
    
    var body: some View {
        VStack(spacing: 0) {
            Map(
//                coordinateRegion: $locationDataManager.region,
                coordinateRegion: $locationDataManager.region,
                showsUserLocation: true
            )
            .frame(maxWidth: .infinity)
            .padding(-30)
            
            List {
                Section {
                    Toggle("Automatic", isOn: $autoLocation)
                    
                    if autoLocation {
                        HStack {
                            Text("City:")
                            Spacer()
//                            Text("\(autoLocation ? locationManager.placemark?.city ?? "" : "")")
                        }
                        
                    }
                }
                
                if !autoLocation {
                    Section(header: Text("Auto Location")) {
                        
                        Label("Add City", systemImage: "plus")
                    }
                }
                
            }
            .animation(.easeInOut, value: autoLocation)
            .frame(maxWidth: .infinity, minHeight: UIScreen.screenHeight / 2)
            .background(.white)
            .cornerRadius(16, corners: [.topLeft, .topRight])
            .shadow(radius: 40)
            
        }
        .ignoresSafeArea()
    }
}

struct LocationView_Previews: PreviewProvider {
    static var previews: some View {
        LocationView()
    }
}
