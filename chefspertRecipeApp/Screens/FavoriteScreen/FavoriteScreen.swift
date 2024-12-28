import Foundation
import SwiftUI
import CoreData

struct FavoriteScreen: View{
    @FetchRequest(sortDescriptors: []) var favourites: FetchedResults<Favourite>
    @Environment(\.managedObjectContext) var context
    
    var body: some View {
        if !favourites.isEmpty{
            List{
                ForEach(favourites){ item in
                    NavigationLink(destination: FavoriteRecipeView( recipe: item)){
                        Text(item.title ?? "")
                    }
                }.onDelete(perform: removeFavourites(at:))
            }
        }else{
            Text("No Liked Recipes...")
        }
    }
    func removeFavourites(at offsets: IndexSet){
        for offset in offsets{
            let recipe = favourites[offset]
            context.delete(recipe)
        
        }
        try? context.save()
    }
}

    //MARK: Preview
    struct FavoriteScreen_Previews: PreviewProvider {
        static var previews: some View {
            FavoriteScreen()
        }
    }
