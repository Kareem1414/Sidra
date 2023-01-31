//
//  ProfileView.swift
//  Sidra
//
//  Created by AHMED ASSIRY on 23/05/1444 AH.
//

import SwiftUI

struct ProfileView: View {
    
    @AppStorage("log_status") var logStatus : Bool = false
    
    var body: some View {
        Section {
            
            Button {
                withAnimation {
                    logStatus = false
                }
                
                
            } label: {
                Label("Sign out", systemImage: "tray.and.arrow.up")
            }
            .foregroundColor(.red)
            .frame(height: 40)
            
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
