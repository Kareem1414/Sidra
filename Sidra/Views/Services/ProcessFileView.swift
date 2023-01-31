//
//  ProcessFileView.swift
//  Sidra
//
//  Created by AHMED ASSIRY on 18/05/1444 AH.
//

import SwiftUI
import UniformTypeIdentifiers
import PhotosUI

struct ProcessFileView: View {
    
    @State var nameProcess : String
    
    @StateObject var imagePicker = ImagePicker()
    
    var columns: [GridItem] = Array(repeating: .init(.flexible()), count: 3)
    
    @State private var showUpload = false
    @State private var filesUpload = false
    @State private var filesSave = false
    
    @State private var urlFiles = ""
    @State private var fileName = ""
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        
        VStack {
            
            VStack {
                HStack {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "arrow.down.square.fill")
                            .foregroundColor(.gray)
                    }
                    .padding()
                    
                    Spacer()
                }
            }
            
            
            
            
            
            if !imagePicker.images.isEmpty {
                
                ScrollView(showsIndicators: false) {
                    LazyVGrid(columns: columns) {
                        ForEach(0..<imagePicker.images.count, id: \.self) { index in
                            ZStack {
                                imagePicker.images[index]
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: UIScreen.screenWidth / 2.5)
                                    .cornerRadius(8)
                                    .onTapGesture {
                                        print(index)
                                        if !imagePicker.imageChoose.contains(index) {
                                            imagePicker.imageChoose.append(index)
                                        } else {
                                            if let itemToRemoveIndex = imagePicker.imageChoose.firstIndex(of: index) {
                                                imagePicker.imageChoose.remove(at: itemToRemoveIndex)
                                            }
                                        }
                                        print(imagePicker.imageChoose)
                                    }
                                    .blur(radius: imagePicker.imageChoose.contains(index) ? 1 : 0)
                                Image(systemName: imagePicker.imageChoose.contains(index) ? "arrow.down.square.fill" : "")
                                    
                            }
                        }
                    }
                    .padding(.horizontal)
                    
                }
                .frame(maxWidth: .infinity)
                
            } else {
                Text("Please select images from menu")
                Spacer()
            }
            
            
            if filesUpload {
                Text(fileName)
                
                Text("\(urlFiles)")
            }
            
            

            
            Button { showUpload = true } label: {
                Text("Add")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(.cyan)
                    .cornerRadius(10)
                    .padding(.horizontal)
                    .foregroundColor(.primary)
            }
            
            if !imagePicker.images.isEmpty {
                Button { filesSave.toggle() } label: {
                    
                    Text("Save")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(urlFiles.isEmpty ? .gray.opacity(0.4) : .purple)
                        .cornerRadius(10)
                        .padding(.horizontal)
                    
                    
                }
                .disabled(urlFiles.isEmpty)
                .padding(.vertical)
                
                Button { } label: {
                    
                    Text("Process")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .foregroundColor(.primary)
                        .background(urlFiles.isEmpty ? .gray.opacity(0.4) : .purple)
                        .cornerRadius(10)
                        .padding(.horizontal)
                    
                }
            }
            

            
            
        }
        
        .fileExporter(isPresented: $filesSave, document: Doc(url: Bundle.main.path(forResource: "xxx", ofType: "pdf")!), contentType: .pdf) { result in
            
            do {
                let fileUrl = try result.get()
                print(fileUrl)
            } catch {
                print("Error save docs: \(error.localizedDescription)")
            }
            
        }
        .sheet(isPresented: $showUpload) {
            
            VStack(spacing: 16) {
                
                Text(nameProcess)
                
                Button { filesUpload.toggle() } label: {
                    Text("Files")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(.red)
                        .cornerRadius(8)
                        .padding(.horizontal)
                        .foregroundColor(.primary)
                }
                
                PhotosPicker(selection: $imagePicker.imageSelections, maxSelectionCount: 12, matching: .any(of: [.images]), photoLibrary: .shared()) {
                    
                    Text("Photos")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(.red)
                        .cornerRadius(8)
                        .padding(.horizontal)
                        .foregroundColor(.primary)
                    
                }
                
                
                Button { } label: {
                    Text("Camera")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(.green)
                        .cornerRadius(8)
                        .padding(.horizontal)
                        .foregroundColor(.primary)
                }
            }
            .presentationDetents([.fraction(0.40)])
            .presentationDragIndicator(.visible)
            
            .fileImporter(isPresented: $filesUpload, allowedContentTypes: [.pdf]) { result in
                do {
                    let fileUrl = try result.get()
                    print(fileUrl)
                    self.urlFiles = fileUrl.absoluteString
                    self.fileName = fileUrl.lastPathComponent
                    print("URL is good : \(self.urlFiles)")
                    
                } catch {
                    print("Error reading docs: \(error.localizedDescription)")
                }
            }
        }
        
    }
}

struct ProcessFileView_Previews: PreviewProvider {
    static var previews: some View {
        ProcessFileView(nameProcess: "")
    }
}


struct Doc : FileDocument {
    
    var url: String
    
    static var readableContentTypes: [UTType] {
        [.pdf]
    }
    
    init(url : String) {
        self.url = url
    }
    
    init(configuration: ReadConfiguration) throws {
        
        // Desetilize the content...
        // We don't need to read contents...
        
        url = ""
    }
    
    func fileWrapper(configuration: WriteConfiguration) throws -> FileWrapper {
        
        // Returning and saving file...
        
        let file = try! FileWrapper(url: URL(fileURLWithPath: url), options: .immediate)
        
        return file
    }
    
    
}


@MainActor
class ImagePicker : ObservableObject {
    
    @Published var image : Image?
    @Published var images : [Image] = []
    
    @Published var imageSelection : PhotosPickerItem? {
        didSet {
            if let imageSelection {
                Task {
                    try await loadTransferable(from: imageSelection)
                }
            }
        }
    }
    @Published var imageSelections : [PhotosPickerItem] = [] {
        didSet {
            Task {
                if !imageSelections.isEmpty {
                    try await loadTransferable (from: imageSelections)
                    imageSelections = []
                }
            }
        }
    }
    
    @Published var imageChoose : [Int] = []
    
    func loadTransferable(from imageSelections: [PhotosPickerItem]) async throws {
        do {
            
            for imageSelection in imageSelections {
                if let data = try await imageSelection.loadTransferable(type: Data.self) {
                    
                    if let uiImage = UIImage (data: data) {
                        self.images.append (Image (uiImage: uiImage))
                    }
                    
                }
            }
            
        } catch {
            print(error.localizedDescription)
            images.removeAll()
        }
    }
    
    func loadTransferable(from imageSelection: PhotosPickerItem?) async throws {
        
        do {
            if let data = try await imageSelection?.loadTransferable(type: Data.self) {
                if let uiImage = UIImage(data: data) {
                    self.image = Image(uiImage: uiImage)
                }
            }
        } catch {
            print(error.localizedDescription)
            image = nil
        }
    }
}
