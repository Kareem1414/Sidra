//
//  ConvertFileView.swift
//  Sidra
//
//  Created by AHMED ASSIRY on 26/04/1444 AH.
//

import SwiftUI

struct ConvertFileView: View {
    let pdfTitles : [String] = ["Scanner", "Image to PDF", "Word to PDF", "Excel to PDF", "PowerPoint to PDF", "Compress PDF", "Merge PDF", "PDF to Word", "PDF to Excel", "PDF to Powerpoint", "Split PDF", "Text Recognition", "Edit PDF", "PDF to JPG", "JPG to PDF", "Sign PDF", "Watermark", "Rotate PDF", "HTML to PDF", "Unlock PDF", "Protect PDF", "Organize PDF", "PDF to PDF/A", "Repair PDF", "Page Numbers", "Scan to PDF"]
    
    let imagesTitles = ["MP4", "AVI", "MPEG", "Apple"]
    
    let videosTitles = ["PDF to JPG", "JPG to PDF", "Sign PDF", "Watermark"]
    
    let AudioTitles = ["PDF to JPG", "JPG to PDF", "Sign PDF", "Watermark"]
    
    @State var indexArray = 0
    
    @State private var searchText = ""
    
    private let numberColumnsArray = Array(repeating: GridItem(.flexible()), count: 3)
    
    @State private var isPresented = false
    @State var selectedProcess: String = ""
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            
            LazyVGrid(columns: numberColumnsArray, spacing: 8) {
                
                ForEach((indexArray == 0 ? pdfTitles : indexArray == 1 ? imagesTitles : indexArray == 2 ? videosTitles : indexArray == 3 ? AudioTitles : pdfTitles).filter({ $0.localizedCaseInsensitiveContains(searchText) || searchText.isEmpty}), id: \.self) { i in
                    
                    
                    
                    VStack {
                        Image(systemName: "calendar")
                            .font(.title.bold())
                            .padding([.leading, .top, .trailing])
                            .padding(.bottom, 8)
                            .frame(maxHeight: .infinity, alignment: .bottom)
                        
                        Text(i)
                            .font(.caption)
                            .frame(maxHeight: .infinity, alignment: .top)
                            .multilineTextAlignment(.center)
                            .padding(.bottom)
                    }
                    .onTapGesture {
                        
                        isPresented.toggle()
                        selectedProcess = i
                        
                    }
                    .foregroundColor(.primary)
                    .frame(maxWidth: .infinity, minHeight: UIScreen.screenWidth / 3.5)
                    .background(Color(.systemBackground))
                    .cornerRadius(8)
                    .fullScreenCover(isPresented: $isPresented) { ProcessFileView(nameProcess: selectedProcess) }
                    
                }
                
            }
            .navigationTitle("Convert Files")
            .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always))
            .padding(.horizontal)
            
        }
        .background(Color(UIColor.secondarySystemBackground).edgesIgnoringSafeArea(.all))
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Menu(content: {
                    Button("Files") {
                        indexArray = 0
                    }
                    
                    Button("Images") {
                        indexArray = 1
                    }
                    
                    Button("Videos") {
                        indexArray = 2
                    }
                    
                    Button("Audios") {
                        indexArray = 3
                    }
                    
                }, label: {Image(systemName: "ellipsis").rotationEffect(.degrees(-90))})
            }
        }
    }
    
}

struct ConvertFileView_Previews: PreviewProvider {
    static var previews: some View {
        ConvertFileView()
    }
}
