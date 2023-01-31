//
//  NotificationsView.swift
//  Sidra
//
//  Created by AHMED ASSIRY on 14/03/1444 AH.
//

import SwiftUI

struct NotificationsView: View {
    
    @State private var islamicTimes = true
    
    
    @State  var prayerTimes = true
    @State  var Morn = true
    @State  var MorningRemembrance = true
    @State  var EveningRemembrance = true
    
    var body: some View {
        List {
            
            Section(footer: Text("Ahmedsfas sdfgsdafg")) {
                HStack {
//                    Image(systemName: "bell.badge.fill")
//                        .font(.largeTitle)
//                        .padding(.trailing, 8)
                    
                    Text("It's angering that such an important change (because otherwise your list will be floating over a white background is so out of context to access. Can also be used like: List.onAppear")
                        .foregroundColor(.gray)
                }
                
                HStack(spacing: 16) {
                    Image(systemName: "bell.and.waves.left.and.right")
                    Toggle("Notifications", isOn: $islamicTimes)
                }
                
                
            }
            
            Section {
                
                Toggle(isOn: $islamicTimes) {
                    Text("Islamic Times")
                }
                
                if islamicTimes {
                    withAnimation {
                        NavigationLink(destination: IslamicTimesFunc()) {
                            Text("More")
                        }
                    }
                    
                }
                
            }
            
            Section {
                Toggle(isOn: $Morn) {
                    Text("Reminder")
                }
            }
            
            Section {
                NavigationLink(destination: ListNotificationView()) {
                    Text("Scheduled Notifications")
                }
            }
            
        }
        .foregroundColor(.primary)
    }
    
    func IslamicTimesFunc() -> some View {
        
        List {
            Section {
                Toggle(isOn: $prayerTimes) {
                    Text("Prayer Times")
                }
            }
            
            Section {
                Toggle(isOn: $Morn) {
                    Text("Morn")
                }
            }
            
            Section {
                Toggle(isOn: $MorningRemembrance) {
                    Text("Morning Remembrance")
                }
            }
        }
    }
    
}

struct NotificationsView_Previews: PreviewProvider {
    static var previews: some View {
        NotificationsView()
    }
}
