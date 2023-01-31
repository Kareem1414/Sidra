//
//  SidraApp.swift
//  Sidra
//
//  Created by AHMED ASSIRY on 21/02/1444 AH.
//

import SwiftUI

@main
struct SidraApp: App {
    
    let persistenceController = PersistenceController.shared
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
