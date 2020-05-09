//
//  ContentView.swift
//  iTunesSwiftUI
//
//  Created by Fernando Olivares on 28/03/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import SwiftUI

// Struct that holds our view
// Structs are value-based
// Classes are reference-based
//
// class UILabel -> instance
// let label = UILabel()
// label.placeholderText = ""
//
// struct (var) Text -> modifications -> Text

struct ContentView: View {
    // A State is the source of truth
    // If it changes, the wole View is going to be redrawn
    // What happend if it changes here? -> It changes on the other side of the binding.
    @State // Is the property wrapper (Truth)
    var artistName: String = "" // Property it wraps (String) -> Whatever the user typed
    
    var body: some View {
        VStack() {
            
            Text("Search for artists in iTunes")
                .font(.subheadline)
            
            // Textfield is expecting a binding.
            // A binding will help SwiftUI know that it needs to update one of our own custom variables.
            // In order for us to have a custom variable like that, we need to use @State to wrap it.
            // $ -> Getter for the underlying binding.
            
            // TextField("Search for Artist", text: $artistName) --> This is commented out since we have SearchView
            SearchView(artistNameBinding: $artistName)
            
            Text("artistName") // Create our first text.
                .font(.largeTitle) // Modify the text (-> a new text with the modifications)
                .bold()
                .multilineTextAlignment(.center)
                .lineLimit(3)
            
            HStack() {
                Text("Artist Genre:")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                
                Text("Artist Genre placeholder")
                    .font(.subheadline)
                    .foregroundColor(.primary)
                
            }
            
            Spacer()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
