//
//  EmptyStatesWithContentUnavailableVIew.swift
//  Project13InstaFilter
//
//  Created by Aryan Panwar on 29/07/24.
//

import SwiftUI

struct EmptyStatesWithContentUnavailableVIew: View {
    var body: some View {
//        ContentUnavailableView("No snippets", systemImage: "swift")
//        ContentUnavailableView("No snippets", systemImage: "swift" , description: Text("You don't have any saved snippets yet."))
        ContentUnavailableView {
            Label("No snippets" , systemImage: "swift")
        } description : {
            Text("You don't have any saved snippets yet.")
        } actions : {
            Button("Create Snippet"){
//                create a snippet
            }
            .buttonStyle(.borderedProminent)
        }
    }
}

#Preview {
    EmptyStatesWithContentUnavailableVIew()
}
