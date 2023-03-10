//
//  Calculator.swift
//  Calculator
//
//  Created by Developer on 11/08/2022.
//

import Foundation

struct Calculator {
    
    //private var newNumber: Decimal?
    private var carryingDecimal: Bool = false
    
    private var expression: ArithmeticExpression?
    private var result: Decimal?
    private var carryingNegative: Bool = false
    private var carryingZeroCount: Int = 0
    private var pressedClear: Bool = false

    
    
    // MARK: - Computed properties
    var displayText:String {
        return getNumberString(forNumber: number, withCommas: true)
    }
    /// Current displaying number
    var number: Decimal? {
            if pressedClear || carryingDecimal {
                return newNumber
            }
            return newNumber ?? expression?.number ?? result
        }
    private var newNumber: Decimal? {
        didSet {
            guard newNumber != nil else { return }
            carryingNegative = false
            carryingDecimal = false
            carryingZeroCount = 0
            pressedClear = false
            
        }
    }
    private var containsDecimal: Bool {
        return getNumberString(forNumber: number).contains(".")
    }
    var showAllClear: Bool {
            newNumber == nil && expression == nil && result == nil || pressedClear
        }
    // MARK: - Operations
    
    mutating func setDigit(_ digit:Digit) {
        if containsDecimal && digit == .zero {
            carryingZeroCount += 1
        } else if canAddDigit(digit) {
            let numberString = getNumberString(forNumber: newNumber)
            newNumber = Decimal(string: numberString.appending("\(digit.rawValue)"))
        }
        
    }
    mutating func setOperation(_ operation: ArithmeticOperation) {
        // 1.
        guard var number = newNumber ?? result else { return }
        // 2.
        if let existingExpression = expression {
            number = existingExpression.evaluate(with: number)
        }
        // 3.
        expression = ArithmeticExpression(number: number, operation: operation)
        // 4.
        newNumber = nil
    }
    
    mutating func toggleSign() {
        if let number = newNumber {
            newNumber = -number
            return
        }
        if let number = result {
            result = -number
            return
        }
        
        carryingNegative.toggle()
    }
    
    mutating func setPercent() {
        // 1.
        if let number = newNumber {
            // 2.
            newNumber = number / 100
            return
        }
        
        // 1.
        if let number = result {
            // 2.
            result = number / 100
            return
        }
    }
    
    mutating func setDecimal() {
        // 1.
        if containsDecimal { return }
        // 2.
        carryingDecimal = true
    }
    
    mutating func evaluate() {
        // 1.
        guard let number = newNumber, let expressionToEvaluate = expression else { return }
        // 2.
        result = expressionToEvaluate.evaluate(with: number)
        // 3.
        expression = nil
        newNumber = nil
    }
    
    mutating func allClear() {
        newNumber = nil
        expression = nil
        result = nil
        carryingNegative = false
        carryingDecimal = false
        carryingZeroCount = 0
    }
    
    mutating func clear() {
        newNumber = nil
        carryingNegative = false
        carryingDecimal = false
        carryingZeroCount = 0
        
        pressedClear = true
    }
    
    private struct ArithmeticExpression: Equatable {
        var number: Decimal
        var operation: ArithmeticOperation
        
        func evaluate(with secondNumber: Decimal) -> Decimal {
            switch operation {
            case .addition:
                return number + secondNumber
            case .subtraction:
                return number - secondNumber
            case .multiplication:
                return number * secondNumber
            case .division:
                return number / secondNumber
            case .sin:
                return number / secondNumber
            case .cos:
                return number / secondNumber
            case .tan:
                return number / secondNumber
            case .mod:
                return number / secondNumber
            case .sinh:
                return number / secondNumber
            case .cosh:
                return number / secondNumber
            case .tanh:
                return number / secondNumber
            case .Rand:
                return number / secondNumber
            case .EE:
                return number / secondNumber
            case .mr:
                return number / secondNumber
            case .Rad:
                return number / secondNumber
            case .mc:
                return number / secondNumber
            case .rest:
                return number / secondNumber
            }
            
        }
    }
    // MARK: - HELPERS
    private func getNumberString(forNumber number: Decimal?, withCommas: Bool = false) -> String {
        var numberString = (withCommas ? number?.formatted(.number) : number.map(String.init)) ?? "0"
        
        if carryingNegative {
            numberString.insert("-", at: numberString.startIndex)
        }
        
        if carryingDecimal {
            numberString.insert(".", at: numberString.endIndex)
        }
        
        // Add this
        if carryingZeroCount > 0 {
            numberString.append(String(repeating: "0", count: carryingZeroCount))
        }
        
        return numberString
    }
    
    private func canAddDigit(_ digit: Digit) -> Bool {
        return number != nil || digit != .zero
    }
    func operationIsHighlighted(_ operation: ArithmeticOperation) -> Bool {
        return expression?.operation == operation && newNumber == nil
    }
}
