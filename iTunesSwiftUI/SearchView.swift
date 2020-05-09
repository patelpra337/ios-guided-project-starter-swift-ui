//
//  SearchView.swift
//  iTunesSwiftUI
//
//  Created by patelpra on 5/7/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import SwiftUI

// Access Control
//
// private - only accessible insdie your class
// fileprivate - only accessible inside the same file
// internal - only accessible in the same module
// public - accessbile everywhere in all modules
// open accessible everywhere _and_ subclassable

// It cannot be subclassed
final class SearchView : NSObject, UIViewRepresentable {
    
    // Two-way street between two variables.
    // Binding itself is just a wrapper around `artistName: String`
    // What happens if it changes here? -> It changes on the other side of the binding.
    @Binding // The property wrapper (Two-way street wrapper)
    var artistName: String // The property its's wrapping is `artistName: String`
    
    init(artistNameBinding: Binding<String>) {
        // In order to assign a binding to our variable
        _artistName = artistNameBinding
    }
    
    // Tell the compiler what view we'll be using while being UIViewRepresentable.
    // Generics via AssociatedType.
    typealias UIViewType = UISearchBar
    
    // Create our UIView
    func makeUIView(context: Context) -> UISearchBar {
        let searchBar = UISearchBar(frame: .zero)
        searchBar.searchBarStyle = .minimal
        searchBar.autocapitalizationType = .none
        searchBar.delegate = self
        return searchBar
    }
    
    // Update it every single time that SwiftUI updates it.
    func updateUIView(_ searchBar: UISearchBar, context: Context) {
        searchBar.delegate = self
    }
}

// In order to become a UISearchBarDelegate
// 1. Be a class
// 2. Be a final class
// 3. Inherit from NSObject
extension SearchView : UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        // The user typed _something_ and then pressed return.
        // artistName = searchBar.text!
        
        // Fetch the user's input and send it to iTunes.
        iTunesAPI.searchArtists(for: searchBar.text!) { result in
            
            // When the iTunes server responds, we either get an array of artits or an error.
            switch result {
            case .success(let artists):
                
                // If we got an array of artits, make sure there is at least
                guard let firstArtist = artists.first else { return }
                
                // Update our `artistName` string, which triggers its own
                self.artistName = firstArtist.artistName
            
            case .failure(let error):
                print(error)
            }
        }
        
        searchBar.endEditing(true)
    }
}
