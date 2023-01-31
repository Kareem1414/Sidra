//
//  CreateNotificationView.swift
//  Sidra
//
//  Created by AHMED ASSIRY on 06/05/1444 AH.
//

import SwiftUI

struct CreateNotificationView: View {
    
    @ObservedObject var notificationManager : NotificationManager
    
    @State private var title = ""
    @State private var date = Date()
    @State private var Nbody = ""
    @State private var badge : NSNumber = 0
    @Binding var isPresented : Bool
    
    var body: some View {
        
        VStack {
            
            
            List {
                Section {
                    VStack {
                        HStack {
                            TextField("Notification Title", text: $title)
                            Spacer()
                            DatePicker("", selection: $date, displayedComponents: [.hourAndMinute])
                        }
                        TextField("Notification Body", text: $Nbody)
                        
                        TextField("Notification Badge", value: $badge, formatter: NumberFormatter())
                            .keyboardType(.numberPad)
                        
                        
                        
                    }
                }
            }
            .listStyle(InsetGroupedListStyle())
            .onDisappear {
                notificationManager.reloadLocalNotifications()
            }
            .navigationTitle("Create")
            
            
            Button {
                notificationManager.createLocalNotificationByLocation(latitude: 24.848807, longitude: 46.800808, exit: true, entry: false, radiusKm: 1, title: "You exit from home zone", body: "Good Job Assiry", subtitle: "Continue") {  Error in
                    print("\(String(describing: Error))")
                }
            } label: {
                Text("Create location exit")
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity)
                    .padding()
            }
            
            Spacer()
            
            Button {
                
                let dateComponents = Calendar.current.dateComponents([.hour, .minute], from: date)
                guard let hour = dateComponents.hour, let minute = dateComponents.minute else { return }
                        
                notificationManager.createLocalNotification(title: title, subtitle: Nbody, badge: badge, hour: hour, minute: minute) { error in
                    if error == nil {
                        DispatchQueue.main.async {
                            self.isPresented = false
                        }
                    }
                    
                }
                
            } label: {
                Text("Create")
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity)
                    .padding()
            }
            .background(Color(.systemGray5))
            .buttonStyle(PlainButtonStyle())
            .disabled(title.isEmpty)
            .cornerRadius(8)
            .padding()
            
            
            
            
        }
        
    }
}

struct CreateNotificationView_Previews: PreviewProvider {
    static var previews: some View {
        CreateNotificationView(notificationManager: NotificationManager(), isPresented: .constant(false))
    }
}
