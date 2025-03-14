//
//  ContentView.swift
//  Project13InstaFilter
//
//  Created by Aryan Panwar on 29/07/24.
//

import CoreImage
import CoreImage.CIFilterBuiltins
import PhotosUI
import StoreKit
import SwiftUI

struct ContentView: View {
    
    @State private var processedImage : Image?
    @State private var filterIntensity = 0.5
    @State private var filterScale = 0.5
    @State private var filterRadius = 0.5
    
    @State private var selecetedItem : PhotosPickerItem?
    
    @State private var currentFilter : CIFilter = CIFilter.sepiaTone()
    
    
    @State private var showingFilters = false
    
    @AppStorage("filterCount") var filterCount = 0
    @Environment(\.requestReview) var requestReview
    
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
            .confirmationDialog("Select a filter", isPresented: $showingFilters) {
                Button("Crystallize") { setFilter(CIFilter.crystallize())}
                Button("Edges"){ setFilter(CIFilter.edges()) }
                Button("Gaussian Blur"){setFilter(CIFilter.gaussianBlur())}
                Button("Pixellate"){ setFilter(CIFilter.pixellate())}
                Button("Sepia Tone"){setFilter(CIFilter.sepiaTone())}
                Button("Unsharp Mask"){ setFilter(CIFilter.unsharpMask())}
                Button("Vignette"){ setFilter(CIFilter.vignette())}
                Button("Thermal"){ setFilter(CIFilter.thermal())}
                Button("Monochrome"){ setFilter(CIFilter.colorMonochrome())}
                Button("Document Enhancer"){ setFilter(CIFilter.documentEnhancer())}
                Button("Bloom"){ setFilter(CIFilter.bloom())}
                
                Button("Cancel" , role : .cancel){}
            }
            
            Spacer()
            
            VStack {
                if currentFilter.inputKeys.contains(kCIInputIntensityKey) {
                    HStack {
                        Text("Intensity")
                            .foregroundStyle(processedImage == nil ? .tertiary : .primary)
                        Slider(value : $filterIntensity)
                            .onChange(of: filterIntensity) {
                                applyProcessing()
                            }
                            .disabled(processedImage == nil)
                    }
                    .padding(.vertical)
                }
                
                if currentFilter.inputKeys.contains(kCIInputScaleKey){
                    HStack {
                        Text("Scale")
                            .foregroundStyle(processedImage == nil ? .tertiary : .primary)
                        Slider(value : $filterScale)
                            .onChange(of: filterScale) {
                                applyProcessing()
                            }
                            .disabled(processedImage == nil)
                    }
                    .padding(.vertical)
                }
                
                if currentFilter.inputKeys.contains(kCIInputRadiusKey) {
                    HStack {
                        Text("Radius")
                            .foregroundStyle(processedImage == nil ? .tertiary : .primary)
                        Slider(value : $filterRadius)
                            .onChange(of: filterRadius) {
                                applyProcessing()
                            }
                            .disabled(processedImage == nil)
                    }
                    .padding(.vertical)
                }
            }
            
            HStack {
                Button("Change Filter"){
                    changeFilter()
                }
                .disabled(processedImage == nil)
                
                Spacer()
                
//                share the picture
                if let processedImage {
                    ShareLink(item : processedImage , preview: SharePreview("InstaFilter Image", image: processedImage))
                }
            }
        }
        .padding([.horizontal , .bottom])
        .navigationTitle("Instafilter")
        
    }
    
    func changeFilter(){
        showingFilters = true
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
        
        let inputKeys = currentFilter.inputKeys
        
        if inputKeys.contains(kCIInputIntensityKey) {currentFilter.setValue(filterIntensity, forKey: kCIInputIntensityKey)}
        
        if inputKeys.contains(kCIInputRadiusKey){ currentFilter.setValue( filterRadius * 200 , forKey: kCIInputRadiusKey)}
        
        if inputKeys.contains(kCIInputScaleKey){ currentFilter.setValue( filterScale * 10 , forKey: kCIInputScaleKey)}
        
        guard let outputImage = currentFilter.outputImage else { return }
        guard let cgImage = context.createCGImage(outputImage , from: outputImage.extent ) else { return }
        
        let uiImage = UIImage(cgImage: cgImage)
        processedImage = Image(uiImage: uiImage)
    }
    
    @MainActor func setFilter(_ filter : CIFilter){
        currentFilter = filter
        filterCount += 1
        
        if filterCount >= 20 {
            requestReview()
        }
        
        loadImage()
    }
}

#Preview {
    ContentView()
}
