//
//  ListNotificationView.swift
//  Sidra
//
//  Created by AHMED ASSIRY on 06/05/1444 AH.
//

import SwiftUI
import UserNotifications
import CoreLocation

struct ListNotificationView: View {
    
    @StateObject private var notificationManager = NotificationManager()
    @State private var isShowPage = false
    
    private static var notificationDateFormatter : DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = .short
        return dateFormatter
    }()
    
    private func timeDisplayText(from notifaction: UNNotificationRequest) -> String {
        guard let nextTriggerDate = (notifaction.trigger as? UNCalendarNotificationTrigger)?.nextTriggerDate() else
        { return ""}
        return Self.notificationDateFormatter.string(from: nextTriggerDate)
    }
    
    @ViewBuilder
    var displayCaseNotifcations : some View {
        switch notificationManager.authorizationStatus {
        case .authorized:
            if notificationManager.notifications.isEmpty {
                InfOverlayView(
                    infoMessage: "No notificans",
                    buttonTitle: "Create",
                    systemImageName: "plus.circle") {
                        isShowPage = true
                }
            }
            
        case .denied:
            InfOverlayView(infoMessage: "Please Enable Notification Permisson In Settings", buttonTitle: "Settings", systemImageName: "gear") {
                guard let settingsURL = URL(string: UIApplication.openSettingsURLString) else { return }
                if UIApplication.shared.canOpenURL(settingsURL) { UIApplication.shared.open(settingsURL)}
            }
            
        default:
            EmptyView()
        }
    }
    var body: some View {
        
        List {
            ForEach(notificationManager.notifications, id: \.identifier) { notification in
                HStack {
                    Text(notification.content.title)
                        .fontWeight(.semibold)
                    
                    Spacer()
                    
                    Text(timeDisplayText(from: notification))
                        .fontWeight(.semibold)
                }
                
            }
            .onDelete(perform: delete)
        }
        .navigationTitle("Notification")
        .overlay(displayCaseNotifcations)
        .listStyle(InsetGroupedListStyle())
        .onAppear(perform: notificationManager.reloadAuthorizationStatus)
        .onChange(of: notificationManager.authorizationStatus) { authorizationStatus in
            switch authorizationStatus {
            case .notDetermined:
                // Request authorization
                notificationManager.requestAuthorization()
            case .authorized:
                // Get local Notifications
                notificationManager.reloadLocalNotifications()
                
            default:
                break
            }
        }
        .onReceive(NotificationCenter.default.publisher(for: UIApplication.willEnterForegroundNotification)) { _ in
            notificationManager.reloadAuthorizationStatus()
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    
                    isShowPage = true
                    
                } label: {
                    
                    Image(systemName: "plus.circle")
                        .imageScale(.large)
                    
                }
            }
        }
        .sheet(isPresented: $isShowPage) {
            CreateNotificationView(
                notificationManager: notificationManager,
                isPresented: $isShowPage
            )
        }
    }
    
    func InfOverlayView(infoMessage: String, buttonTitle: String, systemImageName: String, action: @escaping () -> Void) -> some View {
        VStack {
            Text(infoMessage)
                .fontWeight(.semibold)
                .frame(maxWidth: .infinity)
                .multilineTextAlignment(.center)
            
            Button {
                
                action()
                
            }label: {
                
                Label(buttonTitle, systemImage: systemImageName)
                    .padding()
            }
            .background(Color(.systemGray5))
            .cornerRadius(8)
            
        }
    }
}

extension ListNotificationView {
    func delete(_ indexSet: IndexSet) {
        notificationManager.deleteLocalNotifications(identifiers: indexSet.map { notificationManager.notifications[$0].identifier })
        notificationManager.reloadLocalNotifications()
        
    }
    
}

struct ListNotificationView_Previews: PreviewProvider {
    static var previews: some View {
        ListNotificationView()
    }
}




