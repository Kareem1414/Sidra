//
//  SubjectsView.swift
//  Sidra
//
//  Created by AHMED ASSIRY on 20/05/1444 AH.
//

import SwiftUI

struct SubjectsView: View {
    
    @State private var quizSubject : Bool = false
    @State private var addSubject : Bool = false
    
    var body: some View {
        
        List {
            HStack {
                Rectangle()
                    .fill(.green)
                    .frame(maxWidth: 5, maxHeight: .infinity)
                
                VStack(alignment: .leading, spacing: 8) {
                    HStack {
                        Text("CS433").bold()
                            .font(.caption2)
                            .padding(5)
                            .background(.green.opacity(0.3))
                            .cornerRadius(4)
                        Text("Cloud Computing")
                        
                        Spacer()
                        
                        Button {
                            UISelectionFeedbackGenerator().selectionChanged()
                        } label: {
                            Text("0%").bold()
                                .font(.caption2)
                                .foregroundColor(.black)
                                .padding(5)
                                .background(.gray.opacity(0.3))
                                .cornerRadius(4)
                        }
                    }
                    .padding(.vertical, 4)
                    
                    Divider()
                        .overlay(.gray)
                    
                    HStack {
                        Button {
                            quizSubject.toggle()
                        } label: {
                            VStack(alignment: .center, spacing: 0) {
                                Image(systemName: "list.bullet.below.rectangle")
                                Text("Quiz")
                                    .font(.caption2)
                            }
                            .foregroundColor(.primary.opacity(0.5))
                            .frame(maxWidth: .infinity)
                            
                        }
                        
                        ZStack {
                            VStack(alignment: .center, spacing: 0) {
                                Image(systemName: "books.vertical")
                                Text("Books")
                                    .font(.caption2)
                                    
                                
                            }
                            .foregroundColor(.primary.opacity(0.5))
                            .frame(maxWidth: .infinity)
                            NavigationLink(destination: SubjectBooksView()) {
                                EmptyView()
                            }
                            .opacity(0)
                        }
                        
                        Button {
                            quizSubject.toggle()
                        } label: {
                            VStack(alignment: .center, spacing: 0) {
                                Image(systemName: "rectangle.and.pencil.and.ellipsis")
                                Text("Forum")
                                    .font(.caption2)
                            }
                            .foregroundColor(.primary.opacity(0.5))
                            .frame(maxWidth: .infinity)
                            
                        }
                        
                    }
                }
                .buttonStyle(BorderlessButtonStyle())
                .padding(8)

            }
            .background(Color(UIColor.tertiarySystemBackground))
            .cornerRadius(8)
            .listRowBackground(Color.clear)
            .listRowSeparator(.hidden)
            .listRowInsets(EdgeInsets())
            .padding(.vertical, 8)
            
            HStack {
                Rectangle()
                    .fill(.cyan)
                    .frame(maxWidth: 5, maxHeight: .infinity)
                
                VStack(alignment: .leading, spacing: 8) {
                    HStack {
                        Text("IS654").bold()
                            .font(.caption2)
                            .padding(5)
                            .background(.cyan.opacity(0.3))
                            .cornerRadius(4)
                        Text("Cryptography")
                        
                        Spacer()
                        
                        Button {
                            UISelectionFeedbackGenerator().selectionChanged()
                        } label: {
                            Text("100%").bold()
                                .font(.caption2)
                                .foregroundColor(.black)
                                .padding(5)
                                .background(.green.opacity(0.3))
                                .cornerRadius(4)
                        }
                    }
                    .padding(.vertical, 4)
                    
                    Divider()
                        .overlay(.gray)
                    
                    HStack {
                        Button {
                            quizSubject.toggle()
                        } label: {
                            VStack(alignment: .center, spacing: 0) {
                                Image(systemName: "list.bullet.below.rectangle")
                                Text("Quiz")
                                    .font(.caption2)
                            }
                            .foregroundColor(.primary.opacity(0.5))
                            .frame(maxWidth: .infinity)
                            
                        }
                        
                        Button {
                            quizSubject.toggle()
                        } label: {
                            VStack(alignment: .center, spacing: 0) {
                                Image(systemName: "books.vertical")
                                Text("Books")
                                    .font(.caption2)
                            }
                            .foregroundColor(.primary.opacity(0.5))
                            .frame(maxWidth: .infinity)
                            
                        }
                        
                        Button {
                            quizSubject.toggle()
                        } label: {
                            VStack(alignment: .center, spacing: 0) {
                                Image(systemName: "rectangle.and.pencil.and.ellipsis")
                                Text("Forum")
                                    .font(.caption2)
                            }
                            .foregroundColor(.primary.opacity(0.5))
                            .frame(maxWidth: .infinity)
                            
                        }
                    }
                }
                .padding(8)
            }
            .background(Color(UIColor.tertiarySystemBackground))
            .cornerRadius(8)
            .listRowBackground(Color.clear)
            .listRowSeparator(.hidden)
            .listRowInsets(EdgeInsets())
            .padding(.vertical, 8)
            
            HStack {
                Rectangle()
                    .fill(.red)
                    .frame(maxWidth: 5, maxHeight: .infinity)
                
                VStack(alignment: .leading, spacing: 8) {
                    HStack {
                        Text("CS433").bold()
                            .font(.caption2)
                            .padding(5)
                            .background(.red.opacity(0.3))
                            .cornerRadius(4)
                        Text("Network management")
                        
                        Spacer()
                        
                        Button {
                            UISelectionFeedbackGenerator().selectionChanged()
                        } label: {
                            Text("85%").bold()
                                .font(.caption2)
                                .foregroundColor(.black)
                                .padding(5)
                                .background(.orange.opacity(0.3))
                                .cornerRadius(4)
                        }
                    }
                    .padding(.vertical, 4)
                    
                    Divider()
                        .overlay(.gray)
                    
                    HStack {
                        Button {
                            quizSubject.toggle()
                        } label: {
                            VStack(alignment: .center, spacing: 0) {
                                Image(systemName: "list.bullet.below.rectangle")
                                Text("Quiz")
                                    .font(.caption2)
                            }
                            .foregroundColor(.primary.opacity(0.5))
                            .frame(maxWidth: .infinity)
                            
                        }
                        
                        Button {
                            quizSubject.toggle()
                        } label: {
                            VStack(alignment: .center, spacing: 0) {
                                Image(systemName: "books.vertical")
                                Text("Books")
                                    .font(.caption2)
                            }
                            .foregroundColor(.primary.opacity(0.5))
                            .frame(maxWidth: .infinity)
                            
                        }
                        
                        Button {
                            quizSubject.toggle()
                        } label: {
                            VStack(alignment: .center, spacing: 0) {
                                Image(systemName: "rectangle.and.pencil.and.ellipsis")
                                Text("Forum")
                                    .font(.caption2)
                            }
                            .foregroundColor(.primary.opacity(0.5))
                            .frame(maxWidth: .infinity)
                            
                        }
                    }
                }
                .padding(8)
            }
            .background(Color(UIColor.tertiarySystemBackground))
            .cornerRadius(8)
            .listRowBackground(Color.clear)
            .listRowSeparator(.hidden)
            .listRowInsets(EdgeInsets())
            .padding(.vertical, 8)
            
            HStack {
                Rectangle()
                    .fill(.yellow)
                    .frame(maxWidth: 5, maxHeight: .infinity)
                
                VStack(alignment: .leading, spacing: 8) {
                    HStack {
                        Text("CS548").bold()
                            .font(.caption2)
                            .padding(5)
                            .background(.yellow.opacity(0.3))
                            .cornerRadius(4)
                        Text("Artificial intelligence")
                        
                        Spacer()
                        
                        Button {
                            UISelectionFeedbackGenerator().selectionChanged()
                        } label: {
                            Text("69%").bold()
                                .font(.caption2)
                                .foregroundColor(.black)
                                .padding(5)
                                .background(.yellow.opacity(0.3))
                                .cornerRadius(4)
                        }
                        
                        
                    }
                    .padding(.vertical, 4)
                    
                    Divider()
                        .overlay(.gray)
                    
                    HStack(alignment: .bottom) {
                        Button {
                            quizSubject.toggle()
                        } label: {
                            VStack(alignment: .center, spacing: 0) {
                                Image(systemName: "list.bullet.below.rectangle")
                                Text("Quiz")
                                    .font(.caption2)
                            }
                            .foregroundColor(.primary.opacity(0.5))
                            .frame(maxWidth: .infinity)
                            
                        }
                        
                        Button {
                            quizSubject.toggle()
                        } label: {
                            VStack(alignment: .center, spacing: 0) {
                                Image(systemName: "books.vertical")
                                Text("Books")
                                    .font(.caption2)
                            }
                            .foregroundColor(.primary.opacity(0.5))
                            .frame(maxWidth: .infinity)
                            
                        }
                        
                        Button {
                            quizSubject.toggle()
                        } label: {
                            VStack(alignment: .center, spacing: 0) {
                                Image(systemName: "rectangle.and.pencil.and.ellipsis")
                                Text("Forum")
                                    .font(.caption2)
                            }
                            .foregroundColor(.primary.opacity(0.5))
                            .frame(maxWidth: .infinity)
                            
                        }
                    }
                }
                .padding(8)
            }
            .background(Color(UIColor.tertiarySystemBackground))
            .cornerRadius(8)
            .listRowBackground(Color.clear)
            .listRowSeparator(.hidden)
            .listRowInsets(EdgeInsets())
            .padding(.vertical, 8)
        }
        
        .toolbar {
            
            Button{
                
                addSubject.toggle()
                
            } label: {
                Image(systemName: "plus")
            }
        }
        .fullScreenCover(isPresented: $quizSubject) {
            QuizInstructions()
        }
        .sheet(isPresented: $addSubject) {
            AddSubjectView()
        }
    }
}

struct SubjectsView_Previews: PreviewProvider {
    static var previews: some View {
        SubjectsView()
    }
}
