//
//  FitnessSettingsView.swift
//  Sidra
//
//  Created by AHMED ASSIRY on 04/07/1444 AH.
//

import SwiftUI

struct FitnessSettingsView: View {
    
    @AppStorage("Move_fitness") var move : Int = 0
    @AppStorage("Exercise_fitness") var exercise : Int = 0
    @AppStorage("Stand_fitness") var stand : Int = 0
    
    var body: some View {
        List {
            Section(header: Text("Move")) {
                Stepper("\(move)  Calories", value: $move, in: 0...2000)
                    .fontWeight(.semibold)
                    .padding(.vertical, 4)
                    .foregroundColor(.red)
            }
            
            Section(header: Text("Exercise")) {
                Stepper("\(exercise)  \(exercise < 2 ? "Minute" : "Minutes")", value: $exercise, in: 0...2000)
                    .fontWeight(.semibold)
                    .padding(.vertical, 4)
                    .foregroundColor(.green)
            }
            
            Section(header: Text("Stand")) {
                Stepper("\(stand)  \(stand < 2 ? "Hour" : "Hours")", value: $stand, in: 0...2000)
                    .fontWeight(.semibold)
                    .padding(.vertical, 4)
                    .foregroundColor(.cyan)
            }
        }
    }
    
}

struct FitnessSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        FitnessSettingsView()
    }
}
