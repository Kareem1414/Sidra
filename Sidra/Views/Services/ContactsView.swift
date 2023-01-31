//
//  ContactsView.swift
//  Sidra
//
//  Created by AHMED ASSIRY on 14/03/1444 AH.
//

import SwiftUI
import Contacts

struct ContactsView: View {
    
    @StateObject var contactsVM = ContactsViewModel()
    
    @State private var searchText = ""
    
    var body: some View {
        VStack {
            
            
            if contactsVM.authorizationStatus == .authorized {
                List {
                    
                    ForEach(contactsVM.contacts) { contact in

                        NavigationLink {
                            
                            List {
                                Image(uiImage: UIImage(data: contact.imageData ?? Data()) ?? UIImage())
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                
                                Text(contact.phoneNumber!)
                                
    //                            Text(String(contact.birthday))
                            }
                            

                        } label: {
                           
                            VStack(alignment: .leading) {
                                HStack {
                                    Label(contact.firstName, systemImage: "person.crop.circle")
                                    Text(contact.middleName)
                                    Text(contact.lastName)
                                }
                                Divider()
                                Label(contact.phoneNumber ?? "Not provided", systemImage: "apps.iphone")
                            }
                            .padding()
                            .background(.secondary.opacity(0.25))
                            .clipShape(RoundedRectangle(cornerRadius: 8.0, style: .continuous))
                            

                        }
                        

                    }
                    .listRowSeparator(.hidden)
                    .listRowBackground(Color.clear)
                }
                .listStyle(.plain)
                .navigationBarTitle("My Contacts", displayMode: .large)
                .searchable(text: $searchText, prompt: "Name, Phone, Email")
            } else {
                DeniedPermissionView(message: "We don't have access to contacts")
            }
            
        }
        
    }
    

    
//    var searchResults: [String] {
//            if searchText.isEmpty {
//                return names
//            } else {
//                return names.filter { $0.contains(searchText) }
//            }
//        }
    
    
}

struct ContactsView_Previews: PreviewProvider {
    static var previews: some View {
        ContactsView()
    }
}
