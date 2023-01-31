//
//  AdvancedView.swift
//  Sidra
//
//  Created by AHMED ASSIRY on 03/03/1444 AH.
//

import SwiftUI

struct AdvancedView: View {
    
    @State var showAMPM : Bool = false
    
    @State private var showingOptions = false
    @State private var selection = "None"
    
    var body: some View {
        List{
            Section {
                Toggle("Show AM / PM", isOn: $showAMPM)
                Text("Count to Next Prayer after")
                Text("Number of upcoming days")
                Text("Calculation methods")
                
                Text("App Badge")
                
                Text("Open app settings in system")
                
            }
            
            Section(footer: Text("Your data backup is automatically stored in iCloud Drive, so you can reset the app to a previous state if something goes wrong. We do not store any data in our servers, all your data is stored in your iCloud.").foregroundColor(.gray)) {
                NavigationLink(destination: CloudView()) {
                    Label( "iCloud", systemImage: "externaldrive.badge.icloud")
                }
            }
            
            Section(footer: Text("This will erase all your data and settings on all your devices, you can't go back...!").foregroundColor(.gray)) {
                Label("Reset the App", systemImage: "trash")
                    .foregroundColor(.red)
                    .font(.system(size: 17).bold())
                    .onTapGesture {
                        showingOptions = true
                        UIImpactFeedbackGenerator(style: .heavy).impactOccurred()
                    }
                    .confirmationDialog("This will erase all your data and settings on all your devices, you can't go back...!", isPresented: $showingOptions, titleVisibility: .visible) {
                        Button("Red") {
                            selection = "Red"
                            
                        }
                        
                    }
                
            }
        }
        .foregroundColor(Color.primary)
    }
}

struct AdvancedView_Previews: PreviewProvider {
    static var previews: some View {
        AdvancedView()
    }
}
