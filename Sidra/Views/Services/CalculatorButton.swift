//
//  CalculatorButton.swift
//  Calculator
//
//  Created by Developer on 10/08/2022.
//

import Foundation
import SwiftUI
extension CalculatorView {
    struct CalculatorButton: View {
        
        let buttonType: ButtonType
        @StateObject private var calculatorViewModel: CalculatorViewModel = CalculatorViewModel()
        
        var body: some View {
            Button(buttonType.description) {
                calculatorViewModel.performAction(for: buttonType)
            }
            .buttonStyle(CalculatorButtonStyle(
                size: getButtonSize(), // <- We'll calculate in the next step
                backgroundColor: getBackgroundColor(),
                foregroundColor: getForegroundColor(),
                isWide: buttonType == .digit(.zero),
                fontSize: buttonType.fontSize)
            )
        }
        private func getBackgroundColor() -> Color {
            return calculatorViewModel.buttonTypeIsHighlighted(buttonType: buttonType) ? buttonType.foregroundColor : buttonType.backgroundColor
        }
        
        private func getForegroundColor() -> Color {
            return calculatorViewModel.buttonTypeIsHighlighted(buttonType: buttonType) ? buttonType.backgroundColor : buttonType.foregroundColor
        }
        private func getButtonSize() -> CGFloat {
            let screenWidth = UIScreen.main.bounds.width
            let buttonCount: CGFloat = 6.0
            let spacingCount = buttonCount + 1
            return (screenWidth - (spacingCount * Constants.padding)) / buttonCount
        }
    }
}
