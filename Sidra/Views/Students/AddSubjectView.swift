//
//  AddSubjectView.swift
//  Sidra
//
//  Created by AHMED ASSIRY on 07/07/1444 AH.
//

import SwiftUI

struct AddSubjectView: View {
    
    var colors : [Color] = [.blue, .green, .red, .yellow, .cyan, .orange, .brown, .indigo, .mint]
    
    @State private var nameSubject : String = ""
    @State private var colorSubject : Color = .blue
    
    @State private var semesterSubject : String = ""
    @State private var buildSubject : String = ""
    @State private var classroomSubject : String = ""
    @State private var teacherSubject : String = ""
    
    @State private var startTimeSubject : Date = Date()
    @State private var endTimeSubject : Date = Date()
    
    @State private var activeNotification : Bool = false
    
    @AppStorage("lecture_duration") var lectureDuration: Int = 45
    @AppStorage("break_duration") var breakDuration: Int = 10
    
    var body: some View {
        NavigationView {
            List {
                
                Section {
                    TextField("Subject", text: $nameSubject)
                        .padding(8)
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach(colors, id: \.self) { color in
                                Button {
                                    
                                    colorSubject = color
                                    UISelectionFeedbackGenerator().selectionChanged()
                                    
                                } label: {
                                    ZStack {
                                        RoundedRectangle(cornerRadius: 4, style: .continuous)
                                            .fill(color)
                                            .frame(width: 30, height: 30)
                                            .border(.gray, width: colorSubject == color ? 1 : 0)
                                            .cornerRadius(4)
                                            .padding(.horizontal, 4)
                                            .padding(.vertical, 4)
                                            
                                        
                                        Image(systemName: color == colorSubject ? "checkmark" : "")
                                            .foregroundColor(.white)
                                            .bold()
                                    }
                                }
                            }
                            
                        }
                        .padding(.horizontal, 18)
                    }
                    .padding(.horizontal, -18)
                }
                
                
                Section {
                    TextField("Semester", text: $semesterSubject)
                    TextField("Building", text: $semesterSubject)
                    TextField("classroom", text: $semesterSubject)
                    TextField("Teacher", text: $semesterSubject)
                }
                
                
                Section {
                    NavigationLink(destination: SubjectBooksView()) {
                        Text("Links")
                    }
                    
                    NavigationLink(destination: QuizInstructions()) {
                        Text("Files")
                    }
                }
                
                Section {
                    NavigationLink(destination: SubjectBooksView()) {
                        Text("Days")
                    }
                    
                    DatePicker("Start", selection: $startTimeSubject, displayedComponents: .hourAndMinute)
    //                endTimeSubject = Calendar.current.date(byAdding: .minute, value: lectureDuration, to: startTimeSubject)!
                    DatePicker("End", selection: $endTimeSubject, displayedComponents: .hourAndMinute)
                    
                }
                
                Section {
                    Toggle("Notification", isOn: $activeNotification)
                    if activeNotification {
                        NavigationLink(destination: QuizInstructions()) {
                            HStack {
                                Text("Reminder")
                                
                                Spacer()
                                
                                Text("On time")
                            }
                        }
                    }
                }
            }
        }
        .navigationTitle("Add subject")
    }
}

struct AddSubjectView_Previews: PreviewProvider {
    static var previews: some View {
        AddSubjectView()
    }
}
