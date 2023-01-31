//
//  QuranHomeView.swift
//  Sidra
//
//  Created by AHMED ASSIRY on 10/03/1444 AH.
//

import SwiftUI

struct QuranHomeView: View {
    
    let QuranIndexInfo : [WelcomeElement] = Bundle.main.load("QuranIndex_EN.json")
    
    @State private var showDetailsQuran = false
    @State private var showStartKhatmah = false
    @State private var favoriteKhatmah = 0
    
    @State private var dayKhatmah = 30
    @State private var juzKhatmah = 1
    
    @State var title = ""
    @State var count = ""
    @State var place = ""
    @State var type = ""
    @State var index = ""
    @State var pages = ""
    
    var body: some View {
        
        VStack {
            HStack {
                Image(systemName: "book")
                
                Text("Start new khatma")
                
                Button {
                    print("Go ahead")
                    showStartKhatmah.toggle()
                    UISelectionFeedbackGenerator().selectionChanged()
                } label: {
                    Text("Start")
                        .padding(.horizontal)
                }
                //                    .buttonStyle(.borderedProminent)
                .sheet(isPresented: $showStartKhatmah) {
                    VStack {
                        
                        List {
                            Section(header: Text("New Khatmah"), footer: Text("Reading of Qur'an by juzs, pages, or days.")) {
                                
                                Picker("New Khatmah by", selection: $favoriteKhatmah) {
                                    Text("").tag(0)
                                    Text("Pages").tag(1)
                                    Text("juz").tag(2)
                                    Text("Days").tag(3)
                                    Text("Meaning").tag(4)
                                }
                                .pickerStyle(.automatic)
                            }
                            .headerProminence(.increased)
                            
                            Section {
                                switch favoriteKhatmah {
                                case 1:
                                    Text("Ahmed")
                                case 2:
                                    
                                    Stepper("\(juzKhatmah)  Juz", value: $juzKhatmah, in: 1...30)
                                        .padding(.vertical, 8)
                                    HStack {
                                        Text("Period:")
                                        Spacer()
                                        Text(" \(30 / juzKhatmah) days")
                                    }
                                    
                                    
                                    HStack {
                                        Text("Every Day:")
                                        Spacer()
                                        Text("\(juzKhatmah * 20) Pages")
                                    }
                                    
                                case 3:
                                    
                                    Stepper("\(dayKhatmah) days", value: $dayKhatmah, in: 1...365)
                                    Text("Every day: \(624 / dayKhatmah)  Pages")
                                    
                                case 4:
                                    Text("Assiry")
                                default:
                                    Text("")
                                }
                            }
                            
                            
                            
                        }
                        .padding(.top, 8)
//                        .listRowSeparator(.hidden)
                        .listRowBackground(Color.clear)
                        .background(.clear)
                        
                        Button {
                            print("Start New khatmah")
                            UISelectionFeedbackGenerator().selectionChanged()
                            
                        } label: {
                            Text("Start")
                                .padding()
                        }
                        .disabled(favoriteKhatmah == 0)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .cornerRadius(8)
                        .background(favoriteKhatmah == 0 ? Color(.systemGray2) : .green)
                    }
                    .presentationDetents([.large])
                }
            }
            .padding()
            .frame(maxWidth: .infinity)
            .padding()
            .background()
            .cornerRadius(16)
            .DShadow()
            
            HStack {
                NavigationLink(destination: ReaderView()) {
                    Text("Readers")
                        .padding()
                        .frame(maxWidth: .infinity)
                }
                NavigationLink(destination: SoundsReadersView()) {
                    Text("Sounds Readers")
                        .padding()
                        .frame(maxWidth: .infinity)
                }
            }
            .padding()
            
            List {
                
                NavigationLink(destination: QuranView()) {
                    Label {
                        Text("Continue Reading")
                    } icon: {
                        Image(systemName: "book")
                    }
                }
                .padding(.vertical)
                ForEach(0..<QuranIndexInfo.count, id: \.self) { index in
                    HStack {
                        
                        Text("\(Int(QuranIndexInfo[index].index)!)")
                            .padding()
                        
                        VStack {
                            
                            Text("\(QuranIndexInfo[index].title)")
                                .padding(.top, 20)
                                .bold()
                            
                            Text("Juz: \(Int(QuranIndexInfo[index].juz[0].index)!)")
                                .font(.system(size: 14))
                            
                        }
                        
                        Spacer()
                        
                        VStack {
                            
                            Button(action: {
                                
                                showDetailsQuran.toggle()
                                print("\(QuranIndexInfo[index].pages)")
                                title = "\(QuranIndexInfo[index].title)"
                                count = "\(QuranIndexInfo[index].count)"
                                place = "\(QuranIndexInfo[index].place)"
                                type = "\(QuranIndexInfo[index].type)"
                                self.index = "\(QuranIndexInfo[index].index)"
                                pages = "\(QuranIndexInfo[index].pages)"
                                
                            }, label: {
                                
                                Text("\(QuranIndexInfo[index].pages)")
                                    .font(.system(size: 14))
                                    .frame(width: 30, height: 20, alignment: .center)
                                    .padding()
                            })
                            //                        .buttonStyle(.borderedProminent)
                            .sheet(isPresented: $showDetailsQuran) {
                                VStack{
                                    Text("\(title)")
                                    Text("\(count)")
                                    Text("\(place)")
                                    Text("\(type)")
                                    Text("\(self.index)")
                                    Text("\(pages)")
                                        .padding()
                                    VStack {
                                        Text("\(title)")
                                        Text("\(count)")
                                        Text("\(place)")
                                        Text("\(type)")
                                        Text("\(self.index)")
                                        Text("\(pages)")
                                    }
                                    
                                }
                                .background(.green)
                                .presentationDetents([.medium])
                            }
                        }
                    }
                }
            }
            .buttonStyle(BorderlessButtonStyle())
        }
        
    }
    
    func selectedNewKhatmah(index: Int) -> some View {
        
        VStack {
            Text("\(index)")
            Text("Start")
            Text("Start")
        }
        
    }
}

struct QuranHomeView_Previews: PreviewProvider {
    static var previews: some View {
        QuranHomeView()
    }
}


// MARK: - WelcomeElement
struct WelcomeElement: Codable {
    let place: Place
    let type: TypeEnum
    let count: Int
    let title, titleAr, index, pages: String
    let juz: [Juz]
}

// MARK: - Juz
struct Juz: Codable {
    let index: String
    let verse: Verse
}

// MARK: - Verse
struct Verse: Codable {
    let start, end: String
}

enum Place: String, Codable {
    case mecca = "Mecca"
    case medina = "Medina"
}

enum TypeEnum: String, Codable {
    case madaniyah = "Madaniyah"
    case makkiyah = "Makkiyah"
}


