//
//  CalendarSettingsView.swift
//  Sidra
//
//  Created by AHMED ASSIRY on 17/05/1444 AH.
//

import SwiftUI

struct CalendarSettingsView: View {
    
    var days = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"]
    
    @State private var selectedDays = "Sunday"
    
    @State private var startTime = Date.now
    
    @State private var mainCalendar = 0
    
    @State private var timingSystem = 0
    
//    @AppStorage("official_Calendar") var officialCalendar : Calendar
    
    @AppStorage("display_days_home") var displayDaysHome: Int = 6
    @AppStorage("display_sub_calendar_home") var displaySubCalendarHome: Bool = true
    
    var body: some View {
        
        List {
            
            Section {
                
                HStack {
                    NavigationLink(destination: mainCalendarFunc()) {
                        Text("Main calendar")
                    }
                }
                
                Toggle("Sub calendar", isOn: $displaySubCalendarHome)
                
                if displaySubCalendarHome {
                    NavigationLink(destination: mainCalendarFunc()) {
                        Text("Sub calendar")
                    }
                }
                
                
                HStack {
                    Text("Timing system")
                    
                    Spacer()
                    
                    Picker("What is your favorite color?", selection: $timingSystem) {
                        Text("12 Hour").tag(0)
                        Text("24 Hour").tag(1)
                    }
                    .pickerStyle(.segmented)
                    .frame(width: 180)
                }
                
                HStack {
                    Text("First day of week")
                    
                    Spacer()
                    
                    
                    Menu(NSLocalizedString(selectedDays, comment: "")) {
                        
                        ForEach(days, id: \.self) { day in
                            
                            Button {
                                
                                selectedDays = day
                                selectedDaysFunc(day: day)
                                
                            } label: {
                                
                                Text(NSLocalizedString(day, comment: ""))
                                
                            }
                        }
                    }
                }
                
                HStack {
                    
                    Text("Weekend days")
                    
                    Spacer()
                    
                    Menu(NSLocalizedString(selectedDays, comment: "")) {
                        
                        ForEach(days, id: \.self) { day in
                            
                            Button {
                                
                                selectedDays = day
                                selectedDaysFunc(day: day)
                                
                            } label: {
                                
                                Text(NSLocalizedString(day, comment: ""))
                                
                            }
                        }
                    }
                }
                
                Text("Rotation Schedule")
                
                DatePicker(selection: $startTime, in: ...Date.now, displayedComponents: .hourAndMinute) {
                    Text("Default Start Time")
                }
                
            }
            
            Section(footer: Text("Choose how many days to display on the home page.").foregroundColor(.gray)) {
                HStack {
                    
                    Stepper("\(displayDaysHome + 1) Days", value: $displayDaysHome, in: 6...30)
                    
                }
            }
        }
        .foregroundColor(Color.primary)
        .animation(.default, value: displaySubCalendarHome)
        
    }
    
    func mainCalendarFunc() -> some View {
        List {
            Text("gregorian")
            Text("buddhist")
            Text("chinese")
            Text("ethiopicAmeteMihret")
            Text("ethiopicAmeteAlem")
            Text("hebrew")
            Text("indian")
        }
    }
    
    func selectedDaysFunc(day: String) {
        
        print(day)
    }
    
    
}

struct CalendarSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        CalendarSettingsView()
    }
}
