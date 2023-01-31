//
//  DynamicFilteredView.swift
//  Sidra
//
//  Created by AHMED ASSIRY on 24/02/1444 AH.
//

import SwiftUI
import CoreData

struct DynamicFilteredView<Content: View, T>: View where T: NSManagedObject{
    
    // MARK: Core Data Request
    @FetchRequest var request : FetchedResults<T>
    let content: (T) -> Content
    
    // MARK: Core Data Context
    @Environment(\.managedObjectContext) var context
    
    // MARK: Building Custom ForEach which will give Coredata object to build View
    init(dateFilter: Date, @ViewBuilder content: @escaping (T) -> Content){
        
        // MARK: Predicate to Filter current date Tasks
        let calendar = Calendar.current
        
        let today = calendar.startOfDay(for: dateFilter)
        let tommorow = calendar.date(byAdding: .day, value: 1, to: today)!
        
        // Filter Key
        let filterKey = "taskDate"
        
        // This will fetch task between today and tommorow which is 24 HRS
        let predicate = NSPredicate(format: "\(filterKey) >= %@ AND \(filterKey) < %@", argumentArray: [today, tommorow])
        
        // Intializing Request with NSPredicate
        // Adding Sort
        _request = FetchRequest(entity: T.entity(), sortDescriptors: [.init(keyPath: \TaskCoreData.taskDate, ascending: false)], predicate: predicate, animation: .default)
        self.content = content
    }
    
    var body: some View {
        
        Group {
            if request.isEmpty {
                
                VStack(spacing: 0) {
                    
                    LottieView(animationName: "15",
                               loopMode: .playOnce,
                               contentMode: .scaleAspectFit)
                    .frame(width: UIScreen.screenWidth / 1.2, height: UIScreen.screenWidth / 1.5)
                    
                    Text("Nothing today..")
                        .font(.title2)
                        .foregroundColor(.primary)
                }

                
            } else {
                
                ForEach(request, id: \.objectID) { object in
                    self.content(object)
                }
                
            }
        }
    }
}
