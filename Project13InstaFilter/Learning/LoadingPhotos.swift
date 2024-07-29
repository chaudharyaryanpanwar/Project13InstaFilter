//
//  LoadingPhotos.swift
//  Project13InstaFilter
//
//  Created by Aryan Panwar on 29/07/24.
//

import PhotosUI
import SwiftUI

struct LoadingPhotos1 : View {
    
    @State private var pickerItem : PhotosPickerItem?
    @State private var selectedImage : Image?
    
    var body: some View {
        VStack {
            PhotosPicker("Select a picture", selection: $pickerItem , matching: .images)
            selectedImage?
                .resizable()
                .scaledToFit()
        }
        .onChange(of: pickerItem) {
            Task {
                selectedImage = try await pickerItem?.loadTransferable(type: Image.self)
            }
        }
    }
}
//-----------------------//-----------------------//-----------------------//-----------------------
//SELECTING MORE THAN ONE PHOTO
struct LoadingPhotos2 : View {
    
    @State private var pickerItems = [PhotosPickerItem]()
    @State private var selectedImages = [Image]()
    
    var body: some View {
        VStack {
            PhotosPicker("Select Images", selection: $pickerItems ,maxSelectionCount: 3 ,  matching : .images)
            ScrollView{
                ForEach(0..<selectedImages.count , id : \.self){ i in
                    selectedImages[i]
                        .resizable()
                        .scaledToFit()
                }
            }
        }
        .onChange(of: pickerItems) {
            Task {
                selectedImages.removeAll()
                
                for item in pickerItems {
                    if let loadedImage = try await item.loadTransferable(type: Image.self) {
                        selectedImages.append(loadedImage)
                    }
                }
            }
        }
    }
}
//-----------------------//-----------------------//-----------------------//-----------------------
//USING A LABEL IN PHOTOSPICKER
struct LoadingPhotos3 : View {

    @State private var pickerItems = [PhotosPickerItem]()
    @State private var selectedImages = [Image]()
    
    var body: some View {
        VStack {
            PhotosPicker( selection: $pickerItems ,maxSelectionCount: 3 ,  matching : .images){
                Label("Select a picture" , systemImage: "photo")
            }
            ScrollView{
                ForEach(0..<selectedImages.count , id : \.self){ i in
                    selectedImages[i]
                        .resizable()
                        .scaledToFit()
                }
            }
        }
        .onChange(of: pickerItems) {
            Task {
                selectedImages.removeAll()
                
                for item in pickerItems {
                    if let loadedImage = try await item.loadTransferable(type: Image.self) {
                        selectedImages.append(loadedImage)
                    }
                }
            }
        }
    }
}
//-----------------------//-----------------------//-----------------------//-----------------------
//LIMIT THE KINDS OF PICTURES

struct LoadingPhotos4 :View {
    
    @State private var pickerItems = [PhotosPickerItem]()
    @State private var selectedImages = [Image]()
    
    var body: some View {
        VStack {
            
            
            
            PhotosPicker("Select Images", selection: $pickerItems ,maxSelectionCount: 3 ,  matching : .any(of: [.images , .not(.screenshots)]))
            
            
            
            
            ScrollView{
                ForEach(0..<selectedImages.count , id : \.self){ i in
                    selectedImages[i]
                        .resizable()
                        .scaledToFit()
                }
            }
        }
        .onChange(of: pickerItems) {
            Task {
                selectedImages.removeAll()
                
                for item in pickerItems {
                    if let loadedImage = try await item.loadTransferable(type: Image.self) {
                        selectedImages.append(loadedImage)
                    }
                }
            }
        }
    }
}

#Preview {
    LoadingPhotos4()
}
