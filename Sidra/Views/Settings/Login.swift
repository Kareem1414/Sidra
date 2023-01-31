//
//  Login.swift
//  Sidra
//
//  Created by AHMED ASSIRY on 27/02/1444 AH.
//

import SwiftUI
import Lottie

struct Login: View {
    
    @State var eMail : String = ""
    @State var password : String = ""
    
    @State var agreedTermsAndConditions : Bool = false
    var body: some View {
        VStack {
            LottieView(animationName: "38435-register",
                       loopMode: .loop,
                       contentMode: .scaleAspectFit)
            .frame(height: 200)
            .padding(.horizontal, 16)
            
            Spacer()
            
            NavigationLink(destination: OTPView()) {
                
                Text("OTP")
                    .frame(width: 150, height: 80)
                    .background(LinearGradient(colors: [.green, .green.opacity(0.5)], startPoint: .topTrailing, endPoint: .bottomLeading))
                    .cornerRadius(16)
                    .DShadow()
            }
            
            ScrollView(.horizontal, showsIndicators: false) {
                
                
                HStack (spacing: 8) {
                    LoginFeaturesView(image: "lock", title: "Ahmed", subTitle: "If you need extra space between your content and the safe area inset content, add a spacing parameter like this:")
                        .padding()
                    LoginFeaturesView(image: "lock", title: "Ahmed", subTitle: "If you need extra space between your content and the safe area inset content, add a spacing parameter like this:")
                    LoginFeaturesView(image: "lock", title: "Ahmed", subTitle: "If you need extra space between your content and the safe area inset content, add a spacing parameter like this:")
                    LoginFeaturesView(image: "lock", title: "Ahmed", subTitle: "If you need extra space between your content and the safe area inset content, add a spacing parameter like this:")
                        .padding(.trailing)
                }
                .frame(maxWidth: .infinity)
                
                Spacer()
                
            }
            .safeAreaInset(edge: .bottom) {
                VStack(spacing: 18){
                    
                    VStack {
                        Button {
                            print("Google")
                            UISelectionFeedbackGenerator().selectionChanged()
                        } label: {
                            Text("Google")
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .padding(18)
                                .background(.green)
                                .cornerRadius(32)
                            
                        }
                        .padding(.top)
                        
                        Button {
                            print("Twitter")
                            UISelectionFeedbackGenerator().selectionChanged()
                        } label: {
                            Text("Twitter")
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(.blue)
                                .cornerRadius(40)
                            
                        }
                        
                        
                        Button {
                            print("Apple")
                            UISelectionFeedbackGenerator().selectionChanged()
                        } label: {
                            Text("Apple")
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(.black)
                                .cornerRadius(8)
                            
                        }
                        
                    }
                    .disabled(!agreedTermsAndConditions)
                    .onTapGesture {
                        if !agreedTermsAndConditions {
                            
                        }
                    }
                    
                    
                    Divider()
                    
                    HStack {
                        
                        Button {
                            
                            UISelectionFeedbackGenerator().selectionChanged()
                            withAnimation {
                                agreedTermsAndConditions.toggle()
                            }
                            
                        } label: {
                            Image(systemName: agreedTermsAndConditions ? "checkmark.square" : "square")
                                .font(.system(size: 22, weight: .light))
                                .foregroundColor(agreedTermsAndConditions ? .blue : .gray)
                        }
                        
                        NavigationLink(destination: TermsAndConditionsView()) {
                            Text("By clicking Sign up, Facebook, Google or Apple, you agree to our Terms and Conditions and Privacy Statement.")
                                .foregroundColor(.gray)
                                .font(.system(size: 10))
                                .multilineTextAlignment(.leading)
                                .fixedSize(horizontal: false, vertical: true)
                        }
                    }
                    .padding(.bottom, 24)
                    
                }
                .frame(maxWidth: .infinity)
                .padding()
//                .padding(.bottom, 16)
                .background()
                .cornerRadius(16, corners: [.topLeft, .topRight])
                .shadow(color: .gray, radius: 5)
            }
            .edgesIgnoringSafeArea(.bottom)
            
        }
        .foregroundColor(.primary)
        
    }
    
    // MARK: Task Card View
    func LoginFeaturesView(image: String, title: String, subTitle: String) -> some View {
        
        VStack(alignment: .leading, spacing: 8) {
            HStack(spacing: 8) {
                
                Image(systemName: image)
                    .font(.caption2)
                    .padding(8)
                    .background(
                        Circle()
                            .fill(.green)
                    )
                Text(title)
                
            }
            .padding([.leading, .top], 10)
            
            Text(subTitle)
                .font(.system(size: 12))
                .foregroundColor(.gray)
                .fixedSize(horizontal: false, vertical: true)
                .padding([.leading, .bottom, .trailing],  16)

                
        }
        .frame(width: 250)
        .background()
        
        .clipShape(RoundedRectangle(cornerRadius: 8))
        .shadow(color: .gray, radius: 5)
//        .padding()
        
    }
}

struct Login_Previews: PreviewProvider {
    static var previews: some View {
        Login()
    }
}
