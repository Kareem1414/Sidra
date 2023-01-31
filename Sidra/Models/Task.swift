//
//  Task.swift
//  Sidra
//
//  Created by AHMED ASSIRY on 21/02/1444 AH.
//

import SwiftUI
import Contacts
import Adhan

// Task Model
struct Tasks: Identifiable {
    
    var id = UUID().uuidString
    var taskTitle: String
    var taskNotes: String
    var taskDate: Date
    var taskNotification: Date
    var taskLabel: String
    var taskLocation: Double
    var taskIsCompleted: Bool
    
}

// Prayer Times
struct PrayerTimesItems : Identifiable {
    
    var id = UUID()
    
    var fajr : Date
    var sunrise : Date
    var dhuhr : Date
    var asr : Date
    var maghrib : Date
    var isha : Date
    
    var middleNight : Date
    var lastThirdNight : Date
    
    var currentPrayer : Date
    var nextPrayer : Date
    
}


// Steps Model
struct StepsModel: Identifiable {
    
    let id = UUID()
    let count: Int
    let startDate: Date
    let endDate: Date
    
}

// Heart Rate Model
struct HeartRateModel: Identifiable {
    
    let id = UUID()
    let heartRate: Double
    let quantityType : String
    let startDate: Date
    let endDate: Date
    let metaData : String
    let source : String
    let device : String
    
}

// Date Value Model
struct DateValue : Identifiable {
    var id = UUID().uuidString
    var day : Int
    var date : Date
}

// Contact Model
struct Contact: Identifiable {
    
    var id : String { contact.identifier }
    var firstName: String { contact.givenName }
    var middleName: String { contact.middleName }
    var lastName: String { contact.familyName }
    var phoneNumber: String? { contact.phoneNumbers.map(\.value).first?.stringValue}
//    var email: String? { contact.emailAddresses.map(\.value).first?.stringValue}
    var birthday : DateComponents? { contact.birthday }
    var imageData : Data? { contact.imageData }
    
//    var departmentName: String
//    var identifier : String
//    var jobTitle : String

//    var nickname : String
//    var organizationName : String
    
//    var postalAddresses : [CNLabeledValue<CNPostalAddress>]
//    var socialProfiles : [CNLabeledValue<CNSocialProfile>]
//    var urlAddresses : [CNLabeledValue<NSString>]
    
    let contact: CNContact
    
    
    static func fetchAll(_ completion: @escaping(Result<[Contact], Error>) -> Void) {
        let containerID = CNContactStore().defaultContainerIdentifier()
        let predicate = CNContact.predicateForContactsInContainer(withIdentifier: containerID)
        let descriptor = [
            CNContactIdentifierKey,
            CNContactGivenNameKey,
            CNContactMiddleNameKey,
            CNContactFamilyNameKey,
            CNContactPhoneNumbersKey,
            CNContactBirthdayKey,
            CNContactImageDataKey
            ]
        as [CNKeyDescriptor]
        
        do {
            let rawContacts = try CNContactStore().unifiedContacts(matching: predicate, keysToFetch: descriptor)
            completion(.success(rawContacts.map {.init(contact: $0)}))
        } catch {
            completion(.failure(error))
        }
    }
}


enum PermissionsError: Identifiable {
    var id: String { UUID().uuidString }
    case userError
case fetchError(_: Error)
    var description: String {
        switch self {
        case .userError:
            return "Please change permissions in settings."
        case .fetchError(let error):
            return error.localizedDescription
        }
    }
}


// MARK: Album Model and Sample Data
struct Album: Identifiable {
    var id = UUID().uuidString
    var albumName : String
    var albumImage : String
    var isLiked : Bool = false
}


var albums: [Album] = [
    
    Album(albumName: "Positons", albumImage: "Image3"),
    Album(albumName: "The Best", albumImage: "Image3"),
    Album(albumName: "My Everything", albumImage: "Image5"),
    Album(albumName: "Yours Truly", albumImage: "Image1"),
    Album(albumName: "Sweetener", albumImage: "Image3"),
    Album(albumName: "Rain On Me", albumImage: "Image3"),
    Album(albumName: "Stuck With U", albumImage: "Image4", isLiked: true),
    Album(albumName: "Bang Bang", albumImage: "Image1"),
    Album(albumName: "Sweetener", albumImage: "Image3"),
    Album(albumName: "Rain On Me", albumImage: "Image3"),
    Album(albumName: "Stuck With U", albumImage: "Image5", isLiked: true),
    Album(albumName: "Bang Bang", albumImage: "Image1"),
    Album(albumName: "Sweetener", albumImage: "Image3"),
    Album(albumName: "Rain On Me", albumImage: "Image3"),
    Album(albumName: "Stuck With U", albumImage: "Image4", isLiked: true),
    Album(albumName: "Bang Bang", albumImage: "Image1")
    
]
