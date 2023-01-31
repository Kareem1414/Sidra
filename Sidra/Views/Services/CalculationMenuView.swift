//
//  CalculationMenuView.swift
//  Sidra
//
//  Created by AHMED ASSIRY on 08/07/1444 AH.
//

import SwiftUI

struct CalculationMenuView: View {
    var body: some View {
        List {
            NavigationLink(destination: CalculatorView()) {
                HStack(spacing: 16) {
                    Image(systemName: "apps.iphone")
                    Text("Scientific calculator")
                }
                .padding(.vertical, 8)
                
                
            }
            
            NavigationLink(destination: GPACalculateView()) {
                HStack(spacing: 16) {
                    Image(systemName: "square.stack.3d.up.badge.a")
                    Text("Grade Point Average - GPA")
                }
                .padding(.vertical, 8)
            }
        }
    }
}

struct CalculationMenuView_Previews: PreviewProvider {
    static var previews: some View {
        CalculationMenuView()
    }
}
