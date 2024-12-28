//
//  chefspertRecipeAppApp.swift
//  chefspertRecipeApp
//
//  Created by Bronwyn dos Santos on 2022/12/12.
//

import SwiftUI
enum Screen{
    case homeScreen
    case favouriteScreen
}

final class TabRouter: ObservableObject{
    @Published var screen: Screen = .homeScreen
    
    func change(to screen: Screen){
        self.screen = screen
    }
}


@main
struct chefspertRecipeAppApp: App {
    @StateObject var router = TabRouter()
    @StateObject var homeScreen = ViewModel()
    @StateObject var databaseManager = DatabaseManager()
    var body: some Scene {
        WindowGroup {
            TabView(selection: $router.screen){
                HomeScreen()
                    .tag(Screen.homeScreen)
                    .tabItem {
                        Label("Recipes", systemImage: "fork.knife.circle.fill")
                    }
                FavoriteScreen()
                    .tag(Screen.favouriteScreen)
                    .tabItem {
                        Label("Favourites", systemImage: "heart.circle")
                    }
            }
            .environmentObject(homeScreen)
            .environment(\.managedObjectContext, databaseManager.container.viewContext)
            .accentColor(CustomColors.logoBlueColor)
        }
    }
}
