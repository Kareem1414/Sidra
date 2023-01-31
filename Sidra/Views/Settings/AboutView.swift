//
//  AboutView.swift
//  Sidra
//
//  Created by AHMED ASSIRY on 23/05/1444 AH.
//

import SwiftUI

struct AboutView: View {
    
    let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            
            Text("Make things happen")
                .font(.headline)
                .padding(.horizontal)
            
            Text("Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.\nIt has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged.")
                .font(.caption)
                .foregroundColor(.gray)
                .fixedSize(horizontal: false, vertical: true)
                .padding()
            
            LottieView(animationName: "10", loopMode: .loop, contentMode: .scaleAspectFill)
                .padding(8)
            
            Text("Version  \(appVersion!)")
                .font(.subheadline.bold())
                .frame(maxWidth: .infinity)
            
            VStack(spacing: 2) {
                
                Spacer()
                
                NavigationLink(destination: ContactUsView()) {
                    HStack {
                        Text("Contact Us")
                        
                        Spacer()
                        
                        Image(systemName: "chevron.forward")
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color(.quaternaryLabel))
                    .cornerRadius(8, corners: [.topLeft, .topRight])
                }
                
                Button {
                    
                } label: {
                    HStack {
                        Text("Privacy Policy")
                        
                        
                        Spacer()
                        
                        Image(systemName: "chevron.forward")
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color(.quaternaryLabel))
                    
                }
                
                Button {
                    
                } label: {
                    HStack {
                        Text("Terms of use")
                        
                        Spacer()
                        
                        Image(systemName: "chevron.forward")
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color(.quaternaryLabel))
                    
                }
                
                Button {
                    
                } label: {
                    HStack {
                        Text("Pricing Terms")
                        
                        
                        Spacer()
                        
                        Image(systemName: "chevron.forward")
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color(.quaternaryLabel))
                    .cornerRadius(8, corners: [.bottomLeft, .bottomRight])
                    
                }
                
            }
            .font(.system(size: 12).bold())
            .padding(.horizontal)
            
        }
        
        .foregroundColor(.primary)
    }
}

struct AboutView_Previews: PreviewProvider {
    static var previews: some View {
        AboutView()
    }
}
