//
//  TermsAndConditionsView.swift
//  Sidra
//
//  Created by AHMED ASSIRY on 09/05/1444 AH.
//

import SwiftUI
import WebKit

struct TermsAndConditionsView: View {
    var body: some View {
        VStack(spacing: 8) {
            SwiftUIWebView()
            
            HStack(spacing: 8) {
                Button {
                    
                } label: {
                    
                    Text("Disagree")
                        .padding()
                        
                }
                .frame(maxWidth: .infinity)
                .background(.red)
                .cornerRadius(8)
                
                Button {
                    
                } label: {
                    
                    Text("Agree")
                        .padding()
                        
                }
                .frame(maxWidth: .infinity)
                .background(.green)
                .cornerRadius(8)
            }
            .font(.system(size: 14).bold())
            .padding(.bottom, getSafeArea().bottom)
            .padding(.horizontal)
            .foregroundColor(.white)

            
        }

        .ignoresSafeArea()
        
    }
    
}

struct TermsAndConditionsView_Previews: PreviewProvider {
    static var previews: some View {
        TermsAndConditionsView()
    }
}


struct SwiftUIWebView: UIViewRepresentable {
    typealias UIViewType = WKWebView
    
    let webView: WKWebView
    
    init() {
        webView = WKWebView(frame: .zero)
        webView.load(URLRequest(url: URL(string: "https://www.devtechie.com")!))
    }
    
    func makeUIView(context: Context) -> WKWebView {
        webView
    }
    func updateUIView(_ uiView: WKWebView, context: Context) {
    }
}
