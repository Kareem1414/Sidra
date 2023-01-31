//
//  VerifyPhoneView.swift
//  Sidra
//
//  Created by AHMED ASSIRY on 13/05/1444 AH.
//

import SwiftUI

struct VerifyPhoneView: View {
    
    @State var phoneNumber : String = ""
    
    var body: some View {
        VStack(alignment: .leading){
            
            Text("Please enter your phone number")
                .font(.title)
                .padding(.top, 70)
                .padding(.bottom, 24)
                
            
            ZStack {
                
                TextField("+966 512345678", text: $phoneNumber)
                    .padding(.leading)
                    .keyboardType(.phonePad)
                
            }
            .frame(maxWidth: .infinity, minHeight: 50)
            .overlay(
                ZStack(alignment: .leading) {
                    
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(.gray, lineWidth: 1)
                    
                    Text("Phone Number")
                        .background(.white)
                        .padding(.leading)
                        .offset(y: -27)
                        
                }
            )
            
            Spacer()
            NavigationLink(destination: OTPView()) {
                Text("Get Code")
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity, minHeight: 60)
                    .background(phoneNumber.count == 13 ? .blue : .gray.opacity(0.3))
                    .cornerRadius(8)
            }
            .padding(.bottom)
            .disabled(phoneNumber.count == 13 ? false : true)
            
            
        }
        .padding(.horizontal)
        
    }
}

struct VerifyPhoneView_Previews: PreviewProvider {
    static var previews: some View {
        VerifyPhoneView()
    }
}
