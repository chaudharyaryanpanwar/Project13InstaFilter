//
//  PropertyWrappersBecomeStructs.swift
//  Project13InstaFilter
//
//  Created by Aryan Panwar on 29/07/24.
//

import SwiftUI



struct ContentView1 : View {
    
    @State private var blurAmount = 0.0 {
        didSet {
            print("New value is \(blurAmount)")
        }
    }
    
    var body: some View {
        VStack {
            Text("Hello World!")
                .blur(radius: blurAmount)
            
            Slider(value : $blurAmount , in : 0...20)
            
            Button("Random Blur"){
                blurAmount = Double.random(in: 0...20)
            }
        }
    }
}

#Preview {
    ContentView1()
}
