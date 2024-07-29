//
//  AppStoreReview.swift
//  Project13InstaFilter
//
//  Created by Aryan Panwar on 29/07/24.
//

import StoreKit
import SwiftUI

struct AppStoreReview: View {
    
    @Environment(\.requestReview) var requestReview
    
    var body: some View {
        Button("Leave a review"){
            requestReview()
        }
    }
}

#Preview {
    AppStoreReview()
}
