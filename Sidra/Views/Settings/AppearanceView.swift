//
//  AppearanceView.swift
//  Sidra
//
//  Created by AHMED ASSIRY on 30/02/1444 AH.
//

import SwiftUI

struct AppearanceView: View {
    
    let colorsGrid : [Color] = [.primary, .yellow, .red, .cyan, .orange, .purple]
    
    let imageGrid : [String] = ["AppIcon", "AppIcon 1", "AppIcon 2", "AppIcon 3", "AppIcon 4"]
    
    let columns = Array(repeating: GridItem(.flexible()), count: 4)
    
    @State var arrangInterface : [String] = ["Student", "Tasks", "Muslim", "Fitness"]
    
//    @State private var selectedPickerColor = Color.red
    
    @AppStorage("isDarkMode") private var isDarkMode = false
    
    @AppStorage("selectedAppearance") var selectedAppearance = 0
    var utilities = Utilities()
    
    @AppStorage("colorkey") var storedColor: Color = .black
    
    @AppStorage("Active_icon") var activeAppIcon : String = "AppIcon"
    
    var body: some View {
        
        List {
            
            Section(header: Text("App Color"), footer: Text("Change the main color of an application.")) {
                HStack {
                    
                    ForEach(colorsGrid, id: \.self) { color in
                        
                        Button {
                            
                            print("\(color.description)")
                            UISelectionFeedbackGenerator().selectionChanged()
                            storedColor = color
                            
                            
                        } label: {
                            ZStack {
                                Circle()
                                    .stroke(storedColor == color ? .gray : .black, lineWidth: 2)
                                    .frame(width: 35, height: 35)
                                    .background(
                                        Circle()
                                            .fill(color)
                                    )
                                
                                
                                
                                Image(systemName: storedColor == color ? "checkmark" : "")
                            }
                            
                            
                        }
                        .frame(maxWidth: .infinity)
                        
                    }
                    
                    ColorPicker("", selection: $storedColor, supportsOpacity: true)
                        .frame(width: 30, height: 30)
                        .shadow(color: .gray, radius: 2)
                        .frame(maxWidth: .infinity)
                }
                .padding(.vertical)
                
            }
            .textCase(nil)
            
            Section(header: Text("Night Mode"), footer: Text("Change the Night Mode (Background color).")) {
                
                HStack(spacing: 24) {
                    
                    
                    ZStack {
                        Button {
                            
                            print("\(Color.green.description)")
                            UISelectionFeedbackGenerator().selectionChanged()
                            selectedAppearance = 0
                            
                        } label: {
                            
                            RoundedRectangle(cornerRadius: 10, style: .continuous)
                                .fill(LinearGradient(colors: [.black, .white], startPoint: .leading, endPoint: .trailing))
                                .frame(height: 50)
                                .DShadow()
                            
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(selectedAppearance == 0 ? storedColor : .gray, lineWidth: selectedAppearance == 0 ? 2 : 0)
                                )
                            
                            
                        }
                        Text("System")
                            .font(.caption).bold()
                            .foregroundColor(selectedAppearance == 0 ? storedColor : .white)
                        
                        
                    }
                    .frame(maxWidth: .infinity)
                    
                    ZStack {
                        Button {
                            
                            print("\(Color.black.description)")
                            UISelectionFeedbackGenerator().selectionChanged()
                            selectedAppearance = 2
                            
                        } label: {
                            
                            RoundedRectangle(cornerRadius: 10, style: .continuous)
                                .fill(.black)
                                .frame(height: 50)
                                .DShadow()
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(selectedAppearance == 2 ? storedColor : .gray, lineWidth: selectedAppearance == 2 ? 2 : 0)
                                )
                            
                        }
                        
                        Text("Dark")
                            .font(.caption).bold()
                            .foregroundColor(selectedAppearance == 2 ? storedColor : .white)
                        
                    }
                    .frame(maxWidth: .infinity)
                    
                    
                    
                    
                    ZStack {
                        Button {

                            print("\(Color.white.description)")
                            UISelectionFeedbackGenerator().selectionChanged()
                            selectedAppearance = 1

                        } label: {

                            RoundedRectangle(cornerRadius: 10, style: .continuous)
                                .fill(.white)
                                .frame(height: 50)
                                .DShadow()
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(selectedAppearance == 1 ? storedColor : .gray, lineWidth: selectedAppearance == 1 ? 2 : 0)
                                )

                        }
                        Text("Light")
                            .font(.caption).bold()
                            .foregroundColor(selectedAppearance == 1 ? storedColor : .black)

                    }
                    .frame(maxWidth: .infinity)
                    
                    
                    
                    
                }
                .padding(.vertical, 8)
            }
            .textCase(nil)
            
            Section(header: Text("App Icon")) {
                LazyVGrid(columns: columns, spacing: 16) {
                    ForEach(imageGrid, id: \.self) { image in
                        
                        Button {
                            
                            print("\(image.description)")
                            UISelectionFeedbackGenerator().selectionChanged()
                            activeAppIcon = image
                            
                        } label: {
                            Image(uiImage: UIImage(named: image) ?? UIImage())
                                .resizable()
                                .frame(width: 60, height: 60)
                                .cornerRadius(8)
                                .shadow(color: .gray, radius: 2)
                            
                            
                        }
                    }
                }
                .padding(.vertical)
            }
            .textCase(nil)
            
            
            Section(header: Text("Arrangement of the app interface")) {
                
                ForEach($arrangInterface, id: \.self, editActions: .move) { $item in
                    HStack {
                        Text(item)
                        
                        Spacer()
                        
                        Image(systemName: "line.3.horizontal")
                    }
                    
                        .frame(maxHeight: .infinity)
                        
                }
                .onMove(perform: move)

                
                
            }
            .textCase(nil)
            
        }
        .buttonStyle(PlainButtonStyle())
        .onChange(of: selectedAppearance, perform: { value in
            utilities.overrideDisplayMode()
        })
        .onChange(of: activeAppIcon, perform: { value in
            
            UIApplication.shared.setAlternateIconName(value)
        })
        
    }
    
    func move(from source: IndexSet, to destination: Int) {
        // move the data here
        arrangInterface.move(fromOffsets: source, toOffset: destination)
    }
}

struct AppearanceView_Previews: PreviewProvider {
    static var previews: some View {
        AppearanceView()
    }
}


extension Color: RawRepresentable {

    public init?(rawValue: String) {
        
        guard let data = Data(base64Encoded: rawValue) else{
            self = .black
            return
        }
        
        do{
            let color = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as? UIColor ?? .black
            self = Color(color)
        }catch{
            self = .black
        }
        
    }

    public var rawValue: String {
        
        do{
            let data = try NSKeyedArchiver.archivedData(withRootObject: UIColor(self), requiringSecureCoding: false) as Data
            return data.base64EncodedString()
            
        }catch{
            
            return ""
            
        }
        
    }

}


class Utilities {

    @AppStorage("selectedAppearance") var selectedAppearance = 0
    var userInterfaceStyle: ColorScheme? = .dark

    func overrideDisplayMode() {
        var userInterfaceStyle: UIUserInterfaceStyle

        if selectedAppearance == 2 {
            userInterfaceStyle = .dark
        } else if selectedAppearance == 1 {
            userInterfaceStyle = .light
        } else {
            userInterfaceStyle = .unspecified
        }
    
        let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        windowScene?.windows.first?.overrideUserInterfaceStyle = userInterfaceStyle
        
    }
}
