//
//  CalculatorViewModel.swift
//  Calculator
//
//  Created by Developer on 11/08/2022.
//

import Foundation
import Combine
extension CalculatorView {
final class CalculatorViewModel: ObservableObject {
        
        // MARK: - PROPERTIES
        
        @Published private var calculator = Calculator()
        
        var displayText: String {
            return calculator.displayText
        }
        
    var buttonTypes: [[ButtonType]] {
                let clearType: ButtonType = calculator.showAllClear ? .allClear : .clear
                return [
                    
                    [.operation(.rest), .operation(.mr), .operation(.sinh), .operation(.cosh), .operation(.tanh), .operation(.EE)],
                    [.operation(.division), .operation(.Rand), .operation(.sin), .percent, .negative, clearType],
                    [.operation(.multiplication), .operation(.Rad), .operation(.cos), .digit(.nine), .digit(.eight), .digit(.seven)],
                    [.operation(.subtraction), .operation(.EE), .operation(.tan), .digit(.six), .digit(.five), .digit(.four)],
                    [.operation(.addition), .operation(.mc), .operation(.mod), .digit(.three), .digit(.two), .digit(.one)],
                    [.equals, .decimal, .digit(.zero)],
                    
                ]
            }
        
        // MARK: - ACTIONS
        
        func performAction(for buttonType: ButtonType) {
            switch buttonType {
            case .digit(let digit):
                calculator.setDigit(digit)
            case .operation(let operation):
                calculator.setOperation(operation)
            case .negative:
                calculator.toggleSign()
            case .percent:
                calculator.setPercent()
            case .decimal:
                calculator.setDecimal()
            case .equals:
                calculator.evaluate()
            case .allClear:
                calculator.allClear()
            case .clear:
                calculator.clear()
            }
        }
    // MARK: - HELPERS
           func buttonTypeIsHighlighted(buttonType: ButtonType) -> Bool {
               guard case .operation(let operation) = buttonType else { return false}
               return calculator.operationIsHighlighted(operation)
           }
    }
}
