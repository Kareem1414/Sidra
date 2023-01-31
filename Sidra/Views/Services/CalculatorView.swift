//
//  CalculatorView.swift
//  Calculator
//
//  Created by Developer on 10/08/2022.
//

import SwiftUI


struct CalculatorView: View {
    
    @StateObject private var calculatorViewModel: CalculatorViewModel = CalculatorViewModel()
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var btnBack : some View {
        
        Button {
            self.presentationMode.wrappedValue.dismiss()
        } label: {
            Image(systemName: "arrow.left.circle.fill")
                    .foregroundColor(.orange)
//                    .padding(8)
        }
    }

    var body: some View {
        VStack {
            Spacer()
            displayText
                
            buttonPad
               
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: btnBack)
        .padding(Constants.padding)
        .background(Color(UIColor.secondarySystemBackground))
        
    }
}

struct CalculatorView_Previews: PreviewProvider {
    static var previews: some View {
        CalculatorView()
            
            
    }
}

extension CalculatorView {
    private var displayText: some View {
        Text(calculatorViewModel.displayText)
            .padding()
            .foregroundColor(.primary)
            .frame(maxWidth: .infinity, alignment:.leading)
            .font(.system(size: 56, weight:.light))
            .lineLimit(1)
            .minimumScaleFactor(0.2)

    }
        
    private var buttonPad:some View {
        VStack(spacing:Constants.padding) {
            ForEach (calculatorViewModel.buttonTypes,id: \.self) { row in
                HStack(spacing:Constants.padding) {
                    ForEach (row,id: \.self) { buttonType in
                        CalculatorButton(buttonType: buttonType)
                    }
                }
            }
        }
    }
}
