//
//  ServicesView.swift
//  Sidra
//
//  Created by AHMED ASSIRY on 15/04/1444 AH.
//

import SwiftUI

struct ServicesView: View {
    
    @State private var searchText = ""
    
    private let numberColumnsArray = Array(repeating: GridItem(.flexible()), count: 2)
    
    @AppStorage("ServicesSelectedGridOrList") private var gridOrList : Bool = false
    
    @AppStorage("colorkey") var storedColor: Color = .black
    
    var body: some View {
        VStack {
            
            ScrollView(.vertical, showsIndicators: false) {
                
                if gridOrList {
                    LazyVGrid(columns: numberColumnsArray, spacing: 8) {
                        
                        ForEach(servicesData.filter({"\($0)".localizedCaseInsensitiveContains(searchText) || searchText.isEmpty})) { i in
                            
                            NavigationLink {
                                ViewsContent(titleView: i.title)
                            } label: {
                                VStack(spacing: 8) {
                                    Text("\(i.title)")
                                        .frame(maxHeight: .infinity, alignment: .bottom)
                                        .foregroundColor(.primary)
                                    Text("\(i.section)")
                                        .font(.system(size: 12))
                                        .frame(maxHeight: .infinity, alignment: .top)
                                        .foregroundColor(storedColor)
                                }
                                .shadow(radius: 5)
                                .padding(8)
                                .frame(maxWidth: .infinity, minHeight: UIScreen.screenHeight / 5)
                            }
                            .background(Color(uiColor: .secondarySystemBackground))
                            .foregroundColor(.white)
                            .font(.system(size: 18).bold())
                            .cornerRadius(8)
                            
                        }
                    }
                } else {
                    
                    ForEach(servicesData.filter({"\($0)".localizedCaseInsensitiveContains(searchText) || searchText.isEmpty})) { i in
                        
                        NavigationLink {
                            ViewsContent(titleView: i.title)
                        } label: {
                            VStack(alignment: .leading, spacing: 4) {
                                Text("\(i.title)")
                                Text("\(i.section)")
                                    .font(.caption)
                                    .padding(.leading, 8)
                                    .foregroundColor(.gray)
                            }
                            .padding()
                            .frame(maxWidth: .infinity, alignment: .leading)
                        }
                        .background(Color(uiColor: .secondarySystemBackground))
                        .foregroundColor(.primary)
                        .font(.system(size: 18).bold())
                        .cornerRadius(8)
                        
                    }
                    
                    
                    
                    
                }
                
                
            }
            .animation(.easeInOut(duration: 1.0), value: gridOrList)
            .searchable(text: $searchText)
            .scrollDismissesKeyboard(.immediately)
            .padding([.leading, .trailing])
            .navigationBarTitle("Services", displayMode: .large)
        }
        .toolbar {
            
            ToolbarItem(placement: .navigationBarTrailing) {

                Button {
                    
                    UISelectionFeedbackGenerator().selectionChanged()
                    withAnimation(.easeInOut(duration: 0.5)) {
                        gridOrList.toggle()
                    }
                    
                } label: {
                    
                    Image(systemName: gridOrList ? "square.grid.2x2" : "list.bullet")
                }
            }
        }
        
    }
    
}

struct ServicesView_Previews: PreviewProvider {
    static var previews: some View {
        ServicesView()
    }
}

struct ServicesDataModel : Identifiable {
    
    let id = UUID()
    let title : String
    let section : String
    
}


var servicesData : [ServicesDataModel] = [
    .init(title: NSLocalizedString("Calculations", comment: "Calculations"), section: "Calculator, Mathmatics, Fitness, Health"),
    .init(title: NSLocalizedString("Convert Files", comment: "Convert Files"), section: "PDF, Images, Videos, Sounds, Excel, Word"),
//    .init(title: NSLocalizedString("Number Book", comment: "Number Book"), section: "Find the caller's name"),
//    .init(title: NSLocalizedString("Government", comment: "Government"), section: "Governmental services"),
        .init(title: NSLocalizedString("Information", comment: "Information"), section: "Device"),
//    .init(title: NSLocalizedString("Information", comment: "Information"), section: "Device, Caller, National address"),
//    .init(title: NSLocalizedString("Clean", comment: "Clean"), section: "Images, Contacts, duplicate, Memory"),
//    .init(title: NSLocalizedString("xxx", comment: "xxx"), section: "xxxx, xxxxx, xx"),
]


struct ContainerView<Content: View>: View {
    @ViewBuilder var content: Content
    
    var body: some View {
        content
            .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}


struct ViewsContent: View {
    
    var titleView : String!
    
    var body: some View {
        ContainerView {
            switch titleView {
            case NSLocalizedString("Calculations", comment: "Calculations"):
                CalculationMenuView()
            case NSLocalizedString("Convert Files", comment: "Convert Files"):
                ConvertFileView()
            case NSLocalizedString("Number Book", comment: "Number Book"):
                ContactsView()
            case NSLocalizedString("Information", comment: "Information"):
                InfoDeviceView()
            default:
                OTPView()
            }
        }
    }
    
}
