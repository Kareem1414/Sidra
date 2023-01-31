//
//  ContentView.swift
//  Sidra
//
//  Created by AHMED ASSIRY on 21/02/1444 AH.
//

import SwiftUI

struct ContentView: View {
    
    @AppStorage("log_status") var logStatus : Bool = false
    @AppStorage("colorkey") var storedColor: Color = .red
    
    var body: some View {
        ZStack {
            if logStatus {
                HomeView()
                
            } else {
                WelcomeView()
                
            }
        }
        .animation(.easeInOut(duration: 0.5).delay(0.5), value: logStatus)
        .tint(storedColor)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
