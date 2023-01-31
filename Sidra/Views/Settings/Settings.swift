//
//  Settings.swift
//  Sidra
//
//  Created by AHMED ASSIRY on 25/02/1444 AH.
//

import SwiftUI


struct Settings: View {
    
    @State private var isPremiumSheet = false
    
    @StateObject var faceIDModel : FaceIDViewModel = FaceIDViewModel()
    
    @AppStorage("is_Face_ID_Enabled") var isFaceIDEnabled: Bool = false
    @AppStorage("Face_ID_Minutes") var faceIDMinutes: Int = 0
    
    @AppStorage("colorkey") var storedColor: Color = .black
    
    var body: some View {
        
        VStack(spacing: 0){
            
            
            Button {
                
                print("Good Preimum")
                UISelectionFeedbackGenerator().selectionChanged()
                isPremiumSheet.toggle()
                
            } label: {
                
                ZStack {
                    
                    LottieView(animationName: "9",
                               loopMode: .loop,
                               contentMode: .scaleAspectFill)
                    .blur(radius: 1)
                    
                    HStack(spacing: 12) {
                        Image("Image1")
                            .resizable()
                            .frame(width: 45, height: 45)
                            .clipShape(Circle())
                            .overlay(Circle().stroke(Color.white, lineWidth: 3))
                            .shadow(radius: 5)
                        
                        VStack(alignment: .leading, spacing: 6) {
                            Text("Unlock all features")
                                .font(.system(size: 17).bold())
                            
                            Text("Enjoy all the features of the pro version")
                                .font(.system(size: 12))
                        }
                        .padding(.leading, 4)
                        
                        Spacer()
                        
                        Image(systemName: "chevron.forward")
                    }
                    .padding(.vertical, 8)
                }
                .frame(maxHeight: 100)
            }
            .padding(.horizontal)
            .sheet(isPresented: $isPremiumSheet) {
                PremiumView()
            }
            .background(
                RoundedRectangle(cornerRadius: 16, style: .continuous)
                    .fill(LinearGradient(colors: [.pink, .red], startPoint: .topLeading, endPoint: .bottomTrailing))
            )
            .foregroundColor(.white)
//            .padding(.top, 16)
            .padding(.horizontal, 18)
            
            List {
                
                Section {
                    
                    NavigationLink(destination: Login()) {
                        labelSettings(nameImage: "person.crop.circle.fill", BColor: .orange, Bforeground: .white, title: NSLocalizedString("Profile", comment: ""))
                        
                    }
                    
                    NavigationLink(destination: AppearanceView()) {
                        labelSettings(nameImage: "paintbrush.fill", BColor: .blue, Bforeground: .white, title: NSLocalizedString("Appearance", comment: ""))
                        //                            Label("Appearance", systemImage: "paintbrush")
                    }
                    
                }
                
                Section {
                    NavigationLink(destination: NotificationsView()) {
                        labelSettings(nameImage: "bell.badge.fill", BColor: .red, Bforeground: .white, title: NSLocalizedString("Notifications", comment: ""))
                        
                    }
                    
                    
                    NavigationLink(destination: AdvancedView()) {
                        labelSettings(nameImage: "gearshape.2.fill", BColor: .mint, Bforeground: .white, title: NSLocalizedString("Advanced", comment: ""))
                            .offset(x: -3)
                    }
                    
                    NavigationLink(
                        destination: faceIDSettings(),
                        isActive: $faceIDModel.isUnlocked,
                        label: {
                            labelSettings(nameImage: "faceid", BColor: .green, Bforeground: .white, title: NSLocalizedString("Face ID", comment: ""))
                        }
                    )
                    
                }
                
                Section {
                    
                    NavigationLink(destination: CalendarSettingsView()) {
                        labelSettings(nameImage: "calendar", BColor: .white, Bforeground: .red, title: NSLocalizedString("Calendar", comment: ""))
                    }
                    
                    NavigationLink(destination: StudentSettingsView()) {
                        labelSettings(nameImage: "graduationcap.fill", BColor: .white, Bforeground: .red, title: NSLocalizedString("Student", comment: ""))
                            .offset(x: -2)
                    }
                    
                    NavigationLink(destination: MuslimSettingsView()) {
                        labelSettings(nameImage: "books.vertical.fill", BColor: .white, Bforeground: .red, title: NSLocalizedString("Muslim", comment: ""))
                            .offset(x: -2)
                    }
                    
                    NavigationLink(destination: SoundsSettingsView()) {
                        labelSettings(nameImage: "airpodsmax", BColor: .white, Bforeground: .red, title: NSLocalizedString("Sounds", comment: ""))
                            .offset(x: -1)
                    }
                    
                    NavigationLink(destination: FitnessSettingsView()) {
                        labelSettings(nameImage: "flame.fill", BColor: .white, Bforeground: .red, title: NSLocalizedString("Fitness", comment: ""))
                            .offset(x: 2)
                    }
                    labelSettings(nameImage: "applewatch.watchface", BColor: .white, Bforeground: .red, title: NSLocalizedString("Watch", comment: ""))
                        .offset(x: 2)
                    labelSettings(nameImage: "square.stack.3d.down.forward", BColor: .white, Bforeground: .red, title: NSLocalizedString("Widgets", comment: ""))
                        
                    
                }
                
                Section {
                    
                    Button {
                        UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
                    } label: {
                        HStack {
                            Label("Language", systemImage: "globe")
                            Spacer()
                            Image(systemName: Locale.preferredLanguages[0] == "ar-SA" ? "chevron.left" : "chevron.right" )
                                .font(.system(size: 13)).bold()
                                    .foregroundColor(Color(UIColor.systemGray3))
                        }
                        
                    }
                    
                    
                    NavigationLink(destination: SiriView()) {
                        Label {
                            Text("Siri")
                            
                        }icon: {
                            Image("SiriLogo")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 30, height: 30)
                            
                        }
                    }
                    
                    NavigationLink(destination: ShortcutsView()) {
                        Label {
                            Text("Shortcuts")
                            
                        }icon: {
                            Image("ShortcutsLogo")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 30, height: 30)
                            
                        }
                    }
                    
                }
                
                Section {
                    
                    NavigationLink(destination: AboutView()) {
                        labelSettings(nameImage: "checkmark.circle.badge.questionmark.fill", BColor: .blue, Bforeground: .white, title: NSLocalizedString("About", comment: ""))
                    }
                }
                
                Section {
                    let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
                    VStack{
                        
                        Text(appVersion!)
                            .foregroundColor(.gray)
                        
                        Button {
                            print("What's New")
                        } label: {
                            Text("What's New")
                                .font(.system(size: 12))
                                .foregroundColor(.blue)
                        }
                        
                        
                    }
                    .frame(maxWidth: .infinity, alignment: .center)
                    .listRowBackground(Color.clear)
                    
                }
            }
            .listStyle(.insetGrouped)
            
        }
        .background(Color(.systemGray6))
        .foregroundColor(.primary)
        
    }
    
    func labelSettings(nameImage: String, BColor: Color, Bforeground: Color, title: String) -> some View {
        
        HStack(spacing: 25) {
            Image(systemName: nameImage)
                .foregroundColor(Bforeground)
                .background(RoundedRectangle(cornerRadius: 6, style: .continuous)
                    .fill(BColor)
                            
                    .frame(width: 30, height: 30)
                )
            
                .overlay( /// apply a rounded border
                    RoundedRectangle(cornerRadius: 6)
                        .stroke(.gray, lineWidth: 0.2)
                        .frame(width: 30, height: 30)
                )
            
            Text(title)
                .padding(.vertical, 6)
            
        }
        
    }
    
    func faceIDSettings() -> some View {
        
        List {
            Section {
                Toggle("Face ID", isOn: $isFaceIDEnabled)
                    .onChange(of: isFaceIDEnabled) { newValue in
                        withAnimation {
                            isFaceIDEnabled = newValue
                        }
                        
                    }
                    .padding(.vertical, 8)
            }
            
            Section {
                if isFaceIDEnabled {
                    
                    Button {
                        withAnimation {
                            faceIDMinutes = 0
                        }
                    } label: {
                        HStack {
                            Text("Dirctly")
                            Spacer()
                            Image(systemName: faceIDMinutes == 0 ? "checkmark" : "")
                                .font(.system(size: 14).bold())
                        }
                    }
                    
                    Button {
                        withAnimation {
                            faceIDMinutes = 30
                        }
                    } label: {
                        HStack {
                            Text("After 30 Seconds")
                            Spacer()
                            Image(systemName: faceIDMinutes == 30 ? "checkmark" : "")
                                .font(.system(size: 14).bold())
                        }
                    }
                    
                    Button {
                        withAnimation {
                            faceIDMinutes = 1
                        }
                    } label: {
                        HStack {
                            Text("After 1 minutes")
                            Spacer()
                            Image(systemName: faceIDMinutes == 1 ? "checkmark" : "")
                                .font(.system(size: 14).bold())
                        }
                    }
                    
                    Button {
                        withAnimation {
                            faceIDMinutes = 5
                        }
                    } label: {
                        HStack {
                            Text("After 5 minutes")
                            Spacer()
                            Image(systemName: faceIDMinutes == 5 ? "checkmark" : "")
                                .font(.system(size: 14).bold())
                        }
                    }
                    
                    Button {
                        withAnimation {
                            faceIDMinutes = 15
                        }
                    } label: {
                        HStack {
                            Text("After 15 minutes")
                            Spacer()
                            Image(systemName: faceIDMinutes == 15 ? "checkmark" : "")
                                .font(.system(size: 14).bold())
                        }
                    }
                    
                    Button {
                        withAnimation {
                            faceIDMinutes = 60
                        }
                    } label: {
                        HStack {
                            Text("After one hour")
                            Spacer()
                            Image(systemName: faceIDMinutes == 60 ? "checkmark" : "")
                                .font(.system(size: 14).bold())
                        }
                    }
                }
                    
            }
            .onChange(of: faceIDMinutes) { newValue in
                UISelectionFeedbackGenerator().selectionChanged()
            }
        }
    }
}

struct Settings_Previews: PreviewProvider {
    static var previews: some View {
        Settings()
    }
}



