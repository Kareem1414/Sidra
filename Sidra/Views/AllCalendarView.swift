//
//  AllCalendarView.swift
//  Sidra
//
//  Created by AHMED ASSIRY on 01/03/1444 AH.
//

import SwiftUI

struct AllCalendarView: View {
    var body: some View {
        NavigationView {
            
            VStack(alignment: .leading, spacing: 8) {
                
                HStack(alignment: .top) {
                    
                    VStack {
                        VStack(spacing: 8) {
                            Text("Complete")
                            Text("45")
                        }
                        .frame(maxWidth: .infinity, minHeight: 120)
                        .padding()
                        .background(Color.green.clipShape(RoundedRectangle(cornerRadius:20)))
                        .padding([.trailing, .bottom], 8)
                        
                        VStack(spacing: 8) {
                            Text("Canceled")
                            Text("18")
                        }
                        .frame(maxWidth: .infinity, minHeight: 80)
                        .padding()
                        .background(Color.red.clipShape(RoundedRectangle(cornerRadius:20)))
                        .padding(.trailing, 8)
                    }
                    
                    
                    VStack {
                        VStack(spacing: 8) {
                            Text("Pending")
                            Text("45")
                        }
                        .frame(maxWidth: .infinity, minHeight: 80)
                        .padding()
                        .background(Color.purple.clipShape(RoundedRectangle(cornerRadius:20)))
                        .padding(.bottom, 8)
                        
                        VStack(spacing: 8) {
                            Text("On")
                            Text("18")
                        }
                        .frame(maxWidth: .infinity, minHeight: 120)
                        .padding()
                        .background(Color.blue.clipShape(RoundedRectangle(cornerRadius:20)))
                    }
                    
                    
                }
                .padding()
                .shadow(color: .gray, radius: 5)
                
                
                Text("Today")
                    .padding(.horizontal)
                    .font(.largeTitle.bold())
                
                List {
                    CalendarInfoView()
                    
                }
                    
            }
            
        }
        .navigationTitle("My List")
    }
    
    // MARK: Header
    func CalendarInfoView() -> some View {
        
        HStack(alignment: .top) {
            
            Image(systemName: "circle")
                .padding(.top, 10)
                .padding(.trailing, 4)
            
            VStack(alignment: .leading) {
                
                Text("Ahmed Ali Assiry from Abha")
                    .fontWeight(.medium)
                    .font(.system(size: 14))
                
                Text("\(Date(), style: .time)")
                    .font(.system(size: 12))
                    .foregroundColor(.gray)
                    .padding(.horizontal, 8)
                
                
                
                
            }
            .padding(.vertical, 2)
            
        }
        
    }
    
}

struct AllCalendarView_Previews: PreviewProvider {
    static var previews: some View {
        AllCalendarView()
//            .environment(\.locale, Locale(identifier: "En"))
    }
}
