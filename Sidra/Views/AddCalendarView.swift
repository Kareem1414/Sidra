//
//  AddCalendarView.swift
//  Sidra
//
//  Created by AHMED ASSIRY on 13/03/1444 AH.
//

import SwiftUI

struct AddCalendarView: View {
    var body: some View {
        List {
            Section {
                rowList(image: "calendar", text: "School calendar", subtext: "Add the school calendar to your personal calendar")
            }
            
            Section {
                rowList(image: "film", text: "Movies", subtext: "Add Latest movie releases calendar to your personal calendar")
            }
            
            Section {
                rowList(image: "calendar.badge.exclamationmark", text: "Personal Calendar", subtext: "Add your personal calendar")
            }
            
            
            
            
        }
    }
    
    func rowList(image: String, text: String, subtext: String) -> some View {
        
        HStack {
            
            Image(systemName: image)
                
            VStack(alignment: .leading) {
                
                Text(text)
                    .padding(.bottom,1)
                Text(subtext)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.system(size: 10))
        
            }
            .padding(.leading, 8)
            
            Button {
                UISelectionFeedbackGenerator().selectionChanged()
            } label: {
                Image(systemName: "plus")
            }

            
            
        }
        .padding(.vertical, 8)
    }
}

struct AddCalendarView_Previews: PreviewProvider {
    static var previews: some View {
        AddCalendarView()
    }
}
