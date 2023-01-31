//
//  StudentScheduleView.swift
//  Sidra
//
//  Created by AHMED ASSIRY on 14/05/1444 AH.
//

import SwiftUI

struct StudentScheduleView: View {
    var body: some View {
        VStack(spacing: 16) {
            
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            
            NavigationLink(destination: SubjectDetailsView()) {
                Text("Subject")
            }
            
        }

    }
}

struct StudentScheduleView_Previews: PreviewProvider {
    static var previews: some View {
        StudentScheduleView()
    }
}
