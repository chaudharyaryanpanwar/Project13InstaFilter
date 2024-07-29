//
//  MultipleOptionsWithConfirmationDialog.swift
//  Project13InstaFilter
//
//  Created by Aryan Panwar on 29/07/24.
//

import SwiftUI

struct ContentView3 : View {
    
    @State private var showingConfirmation = false
    @State private var backgroundColor = Color.white
    
    var body: some View {
        Button("Hello World!"){
            showingConfirmation = true
        }
        .frame(width: 300 , height: 300)
        .background(backgroundColor)
        .confirmationDialog("Change Background", isPresented: $showingConfirmation) {
            Button("Red"){ backgroundColor = .red }
            Button("Green"){ backgroundColor = .green }
            Button("Blue"){ backgroundColor = .blue }
            Button("Cancel" , role : .cancel ){}
        } message: {
            Text("Select a color")
        }
    }
}

#Preview {
    ContentView3()
}
