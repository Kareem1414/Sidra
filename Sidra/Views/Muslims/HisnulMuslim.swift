//
//  HisnulMuslim.swift
//  Sidra
//
//  Created by AHMED ASSIRY on 28/02/1444 AH.
//

import SwiftUI
import AVFoundation

struct HisnulMuslim: View {
    
    @State var song1 = false
    @StateObject private var soundManager = SoundManager()
    
    let xxx : Welcome = Bundle.main.load("HisnMuslim_EN.json")
    
    @State private var searchText = ""
    
    var body: some View {
        
//            Text("\((welcome?.english[0].id)!)")
//            Text("\((welcome?.english.count)!)")
//            Text("\((welcome?.english[0].text[0].languageArabicTranslatedText)!)")
       
        VStack {
//            Image(systemName: "calendar")
//                .padding()
            List {
                ForEach(xxx.english, id: \.id) { i in

                    cardHisnulMuslim(ID: "\(i.id)", title: i.title, audioURL: URL(string: "\(i.audioURL)")!, text: i.text)
                    
                }
                .listRowSeparator(.hidden)
                .listRowBackground(Color.clear)
            }
            .listStyle(.plain)
            .navigationTitle("Hisnul Al-Muslim")
        }
        .searchable(text: $searchText)
        
    }
    
    func cardHisnulMuslim(ID: String, title: String, audioURL: URL, text: [Texts]) -> some View {
        
        NavigationLink(destination: cardDetails(details: text).edgesIgnoringSafeArea(.bottom)) {
                
                HStack(alignment: .top, spacing: 16) {
                    VStack{
                        Button {
                            soundManager.playSound(sound: "\(audioURL)")
                            song1.toggle()
                            
                            if song1{
                                soundManager.audioPlayer?.play()
                            } else {
                                soundManager.audioPlayer?.pause()
                            }
                            
                        } label: {
                            
                            Image(systemName: song1 ? "pause.circle.fill": "play.circle.fill")
                                .font(.system(size: 25))
                                
                        }
                        
                        .frame(maxHeight: .infinity)
                        .buttonStyle(PlainButtonStyle())
                        .padding()
                        
//                        Text("\(ID)")
                    }
                    .frame(maxHeight: .infinity)
                    .background(.green)
                    
                    Text("\(title)")
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
//                        .padding([.top, .bottom], 8)
                        .font(.system(size: 14))
                    
                    
                }
            }
            .padding(.trailing)
            .frame(maxWidth: .infinity)
            .background()
            .cornerRadius(8)
            .DShadow()
            .padding(.vertical, 2)
    }
    
    func cardDetails(details: [Texts]) -> some View {
        
        List {
            ForEach(details, id: \.id) { i in
                VStack {
                    Text("\(i.id)")
                    //                    Text("\(i.text)")
                    Text(i.arabicText!)
                    Text(i.languageArabicTranslatedText!)
                    Text(i.translatedText!)
                    Text("\(i.textRepeat)")
                    
                    Button {
                        soundManager.playSound(sound: "\(i.audio)")
                        song1.toggle()
                        
                        if song1{
                            soundManager.audioPlayer?.play()
                        } else {
                            soundManager.audioPlayer?.pause()
                        }
                    } label: {
                        Image(systemName: song1 ? "pause.circle.fill": "play.circle.fill")
                            .font(.system(size: 25))
                    }
                    .frame(maxHeight: .infinity)
                    .buttonStyle(PlainButtonStyle())
                    .padding()
                }
                
                
            }
        }
        .frame(maxWidth: .infinity)
        .cornerRadius(16)
        .DShadow()
        
    }
}

struct HisnulMuslim_Previews: PreviewProvider {
    static var previews: some View {
        HisnulMuslim()
    }
}


// MARK: - Welcome
struct Welcome: Codable {
    let english: [English]

    enum CodingKeys: String, CodingKey {
        case english = "English"
    }
}

// MARK: - English
struct English: Codable {
    let id: Int
    let title: String
    let audioURL: String
    let text: [Texts]

    enum CodingKeys: String, CodingKey {
        case id = "ID"
        case title = "TITLE"
        case audioURL = "AUDIO_URL"
        case text = "TEXT"
    }
}

// MARK: - Text
struct Texts: Codable {
    let id: Int
    let arabicText, languageArabicTranslatedText, translatedText: String?
    let textRepeat: Int
    let audio: String
    let text: String?

    enum CodingKeys: String, CodingKey {
        case id = "ID"
        case arabicText = "ARABIC_TEXT"
        case languageArabicTranslatedText = "LANGUAGE_ARABIC_TRANSLATED_TEXT"
        case translatedText = "TRANSLATED_TEXT"
        case textRepeat = "REPEAT"
        case audio = "AUDIO"
        case text = "Text"
    }
}


class SoundManager : ObservableObject {
    var audioPlayer: AVPlayer?

    func playSound(sound: String){
        if let url = URL(string: sound) {
            self.audioPlayer = AVPlayer(url: url)
        }
    }
}



struct HisnulMuslimSmall: View {
    var body: some View {
        
        HStack(alignment: .top) {
            VStack {
                Text("Hisnul Al-Muslim")
                Button {
                    
                } label: {
                    Text(typeAthkar() == "Morning" ? "Athkar for morning" : typeAthkar() == "Evening" ? "Athkar for Evening" : "")
                }
            }
        }

    }
    
    func typeAthkar() -> String {
        
        let hour = Calendar.current.component(.hour, from: Date())

        switch hour {
        case 6..<12 : return(NSLocalizedString("Morning", comment: "Morning"))
        case 12 : return(NSLocalizedString("Noon", comment: "Noon"))
        case 13..<17 : return(NSLocalizedString("Afternoon", comment: "Afternoon"))
        case 17..<22 : return(NSLocalizedString("Evening", comment: "Evening"))
        default: return(NSLocalizedString("Night", comment: "Night"))
        }
    }
}

struct HisnulMuslimSmall_Previews: PreviewProvider {
    static var previews: some View {
        HisnulMuslimSmall()
    }
}
