//
//  RecipeList.swift
//  chefspertRecipeApp
//
//  Created by Bronwyn dos Santos on 2023/01/04.
//

import SwiftUI

struct RecipeList: View {
    @EnvironmentObject var viewModel: ViewModel
    var body: some View {
        
        VStack{
            //MARK:- All Recipes
            RecipeTitleView(headingText: "Try Something New")
            RecipeCountTitleView(recipeList: $viewModel.allRecipeResultList)
            RecipeGridView(recipeList: $viewModel.allRecipeResultList)
            
            
            
            //MARK:- Pesceterian Recipes
            RecipeTitleView(headingText: "Pescetarian Picks")
            RecipeCountTitleView(recipeList: $viewModel.pescetarianRecipes)
            RecipeGridView(recipeList: $viewModel.pescetarianRecipes)
            
            //MARK:- Vegeterian Recipes
            RecipeTitleView(headingText: "Vegeterian Friendly")
            RecipeCountTitleView(recipeList: $viewModel.vegeterianRecipes)
            RecipeGridView(recipeList: $viewModel.vegeterianRecipes)
            
        }
        .onAppear(){
            viewModel.fetchAllRecipes()
            viewModel.fetchDietSpecificRecipes()
        }
        .padding(.horizontal)
    }
}

struct RecipeList_Previews: PreviewProvider {
    static var previews: some View {
        ScrollView{
            RecipeList()
                .environmentObject(ViewModel())
        }
    }
}

struct RecipeTitleView: View {
    @EnvironmentObject var homeScreen:ViewModel
    let headingText: String
    var body: some View {
        HStack{
            Text(headingText)
                .modifier(HomeScreenTitleModifier())
            
            
            Spacer()
        }
    }
}

struct RecipeCountTitleView: View {
    @Binding var recipeList: [Result]
    var body: some View {
        HStack{
            Text("\(recipeList.count) \(recipeList.count > 1 ? "Recipes" : "Recipe") ")
                .modifier(RecipeCountTitleModifier())
            Spacer()
        }
    }
}

struct RecipeGridView: View {
    
    @Binding var recipeList: [Result]
    var body: some View {
        VStack{
            ScrollView(.horizontal, showsIndicators: false){
                HStack(spacing: 15){
                    
                    ForEach(recipeList, id: \.self) { recipes in
                                   NavigationLink(destination: RecipeView(recipe: recipes)) {
                        RecipeCard( recipeResult: recipes)
                                      }
                        
                        
                    }
                }
            }
            .padding(.top)
        }
    }
}
