//
//  OTPView.swift
//  Sidra
//
//  Created by AHMED ASSIRY on 30/02/1444 AH.
//

import SwiftUI

struct OTPView: View {
    
    @StateObject var otpModel: OTPViewModel = .init()
    
    // MARK: TextField FocusState
    @FocusState var activeField: OTPField?
    
    @State private var timeRemaining = 59
    @State var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @State private var isActive = false
    
    // Hide and show Keyboard
    @FocusState private var keyboardFocused: Bool
    
    var body: some View {
        
        VStack {
            
            OTPField()
                .padding()
            
            Text("00:\(String(format: "%02d", timeRemaining))")
                .font(.system(size: 24)).bold()
                .foregroundColor(.gray.opacity(0.5))
                .padding(.top, 32)
            
            Spacer()
            
            HStack(spacing: 12) {
                Text("Didn't get OTP?")
                    .foregroundColor(.gray)
                
                Button("Resend"){
                    UISelectionFeedbackGenerator().selectionChanged()
                    timeRemaining = 59
                    timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
                    isActive.toggle()
                }
                    .font(.callout)
                    .disabled(!isActive)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.leading)
            
            Button {
                
                UISelectionFeedbackGenerator().selectionChanged()
                
            } label: {
                Text("Verify")
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .padding(.vertical, 12)
                    .frame(maxWidth: .infinity)
                    .background{
                        RoundedRectangle(cornerRadius: 10, style: .continuous)
                            .fill(.blue)
                    }
            }
            .disabled(checkStates())
            .opacity(checkStates() ? 0.4 : 1)
            
        }
        .padding()
        .frame(maxHeight: .infinity, alignment: .top)
        .navigationBarTitle("Verification", displayMode: .large)
        .onChange(of: otpModel.otpFields) { newValue in
            OTPConditon(value: newValue)
        }
        
        .onReceive(timer) { time in

            if timeRemaining > 0 {
                timeRemaining -= 1
            } else {
                isActive.toggle()
                timer.upstream.connect().cancel()
            }
        }
        
    }
    
    func checkStates() -> Bool {
        for index in 0..<4 {
            if otpModel.otpFields[index].isEmpty{return true}
        }
        return false
    }
    
    // MARK: Conditions For Custom OTP Field & Limiting Only one Text
    func OTPConditon(value: [String]){
        
        // Moving Next Field If Current Field Type
        for index in 0..<3{
            if value[index].count == 1 && activeStateForIndex(index: index) == activeField {
                activeField = activeStateForIndex(index: index + 1)
            }
        }
        
        // Moving Back if Current is Empty And Previous is not Empty
        for index in 1...3{
            if value[index].isEmpty && !value[index - 1].isEmpty {
                activeField = activeStateForIndex(index: index - 1)
            }
        }
        
        for index in 0..<4 {
            if value[index].count > 1{
                otpModel.otpFields[index] = String(value[index].last!)
            }
        }
    }
    
    // MARK: Custom OTP TextField
    @ViewBuilder
    func OTPField() -> some View {
        HStack(spacing: 14){
            ForEach(0..<4, id: \.self) { index in
                
                VStack(spacing: 8) {
                    
                    TextField("", text: $otpModel.otpFields[index])
                        .keyboardType(.numberPad)
                        .textContentType(.oneTimeCode)
                        .multilineTextAlignment(.center)
                        .focused($activeField, equals: activeStateForIndex(index: index))
                        .frame(maxHeight: 60)
                        .font(.largeTitle)
                        .offset(y: 5)
                    
                        .tag(index)
                        .focused($keyboardFocused, equals: index == 0 ? true : false )
                        .onAppear {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.75) {
                                keyboardFocused = true
                            }
                        }
                    
                    RoundedRectangle(cornerRadius: 10, style: .continuous)
                        .fill(activeField == activeStateForIndex(index: index) ? .blue : .gray.opacity(0.3))
                        .frame(height: 4)
                    
                }
                .frame(maxWidth: .infinity)
                .background(.gray.opacity(0.2))
                .cornerRadius(6)
                
            }
        }
    }
    
    func activeStateForIndex(index: Int) -> OTPField {
        
        switch index {
        case 0: return .field1
        case 1: return .field2
        case 2: return .field3
        default: return .field4
        }
    }
}

struct OTPView_Previews: PreviewProvider {
    static var previews: some View {
        OTPView()
    }
}


enum OTPField {
    case field1
    case field2
    case field3
    case field4
}



