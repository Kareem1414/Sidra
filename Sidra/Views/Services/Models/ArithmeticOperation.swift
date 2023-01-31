//
//  ArithmeticOperation.swift
//  Calculator
//
//  Created by Developer on 10/08/2022.
//

import Foundation

enum ArithmeticOperation: CaseIterable, CustomStringConvertible {
    case addition, subtraction, multiplication, division, sin, sinh, cos, cosh, tan, tanh, mod, Rand, EE, mr, Rad, mc, rest
    
    var description: String {
        switch self {
        case .addition:
            return "+"
        case .subtraction:
            return "−"
        case .multiplication:
            return "×"
        case .division:
            return "÷"
        case .sin:
            return "sin"
        case .cos:
            return "cos"
        case .tan:
            return "tan"
        case .mod:
            return "mod"
        case .Rand:
            return "Rand"
        case .sinh:
            return "sin"
        case .cosh:
            return "cosh"
        case .tanh:
            return "tanh"
        case .EE:
            return "EE"
        case .mr:
            return "mr"
        case .Rad:
            return "Rad"
        case .mc:
            return "mc"
        case .rest:
            return "%"
        }
    }
}
