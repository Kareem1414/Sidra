//
//  ScanOCRView.swift
//  Sidra
//
//  Created by AHMED ASSIRY on 19/04/1444 AH.
//

import SwiftUI
import Vision
import VisionKit

struct ScanOCRView: View {
    
    @State private var showScannerSheet = false
    @State private var texts : [ScanData] = []
    
    var body: some View {
        VStack {
            
            if texts .count > 0 {
                List {
                    ForEach(texts) { text in
                        NavigationLink(destination: ScrollView{Text(text.content)}) {
                            Text(text.content)
                                .lineLimit(2)
                        }
                    }
                    .onDelete(perform: delete)
                }
            } else {
                Text("No scan yet")
                    .font(.title)
            }
            
        }
//        .navigationTitle("Scan OCR")
        .navigationBarItems(trailing: Button(action: {
            self.showScannerSheet.toggle()
        }, label: {
            Image(systemName: "doc.text.viewfinder")
            
        })
            .sheet(isPresented: $showScannerSheet, content: {
                makeScannerView()
            })
                            
        )
    }
    
    func delete(at offsets: IndexSet) {
            texts.remove(atOffsets: offsets)
        }
    
    private func makeScannerView() -> ScannerView {
        ScannerView(completion: { textPerPage in
            
            if let outputText = textPerPage?.joined(separator: "\n").trimmingCharacters(in: .whitespacesAndNewlines) {
                let newScanData = ScanData(content: outputText)
                self.texts.append(newScanData)
            }
            self.showScannerSheet = false
        })
    }
}

struct ScanOCRView_Previews: PreviewProvider {
    static var previews: some View {
        ScanOCRView()
    }
}


struct ScanData: Identifiable {
    var id = UUID()
    let content : String
    
    init(content: String) {
        self.content = content
    }
}


struct ScannerView: UIViewControllerRepresentable {
    func makeCoordinator() -> Coordinator {
        return Coordinator(completion: completionHandler)
    }
    
    
    final class Coordinator : NSObject, VNDocumentCameraViewControllerDelegate {
        private let completionHandler : ([String]?) -> Void
        
        init(completion: @escaping ([String]?) -> Void) {
            self.completionHandler = completion
        }
        
        func documentCameraViewController(_ controller: VNDocumentCameraViewController, didFinishWith scan: VNDocumentCameraScan) {
            let recognizer = TextRecognizer(cameraScan: scan)
            recognizer.recognizeText(withCompletionHandler: completionHandler)
            
            var scannedPages = [UIImage]()
             
                for i in 0..<scan.pageCount {
                    scannedPages.append(scan.imageOfPage(at: i))
                }
        }
        
        func documentCameraViewController(_ controller: VNDocumentCameraViewController, didFailWithError error: Error) {
            completionHandler(nil)
        }
        
        func documentCameraViewControllerDidCancel(_ controller: VNDocumentCameraViewController) {
            completionHandler(nil)
        }
    }
    
    func makeUIViewController(context: Context) -> VNDocumentCameraViewController {
        let viewController = VNDocumentCameraViewController()
        viewController.delegate = context.coordinator
        return viewController
    }
    
    func updateUIViewController(_ uiViewController: VNDocumentCameraViewController, context: Context) {
        
        
    }
    
    typealias UIViewControllerType = VNDocumentCameraViewController
    
    private let completionHandler : ([String]?) -> Void
    
    init(completion: @escaping ([String]?) -> Void) {
        self.completionHandler = completion
    }
    
}


final class TextRecognizer {
    
    let cameraScan : VNDocumentCameraScan
    init(cameraScan : VNDocumentCameraScan) {
        self.cameraScan = cameraScan
    }
    
    private let queue = DispatchQueue(label: "scan-codes", qos: .default, attributes: [], autoreleaseFrequency: .workItem)
    
    func recognizeText(withCompletionHandler completionHandler: @escaping ([String]) -> Void) {
        queue.async {
            let images = (0..<self.cameraScan.pageCount).compactMap({
                self.cameraScan.imageOfPage(at:$0).cgImage
            })
            let imagesAndRequests = images.map({ (image: $0, request: VNRecognizeTextRequest())})
            let textPerPage = imagesAndRequests.map{image, request -> String in
                let handler = VNImageRequestHandler(cgImage: image, options: [:])
                do{
                    try handler.perform([request])
                    guard let observations = request.results else {return ""}
                    return observations.compactMap({$0.topCandidates(1).first?.string}).joined(separator: "\n")
                } catch {
                    print(error)
                    return ""
                }
            }
            DispatchQueue.main.async {
                completionHandler(textPerPage)
            }
        }
    }
}
