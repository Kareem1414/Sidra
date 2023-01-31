//
//  NamesOfAllahView.swift
//  Sidra
//
//  Created by AHMED ASSIRY on 05/03/1444 AH.
//

import SwiftUI

struct NamesOfAllahView: View {
    
    typealias names = [namesElement]
    
    var body: some View {
        
        let Names = try! JSONDecoder().decode(names.self, from: readLocalFile(forName: "NamesOfAllah_EN")!)
        
        List{
            ForEach(0...Names.count - 1, id: \.self) { i in
                cardNames(index: i, name: Names[i].name, text: Names[i].text)
                    .background(Color(uiColor: .secondarySystemBackground))
                    .cornerRadius(8)
//                    .DShadow()
                
            }
            .listRowSeparator(.hidden)
            .listRowBackground(Color.clear)
        }
//        .navigationBarTitle("Names of Allah")
        .listStyle(.plain)
    }
    
    func cardNames(index: Int, name: String, text: String) -> some View {
        
        VStack(alignment: .leading) {
            
            HStack{
                
                Image(systemName: "note.text")
                    
                
                Text(name)
                    .frame(minWidth: 80)
                    .fontWeight(.semibold)
                   
                    
            Spacer()
                Text("\(index)")
                    .font(.caption2)
                    .frame(width: 25, height: 25)
                    .background(
                        Circle()
                            .strokeBorder(.black, lineWidth: 1)

                    )
                    
                    
                    .font(.system(size: 14))
                    
            }
            .padding([.leading, .top, .trailing], 12)
            
            Text(text)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding([.leading, .bottom, .trailing])
                .padding(.top, 2)
                .font(.system(size: 14))
            
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 2)
        
    }
    
    func readLocalFile(forName name: String) -> Data? {
        do {
            if let bundlePath = Bundle.main.path(forResource: name, ofType: "json"),
               let jsonData = try String(contentsOfFile: bundlePath).data(using: .utf8) {
                return jsonData
            }
        } catch {
            print(error)
        }
        
        return nil
    }
}

struct NamesOfAllahView_Previews: PreviewProvider {
    static var previews: some View {
        NamesOfAllahView()
    }
}


// MARK: - Names of Allah Element
struct namesElement: Codable {
    let name, text: String
}
