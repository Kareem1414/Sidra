//
//  PrayerTimesView.swift
//  Sidra
//
//  Created by AHMED ASSIRY on 28/02/1444 AH.
//

import SwiftUI
import Adhan
import CoreLocation
import CoreLocationUI
import Contacts

struct PrayerTimesView: View {
    
    @StateObject var PrayerTimesModel : PrayerTimesViewModel = PrayerTimesViewModel()
    @StateObject var locationDataManager = LocationDataManager()
    
    var body: some View {
        
        VStack(alignment: .leading) {
            
            NavigationLink(destination: QiblaView()) {
                Image(systemName: "safari")
            }
            
            switch locationDataManager.locationManager.authorizationStatus {
            case .authorizedWhenInUse, .authorizedAlways:
                
                Text("Your current location is:")
                Text("Latitude: \(locationDataManager.locationManager.location?.coordinate.latitude.description ?? "Error loading")")
                Text("Longitude: \(locationDataManager.locationManager.location?.coordinate.longitude.description ?? "Error loading")")
                
                TabView {
                    today(date: Date())
                    
                    today(date: Date().addMonths(numberOfMonths: 1))
                    
                    today(date: Date().addMonths(numberOfMonths: 2))
                }
                .tabViewStyle(.page)
                
            case .restricted, .denied:
                
                DeniedPermissionView(message: "Current location data was restricted or denied.\nplease turn on from settings")
                
                    
            default:
                ProgressView()
            }
            

            
        }
//        .background(LinearGradient(colors: [.green, .cyan], startPoint: .topTrailing, endPoint: .bottomLeading))
    }
    
    func today(date: Date) -> some View {
        
        VStack(spacing: 30) {
            
            ForEach(PrayerTimesModel.generateTimes(date: date), id: \.id) { name in
                
                Text("\(date, style: .date)")
                
                Text("Fajr:       \(name.fajr, style: .time)")
                Text("Sunrise:       \(name.sunrise, style: .time)")
                Text("Dhuhr:       \(name.dhuhr, style: .time)")
                Text("Asr:       \(name.asr, style: .time)")
                Text("Maghrib:       \(name.maghrib, style: .time)")
                Text("Isha:       \(name.isha, style: .time)")
                
                Text("currentPrayer:       \(name.currentPrayer, style: .time)").padding(.top, 40)
                Text("nextPrayer:       \(name.nextPrayer, style: .time)")
            }
            
        }
    }
}

struct PrayerTimesView_Previews: PreviewProvider {
    static var previews: some View {
        PrayerTimesView()
    }
}
