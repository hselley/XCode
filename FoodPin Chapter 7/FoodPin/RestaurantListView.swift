//
//  ContentView.swift
//  FoodPin
//
//  Created by Héctor Julián Selley Rojas on 28/02/23.
//

import SwiftUI

struct RestaurantListView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        RestaurantListView()
    }
}
