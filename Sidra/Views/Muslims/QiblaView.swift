//
//  QiblaView.swift
//  Sidra
//
//  Created by AHMED ASSIRY on 16/04/1444 AH.
//

import SwiftUI
import AudioToolbox
import Adhan

struct QiblaView: View {
    
    @ObservedObject var compassHeading = CompassHeading()
    @StateObject var locationDataManager = LocationDataManager()
    
    var body: some View {
        
        let xx = -self.compassHeading.degrees
        let qibla = Qibla(coordinates: Coordinates(latitude: (locationDataManager.locationManager.location?.coordinate.latitude)!, longitude: (locationDataManager.locationManager.location?.coordinate.longitude)!)).direction
        
        VStack {
            
            HStack {
                
                Text("Direction \n \(Int(xx))")
                
                Spacer()
                
                Text("Qibla \n \(Int(qibla))")
                
            }
            .animation(.easeOut(duration: 0.8), value: Int(qibla) == Int(xx))
            .font(Int(qibla) == Int(xx) ? .headline : .title)
            .multilineTextAlignment(.center)
            .foregroundColor(Int(qibla) == Int(xx) ? .red : .black)
            .padding(.bottom, 32)
            .padding()
            
            
            Capsule()
                .frame(width: 5, height: 50)
                .padding(.bottom, 16)
            
            ZStack {
                ForEach(Marker.markers(), id: \.self) { marker in
                    CompassMarkerView(marker: marker,
                                      compassDegress: self.compassHeading.degrees)
                }
                
                Text("\(Int(xx))")
                    .fontWeight(.black)
                    
            }
            .onChange(of: xx, perform: { newValue in
                
                print(newValue)
                
                if Int(newValue) == Int(qibla) {
                    UINotificationFeedbackGenerator().notificationOccurred(.success)
                    
                }
            })
            .rotationEffect(Angle(degrees: self.compassHeading.degrees))
            
            
            
        }
        .navigationBarTitle("Qibla", displayMode: .automatic)
    }
}

struct QiblaView_Previews: PreviewProvider {
    static var previews: some View {
        QiblaView()
    }
}


struct Marker: Hashable {
    let degrees: Double
    let label: String
    
    init(degrees: Double, label: String = "") {
        self.degrees = degrees
        self.label = label
    }
    
    func degreeText() -> String {
        return String(format: "%.0f", self.degrees)
    }
    
    static func markers() -> [Marker] {
        return [
            Marker(degrees: 0, label: "N"),
            Marker(degrees: 30),
            Marker(degrees: 60),
            Marker(degrees: 90, label: "E"),
            Marker(degrees: 120),
            Marker(degrees: 150),
            Marker(degrees: 180, label: "S"),
            Marker(degrees: 210),
            Marker(degrees: 240),
            Marker(degrees: 270, label: "W"),
            Marker(degrees: 300),
            Marker(degrees: 330)
        ]
    }
}

struct CompassMarkerView: View {
    let marker: Marker
    let compassDegress: Double
    
    var body: some View {
        VStack {
            
            Image(systemName: self.marker.degrees == 240 ? "arrow.up" : "")
//                .padding(.bottom)
                .font(.system(size: 32, weight: .heavy, design: .rounded))
            
            Text(marker.degreeText() != "240" ? marker.degreeText() : "")
                .fontWeight(.ultraLight)
                .foregroundColor(self.qiblaColor())
                .rotationEffect(self.textAngle())
            
            Capsule()
                .frame(width: self.capsuleWidth(), height: self.capsuleHeight())
                .foregroundColor(self.capsuleColor())
            
            Text(marker.label)
                .fontWeight(.bold)
                .rotationEffect(self.textAngle())
                .padding(.bottom, 250)
            
        }
        .rotationEffect(Angle(degrees: marker.degrees))
        
    }
    
    private func capsuleWidth() -> CGFloat {
        return self.marker.degrees == 0 ? 7 : 3
    }
    
    private func capsuleHeight() -> CGFloat {
        return self.marker.degrees == 0 ? 35 : 20
    }
    
    private func capsuleColor() -> Color {
        return self.marker.degrees == 0 ? .red : .gray
    }
    
    private func qiblaColor() -> Color {
        return self.marker.degrees == 240 ? .red : .gray
    }
    
    private func textAngle() -> Angle {
        return Angle(degrees: -self.compassDegress - self.marker.degrees)
    }
}
