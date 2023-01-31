//
//  FitnessRingCardView.swift
//  MinimalAnimation-2
//
//  Created by AHMED ASSIRY on 08/07/1444 AH.
//

import SwiftUI

struct FitnessCardView: View {
    
    @State var numberFitness : Bool = true
    
    @AppStorage("colorkey") var storedColor: Color = .red
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            HStack(spacing: 8) {
                Image(systemName: "flame.fill")
                Text("Activity")
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .foregroundColor(storedColor)

            
            HStack(spacing: 16) {
                
                // Progress Ring
                NavigationLink(destination: FitnessView()) {
                    ZStack {
                        ForEach(rings.indices, id: \.self) { index in
                            ZStack {
                                
                                Circle()
                                    .stroke(.gray.opacity(0.3), lineWidth: 10)
                                
                                Circle()
                                    .trim(from: 0, to: rings[index].progress / 100)
                                    .stroke(rings[index].keyColor, style: StrokeStyle(lineWidth: 10, lineCap: .round, lineJoin: .round))
                                    .rotationEffect(.init(degrees: -90))
                                
                            }
                            .padding(CGFloat(index) * 13)
                        }
                    }
                    .frame(width: UIScreen.screenWidth / 3.2)
                }
                
                VStack(alignment: .leading, spacing: 5) {
                    ForEach(rings) { ring in
                        
                        Label {
                            
                            HStack(spacing: 8) {
                                
                                HStack(alignment: .bottom, spacing: 1) {
                                    Text("\(numberFitness ? Int(ring.progress) : Int(ring.progress * 3))")
                                        .font(.title2)
                                        
                                    Text(numberFitness ? "%" : "")
                                        .font(.system(size: 12))
                                        .offset(y: -3)
                                }
                                .lineLimit(1)
                                .fixedSize()
                                
                                
                                Text(numberFitness ? NSLocalizedString(ring.value, comment: ring.value) : NSLocalizedString(ring.unit, comment: ring.unit))
                                    .font(.caption)
                                    .lineLimit(1)
                                    .fixedSize()
                            }
                            
                        } icon: {
                            Group {
                                if ring.isText {
                                    Text(ring.keyIcon)
                                        .font(.title2)
                                    
                                    
                                } else {
                                    Image(systemName: ring.keyIcon)
                                        .foregroundColor(ring.keyColor)
                                }
                            }
                            .frame(width: 30)
                        }
                    }
                }
                .animation(.easeInOut(duration: 1), value: numberFitness)
                .padding(.leading, 8)
                .onTapGesture {
                    withAnimation {
                        numberFitness.toggle()
                        UISelectionFeedbackGenerator().selectionChanged()
                    }
                }
            }
            
        }
        
        .padding(.horizontal, 20)
        .padding(.vertical)
        .background {
            RoundedRectangle(cornerRadius: 8, style: .continuous)
                .fill(Color(UIColor.tertiarySystemBackground))
        }
        .padding()
        
    }
}

struct FitnessCardView_Previews: PreviewProvider {
    static var previews: some View {
        FitnessCardView()
    }
}


// MARK: Progress Ring Model and Sample Data
struct Ring : Identifiable {
    var id = UUID().uuidString
    var progress : CGFloat
    var value : String
    var unit : String
    var keyIcon : String
    var keyColor : Color
    var isText : Bool = false
}



var rings : [Ring] = [
    Ring(progress: 72, value: "Steps", unit: "steps", keyIcon : "figure.walk", keyColor: .cyan),
    Ring(progress: 36, value: "Calories", unit: "calories", keyIcon : "flame", keyColor: .red),
    Ring(progress: 48, value: "Exercise", unit: "minutes", keyIcon : "figure.step.training", keyColor: .green),
//    Ring(progress: 88, value: "Sleep time", unit: "hours", keyIcon : "moon.zzz.fill", keyColor: .purple),
    Ring(progress: 7, value: "Stand Up", unit: "hours", keyIcon : "figure.stand", keyColor: .yellow)
]
