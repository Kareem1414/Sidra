//
//  SubjectDetailsView.swift
//  Sidra
//
//  Created by AHMED ASSIRY on 19/05/1444 AH.
//

import SwiftUI

struct SubjectDetailsView: View {
    
    let imagesTitles = ["Name", "Files", "MPEG", "Ahmed"]
    
    @State var detailsSubject : Bool = false
    @State var editSubject : Bool = false
    
    @State var remainDays : Double = 43.0
    
    var body: some View {
        
        VStack(spacing: 8) {
            
            Image(systemName: "calendar")
                .frame(width: detailsSubject ? 60 : 120, height: detailsSubject ? 60 : 120)
                .background(.linearGradient(colors: [.cyan, .blue], startPoint: .topLeading, endPoint: .bottomTrailing))
                .clipShape(Circle())
                .font(.system(size: detailsSubject ? 25 : 55))
                .foregroundColor(.white)
                .shadow(color: .blue.opacity(0.6), radius: 10)
                
            
            HStack(alignment: .center) {
                Text("Cyber Security")
                    .font(.system(size: 25).bold())
                    .padding(.top)
                    .offset(x: 10)
                
                Button {
                    UISelectionFeedbackGenerator().selectionChanged()
                    withAnimation {
                        detailsSubject.toggle()
                    }
                } label: {
                    Image(systemName: "info.circle")
                        .font(.callout)
                }
                .offset(x: 10, y: 10)
                
            }
            
            if detailsSubject {
                VStack(spacing: 8) {
                    Text("\(Date.now, format: .dateTime)")
                    
                    Text("Every Week: Monday, Wednesday")
                    
                    Text("Room: 65C")
                }
                .transition(.scale)
                
            }
            
            
            HStack {
                
                Button {
                    
                } label: {
                    VStack {
                        Image(systemName: "eraser.line.dashed.fill")
                            .frame(width: detailsSubject ? 35 : 50, height: detailsSubject ? 35 : 50)
                            .background(.linearGradient(colors: [.cyan, .blue], startPoint: .topLeading, endPoint: .bottomTrailing))
                            .clipShape(Circle())
                            .foregroundColor(.white)
                            .shadow(color: .blue.opacity(0.2), radius: 10)
                            
                        
                        Text("Cancel class")
                            
                        
                    }
                    .font(detailsSubject ? .system(size: 12) : .system(size: 12).bold())
                }
                .frame(maxWidth: .infinity)
                
                
                Button {
                    
                } label: {
                    VStack {
                        Image(systemName: "character.book.closed.fill")
                            .frame(width: detailsSubject ? 35 : 50, height: detailsSubject ? 35 : 50)
                            .background(.linearGradient(colors: [.cyan, .blue], startPoint: .topLeading, endPoint: .bottomTrailing))
                            .clipShape(Circle())
                            .foregroundColor(.white)
                            .shadow(color: .blue.opacity(0.2), radius: 10)
                            
                        
                        Text("Convert to Exam")
                            
                    }
                    .font(detailsSubject ? .system(size: 12) : .system(size: 12).bold())
                }
                .frame(maxWidth: .infinity)
                
                Button {
                    
                } label: {
                    VStack {
                        Image(systemName: "plus")
                            .frame(width: detailsSubject ? 35 : 50, height: detailsSubject ? 35 : 50)
                            .background(.linearGradient(colors: [.cyan, .blue], startPoint: .topLeading, endPoint: .bottomTrailing))
                            .clipShape(Circle())
                            .foregroundColor(.white)
                            .shadow(color: .blue.opacity(0.2), radius: 10)
                            
                        
                        Text("Add Homework")
                            
                    }
                    .font(detailsSubject ? .system(size: 12) : .system(size: 12).bold())
                }
                .frame(maxWidth: .infinity)
            }
            .padding([.leading, .trailing, .top], 16)
            .padding(.bottom, 8)
            
            Menu {
                Button("82 Days") {}
                    
            } label: {
                ProgressView(value: remainDays, total: 100)
                    .padding(.horizontal)
            }

            TabView {
                List(imagesTitles, id: \.self) { title in
                    
                    Text(title)
                }
                .frame(maxWidth: .infinity)
                .cornerRadius(16)
                .edgesIgnoringSafeArea(.bottom)
                
                List(imagesTitles, id: \.self) { title in
                    
                    Text(title)
                }
                
                .frame(maxWidth: .infinity)
                .cornerRadius(16)
                .edgesIgnoringSafeArea(.bottom)
                
                List(imagesTitles, id: \.self) { title in
                    
                    Text(title)
                }
                .frame(maxWidth: .infinity)
                .cornerRadius(16)
                .edgesIgnoringSafeArea(.bottom)
            }
            .edgesIgnoringSafeArea(.bottom)
            .tabViewStyle(PageTabViewStyle())

            
        }
        .font(.caption2)
        .foregroundColor(.primary)
        .toolbar {
            
            Button {
                editSubject.toggle()
            } label: {
                Image(systemName: "ellipsis")
            }
        }
        .sheet(isPresented: $editSubject) {
            
            VStack(spacing: 16) {
                
               Text("Cyber ahmed")
            }
            .presentationDetents([.fraction(0.40)])
            .presentationDragIndicator(.visible)
            
        }
    }
}

struct SubjectDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        SubjectDetailsView()
    }
}

