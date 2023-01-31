//
//  SoundsSettingsView.swift
//  Sidra
//
//  Created by AHMED ASSIRY on 04/07/1444 AH.
//

import SwiftUI

struct SoundsSettingsView: View {
    
    @AppStorage("Continue_Playing_Audio_in_Background") var continuePlayAudioInBackground : Bool = true
    
    var body: some View {
        List{
            Section {
                Toggle("Continue Playing Audio in Background", isOn: $continuePlayAudioInBackground)
            }
        }
    }
}

struct SoundsSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SoundsSettingsView()
    }
}
