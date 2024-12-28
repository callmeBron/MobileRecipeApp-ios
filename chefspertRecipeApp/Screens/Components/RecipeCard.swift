//
//  RecipeCard.swift
//  chefspertRecipeApp
//
//  Created by Bronwyn dos Santos on 2023/01/04.
//

import SwiftUI

struct RecipeCard: View {
    @EnvironmentObject var homeScreen: ViewModel
    let recipeResult: Result
    
    var body: some View {
        
        VStack{
            
            AsyncImage(url: URL(string:recipeResult.image)){ image in
                image
                    .resizable()
                    .aspectRatio( contentMode: .fill)
                    .overlay(alignment:.bottom) {
                        Text(recipeResult.title)
                            .modifier(FoodCardTitelModifier())
                    }
            }
        placeholder: { Image(systemName: "photo")
                .resizable()
                .modifier(PlacerHolderImageModifier())
                .overlay(alignment:.bottom) {
                   LinearGradient(gradient: Gradient(colors: [Color(.gray).opacity(0.3),Color(.gray)]), startPoint: .top, endPoint: .bottom)
                    Text(recipeResult.title)
                        .modifier(FoodCardTitelModifier())
                }
        }
            
            
            
        }
        .modifier(FoodItemCardModifier())
        .onAppear(){
            homeScreen.fetchAllRecipes()
        }
    }
    
}

//struct RecipeCard_Previews: PreviewProvider {
//    static var previews: some View {
//        RecipeCard()
//            .environmentObject(HomeScreenViewModel())
//    }
//}
