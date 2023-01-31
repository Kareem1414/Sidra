//
//  StudentsView.swift
//  Sidra
//
//  Created by AHMED ASSIRY on 06/07/1444 AH.
//

import SwiftUI

struct StudentSettingsView: View {
    
    @AppStorage("name_university") var nameUniversity: String = "King Saud University"
    @AppStorage("rate_system_university") var rateSystemUniversity: Bool = true
    
    @AppStorage("active_university_schedule") var activeUniversitySchedule: Bool = false
    
    @AppStorage("lecture_duration") var lectureDuration: Int = 45
    @AppStorage("break_duration") var breakDuration: Int = 10
    
    var body: some View {
        List {
            
            Section {
                Toggle("Student Schedule", isOn: $activeUniversitySchedule)
            }
            
            if activeUniversitySchedule {
                
                Section {
                    HStack {
                        
                        Text("University")
                        
                        Spacer()
                        
                        Menu("\(nameUniversity)") {
                            Menu("Central") {
                                Button("King Saud University", action: actionX)
                                Button("Princess Nora bint Abdul Rahman University", action: actionX)
                                Button("Imam Muhammad bin Saud Islamic University", action: actionX)
                                Button("Prince Sultan University", action: actionX)
                                Button("College of Telecom & Information", action: actionX)
                                Button("Arab Open University", action: actionX)
                                Button("Riyadh College of Dentistry and Pharmacy", action: actionX)
                                Button("Dar Al Uloom University", action: actionX)
                                Button("Al Yamamah University", action: actionX)
                                Button("King Saud bin Abdulaziz University for Health Sciences", action: actionX)
                            }
                            Menu("Eastern") {
                                Button("King Fahd University for Petroleum and Minerals", action: actionX)
                                Button("Imam Abdulrahman Bin Faisal University", action: actionX)
                                Button("Dammam Community College", action: actionX)
                                Button("Jubail Technical Institute", action: actionX)
                                Button("Imam Abdulrahman Bin Faisal University", action: actionX)
                                Button("Qatif College of Technology", action: actionX)
                                Button("Prince Mohammad University", action: actionX)
                            }
                            Menu("Western") {
                                Button("Rename", action: actionX)
                                Button("Delay", action: actionX)
                            }
                            
                            Menu("Northern") {
                                Button("Northern Borders University", action: actionX)
                                Button("Tabuk University", action: actionX)
                                Button("Fahd bin Sultan University", action: actionX)
                            }
                            
                            Menu("Southern") {
                                Button("King Khalid University", action: actionX)
                                Button("IBN Rushd College for Management Sciences", action: actionX)
                                Button("Jazan University", action: actionX)
                                Button("Al Baha University", action: actionX)
                                Button("Najran University", action: actionX)
                                Button("Al Baha University", action: actionX)
                            }
                        }
                    }
                    
                    HStack {
                        Text("Rate system")
                        
                        Spacer()
                        
                        Menu("\(rateSystemUniversity ? 5 : 4)") {
                            
                            Button("5", action: actionX)
                            Button("4", action: actionX)
                            
                        }
                    }
                }
                
                Section {
                    HStack {
                        Text("Lecture Duration")
                        Spacer()
                        Text("\(lectureDuration) Min")
                    }
                    
                    HStack {
                        Text("Break Duration")
                        Spacer()
                        Text("\(breakDuration) Min")
                    }
                    
                }
                
            }
            
        }
        .animation(.easeInOut(duration: 1), value: activeUniversitySchedule)
    }
    
    func actionX() {
        
    }
}

struct StudentsView_Previews: PreviewProvider {
    static var previews: some View {
        StudentSettingsView()
    }
}
