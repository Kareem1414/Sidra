//
//  Home.swift
//  Sidra
//
//  Created by AHMED ASSIRY on 21/02/1444 AH.
//

import SwiftUI
import UserNotifications

struct Home: View {
    
    @StateObject var taskModel : CalendarViewModel = CalendarViewModel()
    
    @StateObject var faceIDModel : FaceIDViewModel = FaceIDViewModel()
    
    @StateObject var locationDataManager = LocationDataManager()
    
    //    @StateObject var PrayerTimesModel : PrayerTimesViewModel = PrayerTimesViewModel()
    
    @Namespace var animation
    
    // MARK: Core Data Context
    @Environment(\.managedObjectContext) var context
    
    // MARK: All Environment Values in one Variable
    @Environment(\.self) var env
    
    @Binding var showMenu : Bool
    
    @AppStorage("log_FaceID") var logFaceID : Bool = false
    
    @AppStorage("colorkey") var storedColor: Color = .red
    
    @AppStorage("display_sub_calendar_home") var displaySubCalendarHome: Bool = false
    
    var body: some View {
        
        NavigationView {
            
            VStack {
                
                HeaderView()
                
                
                
            }
            
            .coordinateSpace(name: "SCROLL")
            .ignoresSafeArea(.container, edges: .vertical)
            .background(Color(UIColor.secondarySystemBackground))
            //            .gesture(DragGesture(minimumDistance: 0, coordinateSpace: .local)
            //                .onEnded({ value in
            //                    print(value.translation)
            //                    print(value.location)
            //                    print(value.time)
            //                    if value.translation.width < 0 {
            //                        // left
            //                        withAnimation {
            //                            self.showMenu.toggle()
            //                        }
            //
            //                    }
            //
            //                    if value.translation.width > 0 {
            //                        // right
            //                        withAnimation {
            //                            self.showMenu.toggle()
            //                        }
            //                    }
            //                }))
            
        }
        .overlay {
            
            if showMenu {
                Rectangle()
                    .fill(.primary.opacity(0.2))
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .onTapGesture {
                        withAnimation {
                            showMenu.toggle()
                        }
                    }
            }
            
            if logFaceID {
                
                FaceIDView(show: Binding<Bool>(get: {return !self.faceIDModel.isUnlocked},
                                               set: { p in self.faceIDModel.isUnlocked = p}))
                .onAppear {
                    faceIDModel.authenticate()
                }
            }
            
        }
        
        .sheet(isPresented: $taskModel.addNewTask) {
            // Clearing Edit Data
            taskModel.editTask = nil
            
        } content: {
            
            NewTask()
                .environmentObject(taskModel)
            
        }
    }
    
    // MARK: Header
    func HeaderView() -> some View {
        
        VStack {
            
            HStack(spacing: 10) {
                
                Button {
                    UISelectionFeedbackGenerator().selectionChanged()
                    withAnimation {
                        taskModel.currentDay = Date()
                    }
                    
                } label: {
                    
                    Text(taskModel.currentDay.formatted(date: .complete, time: .omitted ))
                        .hLeading()
                    
                    
                }
                
                
                Button {
                    
                    UISelectionFeedbackGenerator().selectionChanged()
                    
                    withAnimation {
                        showMenu.toggle()
                    }
                    
                } label: {
                    Image(systemName: "line.3.horizontal")
                        .foregroundColor(.primary)
                }
                
            }
            .font(.system(size: 20).bold())
            .padding(.top, getSafeArea().top + 8)
            .padding(.horizontal)
            .padding(.bottom, 8)
            .foregroundColor(.primary)
            
            CurrentWeekView()
            
            TabView {
                
                TasksView()
                    .frame(maxHeight: .infinity, alignment: .top)
                    .padding(.top)
                
                FitnessList()
                
                MuslimList()
                
            }
            .tabViewStyle(.page)
            .indexViewStyle(.page(backgroundDisplayMode: .always))
        }
    }
    
    // MARK: Current Week Task View
    func CurrentWeekView() -> some View {
        // MARK: Current Week View
        HStack {
            
            ForEach(taskModel.currentWeek, id: \.self) { day in
                
                VStack(spacing: 2) {
                    
                    // EEE will return day as MON, TUE
                    Text(day.toString(format: "EEE"))
                        .font(.system(size: 10))
                    
                    // dd will return day as 03, 02
                    Text(day.toString(format: "d"))
                        .font(.system(size: displaySubCalendarHome ? 18 : 20))
                        .padding(.vertical, displaySubCalendarHome ? 0 : 3)
                    
                    if displaySubCalendarHome {
                        // dd will return day as 09, 02
                        Text(day.hijriDate(format: "d"))
                            .font(.system(size: 10, weight: .medium))
                    }
                    
                }
                
                
                // MARK: Foreground Style
                .foregroundStyle(taskModel.isToday(date: day) ? .white : taskModel.isRealToday(date: day) ? storedColor : .white)
                
                // MARK: Foreground Color
//                .foregroundColor(taskModel.isToday(date: day) ? .white : .green)
                .foregroundColor(.white)
                
                // MARK: Capsule Shape
                .frame(maxWidth: .infinity)
                .frame(width: taskModel.isToday(date: day) ? 53 : nil, height: taskModel.isToday(date: day) ? displaySubCalendarHome ? 58 : 52 : displaySubCalendarHome ? 58 : 52)
                .background(
                    
                    ZStack{
                        
                        if taskModel.isToday(date: day) {
                            RoundedRectangle(cornerRadius: 8, style: .continuous)
                                .fill(storedColor)
                                .matchedGeometryEffect(id: "CURRENTDAY", in: animation)
                        } else {
                            RoundedRectangle(cornerRadius: 8, style: .continuous)
                            //                                .fill(Color(.quaternaryLabel))
                                .fill(Color(UIColor.tertiaryLabel).opacity(0.3))
                            
                        }
                    }
                    
                )
//
                
                //                                .contentShape(Capsule())
                .onTapGesture {
                    
                    UISelectionFeedbackGenerator().selectionChanged()
                    
                    // Updating Current Day
                    withAnimation {
                        taskModel.currentDay = day
                    }
                    
                }
                
                .contextMenu {
                    Button {
                        print("Task")
                    } label: {
                        Label("Task", systemImage: "checklist")
                    }
                    
                    Button {
                        print("Event")
                        taskModel.addNewTask.toggle()
                    } label: {
                        Label("Event", systemImage: "calendar.badge.plus")
                    }
                    
                    Button(role: .destructive) {
                        print("Delete")
                    } label: {
                        Label("Delete", systemImage: "trash")
                    }
                }
                
                
                
            }
            
        }
        .padding(.horizontal)
    }
    
    // MARK: Tasks View
    func TasksView() -> some View {
        
        VStack {
            
            //        Converting object as Our Task Model
            DynamicFilteredView(dateFilter: taskModel.currentDay) { (object: TaskCoreData) in
                
                TaskCardView(task: object)
                    .onTapGesture {
                        taskModel.editTask = object
                        taskModel.addNewTask.toggle()
                    }
            }
        }
    }
    
    // MARK: Task Card View
    func TaskCardView(task: TaskCoreData) -> some View {
        
        // MARK: Since CoreData Values will Give Optinal data
        
        // If Edit mode enabled then showing Delete Button
        //            if editButton?.wrappedValue == .active {
        //                // Edit Button for Current and Future Tasks
        //                VStack(spacing: 10) {
        //
        //                    if task.taskDate?.compare(Date()) == .orderedDescending || Calendar.current.isDateInToday(task.taskDate ?? Date()) {
        //                        Button {
        //
        //                            taskModel.editTask = task
        //                            taskModel.addNewTask.toggle()
        //
        //                        } label: {
        //                            Image(systemName: "pencil.circle.fill")
        //                                .font(.title)
        //                                .foregroundColor(.primary)
        //                        }
        //                    }
        //                }
        //            }
        
        HStack {
            
            Image(systemName:"square\(task.taskIsCompleted ? ".fill" : "")")
                .font(.title2)
                .onTapGesture {
                    UISelectionFeedbackGenerator().selectionChanged()
                    
                    // MARK: Check Button is Completed
                    task.taskIsCompleted.toggle()
                    try? context.save()
                }
            
            VStack(alignment: .leading, spacing: 4) {
                Text(task.taskTitle ?? "")
                    .strikethrough(task.taskIsCompleted)
                    
                
                Text(task.taskNotes ?? "")
                    .font(.footnote)
                    .foregroundColor(.gray)
                    .strikethrough(task.taskIsCompleted)
                    .padding(.leading, 4)
            }
            .padding(.leading, 8)
            
            Spacer()
            
            VStack(alignment: .trailing, spacing: 4) {
                Text(task.taskDate?.formatted(date: .omitted, time: .shortened) ?? "")
                Text(task.taskDate?.formatted(date: .abbreviated, time: .omitted) ?? "")
            }
            .padding(.trailing, 8)
            .font(.caption)
            
        }
        .foregroundColor(.primary)
        .padding()
        .background(Color(uiColor: .tertiarySystemBackground))
        .cornerRadius(8)
        .hLeading()
        .padding(.horizontal, 15)
        
        
        //            .foregroundColor(taskModel.isCurrentHour(date: task.taskDate ?? Date()) ? .white : .secondary)
        //            .padding(taskModel.isCurrentHour(date: task.taskDate ?? Date()) ? 15 : 5)
        //            .padding(.bottom, taskModel.isCurrentHour(date: task.taskDate ?? Date()) ? 0 : 10)
        
        
        
    }
    
    // MARK: Scroll Cards Pinned Content
    func MuslimList() -> some View {
        
        ScrollView(.vertical, showsIndicators: false) {
            
            VStack(spacing: 16) {
                
                NavigationLink(destination: PrayerTimesView()) {
                    Text("Prayer Times")
                        .frame(maxWidth: .infinity, minHeight: 120)
                        .background(Color(UIColor.tertiarySystemBackground))
                        .cornerRadius(8)
                }
                
                NavigationLink(destination: QuranHomeView()) {
                    Text("Holy Quran")
                        .frame(maxWidth: .infinity, minHeight: 120)
                        .background(Color(UIColor.tertiarySystemBackground))
                        .cornerRadius(8)
                }
                
//                NavigationLink(destination: tryQuranView()) {
//                    
//                    Text("Try Quran")
//                        .frame(maxWidth: .infinity, minHeight: 120)
//                        .background(Color(UIColor.tertiarySystemBackground))
//                        .cornerRadius(8)
//                }
                
                NavigationLink(destination: HisnulMuslim()) {
                    Text("Hisnul Muslim")
                        .frame(maxWidth: .infinity, minHeight: 120)
                        .background(Color(UIColor.tertiarySystemBackground))
                        .cornerRadius(8)
                }
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 16) {
                        NavigationLink(destination: NamesOfAllahView()) {
                            VStack {
                                Image(systemName: "character.book.closed")
                                Text("Names of Allah")
                                    .font(.caption2)
                                    .padding(.top, 6)
                                    
                            }
                            .foregroundColor(.primary)
                            .padding()
                            .background(Color(.systemGray6))
                            .cornerRadius(8)
                            
                        }
                        
                        NavigationLink(destination: NamesOfAllahView()) {
                            VStack {
                                Image(systemName: "globe.europe.africa")
                                Text("Mosque Finder")
                                    .font(.caption2)
                                    .padding(.top, 6)
                                    
                            }
                            .foregroundColor(.primary)
                            .padding()
                            .background(Color(.systemGray6))
                            .cornerRadius(8)
                            
                        }
                        
                        NavigationLink(destination: NamesOfAllahView()) {
                            VStack {
                                Image(systemName: "hand.point.up.braille")
                                Text("Praise")
                                    .font(.caption2)
                                    .padding(.top, 6)
                                    
                            }
                            .foregroundColor(.primary)
                            .padding()
                            .background(Color(.systemGray6))
                            .cornerRadius(8)
                            
                        }
                    }
                    .padding()
                }
                .background(Color(UIColor.tertiarySystemBackground))
                .cornerRadius(8)
                
            }
            .padding()
        }
    }
    
    // MARK: Scroll Cards Pinned Content
    func FitnessList() -> some View {
        
        ScrollView(.vertical, showsIndicators: false) {
            
            VStack(spacing: 16) {
                
                FitnessCardView()
                    
                NavigationLink(destination: FitnessView()) {
                    Text("Sleep")
                        .frame(maxWidth: .infinity, minHeight: 120)
                        .background(Color(UIColor.tertiarySystemBackground))
                        .cornerRadius(8)
                        
                }
                .padding(.horizontal)
            }
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


// MARK: UI Design Helper functions
// We use this extension to avoid the use of Spacer() & .frame()
extension View {
    
    func hLeading() -> some View {
        self
            .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    func hTrailing() -> some View {
        self
            .frame(maxWidth: .infinity, alignment: .trailing)
    }
    
    func hCenter() -> some View {
        self
            .frame(maxWidth: .infinity, alignment: .center)
    }
    
    func DShadow() -> some View {
        self
            .shadow(
                color: Color.gray.opacity(0.3),
                radius: 8
            )
    }
    
    // MARK: Safe Area
    func getSafeArea() -> UIEdgeInsets {
        guard let screen = UIApplication.shared.connectedScenes.first as? UIWindowScene else {
            return .zero
        }
        
        guard let safeArea = screen.windows.first?.safeAreaInsets else {
            return .zero
        }
        
        return safeArea
    }
}
