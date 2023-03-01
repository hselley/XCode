//
//  ContentView.swift
//  FoodPin
//
//  Created by Héctor Julián Selley Rojas on 28/02/23.
//

import SwiftUI

struct RestaurantListView: View {
    
    var restaurantNames = [
        "Cafe Deadend", "Homei", "Teakha", "Cafe Loisl",
        "Petite Oyster", "For Kee Restaurant", "Po's Atelier",
        "Bourke Street Bakery", "Haigh's Chocolate", "Palomino Espresso",
        "Upstate", "Traif", "Graham Avenue Meats", "Waffle & Wolf",
        "Five Leaves", "Cafe Lore", "Confessional", "Barrafina",
        "Donostia", "Royal Oak", "CASK Pub and Kitchen"]
    
    var restaurantImages = [
        "cafedeadend", "homei", "teakha", "cafeloisl", "petiteoyster",
        "forkee", "posatelier", "bourkestreetbakery", "haigh",
        "palomino", "upstate", "traif", "graham", "waffleandwolf",
        "fiveleaves", "cafelore", "confessional", "barrafina",
        "donostia", "royaloak", "cask"]
    
    var restaurantLocations = [
        "Hong Kong", "Hong Kong", "Hong Kong", "Hong Kong", "Hong Kong",
        "Hong Kong", "Hong Kong", "Sydney", "Sydney", "Sydney",
        "New York", "New York", "New York", "New York", "New York", "New York",
        "New York", "London", "London", "London", "London"]
    
    var restaurantTypes = [
        "Coffee & Tea Shop", "Cafe", "Tea House", "Austrian / Causual Drink",
        "French", "Bakery", "Bakery", "Chocolate", "Cafe", "American / Seafood",
        "American", "American", "Breakfast & Brunch", "Coffee & Tea", "Coffee & Tea",
        "Latin American", "Spanish", "Spanish", "Spanish", "British", "Thai"]
    
    @State var restaurantIsFavorites = Array(repeating: false, count: 21)
    
    var body: some View {
        List() {
            ForEach(restaurantNames.indices, id: \.self) {
                index in FullImageRow( isFavorite: $restaurantIsFavorites[index],
                                       imageName: restaurantImages[index],
                                       name: restaurantNames[index],
                                       type: restaurantTypes[index],
                                       location: restaurantLocations[index]
                )
            }
            .listRowSeparator(.hidden)
        }
        .listStyle(.plain)
    }
}

struct FullImageRow: View {
    @State private var showOptions = false
    @State private var showError = false
    
    @Binding var isFavorite: Bool
    
    var imageName: String
    var name: String
    var type: String
    var location: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Image(imageName)
                .resizable()
                .scaledToFill()
                .frame(height: 200)
                .cornerRadius(20)
            
            HStack {
                VStack(alignment: .leading) {
                    Text(name)
                        .font(.system(.title2, design: .rounded))
                    
                    Text(type)
                        .font(.system(.body, design: .rounded))
                    
                    Text(location)
                        .font(.system(.subheadline, design: .rounded))
                        .foregroundColor(.gray)
                    
                }
                .padding(.horizontal)
                .padding(.bottom)
                
                if isFavorite {
                    Spacer()
                    
                    Image(systemName: "heart.fill")
                        .foregroundColor(.red)
                }
            }
            
        }
        .onTapGesture {
            showOptions.toggle()
        }
        .actionSheet(isPresented: $showOptions) {
            ActionSheet(title: Text("What do you want to do?"),
                        message: nil,
                        buttons: [
                            .default(Text("Reserve a table")) {
                                self.showError.toggle()
                            },
                            .default(Text("Mark as favorite")) {
                                self.isFavorite.toggle()
                            },
                            .cancel()
                        ]
            )
        }
        .alert(isPresented: $showError) {
            Alert(title: Text("Not yet available"),
                  message: Text("Sorry, this feature is not yet available. Please try again later."),
                  primaryButton: .default(Text("OK")),
                  secondaryButton: .cancel()
            )
        }
        
    }
}

struct BasicTextImageRow: View {
    var imageName: String
    var name: String
    var type: String
    var location: String
    
    var body: some View {
        HStack(alignment: .top, spacing: 20) {
            Image(imageName)
                .resizable()
                .frame(width: 120, height: 118)
                .cornerRadius(20)
            //.clipShape(RoundedRectangle(cornerRadius: 20))
            
            VStack(alignment: .leading) {
                Text(name)
                    .font(.system(.title2, design: .rounded))
                
                Text(type)
                    .font(.system(.body, design: .rounded))
                
                Text(location)
                    .font(.system(.subheadline, design: .rounded))
                    .foregroundColor(.gray)
            }
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        RestaurantListView()
            .previewDisplayName("Light Side")
        
        RestaurantListView()
            .previewDisplayName("Dark Side")
            .preferredColorScheme(.dark)
        
        FullImageRow(isFavorite: .constant(true),
                     imageName: "cafedeadend",
                     name: "Cafe Deadend",
                     type: "Cafe",
                     location: "Hong Kong")
            .previewDisplayName("VStack")
        
        BasicTextImageRow(
                     imageName: "cafedeadend",
                     name: "Cafe Deadend",
                     type: "Cafe",
                     location: "Hong Kong")
            .previewDisplayName("HStack")
    }
}
