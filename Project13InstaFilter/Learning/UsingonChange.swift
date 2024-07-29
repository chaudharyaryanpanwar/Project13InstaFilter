//
//  UsingonChange.swift
//  Project13InstaFilter
//
//  Created by Aryan Panwar on 29/07/24.
//

import SwiftUI

struct ContentView2 : View {
    
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
                .onChange(of: blurAmount) { oldValue, newValue in
                    print("New value is \(newValue)")
                }
        
        }
    }
}

#Preview {
    ContentView2()
}
