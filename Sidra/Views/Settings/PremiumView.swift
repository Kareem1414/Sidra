//
//  PremiumView.swift
//  Sidra
//
//  Created by AHMED ASSIRY on 30/02/1444 AH.
//

import SwiftUI

struct PremiumView: View {
    
    @Environment(\.dismiss) var dismiss
    
    @State var prices : [Double] = [2.99, 20.99, 99.99]
    @State var discount : Double = 50
    
    @State var indexButton : Int = 1
    @State var isAnimating : Bool = false
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 8) {
            
            HStack {
                Text("Premium")
                    .font(.title.bold())
                
                Spacer ()
                
                Button {
                    
                    UISelectionFeedbackGenerator().selectionChanged()
                    dismiss()
                    
                } label: {
                    Image(systemName: "x.square.fill")
                }
                .padding(.trailing)
                .foregroundColor(.gray)
            }
            .padding(.leading)
            .padding(.top, 20)
            
            Text("Any SwiftUI view can have its corners rounded using the cornerRadius() modifier.")
                .font(.system(size: 12))
                .foregroundColor(.gray)
                .padding(.leading)
        
        ScrollView(.vertical, showsIndicators: false) {
            

                
                ScrollView(.horizontal, showsIndicators: false) {
                    
                    HStack(spacing: 0) {
                        
                        FeaturesView(image: "trash.circle.fill", title: "No Ads", subTitle: "You can also add an alignment to your safe area inset content.")
                        
                        FeaturesView(image: "paintbrush.fill", title: "Appearance", subTitle: "You can also add an alignment to your safe area")
                        
                        FeaturesView(image: "lock.open.applewatch", title: "Apple Watch", subTitle: "Sponsor Hacking with Swift and reach the world's largest Swift community!")
                        
                        FeaturesView(image: "arrow.left.arrow.right", title: "Date", subTitle: "You can include or exclude a view in your design just by using a regular Swift condition.")
                        
                    }
                }
                
                
                VStack(alignment: .leading, spacing: 12) {
                    
                    Text("Plans")
                        .font(.title3)
                        .padding(.leading, 8)
                    
                    Button {
                        
                        withAnimation {
                            indexButton = 0
                        }
                        
                        UISelectionFeedbackGenerator().selectionChanged()
                        
                    } label: {
                        
                        HStack(spacing: 8) {
                            
//                            Image(systemName: indexButton == 0 ? "checkmark.circle.fill" : "circle")
//                                .padding(.trailing, 8)
//                                .foregroundColor(indexButton == 0 ? .blue : .primary)
                            HStack {
                                VStack(alignment: .leading, spacing: 2) {
                                    
                                    Text("Monthly")
                                        .font(.system(size: 16).bold())
                                        .foregroundColor(indexButton == 0 ? .blue : .primary)
                                    
                                    Text("No free trial")
                                        .font(.system(size: 12))
                                        .foregroundColor(.gray)
                                        .padding(.leading, 8)
                                }
                                
                                Spacer()
                                
                                VStack(alignment: .leading, spacing: 8) {
                                    
                                    Text("$\(prices[0].format(f: "2"))")
                                        .font(.system(size: 16).bold())
                                        .foregroundColor(indexButton == 0 ? .blue : .primary)
                                    
                                }
                                
                            }
                            
                        }
                        .padding()
                        .frame(maxWidth: .infinity)
                        .cornerRadius(8)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(indexButton == 0 ? .blue : .primary, lineWidth: indexButton == 0 ? 2 : 0.5)
                        )
                        .shadow(
                            color: Color.gray.opacity(0.3),
                            radius: 8
                        )
                        
                    }
                    
                    Button {
                        withAnimation {
                            indexButton = 1
                        }
                        
                        
                        print("Second Subscribe")
                        UISelectionFeedbackGenerator().selectionChanged()
                        
                    } label: {
                        
                        HStack(spacing: 8) {
                            
                            
                            VStack(alignment: .leading, spacing: 2) {
                                
                                Text("Annual")
                                    .font(.system(size: 16).bold())
                                    .foregroundColor(indexButton == 1 ? .blue : .primary)
                                
                                Text("7 days free trial")
                                    .font(.system(size: 12))
                                    .foregroundColor(.gray)
                                    .padding(.leading, 8)
                                    .transition(.slide)
                            }
                            
                            Spacer()
                            
                            Text("\(discount(first: prices[1], second: prices[0] * 12))%")
                                .font(.system(size: indexButton == 1 ? 18 : 12).bold())
                                .foregroundColor(.pink)
                            
                            Spacer()
                            
                            
                            Text("$\(prices[1].format(f: "2"))")
                                .font(.system(size: 16).bold())
                                .foregroundColor(indexButton == 1 ? .blue : .primary)
                            
                            
                        }
                        .animation(.default.speed(0.5), value: indexButton)
                        .padding()
                        .padding(.vertical, indexButton == 1 ? 16 : 0)
                        .frame(maxWidth: .infinity)
                        .cornerRadius(8)
                        .overlay(
                            ZStack {
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(indexButton == 1 ? .blue : .primary, lineWidth: indexButton == 1 ? 2 : 0.5)
                            }
                            
                        )
                        .shadow(
                            color: Color.gray.opacity(0.3),
                            radius: 8
                        )
                        
                    }
                    
                    Button {
                        
                        withAnimation {
                            indexButton = 2
                        }
                        
                        print("Third Subscribe")
                        UISelectionFeedbackGenerator().selectionChanged()
                        
                    } label: {
                        
                        HStack(spacing: 8) {
                            
                            VStack(alignment: .leading, spacing: 2) {
                                
                                Text("Lifetime")
                                    .font(.system(size: 16).bold())
                                    .foregroundColor(indexButton == 2 ? .blue : .primary)
                                
                            }
                            
                            Spacer()
                            
                            VStack(alignment: .leading, spacing: 2) {
                                
                                Text("$99.99")
                                    .font(.system(size: 16).bold())
                                    .foregroundColor(indexButton == 2 ? .blue : .primary)
                                
                                Text("One-time")
                                    .font(.system(size: 12))
                                    .foregroundColor(.gray)
                            }
                        }
                        .padding()
                        .frame(maxWidth: .infinity)
                        //                        .background(.white)
                        .cornerRadius(8)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(indexButton == 2 ? .blue : .primary, lineWidth: indexButton == 2 ? 2 : 0.5)
                        )
                        .shadow(
                            color: Color.gray.opacity(0.3),
                            radius: 8
                        )
                        
                    }
                    
                }
                .padding(.horizontal)
                .foregroundColor(.primary)
                .scaleEffect(isAnimating ?  1.0 : 0, anchor: .top)
                .onAppear {
                    withAnimation(Animation.easeOut(duration: 0.4).delay(0.5)) {
                        isAnimating = true
                    }
                }
                
                
                Text("Your iTunes account will be charged as soon as you confirm the Premium purchase. Your subscription will auto renew unless cancelled at least 24 hours before the end of the current period. Manage your subscriptions in the iTunes Store after purchase. By upgrading to premium you accept our Privacy Policy and Terms of use. ")
                    .font(.caption2)
                    .foregroundColor(.gray)
                    .padding(.top)
                    .padding()
                
            }
            
            
        }
        .safeAreaInset(edge: .bottom) {
            
            VStack {
                Button {
                    print("Subscribe")
                } label: {
                    
                    Text(indexButton == 1 ? "Start Free Trial" : "Purchase")
                        .foregroundColor(.white)
                }
                
                .frame(maxWidth: .infinity, minHeight: 60)
                .background(.blue)
                .cornerRadius(8)
                .padding()
                .padding(.top, 8)
                .scaleEffect(isAnimating ?  1.0 : 0, anchor: .bottom)
                
                HStack {
                    Button {
                        print("Restore Purchases")
                    } label: {
                        Text("Restore Purchases")
                    }
                    .frame(maxWidth: .infinity, minHeight: 10)
                    .padding(.horizontal)
                    
                    Divider()
                        .frame(height: 12)
                        .background(.black)
                    Button {
                        print("Manage Subscriptions")
                        guard let settingsURL = URL(string: "https://apps.apple.com/account/subscriptions") else { return }
                        if UIApplication.shared.canOpenURL(settingsURL) { UIApplication.shared.open(settingsURL)}
                    } label: {
                        Text("Manage Subscriptions")
                    }
                    .frame(maxWidth: .infinity, minHeight: 10)
                    .padding(.horizontal)
                }
                .foregroundColor(.gray)
                .font(.system(size: 12))
                .padding(.bottom, 35)
                
            }
            .background()
            .cornerRadius(16, corners: [.topLeft, .topRight])
            .shadow(
                color: Color.gray.opacity(0.4),
                radius: 8
            )
            
            
        }
        .edgesIgnoringSafeArea(.bottom)
        .foregroundColor(.primary)
    }
    
    func discount(first: Double, second: Double) -> String {
        let percentage = (first / second) * 100
        return percentage.format(f: "0")
    }
    
    // MARK: Task Card View
    func FeaturesView(image: String, title: String, subTitle: String) -> some View {
        
        VStack(alignment: .leading, spacing: 8) {
            HStack(spacing: 8) {
                
                Image(systemName: image)
                Text(title)
                
            }
            .padding([.leading, .top], 8)
            
            Text(subTitle)
            
                .font(.system(size: 12))
                .foregroundColor(.gray)
                .fixedSize(horizontal: false, vertical: true)
                .padding([.leading, .bottom, .trailing],  16)
            
            
        }
        .frame(width: 200, height: 100)
        .background()
        
        .clipShape(RoundedRectangle(cornerRadius: 8))
        .shadow(
            color: Color.gray.opacity(0.3),
            radius: 8
        )
        .padding()
        
    }
}

struct PremiumView_Previews: PreviewProvider {
    static var previews: some View {
        PremiumView()
    }
}
