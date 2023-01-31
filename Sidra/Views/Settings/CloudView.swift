//
//  CloudView.swift
//  Sidra
//
//  Created by AHMED ASSIRY on 20/05/1444 AH.
//

import SwiftUI

struct CloudView: View {
    
    @State var enableCloud : Bool = false
    var body: some View {
        VStack {
        
            ZStack {
                LottieView(animationName: "6", loopMode: .loop, contentMode: .scaleAspectFit)
                
                LottieView(animationName: "6", loopMode: .autoReverse, contentMode: .scaleAspectFit)
            }
            .frame(maxHeight: 150)
            
            List {
                Section(header: Text("iCloud sync status").foregroundColor(.gray), footer: Text("If the device does not sync, please check the network or contact Technical Support (Help Center) for troubleshooting tips.").foregroundColor(.gray)) {
                    
                    HStack(spacing: 20) {
                        Image(systemName: "cloud")
                        Toggle(isOn: $enableCloud) {
                            Text("iCloud")
                        }
                    }
                    
                }
                .textCase(nil)
                
                Section {
                    Text("Backup now")
                        .foregroundColor(.gray)
                }
                
                Section(header: Text("Previous Backups").foregroundColor(.gray)) {
                    ForEach( 0..<5) { i in
                        VStack(alignment: .leading, spacing: 4) {
                            Text("\(Date.now, format: .dateTime)")
                            Text("iPhone")
                                .padding(.leading)
                                .font(.footnote)
                                .foregroundColor(.gray)
                        }
                    }
                    
                }
                .textCase(nil)
            }
            .background(.clear)
            .scrollContentBackground(.hidden)
        }
        .foregroundColor(Color.primary)
        .background(Color(.systemGray6))
        
    }
}

struct CloudView_Previews: PreviewProvider {
    static var previews: some View {
        CloudView()
    }
}
