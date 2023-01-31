//
//  SemesterDetailsView.swift
//  Sidra
//
//  Created by AHMED ASSIRY on 20/05/1444 AH.
//

import SwiftUI

struct SemesterDetailsView: View {
    
    
    var body: some View {
        List{
            Section {
                
                NavigationLink(destination: SubjectsView()) {
                    
                    HStack {
                        VStack(alignment: .leading, spacing: 4) {
                            Text("First Semester 1444 - 1445 ")
                            
                            Text("\(Date(), style: .date)  TO  \(Date().addMonths(numberOfMonths: 3), style: .date)")
                                .font(.caption2)
                                .foregroundColor(.gray)
                                .padding(.leading, 8)
                        }
                        
                        Spacer()
                        
                        VStack {
                            Button {
                                UISelectionFeedbackGenerator().selectionChanged()
                            } label: {
                                VStack(spacing: 4) {
                                    Text("4.48").bold()
                                        .font(.caption2)
                                        .foregroundColor(.primary)
                                        .padding(5)
                                        .background(.gray.opacity(0.3))
                                        .cornerRadius(4)

                                }
                                
                            }
                        }
                    }
                    .padding(.vertical, 8)
                }
            }
            
            Section {
                NavigationLink(destination: SubjectsView()) {
                    HStack {
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Second Semester 1444 - 1445 ")
                            
                            Text("\(Date().addMonths(numberOfMonths: 3), style: .date)  TO  \(Date().addMonths(numberOfMonths: 6), style: .date)")
                                .font(.caption2)
                                .foregroundColor(.gray)
                                .padding(.leading, 8)
                            
                        }
                        
                        Spacer()
                        
                        VStack {
                            Button {
                                UISelectionFeedbackGenerator().selectionChanged()
                            } label: {
                                VStack(spacing: 4) {
                                    Text("3.72").bold()
                                        .font(.caption2)
                                        .foregroundColor(.primary)
                                        .padding(5)
                                        .background(.gray.opacity(0.3))
                                        .cornerRadius(4)
                                }
                                
                            }
                        }
                    }
                    .padding(.vertical, 8)
                }
            }
            
            Section {
                NavigationLink(destination: SubjectsView()) {
                    
                    HStack {
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Third Semester 1444 - 1445 ")
                            
                            Text("\(Date().addMonths(numberOfMonths: 6), style: .date)  TO  \(Date().addMonths(numberOfMonths: 9), style: .date)")
                                .font(.caption2)
                                .foregroundColor(.gray)
                                .padding(.leading, 8)
                        }
                        
                        Spacer()
                        
                        VStack {
                            Button {
                                UISelectionFeedbackGenerator().selectionChanged()
                            } label: {
                                VStack(spacing: 4) {
                                    Text("2.56").bold()
                                        .font(.caption2)
                                        .foregroundColor(.primary)
                                        .padding(5)
                                        .background(.gray.opacity(0.3))
                                        .cornerRadius(4)
                                    
                                }
                                
                            }
                        }
                    }
                    .padding(.vertical, 8)
                }
            }
        }
        .toolbar {
            Text("3.42").bold()
                .font(.caption2)
                .foregroundColor(.primary)
                .padding(4)
                .background(.cyan.opacity(0.3))
                .cornerRadius(4)
        }
    }
}

struct SemesterDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        SemesterDetailsView()
    }
}
