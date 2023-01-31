//
//  FitnessView.swift
//  Sidra
//
//  Created by AHMED ASSIRY on 28/02/1444 AH.
//

import SwiftUI
import HealthKit

struct FitnessView: View {
    
    private var healthStore : HealthStore?
    @State private var steps : [StepsModel] = [StepsModel]()
    
    init() {
        healthStore = HealthStore()
    }
    
    private func updateStepsUIFromStatistics(_ statisticsCollection: HKStatisticsCollection) {
        
        let startDate = Calendar.current.date(byAdding: .day, value: -7, to: Date())!
        
        let endDate = Date()
        
        statisticsCollection.enumerateStatistics(from: startDate, to: endDate) { (statistics, stop) in
            
            let count = statistics.sumQuantity()?.doubleValue(for: .count())
            
            let step = StepsModel(count: Int(count ?? 0), startDate: statistics.startDate, endDate: statistics.endDate)
            
            steps.append(step)
        }
    }

    var body: some View {
        
        List{
            
            Section {
                stepsFitnessInfo(title: "Steps", step: steps.last?.count ?? 0)
            }
            
            Section {
                activityFitnessInfo(title: "Calories", step: steps.last?.count ?? 0)
            }
            
            Section {
                sleepFitnessInfo(title: "Sleep", step: steps.last?.count ?? 0)
            }
            
            Section {
                sleepFitnessInfo(title: "Distance", step: steps.last?.count ?? 0)
            }
            
            Section {
                sleepFitnessInfo(title: "Stand", step: steps.last?.count ?? 0)
            }
            
            Section {
                stepsFitnessInfo(title: "Running", step: steps.last?.count ?? 0)
            }
            
            Section {
                activityFitnessInfo(title: "Water", step: steps.last?.count ?? 0)
            }
            
            
            
            .navigationBarTitle("Today", displayMode: .large)

            .frame(maxWidth: .infinity)
            
        }
        

        .onAppear {
            if let healthStore = healthStore {
                healthStore.requestAuthorization { success in
                    
                    if success {
                        
                        healthStore.calculateSteps { statisticsCollection in
                            
                            if let statisticsCollection = statisticsCollection {
                                // update the UI
                                updateStepsUIFromStatistics(statisticsCollection)
                            }
                            
                        }
                    }
                }
            }
        }
    }
    
    func stepsFitnessInfo(title: String, step: Int) -> some View {
        
        NavigationLink(destination: StepsInf()) {
            
            HStack(alignment: .top) {
                
                VStack(alignment: .leading) {
                    HStack {
                        Image(systemName: "flame.fill")
                        Text(title)
                    }
                    .padding(.vertical, 8)
                    .foregroundColor(.orange)
                    
                    Spacer()
                    
                    HStack {
                        Text("\(step)")
                            .font(.title2.bold())
                        
                        Text("steps")
                            .font(.caption)
                    }
                    .padding(.bottom)
                    
                }
                
                
                Spacer()
                
                ZStack {
                    CircularProgressView(progress: 0.44, BColor: .pink)
                        .frame(width: 80, height: 80)
                        .padding()
                    
                    Text("\(steps.last?.count ?? 0)")
                    
                }
            }
        }
    }
    
    func activityFitnessInfo(title: String, step: Int) -> some View {
        
        NavigationLink(destination: StepsInf()) {
            
            HStack(alignment: .top) {
                
                VStack(alignment: .leading) {
                    HStack {
                        Image(systemName: "flame.fill")
                        Text(title)
                    }
                    .padding(.vertical, 8)
                    .foregroundColor(.orange)
                    
                    Spacer()
                    
                    HStack {
                        Text("\(step)")
                            .font(.title2.bold())
                        
                        Text("steps")
                            .font(.caption)
                    }
                    .padding(.bottom)
                    
                }
                
                Spacer()
                
                ZStack {
                    CircularProgressView(progress: 0.44, BColor: .pink)
                        .frame(width: 80, height: 80)
                        .padding()
                    
                    Text("\(steps.last?.count ?? 0)")
                    
                }
            }
        }
    }
    
    func sleepFitnessInfo(title: String, step: Int) -> some View {
        
        NavigationLink(destination: StepsInf()) {
            
            HStack(alignment: .top) {
                
                VStack(alignment: .leading) {
                    HStack {
                        Image(systemName: "flame.fill")
                        Text(title)
                    }
                    .padding(.vertical, 8)
                    .foregroundColor(.orange)
                    
                    Spacer()
                    
                    HStack {
                        Text("\(step)")
                            .font(.title2.bold())
                        
                        Text("steps")
                            .font(.caption)
                    }
                    .padding(.bottom)
                    
                }
                
                Spacer()
                
                ZStack {
                    CircularProgressView(progress: 0.44, BColor: .pink)
                        .frame(width: 80, height: 80)
                        .padding()
                    
                    Text("\(steps.last?.count ?? 0)")
                    
                }
            }
        }
    }
    
    // MARK: Header
    func StepsInf() -> some View {
        
        List(steps, id: \.id) { step in
            VStack(alignment: .leading) {
                HStack {

                    Text("\(step.count)")
                        .font(.largeTitle)
                    
                    Text("steps")
                        .font(.caption)
                        
                    
                    Spacer()
                    Image(systemName: "applewatch")
                    
                }
                .background(.green)
                .padding(.bottom, 4)
                
                HStack {
                    Text("\(step.startDate, style: .date)")
                        .font(.caption)
                    
                    Image(systemName: "arrow.forward")
                    Spacer()
                    
                    Text("\(step.endDate, style: .date)")
                        .font(.caption)
                }
                .frame(maxWidth: .infinity)
            }
            .navigationTitle("Today")
            .navigationBarTitleDisplayMode(.large)
            
        }
        
    }
}

struct FitnessView_Previews: PreviewProvider {
    static var previews: some View {
        FitnessView()
    }
}



struct CircularProgressView: View {
    // 1
    @State var progress: Double
    @State var percentage = 0.0
    @State var BColor: Color
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(
                    .gray.opacity(0.3),
                    lineWidth: 8
                )
            
            Circle()
            // 2
                .trim(from: 0, to: CGFloat(min(self.percentage, 5.0)))
                .stroke(
                    BColor,
                    style: StrokeStyle(
                        lineWidth: 10,
                        lineCap: .round,
                        lineJoin: .round
                    )
                )
                .rotationEffect(.degrees(-90))
                .onAppear {
                    withAnimation {
                        percentage = progress
                    }
                    
                }
                .shadow(color: BColor, radius: 5)
        }
        
    }
}
