//
//  ShareContentWithShareLink.swift
//  Project13InstaFilter
//
//  Created by Aryan Panwar on 29/07/24.
//

import SwiftUI

struct ShareContentWithShareLink1 : View {
    var body: some View {
//        ShareLink(item: URL(string : "https://www.hackingwithswift.com")!)
        
        
//        ShareLink(item: URL(string : "https://www.hackingwithswift.com")! , subject: Text("Learn Swift here") , message : Text("Check out the 100 days of 100 SwiftUI!"))
        
        ShareLink(item: URL(string : "https://www.hackingwithswift.com")!){
            Label("Spread the word about Swift" , systemImage: "swift")
        }
    }
}

//---------------------------//---------------------------//---------------------------
//PROVIDING PREVIEW FOR THE SHAR
struct ShareContentWithShareLink2 : View {
    let example = Image(.example)
    var body: some View {
        ShareLink(item: example , preview: SharePreview("Rolls Royce", image: example)){
            Label("Click to share", systemImage: "car")
        }
    }
}
#Preview {
//    ShareContentWithShareLink1()
    ShareContentWithShareLink2()
}
