//
//  CalculatorButtonStyle.swift
//  Calculator
//
//  Created by Developer on 10/08/2022.
//

import Foundation
import SwiftUI

struct CalculatorButtonStyle: ButtonStyle {
    
    var size: CGFloat
    var backgroundColor: Color
    var foregroundColor: Color
    var isWide: Bool = false
    var fontSize : CGFloat
    
    func makeBody(configuration: Configuration) -> some View {
            configuration.label
                .font(.system(size: fontSize, weight: .medium))
                .frame(width: size, height: size / 1.5)
                .frame(maxWidth: isWide ? .infinity : size)
                .background(backgroundColor)
                .foregroundColor(foregroundColor)
                .overlay {
                    if configuration.isPressed {
                        Color(white: 1.0, opacity: 0.2)
                    }
                }
                .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
//                .animation(.easeInOut(duration: 2), value: configuration.isPressed)
    }
}
struct CalculatorButtonStyle_Previews: PreviewProvider {
    static let buttonType: ButtonType = .digit(.five)
    
    static var previews: some View {
        Button(buttonType.description) { }
            .buttonStyle(CalculatorButtonStyle(
                size: 80,
                backgroundColor: buttonType.backgroundColor,
                foregroundColor: buttonType.foregroundColor,
                fontSize: buttonType.fontSize)
                         
            )
    }
}
