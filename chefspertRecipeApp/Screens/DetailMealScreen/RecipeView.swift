import SwiftUI
import CoreData

struct RecipeView: View {
    @FetchRequest(sortDescriptors: []) var favourites: FetchedResults<Favourite>
    @Environment(\.managedObjectContext) var context
    @EnvironmentObject var viewModel: ViewModel
    var recipe: Result
    
    
    var body: some View {
        ScrollView{
            AsyncImage(url: URL(string:recipe.image)){ image in
                image
                    .resizable()
                    .aspectRatio( contentMode: .fill)
            }
        placeholder: {
            Image(systemName: "photo")
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100, alignment: .center)
                .foregroundColor(.white.opacity(0.7))
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .frame(height: 300)
        .background(LinearGradient(gradient: Gradient(colors: [Color(.gray).opacity(0.3),Color(.gray)]), startPoint: .top, endPoint: .bottom))
            VStack(spacing: 30){
                VStack{
                    Text(recipe.title)
                        .font(.title2)
                        .bold()
                        .multilineTextAlignment(.center)
                    
                    Button{
                        addToFavourites()
                    }label:{
                        Label("Add to Favorites", systemImage: "heart")
                            .foregroundColor(.pink)
                    }
                }
                HStack{
                    if recipe.veryPopular == true{
                        VStack{
                            Image(systemName: "star.fill")
                                .foregroundColor(.yellow)
                            Text("Popularity")
                        }
                        .padding()
                    }else{
                        VStack{
                            Image(systemName: "star.slash.fill")
                                .foregroundColor(.gray)
                            Text("Popularity")
                        }
                        .padding()
                    }
                    if recipe.veryHealthy == true{
                        VStack{
                            Image(systemName: "leaf.fill")
                                .foregroundColor(.green)
                            Text("Health")
                        }
                        .padding()
                    }else{
                        VStack{
                            Image(systemName: "leaf")
                                .foregroundColor(.gray)
                            Text("Health")
                        }
                        .padding()
                    }
                }
                ScrollView(.horizontal, showsIndicators: false){
                    HStack{
                        foodSpecification(imageName: "clock", title: "Prep time", infoSlot: "\(recipe.preparationMinutes < 1 ? "0 min" : "\(recipe.preparationMinutes)mins")")
                        foodSpecification(imageName: "hand.thumbsup", title: "Likes", infoSlot: "\(recipe.aggregateLikes)")
                        foodSpecification(imageName: "stethoscope.circle", title: "Health", infoSlot: "\(recipe.healthScore)")
                        foodSpecification(imageName: "person.3", title: "Serves", infoSlot: "\(recipe.servings)")
                        foodSpecification(imageName: "frying.pan", title: "Cook", infoSlot:  "\(recipe.cookingMinutes < 1 ? "0 min" : "\(recipe.cookingMinutes)mins")")
                    }
                    
                }

                    VStack{
                        Text("Directions")
                            .font(.headline)
                        Text("no directions found")
                        List {
                            ForEach(viewModel.ingredientArray, id: \.self){ item in
                                Text(item.description)
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                                    .listRowBackground(Color(.red))
                            }
                        }
                    }
                    

            }
            .padding(.horizontal)
        }
        .onAppear(){
        
        }
        .ignoresSafeArea(.container, edges: .top)
    }
    
    func addToFavourites(){
        let favouriteRecipe = Favourite(context: context)
        
        favouriteRecipe.title = recipe.title
        favouriteRecipe.cookmins = String(recipe.cookingMinutes)
        favouriteRecipe.healthscore = String(recipe.healthScore)
        favouriteRecipe.prepmins = String(recipe.preparationMinutes)
        favouriteRecipe.likes = String(recipe.aggregateLikes)
        favouriteRecipe.serves = String(recipe.servings)
        favouriteRecipe.image = recipe.image
        try? context.save()
    }
 
}


//struct RecipeView_Previews: PreviewProvider {
//    static var previews: some View {
//        RecipeView()
//    }
//}

struct foodSpecification: View {
    var imageName: String
    var title: String
    var infoSlot: String
    var body: some View {
        VStack{
            Image(systemName: imageName)
            Text(title)
            Text(infoSlot)
        }.padding()
    }
}
