//
//  CalendarView.swift
//  Sidra
//
//  Created by AHMED ASSIRY on 28/02/1444 AH.
//

import SwiftUI

struct CalendarView: View {
    
    @State var currentDate : Date = Date()
    
    @State var currentMonth : Int = 0
    
    @State var OpenAddEvents : Bool = false
    
    @State private var users = ["Paul", "Taylor", "Adele", "Paul", "Taylor", "Adele","Paul", "Taylor", "Adele"]
    
    var body: some View {
        
        VStack(spacing: 0) {
            
            // Days....
            let days: [String] = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]
            
            // Day View...
            HStack(spacing: 0) {
                ForEach(days, id: \.self) { day in
                    Text(day)
                        .font(.system(size: 10))
                        .frame(maxWidth: .infinity)
                }
            }
            
            // Dates...
            // Lazy Grid
            let columns = Array(repeating: GridItem(.flexible()), count: 7)
            
            LazyVGrid(columns: columns, spacing: 1) {
                
                ForEach(extractDate()) { value in
                    
                    CardView(value: value)
                    
                        .background(
                            Circle()
                                .fill(.yellow)
                                .opacity(value.day != -1 ? isSameDay(date1: value.date, date2: currentDate) ? 1 : 0 : 0)
                            
                        )
                        .foregroundColor(value.day != -1 ? isSameDay(date1: value.date, date2: Date()) ? .red : .black : .clear)
                    
                        .onTapGesture() {
                            print("Double tapped!")
                            UISelectionFeedbackGenerator().selectionChanged()
                            
                            withAnimation {
                                currentDate = value.date
                            }
                        }
                    
                        .simultaneousGesture(
                            TapGesture(count: 2)
                                .onEnded({ _ in
                                    UISelectionFeedbackGenerator().selectionChanged()
                                    print("One tapped!")
                                    withAnimation {
                                        currentDate = value.date
                                    }
                                    
                                })
                        )
                }
                .background(.green)
            }
            .background(.blue)
            
            
            List {
                ForEach(users, id: \.self) { user in
                    HStack(spacing: 15) {
                        Button {
                            UISelectionFeedbackGenerator().selectionChanged()
                            
                        } label: {
                            Image(systemName: "circle")
                        }
                        .buttonStyle(PlainButtonStyle())
                        
                        Text(user)
                    }
                    .padding(.vertical, 8)
                    
                }
                
                .onDelete(perform: delete)
                .onMove(perform: onMove)
//                .listRowSeparator(.hidden)
//                .listRowBackground(Color.red)
                
                
            }
            
            
        }
        .edgesIgnoringSafeArea(.bottom)
        .navigationTitle("\(extraData()[0])  \(extraData()[1])")
        .toolbar {
            
            Button {
                OpenAddEvents.toggle()
            } label: {
                Image(systemName: "calendar.badge.plus")
                    .font(.caption)
                
            }
            .sheet(isPresented: $OpenAddEvents) {
                AddCalendarView()
            }
            
            NavigationLink(destination: AllCalendarView()) {
                
                Image(systemName: "calendar.badge.clock")
                    .font(.caption)
            }
            
            NavigationLink(destination: SemesterDetailsView()) {
                Image(systemName: "calendar.badge.plus")
                    .font(.caption)
            }
            
        }
        .background()
        
        
        .onChange(of: currentMonth) { newValue in
            
            // Updating Month...
            currentDate = getCurrentMonth()
        }
        
    }
    
    func delete(at offsets: IndexSet) {
        users.remove(atOffsets: offsets)
    }
    
    private func onMove(source: IndexSet, destination: Int) {
        users.move(fromOffsets: source, toOffset: destination)
    }
    
    func isSameDay(date1: Date, date2: Date) -> Bool {
        let calendar = Calendar.current
        
        return calendar.isDate(date1, inSameDayAs: date2)
    }
    
    func extraData() -> [String] {
        
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY MMMM"
        
        let date = formatter.string(from: currentDate)
        return date.components(separatedBy: " ")
        
    }
    
    @ViewBuilder
    func CardView(value: DateValue) -> some View {
        VStack(spacing: 0){
            
            if value.day != -1 {
                Text("\(value.day)")
                    .font(.headline)
                    .frame(maxHeight: .infinity)
                //                    .background(.green)
                
                Circle()
                    .fill(isSameDay(date1: value.date, date2: Date()) ? .black : .clear)
                    .frame(width: 5, height: 5)
                    .padding(.bottom, isSameDay(date1: value.date, date2: Date()) ? 4 : 0)
                
            }
        }
        .frame(width: 62, height: 62)
        
    }
    
    func getCurrentMonth() -> Date {
        
        let calendar = Calendar.current
        
        // Getting Current Month Date...
        guard let currentMonth = calendar.date(byAdding: .month, value: self.currentMonth, to: Date()) else {
            return Date()
        }
        return currentMonth
    }
    
    func extractDate() -> [DateValue]{
        
        let calendar = Calendar.current
        
        // Getting Current Month Date...
        let currentMonth = getCurrentMonth()
        
        var days = currentMonth.getAllDatesForMonth().compactMap { date -> DateValue in
            
            // Getting day...
            let day = calendar.component(.day, from: date)
            return DateValue(day: day, date: date)
        }
        
        // adding offset days to get exact week day...
        
        let firstWeekday = calendar.component(.weekday, from: days.first?.date ?? Date())
        for _ in 0..<firstWeekday - 1 {
            days.insert(DateValue(day: -1, date: Date()), at: 0)
        }
        
        return days
    }
    
}

struct CalendarView_Previews: PreviewProvider {
    static var previews: some View {
        CalendarView()
        //            .environment(\.locale, Locale(identifier: "fr"))
    }
}


extension Date {
    
    func getAllDatesForMonth() -> [Date] {
        
        let calendar = Calendar.current
        
        // Getting start Date...
        let startDate = calendar.date(from: Calendar.current.dateComponents([.year, .month], from: self))!
        
        let range = calendar.range(of: .day, in: .month, for: startDate)!
        
        
        
        // getting date...
        return range.compactMap { day -> Date in
            
            return calendar.date(byAdding: .day, value: day - 1, to: startDate)!
        }
    }
}
