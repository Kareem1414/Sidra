//
//  TaskViewModel.swift
//  Sidra
//
//  Created by AHMED ASSIRY on 21/02/1444 AH.
//

import SwiftUI
import HealthKit
import Contacts
import LocalAuthentication

class TaskViewModel: ObservableObject {
    
    // MARK: Current Week Days
    @Published var currentWeek : [Date] = []
    
    // MARK: Current Hijri Week Days
    @Published var currentHijriWeek : [Date] = []
    
    // MARK: Current Day
    @Published var currentDay : Date = Date()
    
    // MARK: Filtering Today Tasks
    @Published var filteredTasks : [Task]?
    
    // MARK: New Task View
    @Published var addNewTask : Bool = false
    
    // MARK: Edit Data
    @Published var editTask : Task?
    
    
    
    init(){
        fetchCurrentWeek()
    }
    
    
    func fetchCurrentWeek() {
        
        let today = Date()
        let calendar = Calendar.current
        //        calendar.firstWeekday = -1
        
        let week = calendar.dateInterval(of: .weekOfMonth, for: today)
        
        guard let firstWeekDay = week?.start else {
            return
        }
        
        (0...6).forEach { day in
            
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
        
        (0...6).forEach { day in
            
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
    
    // MARK: Checking if the currentHour is task Hour
    func isCurrentHour(date: Date) -> Bool {
        
        let calendar = Calendar.current
        
        let hour = calendar.component(.hour, from: date)
        let currentHour = calendar.component(.hour, from: Date())
        
        let isToday = calendar.isDateInToday(date)
        
        return (hour == currentHour && isToday)
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
    @Published var permissionsError: PermissionsError? = .none
    
    init() {
        permissions()
    }
    
    func openSettings() {
        permissionsError = .none
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
            case .failure(let error):
                self.permissionsError = .fetchError(error)
            }
        }
    }
    
    private func permissions() {
        switch CNContactStore.authorizationStatus(for: .contacts) {
        case .authorized:
            getContacts()
        case .notDetermined, .restricted, .denied :
            CNContactStore().requestAccess(for: .contacts) { [weak self] granted, error in
                guard let self = self else { return }
                switch granted {
                case true:
                    self.getContacts()
                case false:
                    DispatchQueue.main.async {
                        self.permissionsError = .userError
                    }
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
