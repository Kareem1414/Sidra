//
//  TaskViewModel.swift
//  Sidra
//
//  Created by AHMED ASSIRY on 21/02/1444 AH.
//

import SwiftUI
import CoreLocation
import MapKit
import CoreData
import HealthKit
import Contacts
import LocalAuthentication
import Adhan
import AppTrackingTransparency
import AdSupport

class CalendarViewModel: ObservableObject {
    
    // MARK: Current Week Days
    @Published var currentWeek : [Date] = []
    
    // MARK: Current Hijri Week Days
    @Published var currentHijriWeek : [Date] = []
    
    // MARK: Current Day
    @Published var currentDay : Date = Date()
    
    // MARK: Filtering Today Tasks
    @Published var filteredTasks : [TaskCoreData]?
    
    // MARK: New Task View
    @Published var addNewTask : Bool = false
    
    // MARK: Edit Data
    @Published var editTask : TaskCoreData?
    
    @Published var taskTitle : String = ""
    @Published var taskDate : Date = Date()
    @Published var showDatePicker : Bool = false
    
    @AppStorage("display_days_home") var displayDaysHome: Int = 7
    
    init(){
        fetchCurrentWeek()
    }
    
    func fetchCurrentWeek() {
        
        let today = Date()
        let calendar = Calendar.current
        
        let week = calendar.dateInterval(of: .weekOfMonth, for: today)
        
        guard let firstWeekDay = week?.start else {
            return
        }
        
        (0...displayDaysHome).forEach { day in
            
            if let weekDay = calendar.date(byAdding: .day, value: day, to: firstWeekDay) {
                
                currentWeek.append(weekDay)
                
            }
        }
    }
    
    func fetchCurrentHijriWeek() {
        
        let today = Date()
        let calendar = Calendar.current
        
        
        let week = calendar.dateInterval(of: .weekOfMonth, for: today)
        
        guard let firstWeekDay = week?.start else {
            return
        }
        
        (0...displayDaysHome).forEach { day in
            
            if let weekDay = calendar.date(byAdding: .day, value: day, to: firstWeekDay) {
                
                currentHijriWeek.append(weekDay)
                
            }
        }
    }
    
    // MARK: Checking if current Date is Today
    
    func isToday(date: Date) -> Bool {
        
        let calendar = Calendar.current
        
        return calendar.isDate(currentDay, inSameDayAs: date)
    }
    
    func isRealToday(date: Date) -> Bool {
        let calendar = Calendar.current
        
        return calendar.isDate(Date(), inSameDayAs: date)
    }
    
    // MARK: Checking if the currentHour is task Hour
    func isCurrentHour(date: Date) -> Bool {
        
        let calendar = Calendar.current
        
        let hour = calendar.component(.hour, from: date)
        let currentHour = calendar.component(.hour, from: Date())
        
        let isToday = calendar.isDateInToday(date)
        
        return (hour == currentHour && isToday)
    }
    
    // MARK: Adding Task To Core Data
    func addTask(context: NSManagedObjectContext) -> Bool {
        
        // MARK: updating Existing Data in Core Data
        var task : TaskCoreData!
        
        if let editTask = editTask {
            task = editTask
        } else {
            task = TaskCoreData(context: context)
        }
        
        task.taskTitle = taskTitle
        task.taskDate = taskDate
        task.taskIsCompleted = false
        
        if let _ = try? context.save() {
            return true
        }
        
        return false
    }
    
    // MARK: Resetting Data
    func resetTaskData() {
        taskTitle = ""
        taskDate = Date()
    }
    
    // MARK: If Edit Task Is Available Then Setting Exisiting Data
    func setupTask() {
        
        if let editTask = editTask {
            taskTitle = editTask.taskTitle ?? ""
            taskDate = editTask.taskDate ?? Date()
        }
        
    }
    
}

class HealthStore {
    
    var healthStore : HKHealthStore?
    var query : HKStatisticsCollectionQuery?
    
    init() {
        if HKHealthStore.isHealthDataAvailable() {
            healthStore = HKHealthStore()
        }
    }
    
    func HeartRate(completion: @escaping (HKStatisticsCollection?) -> Void) {
        
    }
    
    func calculateSteps(completion: @escaping (HKStatisticsCollection?) -> Void) {
        
        let stepType = HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.stepCount)!
        
        let startDate = Calendar.current.date(byAdding: .day, value: -7, to: Date())
        
        let anchorDate = Calendar.current.date(bySettingHour: 12, minute: 0, second: 0, of: Date())!
        
        let daily = DateComponents(day: 1)
        
        let predicate = HKQuery.predicateForSamples(withStart: startDate, end: Date(), options: .strictStartDate)
        
        query = HKStatisticsCollectionQuery(quantityType: stepType, quantitySamplePredicate: predicate, options: .cumulativeSum, anchorDate: anchorDate, intervalComponents: daily)
        
        query!.initialResultsHandler = { query, statisticsCollection, error in
            completion(statisticsCollection)
        }
        
        if let healthStore = healthStore, let query = self.query {
            healthStore.execute(query)
        }
    }
    
    func requestAuthorization(completion: @escaping (Bool) -> Void) {
        let typesToRead: Set = [
            
            // CharacteristicType
            HKQuantityType.characteristicType(forIdentifier: .bloodType)!,
            HKQuantityType.characteristicType(forIdentifier: .dateOfBirth)!,
            HKQuantityType.characteristicType(forIdentifier: .biologicalSex)!,
            HKQuantityType.characteristicType(forIdentifier: .activityMoveMode)!,
            HKQuantityType.characteristicType(forIdentifier: .fitzpatrickSkinType)!,
            HKQuantityType.characteristicType(forIdentifier: .wheelchairUse)!,
            
            // QuantityType
            HKQuantityType.quantityType(forIdentifier: .heartRate)!,
            HKQuantityType.quantityType(forIdentifier: .stepCount)!,
            HKQuantityType.quantityType(forIdentifier: .walkingSpeed)!,
            HKQuantityType.quantityType(forIdentifier: .distanceWalkingRunning)!,
            HKQuantityType.quantityType(forIdentifier: .appleExerciseTime)!,
            HKQuantityType.quantityType(forIdentifier: .height)!,
            HKQuantityType.quantityType(forIdentifier: .dietaryFatTotal)!,
            HKQuantityType.quantityType(forIdentifier: .bodyFatPercentage)!,
            HKQuantityType.quantityType(forIdentifier: .oxygenSaturation)!,
            HKQuantityType.quantityType(forIdentifier: .activeEnergyBurned)!,
            HKQuantityType.quantityType(forIdentifier: .bodyTemperature)!,
            HKQuantityType.quantityType(forIdentifier: .appleStandTime)!
            
        ]
        
        guard let healthStore = self.healthStore else { return completion(false)}
        
        healthStore.requestAuthorization(toShare: [], read: typesToRead) { (success, error) in
            completion(success)
        }
    }
}

class ContactsViewModel: ObservableObject {
    
    @Published var contacts: [Contact] = []
    @Published var authorizationStatus: CNAuthorizationStatus?
    
    init() {
        permissions()
    }
    
    func openSettings() {
        guard let settingsURL = URL(string: UIApplication.openSettingsURLString) else { return }
        if UIApplication.shared.canOpenURL(settingsURL) { UIApplication.shared.open(settingsURL)}
    }
    
    private func getContacts() {
        Contact.fetchAll { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let fetchedContacts):
                DispatchQueue.main.async {
                    self.contacts = fetchedContacts.sorted(by: {$0.firstName < $1.firstName})
                }
            case .failure(_):
                break
            }
        }
    }
    
    private func permissions() {
        switch CNContactStore.authorizationStatus(for: .contacts) {
        case .authorized:
            getContacts()
            authorizationStatus = .authorized
        
        case .restricted, .denied:
            authorizationStatus = .denied
            
        case .notDetermined:
            CNContactStore().requestAccess(for: .contacts) { [weak self] granted, error in
                guard let self = self else { return }
                switch granted {
                case true:
                    self.getContacts()
                case false:
                    self.authorizationStatus = .restricted
                }
            }
        default:
            fatalError("Unknown Error!")
        }
    }
    
}

class OTPViewModel: ObservableObject {
    
    @Published var otpText: String = ""
    @Published var otpFields: [String] = Array(repeating: "", count: 4)
    
}

class FaceIDViewModel: ObservableObject {
    
    @Published var isUnlocked = false
    
    func authenticate() {
        
        let context = LAContext()
        var error: NSError?
        
        if context.canEvaluatePolicy(.deviceOwnerAuthentication, error: &error) {
            
            context.evaluatePolicy(.deviceOwnerAuthentication, localizedReason: "Please authenticate yourself to unlock your places.") { success, authenticationError in
                
                DispatchQueue.main.async {
                    if success {
                        
                        self.isUnlocked = true
                        
                    } else {
                        // error
                    }
                }
            }
        } else {
            // no biometrics
        }
    }
}

class PrayerTimesViewModel : ObservableObject {
    
    // MARK: Current Day
    @Published var currentDay : Date = Date()
    
    var locationDataManager = LocationDataManager()
    
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
    
//    init(){
//        _ = generateTimes(date: Date())
//    }
    
//    func directionQibla(coordinates: Coordinates) -> Double {
//        return Qibla(coordinates: Coordinates(latitude: 24.774265, longitude: 46.738586)).direction
//    }
    
    func generateTimes(date: Date) -> [PrayerTimesItems] {
        
        
        
        let cal = Calendar(identifier: .gregorian)
        let date = cal.dateComponents([.year, .month, .day], from: date)
        let coordinates = Coordinates(latitude: (locationDataManager.locationManager.location?.coordinate.latitude)!, longitude: (locationDataManager.locationManager.location?.coordinate.longitude)!)
        var params = currentCalculationMethodPrayerTimes.params
        
        params.madhab = madhabPrayerTimes
        params.highLatitudeRule = HighLatitudeRulePrayerTimes
        params.shafaq = shafaqPrayerTimes
        
        params.adjustments.fajr = fajrManualCorrectionPrayerTimes
        params.adjustments.sunrise = sunriseManualCorrectionPrayerTimes
        params.adjustments.dhuhr = dhuhrManualCorrectionPrayerTimes
        params.adjustments.asr = asrManualCorrectionPrayerTimes
        params.adjustments.maghrib = maghribManualCorrectionPrayerTimes
        params.adjustments.isha = ishaManualCorrectionPrayerTimes
        
        
        let prayers = PrayerTimes(coordinates: coordinates, date: date, calculationParameters: params)
        let sunnahTimes = SunnahTimes(from: prayers!)
        
        print("Generate Prayer Times")
//        let formatter = DateFormatter()
//        formatter.timeStyle = .medium
//        formatter.timeZone = TimeZone.current //TimeZone(identifier: "America/New_York")!
//
//        print("fajr \(formatter.string(from: prayers!.fajr))")
//        print("sunrise \(formatter.string(from: prayers!.sunrise))")
//        print("dhuhr \(formatter.string(from: prayers!.dhuhr))")
//        print("asr \(formatter.string(from: prayers!.asr))")
//        print("maghrib \(formatter.string(from: prayers!.maghrib))")
//        print("isha \(formatter.string(from: prayers!.isha))")
        
        return [PrayerTimesItems(fajr: prayers!.fajr, sunrise: prayers!.sunrise, dhuhr: prayers!.dhuhr, asr: prayers!.asr, maghrib: prayers!.maghrib, isha: prayers!.isha, middleNight: sunnahTimes!.middleOfTheNight, lastThirdNight: sunnahTimes!.lastThirdOfTheNight, currentPrayer: prayers!.time(for: prayers!.currentPrayer() ?? .isha), nextPrayer: prayers!.time(for: prayers!.nextPrayer() ?? .fajr))]
        
        
    }
}

class LocationDataManager : NSObject, ObservableObject, CLLocationManagerDelegate {
    
    var locationManager = CLLocationManager()
    var region = MKCoordinateRegion()
    
    @Published var authorizationStatus: CLAuthorizationStatus?
    
    
    override init() {
        super.init()
        locationManager.delegate = self
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .authorizedWhenInUse, .authorizedAlways:  // Location services are available.
            // Insert code here of what should happen when Location services are authorized
            authorizationStatus = .authorizedWhenInUse
            locationManager.requestLocation()
            region = MKCoordinateRegion(center: locationManager.location!.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.03, longitudeDelta: 0.03))
            
        case .restricted:  // Location services currently unavailable.
            // Insert code here of what should happen when Location services are NOT authorized
            authorizationStatus = .restricted
            
        case .denied:  // Location services currently unavailable.
            // Insert code here of what should happen when Location services are NOT authorized
            authorizationStatus = .denied
            
        case .notDetermined:        // Authorization not determined yet.
            authorizationStatus = .notDetermined
//            manager.requestWhenInUseAuthorization()
            
        default:
            break
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        // Insert code to handle location updates
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("error: \(error.localizedDescription)")
    }
    
    func openSettings() {
        guard let settingsURL = URL(string: UIApplication.openSettingsURLString) else { return }
        if UIApplication.shared.canOpenURL(settingsURL) { UIApplication.shared.open(settingsURL)}
    }
    
}

//// MARK: Get Location: latitude & longitude
//class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
//
//    let manager = CLLocationManager()
//
//    @Published var location: CLLocation?
//
//    @Published var placemark: CLPlacemark? {
//        willSet { objectWillChange.send() }
//    }
//
//    override init() {
//        super.init()
//        manager.delegate = self
//
//    }
//
//    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        guard let location = locations.last else { return }
//        self.location = location
//        self.geocode()
//    }
//
//    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
//        print("error:: \(error.localizedDescription)")
//    }
//
//    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
//        if status == .authorizedWhenInUse {
//            manager.requestLocation()
//        }
//    }
//
//    private func geocode() {
//        guard let location = self.location else { return }
//        location.placemark { placemark, error in
//
//            self.placemark = placemark!
//        }
//    }
//}


class NotificationManager : ObservableObject {
    
    @Published var notifications : [UNNotificationRequest] = []
    @Published var authorizationStatus : UNAuthorizationStatus?
    
    func reloadAuthorizationStatus() {
        UNUserNotificationCenter.current().getNotificationSettings { settings in
            DispatchQueue.main.async {
                self.authorizationStatus = settings.authorizationStatus
            }
        }
    }
    
    func requestAuthorization() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
            
            DispatchQueue.main.async {
                self.authorizationStatus = success ? .authorized : .denied
            }
        }
    }
    
    func reloadLocalNotifications() {
        print("reload Local Notifications")
        UNUserNotificationCenter.current().getPendingNotificationRequests { notifications in
            DispatchQueue.main.async {
                self.notifications = notifications
            }
        }
    }
    
    func createLocalNotification(title: String, body: String = "", subtitle: String = "", badge: NSNumber = 0, hour: Int, minute: Int, completion: @escaping (Error?) -> Void) {
        var dateComponents = DateComponents()
        dateComponents.hour = hour
        dateComponents.minute = minute
//        dateComponents.weekday = weekDay
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        
        let notificationContent = UNMutableNotificationContent()
        notificationContent.title = title
        notificationContent.sound = .defaultCritical
        notificationContent.body = body
        notificationContent.subtitle = subtitle
        notificationContent.badge = badge
        
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: notificationContent, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request, withCompletionHandler: completion)
        
    }
    
    func createLocalNotificationByLocation(latitude: Double, longitude: Double, exit: Bool, entry: Bool, radiusKm: Double, title: String, body: String, subtitle: String, badge: NSNumber = 0, completion: @escaping (Error?) -> Void) {
        
        let center = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        let region = CLCircularRegion(center: center, radius: radiusKm * 1000, identifier: UUID().uuidString)
        region.notifyOnEntry = entry
        region.notifyOnExit = exit
        let trigger = UNLocationNotificationTrigger(region: region, repeats: true)
        
        let notificationContent = UNMutableNotificationContent()
        notificationContent.title = title
        notificationContent.sound = .defaultCritical
        notificationContent.body = body
        notificationContent.subtitle = subtitle
        notificationContent.badge = badge
        
        let id = UUID().uuidString
        let request = UNNotificationRequest(identifier: id, content: notificationContent, trigger: trigger)

        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                // handle error
                print(error)
                
            }
        }
    }
    
    func createLocalNotificationByTimeInterval(title: String, body: String = "", subtitle: String = "", badge: NSNumber = 0, hour: Int, minute: Int, completion: @escaping (Error?) -> Void) {
        
        // The following time interval trigger example triggers the notification in 10 minutes from now.
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 10*60, repeats: false)
        
        let notificationContent = UNMutableNotificationContent()
        notificationContent.title = title
        notificationContent.sound = .defaultCritical
        notificationContent.body = body
        notificationContent.subtitle = subtitle
        notificationContent.badge = badge
        
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: notificationContent, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request, withCompletionHandler: completion)
    }
    
    func deleteLocalNotifications(identifiers: [String]) {
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: identifiers)
    }
}

class TrackingManager : ObservableObject {
    
    @Published var authorizationStatus: ATTrackingManager.AuthorizationStatus?
    
    static func getIDFA() -> String {
        return ASIdentifierManager.shared().advertisingIdentifier.uuidString
    }
    
    static func checkTrackingStatus(completionHandler: @escaping (ATTrackingManager.AuthorizationStatus) -> Void) {
        ATTrackingManager.requestTrackingAuthorization { status in
            DispatchQueue.main.async {
                completionHandler(status)
            }
        }
    }
    
    func requestPermission() {
        if #available(iOS 14, *) {
            ATTrackingManager.requestTrackingAuthorization { status in
                switch status {
                case .authorized:
                    // Tracking authorization dialog was shown
                    // and we are authorized
                    print("Authorized")
                    self.authorizationStatus = .authorized
                    // Now that we are authorized we can get the IDFA
                    print(ASIdentifierManager.shared().advertisingIdentifier)
                case .denied:
                    // Tracking authorization dialog was
                    // shown and permission is denied
                    self.authorizationStatus = .denied
                    print("Denied")
                case .notDetermined:
                    // Tracking authorization dialog has not been shown
                    self.authorizationStatus = .notDetermined
                    print("Not Determined")
                case .restricted:
                    self.authorizationStatus = .restricted
                    print("Restricted")
                @unknown default:
                    print("Unknown")
                }
            }
        }
    }
}
