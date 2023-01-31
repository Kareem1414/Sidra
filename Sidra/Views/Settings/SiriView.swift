//
//  SiriView.swift
//  Sidra
//
//  Created by AHMED ASSIRY on 12/05/1444 AH.
//

import SwiftUI

struct SiriView: View {
    
    var titleSiri : [String] = ["Add task", "Add event", "Love you"]
    
    @State private var isRotating = 0.0
    
    var body: some View {
        
        List {
            Section {
                HStack {
                    Image("SiriLogo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 45, height: 45)
                        .DShadow()
                        .rotationEffect(.degrees(isRotating))
                        .onAppear {
                            withAnimation(.linear(duration: 1)
                                .speed(0.1).repeatForever(autoreverses: false)) {
                                    isRotating = 360.0
                                }
                        }
                    
                    VStack(alignment: .leading, spacing: 5) {
                        Text("Siri")
                            
                        Text("Use your voice and quick commands to ask Siri.")
                            .font(.system(size: 12))
                        
                    }
                    .padding(.leading)
                }
                .padding(.vertical, 8)
            }
            
            Section(header: Text("Calendar")) {
                ForEach(titleSiri, id: \.self) { title in
                    titleAddSiri(title: title)
                }
                
            }
            
            Section(header: Text("Muslims")) {
                ForEach(titleSiri, id: \.self) { title in
                    titleAddSiri(title: title)
                }
                
            }
        }
        .navigationTitle("Siri")
        
        
    }
    
    func titleAddSiri(title: String) -> some View {
        HStack {
            Text(title)
            
            Spacer()
            
            Image(systemName: "plus")
        }
    }
}

struct SiriView_Previews: PreviewProvider {
    static var previews: some View {
        SiriView()
    }
}
