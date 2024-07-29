//
//  ContentView.swift
//  Project13InstaFilter
//
//  Created by Aryan Panwar on 29/07/24.
//

import CoreImage
import CoreImage.CIFilterBuiltins
import PhotosUI
import SwiftUI

struct ContentView: View {
    
    @State private var processedImage : Image?
    @State private var filterIntensity = 0.5
    
    @State private var selecetedItem : PhotosPickerItem?
    
    @State private var currentFilter = CIFilter.sepiaTone()
    let context = CIContext()
    
    var body: some View {
        VStack {
            Spacer()
            
            PhotosPicker(selection: $selecetedItem) {
                if let processedImage {
                    processedImage
                        .resizable()
                        .scaledToFit()
                } else {
                    ContentUnavailableView("No Picture", systemImage: "photo.badge.plus" , description: Text("Tap to import a photo"))
                }
            }
            .onChange(of: selecetedItem) {
                loadImage()
            }
            
            Spacer()
            
            HStack {
                Text("Intensity")
                Slider(value : $filterIntensity)
                    .onChange(of: filterIntensity) {
                        applyProcessing()
                    }
            }
            .padding(.vertical)
            
            HStack {
                Button("Chaneg Filter"){
                    changeFilter()
                }
                
                Spacer()
                
//                share the picture
            }
        }
        .padding([.horizontal , .bottom])
        .navigationTitle("Instafilter")
    }
    
    func changeFilter(){
        
    }
    
    func loadImage() {
        Task {
            guard let imageData = try await selecetedItem?.loadTransferable(type: Data.self) else { return }
            guard let inputImage = UIImage(data: imageData) else { return }
            
            let beginImage = CIImage(image : inputImage)
            currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
            applyProcessing()
        }
    }
    
    func applyProcessing(){
        currentFilter.intensity = Float(filterIntensity)
        
        guard let outputImage = currentFilter.outputImage else { return }
        guard let cgImage = context.createCGImage(outputImage , from: outputImage.extent ) else { return }
        
        let uiImage = UIImage(cgImage: cgImage)
        processedImage = Image(uiImage: uiImage)
    }
}

#Preview {
    ContentView()
}
