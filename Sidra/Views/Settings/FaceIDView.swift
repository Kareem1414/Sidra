//
//  FaceIDView.swift
//  Sidra
//
//  Created by AHMED ASSIRY on 22/05/1444 AH.
//

import SwiftUI

struct FaceIDView: View {
    
    @Binding var show : Bool
    
    @StateObject var faceIDModel : FaceIDViewModel = FaceIDViewModel()
    
    var body: some View {
        ZStack {
            if show {
                Group {
                    Rectangle()
                        .fill(.black.opacity(0.25))
                        .ignoresSafeArea()
                    
//                    ProgressView()
//                        .padding(15)
//                        .background(.white, in: RoundedRectangle(cornerRadius: 10, style: .continuous))
                    
                    Button {
                        faceIDModel.authenticate()
                    } label: {
                        HStack(spacing: 8) {
                            Image(systemName: "faceid")
                            Text("FaceID")
                                
                        }
                        .padding(24)
                        .background(.white, in: RoundedRectangle(cornerRadius: 8, style: .continuous))
                        
                    }
                }
            }
        }
        .animation(.easeInOut(duration: 0.25), value: show)
        
    }
}
