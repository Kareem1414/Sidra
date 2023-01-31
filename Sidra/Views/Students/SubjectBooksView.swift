//
//  SubjectBooksView.swift
//  Sidra
//
//  Created by AHMED ASSIRY on 06/07/1444 AH.
//

import SwiftUI
import PDFKit
import Vision
import VisionKit

struct SubjectBooksView: View {
    
    @State private var showScannerSheet = false
    @State private var texts : [ScanData] = []
    
    var body: some View {
        
        List {
            Section {
                NavigationLink(destination: PDFKitView(pdfDocument: PDFDocument(data: Bundle.main.loadFile("CloudComputing"))!).ignoresSafeArea()) {
                    HStack(alignment: .top) {
                        Image(uiImage: generatePdfThumbnail(of: CGSize(width: 80, height: 80), for: Bundle.main.url(forResource: "CloudComputing", withExtension: "pdf")!, atPage: 0)!)
                            .cornerRadius(2)
                        VStack(alignment: .leading) {
                            
                            Text("Cloud Computing")
                                .fontWeight(.bold)
                            
                            Text("Nayan Ruparelia")
                                .font(.caption)
                                .fontWeight(.medium)
                                .foregroundColor(.gray)
                                .padding(.leading)
                            
                        }
                        .padding(.leading, 8)
                        
                    }
                    .padding(.vertical, 0)
                    
                }
            }
            
            Section {
                if texts .count > 0 {
                    ForEach(texts) { text in
                        NavigationLink(destination: ScrollView{Text(text.content)}) {
                            Text(text.content)
                                .lineLimit(2)
                        }
                    }
                    .onDelete(perform: delete)
                    
                } else {
                    Button {
                        showScannerSheet.toggle()
                    } label: {
                        Text("Scanner")
                    }
                }
            }
            
        }
        .fullScreenCover(isPresented: $showScannerSheet, content: {
            makeScannerView()
                .ignoresSafeArea()
        
        })
        
    }
    func delete(at offsets: IndexSet) {
        texts.remove(atOffsets: offsets)
    }
    
    func makeScannerView() -> ScannerView {
        ScannerView(completion: { textPerPage in
            
            if let outputText = textPerPage?.joined(separator: "\n").trimmingCharacters(in: .whitespacesAndNewlines) {
                let newScanData = ScanData(content: outputText)
                self.texts.append(newScanData)
            }
            self.showScannerSheet = false
        })
    }
    
    
    func generatePdfThumbnail(of thumbnailSize: CGSize , for documentUrl: URL, atPage pageIndex: Int) -> UIImage? {
        let pdfDocument = PDFDocument(url: documentUrl)
        let pdfDocumentPage = pdfDocument?.page(at: pageIndex)
        return pdfDocumentPage?.thumbnail(of: thumbnailSize, for: PDFDisplayBox.trimBox)
    }
    
}

struct SubjectBooksView_Previews: PreviewProvider {
    static var previews: some View {
        SubjectBooksView()
    }
}
