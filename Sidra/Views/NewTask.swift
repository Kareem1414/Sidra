//
//  NewTask.swift
//  Sidra
//
//  Created by AHMED ASSIRY on 25/02/1444 AH.
//

import SwiftUI

struct NewTask: View {
    
    @Environment(\.dismiss) var dismiss
    
    @State var taskTitle : String = ""
    @State var taskNotes : String = ""
    @State var taskColor: Color = .blue
    @State var taskDate : Date = Date()
    @State var taskNotification: Date = Date()
    @State var taskLabel: String?
    
    @State var taskLocation: Double?
    @State var taskIsCompleted: Bool = false
    
    var colors : [Color] = [.blue, .green, .red, .yellow, .cyan, .orange, .brown, .indigo, .mint]
    
    // MARK: Core Data Context
    @Environment(\.managedObjectContext) var context
    
    @EnvironmentObject var taskModel : CalendarViewModel
    
    // Hide and show Keyboard
    @FocusState private var keyboardFocused: Bool
    
    var body: some View {
        List {
            
            Section {
                TextField("Title", text: $taskTitle)
                    .focused($keyboardFocused)
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now()) {
                            keyboardFocused = true
                        }
                    }
                TextField("Notes", text: $taskNotes)
                
            } header: {
                Text("Task Title")
            }
            
            
            Section {
                HStack{
                    Menu("Task") {
                        Button("Task", action: placeOrder)
                        Button("Event", action: adjustOrder)
                        Menu("Priority") {
                            Button("High", action: rename)
                            Button("Low", action: delay)
                        }
                        Button("Cancel", action: cancelOrder)
                    }
                    
                    Menu("Label") {
                        Button("Personal", action: cancelOrder)
                        Button("Home", action: placeOrder)
                        Button("Work", action: adjustOrder)
                        Button("Shopping", action: adjustOrder)
                    }
                }
                .foregroundColor(.black)
                .frame(maxWidth: .infinity)
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(colors, id: \.self) { color in
                            Button {
                                
                                taskColor = color
                                UISelectionFeedbackGenerator().selectionChanged()
                                
                            } label: {
                                ZStack {
                                    RoundedRectangle(cornerRadius: 4, style: .continuous)
                                        .fill(color)
                                        .frame(width: 30, height: 30)
                                        .border(.gray, width: taskColor == color ? 1 : 0)
                                        .cornerRadius(4)
                                        .padding(.horizontal, 4)
                                        .padding(.vertical, 4)
                                        
                                    
                                    Image(systemName: color == taskColor ? "checkmark" : "")
                                        .foregroundColor(.white)
                                        .bold()
                                }
                            }
                        }
                    }
                    .padding(.horizontal, 18)
                }
                .padding(.horizontal, -18)
                
            } header: {
                Text("Task Label")
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            // Disabling Date for Edit Mode
            if taskModel.editTask == nil {
                Section {
                    DatePicker("", selection: $taskDate)
                        .datePickerStyle(.compact)
                        .labelsHidden()
                        .frame(maxWidth: .infinity)
                } header: {
                    Text("Task Date")
                }
                
            }
            
            Section {
                HStack {
                    
                    Button {
                        print("Ahmed")
                    }label: {
                        Label("Location",systemImage: "location")
                    }
                    
                    Button {
                        print("Ahmed")
                    }label: {
                        Label("Arrive",systemImage: "location")
                    }
                    
                    Button {
                        print("Ahmed")
                    }label: {
                        Label("Leave",systemImage: "location")
                    }
                }
                .buttonStyle(PlainButtonStyle())
                .foregroundColor(.gray)
                .frame(maxWidth: .infinity, alignment: .leading)
                
            }
            
        }
        .listStyle(.insetGrouped)
        .navigationTitle("Add New Task")
        .navigationBarTitleDisplayMode(.inline)
        
        
        
        Button {
            UISelectionFeedbackGenerator().selectionChanged()
            
            let task = TaskCoreData(context: context)
            task.taskTitle = taskTitle
            task.taskNotes = taskNotes
            task.taskColor = taskColor.description
            task.taskDate = taskDate
            
            // Saving
            try? context.save()
            
            // Dismissing View
            dismiss()
            
        } label: {
            
            Text("Save")
            
        }
        .disabled(taskTitle.isEmpty)
        .frame(maxWidth: .infinity, minHeight: 50, alignment: .center)
//        .background(.green)
        
        // MARK: Disbaling Dismiss on Swipe
        //        .interactiveDismissDisabled()
    }
    
    func placeOrder() { }
    func adjustOrder() { }
    func rename() { }
    func delay() { }
    func cancelOrder() { }
}
