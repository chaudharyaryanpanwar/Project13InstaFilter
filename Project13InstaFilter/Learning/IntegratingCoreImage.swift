//
//  IntegratingCoreImage.swift
//  Project13InstaFilter
//
//  Created by Aryan Panwar on 29/07/24.
//

import CoreImage
import CoreImage.CIFilterBuiltins
import SwiftUI
import UIKit

struct IntegratingCoreImage: View {
    
    @State private var image : Image?
    
    var body: some View {
        VStack {
            image?
                .resizable()
                .scaledToFit()
        }
        .onAppear(perform: {
//            loadImage1()
//            loadImage2()
//            loadImage3()
//            loadImage4()
            loadImage5()
        })
    }
    
    func loadImage1(){
        let inputImage = UIImage(resource: .example)
        let beginImage = CIImage(image: inputImage)
        
        let context = CIContext()
        let currentFilter = CIFilter.sepiaTone()
        
        
        currentFilter.inputImage  = beginImage
        currentFilter.intensity = 1
        
//        geta CIImage from our filter or exit is that fails
        guard let outputImage = currentFilter.outputImage else { return }
        
//        attempt to get a CGImage form our CIImage
        guard let cgImage =  context.createCGImage(outputImage, from: outputImage.extent ) else {return }
        
//        convert that to a UIImage
        let uiImage = UIImage(cgImage: cgImage)
        
//        and convert that into a SwiftUI image
        image = Image(uiImage: uiImage)
    }
    
    func loadImage2(){
        let inputImage = UIImage(resource: .example)
        let beginImage = CIImage(image: inputImage)
        
        let context = CIContext()
        let currentFilter = CIFilter.pixellate()
        
        
        currentFilter.inputImage  = beginImage
        currentFilter.scale = 200
        
//        geta CIImage from our filter or exit is that fails
        guard let outputImage = currentFilter.outputImage else { return }
        
//        attempt to get a CGImage form our CIImage
        guard let cgImage =  context.createCGImage(outputImage, from: outputImage.extent ) else {return }
        
//        convert that to a UIImage
        let uiImage = UIImage(cgImage: cgImage)
        
//        and convert that into a SwiftUI image
        image = Image(uiImage: uiImage)
    }
    
    func loadImage3(){
        let inputImage = UIImage(resource: .example)
        let beginImage = CIImage(image : inputImage)
        
        let context = CIContext()
        let currentFilter = CIFilter.crystallize()
        
        currentFilter.inputImage = beginImage
        currentFilter.radius = 200
        
        guard let outputImage = currentFilter.outputImage else { return }
        guard let cgImage = context.createCGImage(outputImage, from: outputImage.extent ) else { return }
        let uiImage = UIImage(cgImage: cgImage)
        image = Image(uiImage: uiImage)
    }
    
    func loadImage4(){
        let inputImage = UIImage(resource: .example)
        let beginImage = CIImage(image : inputImage)
        
        let context = CIContext()
        let currentFilter = CIFilter.twirlDistortion()
        
        currentFilter.inputImage = beginImage
        currentFilter.radius = 1000
        currentFilter.center = CGPoint(x : inputImage.size.width / 2 , y : inputImage.size.height / 2 )
        
        guard let outputImage = currentFilter.outputImage else { return }
        guard let cgImage = context.createCGImage(outputImage, from: outputImage.extent ) else { return }
        let uiImage = UIImage(cgImage: cgImage)
        image = Image(uiImage: uiImage)
    }
    
    func loadImage5(){
        let inputImage = UIImage(resource: .example)
        let beginImage = CIImage(image : inputImage)
        
        let context = CIContext()
        let currentFilter = CIFilter.crystallize()
        
        currentFilter.inputImage = beginImage
        
        let amount = 1.0
        
        let inputKeys = currentFilter.inputKeys
        
        if inputKeys.contains(kCIInputIntensityKey){
            currentFilter.setValue(amount, forKey: kCIInputIntensityKey)
        }
        if inputKeys.contains(kCIInputRadiusKey){
            currentFilter.setValue(amount * 200 , forKey: kCIInputRadiusKey)
        }
        if inputKeys.contains(kCIInputScaleKey){
            currentFilter.setValue(amount * 10 , forKey: kCIInputScaleKey)
        }
        
        guard let outputImage = currentFilter.outputImage else { return }
        guard let cgImage = context.createCGImage(outputImage, from: outputImage.extent ) else { return }
        let uiImage = UIImage(cgImage: cgImage)
        image = Image(uiImage: uiImage)
    }
}


#Preview {
    IntegratingCoreImage()
}
