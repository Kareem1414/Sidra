//
//  MuslimSettingsView.swift
//  Sidra
//
//  Created by AHMED ASSIRY on 09/06/1444 AH.
//

import SwiftUI
import Adhan

struct MuslimSettingsView: View {
    
    @StateObject var locationDataManager = LocationDataManager()
    
    @AppStorage("colorkey") var storedColor: Color = .black
    
    @AppStorage("screen_Lock_During_Recitation") var screenLockDuringRecitation : Bool = true
    @AppStorage("show_Status_Bar") var showStatusBar : Bool = false
    @AppStorage("page_Gestures_Quran") var pageGesturesQuran : Bool = true


    @AppStorage("auto_Calculation_Methods_Prayer_Times") var autoCalculationMethodsPrayerTimes : Bool = true
    @AppStorage("current_Calculation_Method_Prayer_Times") var currentCalculationMethodPrayerTimes : CalculationMethod = .ummAlQura
    @AppStorage("madhab_Prayer_Times") var madhabPrayerTimes : Madhab = .shafi
    @AppStorage("high_Latitude_Rule_Prayer_Times") var HighLatitudeRulePrayerTimes : HighLatitudeRule?
    @AppStorage("shafaqـPrayer_Times") var shafaqPrayerTimes : Shafaq = .general
    
    @AppStorage("fajr_Manual_Correction_Prayer_Times") var fajrManualCorrectionPrayerTimes : Minute = 0
    @AppStorage("sunrise_Manual_Correction_Prayer_Times") var sunriseManualCorrectionPrayerTimes : Minute = 0
    @AppStorage("dhuhr_Manual_Correction_Prayer_Times") var dhuhrManualCorrectionPrayerTimes : Minute = 0
    @AppStorage("asr_Manual_Correction_Prayer_Times") var asrManualCorrectionPrayerTimes : Minute = 0
    @AppStorage("maghrib_Manual_Correction_Prayer_Times") var maghribManualCorrectionPrayerTimes : Minute = 0
    @AppStorage("isha_Manual_Correction_Prayer_Times") var ishaManualCorrectionPrayerTimes : Minute = 0
    
    @AppStorage("daylight_Saving_Prayer_Times") var daylightSavingPrayerTimes : Bool = true
    
    @State var ddd : CalculationParameters!
    
    var body: some View {
        List {
            
            Section(header: Text("Prayer Times")) {
                
                switch locationDataManager.locationManager.authorizationStatus {
                case .authorizedWhenInUse:  // Location services are available.
                    // Insert code here of what should happen when Location services are authorized
    //                Text("Your current location is:")
    //                Text("Latitude: \(locationDataManager.locationManager.location?.coordinate.latitude.description ?? "Error loading")")
    //                Text("Longitude: \(locationDataManager.locationManager.location?.coordinate.longitude.description ?? "Error loading")")
                    NavigationLink(destination: LocationView()) {
                        Text("Location")
                    }
                    
                    NavigationLink(destination: calculationMethodsPrayerTimesSet()) {
                        Text("Calculation Methods")
                    }
                    
                    NavigationLink(destination: madhabPrayerTimesSet()) {
                        Text("Madhab")
                    }
                    
                    NavigationLink(destination: HighLatitudeRulePrayerTimesSet()) {
                        Text("Higher Latitudes")
                    }
                    
                    NavigationLink(destination: ManualCorrectionPrayerTimesSet()) {
                        Text("Manual Correction")
                    }
                    
                    NavigationLink(destination: DaylightSavingPrayerTimesSet()) {
                        Text("Daylight Saving")
                    }
                    
                    NavigationLink(destination: ShafaqPrayerTimesSet()) {
                        Text("Twilight")
                    }
                    
                case .restricted, .denied:
                    HStack {
                        Text("Current location data was restricted or denied.")
                        
                        Spacer()
                        
                        Button {
                            locationDataManager.openSettings()
                        } label: {
                            Text("Settings")
                                .font(.system(size: 14))
                                .padding(12)
                                .foregroundColor(.white)
                                .background(storedColor)
                                .cornerRadius(8)
                        }
                    }
                    
                case .notDetermined:        // Authorization not determined yet.
                    HStack {
                        Text("Finding your location...")
                            .font(.system(size: 14))
                        Spacer()
                        ProgressView()
                        
                    }
                    .onAppear {
                        locationDataManager.locationManager.requestWhenInUseAuthorization()
                    }
                default:
                    ProgressView()
                }
                

                
                
            }
            
            Section(header: Text("Quran")) {
                
                Toggle("Disable screen lock during recitation", isOn: $screenLockDuringRecitation)
                
                Toggle("Show clock and battery", isOn: $showStatusBar)
                
                HStack {
                    
                    Text("Page gestures")
                    
                    Spacer()
                    
                    Button {
                        UISelectionFeedbackGenerator().selectionChanged()
                        pageGesturesQuran.toggle()
                        
                    } label: {
                        Image(systemName: "arrow.up.arrow.down")
                            .padding(.horizontal)
                            .foregroundColor(pageGesturesQuran ? .gray.opacity(0.5) : storedColor)
                    }
                    
                    Button {
                        UISelectionFeedbackGenerator().selectionChanged()
                        pageGesturesQuran.toggle()
                    } label: {
                        Image(systemName: "arrow.left.arrow.right")
                            .foregroundColor(pageGesturesQuran ? storedColor : .gray.opacity(0.5))
                    }
                }
                
            }
            
            Section(header: Text("Hisnul Muslim")) {
                
            }
        }
        .buttonStyle(PlainButtonStyle())
    }
    
    func calculationMethodsPrayerTimesSet() -> some View {
        
        List {
            Section(header: Text("Current Method")) {
                Text("\(currentCalculationMethodPrayerTimes.rawValue)")
            }
            
            Section(footer: Text("If this option is disabled, you can manually select a calculation method")) {
                Toggle("Automatic", isOn: $autoCalculationMethodsPrayerTimes)
            }
            
            if !autoCalculationMethodsPrayerTimes {
                Section(header: Text("Calculation Methods")) {
                    
                    ForEach(CalculationMethod.allCases, id: \.rawValue) { method in
                        
                        Button {
                            currentCalculationMethodPrayerTimes = method
                        } label: {
                            HStack {
                                Text("\(method.rawValue)")
                                
                                Spacer()
                                
                                Image(systemName: currentCalculationMethodPrayerTimes == method ? "checkmark.circle.fill" : "")
                            }
                        }
                    }
                }
            }
        }
    }
    
    func madhabPrayerTimesSet() -> some View {
        List {
            Section(header: Text("Madhab")) {
                
                
                Button {
                    UISelectionFeedbackGenerator().selectionChanged()
                    madhabPrayerTimes = .shafi
                } label: {
                    HStack {
                        Text("Shafii, Hanbali, and Maliki")
                        Spacer()
                        Image(systemName: madhabPrayerTimes == .shafi ? "checkmark.circle.fill" : "")
                    }
                }
                
                
                Button {
                    UISelectionFeedbackGenerator().selectionChanged()
                    madhabPrayerTimes = .hanafi
                } label: {
                    HStack {
                        Text("Hanafi")
                        Spacer()
                        Image(systemName: madhabPrayerTimes == .hanafi ? "checkmark.circle.fill" : "")
                    }
                }
            }
        }
    }
    
    func HighLatitudeRulePrayerTimesSet() -> some View {
        List {
            Section(header: Text("")) {
                Button {
                    HighLatitudeRulePrayerTimes = nil
                } label: {
                    HStack {
                        Text("Nothing")
                        Spacer()
                        Image(systemName: HighLatitudeRulePrayerTimes == nil ? "checkmark.circle.fill" : "")
                    }
                }
                ForEach(HighLatitudeRule.allCases, id: \.rawValue) { method in
                    
                    Button {
                        HighLatitudeRulePrayerTimes = method
                    } label: {
                        HStack {
                            Text("\(method.rawValue)")
                            Spacer()
                            Image(systemName: HighLatitudeRulePrayerTimes?.rawValue == method.rawValue ? "checkmark.circle.fill" : "")
                        }
                    }
                }
            }
        }
    }
    
    func ManualCorrectionPrayerTimesSet() -> some View {
        
        List {
            
            Section {
                
                Stepper("fajr", value: $fajrManualCorrectionPrayerTimes, in: -60...60)
                HStack {
                    Text("\(fajrManualCorrectionPrayerTimes)")
                    
                    Spacer()
                    
                    Text("5:19")
                }
            }
            
            Section {
                
                Stepper("sunrise", value: $sunriseManualCorrectionPrayerTimes, in: -60...60)
                HStack {
                    Text("\(sunriseManualCorrectionPrayerTimes)")
                    
                    Spacer()
                    
                    Text("6:21")
                }
            }
            
            Section {
                
                Stepper("dhuhr", value: $dhuhrManualCorrectionPrayerTimes, in: -60...60)
                HStack {
                    Text("\(dhuhrManualCorrectionPrayerTimes)")
                    
                    Spacer()
                    
                    Text("11:35")
                }
            }
            
            Section {
                
                Stepper("asr", value: $asrManualCorrectionPrayerTimes, in: -60...60)
                HStack {
                    Text("\(asrManualCorrectionPrayerTimes)")
                    
                    Spacer()
                    
                    Text("2:28")
                }
            }
            
            Section {
                
                Stepper("maghrib", value: $maghribManualCorrectionPrayerTimes, in: -60...60)
                HStack {
                    Text("\(maghribManualCorrectionPrayerTimes)")
                    
                    Spacer()
                    
                    Text("5:09")
                }
            }
            
            Section {
                
                Stepper("isha", value: $ishaManualCorrectionPrayerTimes, in: -60...60)
                HStack {
                    Text("\(ishaManualCorrectionPrayerTimes)")
                    
                    Spacer()
                    
                    Text("7:41")
                }
            }
        }
    }
    
    func DaylightSavingPrayerTimesSet() -> some View {
        List {
            Section(footer: Text("Daylight saving time (DST) is the practice of advancing clocks (typically by one hour) during warmer months so that darkness falls at a later clock time. The typical implementation of DST is to set clocks forward by one hour in the spring (spring forward), and to set clocks back by one hour in the fall (fall back) to return to standard time. As a result, there is one 23-hour day in early spring and one 25-hour day in the middle of autumn.")) {
                Toggle("Automatic", isOn: $daylightSavingPrayerTimes)
            }
            
            if !daylightSavingPrayerTimes {
                Section(header: Text("Hour")) {
                    HStack {
                        Text("+ 1")
                        Spacer()
                        Image(systemName: daylightSavingPrayerTimes ? "checkmark.circle.fill" : "")
                    }
                    
                    HStack {
                        Text("- 1")
                        Spacer()
                        Image(systemName: daylightSavingPrayerTimes ? "checkmark.circle.fill" : "")
                    }
                }
            }
            
        }
    }
    
    func ShafaqPrayerTimesSet() -> some View {
        List {
            Section(footer: Text("Shafaq (Twilight) is light produced by sunlight scattering in the upper atmosphere, when the Sun is below the horizon, which illuminates the lower atmosphere and the Earth's surface. The word twilight can also refer to the periods of time when this illumination occurs.")) {
                
                ForEach(Shafaq.allCases, id: \.rawValue) { type in
                    Button {
                        shafaqPrayerTimes = type
                    } label: {
                        HStack {
                            Text("\(type.rawValue)")
                            Spacer()
                            Image(systemName: shafaqPrayerTimes.rawValue == type.rawValue ? "checkmark.circle.fill" : "")
                        }
                    }
                }
            }
        }
    }
}

struct MuslimSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        MuslimSettingsView()
    }
}
