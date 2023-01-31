//
//  QuranView.swift
//  Sidra
//
//  Created by AHMED ASSIRY on 28/02/1444 AH.
//

import SwiftUI
import PDFKit

struct QuranView: View {
    
    @Environment(\.colorScheme) var colorScheme
    
    @State var showInfQuran = true
    
    var body: some View {
        
        VStack {
            
            PDFKitView()
                .onTapGesture {
                    withAnimation {
                        showInfQuran.toggle()
                    }
                }
            
        }
        .onAppear {
            UIApplication.shared.isIdleTimerDisabled = true
        }
        .onDisappear {
            UIApplication.shared.isIdleTimerDisabled = false
        }
        .ignoresSafeArea()
//        .navigationBarBackButtonHidden(true)
        .safeAreaInset(edge: .bottom) {
            
            PDFThumbnailRepresented()
                .frame(maxWidth: .infinity, maxHeight: 50)
            
        }
        
    }
}

struct QuranView_Previews: PreviewProvider {
    
    static var previews: some View {
        QuranView()
    }
}

struct PDFKitView: UIViewRepresentable {
    
    let pdfView = PDFView()
    let pdfDocument = PDFDocument(data: Bundle.main.loadFile("xxx"))
    
    func makeUIView(context: UIViewRepresentableContext<PDFKitView>) -> UIViewType {
        
        pdfView.document = pdfDocument
        pdfView.autoScales = true
        pdfView.usePageViewController(true)
        pdfView.displayDirection = .horizontal
        pdfView.displayMode = .singlePageContinuous
        pdfView.backgroundColor = .clear
        pdfView.pageShadowsEnabled = false
        pdfView.displaysRTL = true
        
        let pdfScrollView = pdfView.subviews.first?.subviews.first as? UIScrollView
        pdfScrollView?.showsHorizontalScrollIndicator = false

        
        return pdfView
    }

    func updateUIView(_ uiView: PDFView, context: Context) {
        print("Goood")

    }
    
    
}


struct PDFThumbnailRepresented : UIViewRepresentable {
    
    let pdfView = PDFView()
    let thumbnail = PDFThumbnailView()
    
    func makeUIView(context: Context) -> PDFThumbnailView {
        
        pdfView.displaysRTL = true
        thumbnail.pdfView = pdfView
        thumbnail.layoutMode = .horizontal
        thumbnail.thumbnailSize = CGSize(width: 40, height: 50)
        
        return thumbnail
    }
    
    func updateUIView(_ uiView: PDFThumbnailView, context: Context) {
        if let document = PDFDocument(data: Bundle.main.loadFile("xxx")) {
            pdfView.document = document
            thumbnail.layoutMode = .horizontal
            thumbnail.thumbnailSize = CGSize(width: 40, height: 50)
            
            uiView.pdfView = pdfView
        }
    }
}
