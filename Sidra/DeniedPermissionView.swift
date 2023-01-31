//
//  DeniedPermissionView.swift
//  Sidra
//
//  Created by AHMED ASSIRY on 02/07/1444 AH.
//

import SwiftUI

struct DeniedPermissionView: View {
    
    @State var message : String
    
    @AppStorage("colorkey") var storedColor: Color = .black
    
    var body: some View {
        VStack {
            LottieView(animationName: "14",
                       contentMode: .scaleAspectFill)
            .frame(width: 250, height: 250)
            .padding(.top, 40)
            
            Text(message)
                .padding(.horizontal)
                .multilineTextAlignment(.center)
            
            Spacer()
            
            Button {
                guard let settingsURL = URL(string: UIApplication.openSettingsURLString) else { return }
                if UIApplication.shared.canOpenURL(settingsURL) { UIApplication.shared.open(settingsURL)}
            } label: {
                Text("Settings")
                    .bold()
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(storedColor)
                    .cornerRadius(8)
                    .padding(.horizontal, 40)
            }
        }
        
    }
}

struct DeniedPermissionView_Previews: PreviewProvider {
    static var previews: some View {
        DeniedPermissionView(message: "")
    }
}
