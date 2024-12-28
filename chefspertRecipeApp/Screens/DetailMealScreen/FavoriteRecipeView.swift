import SwiftUI
import CoreData

struct FavoriteRecipeView: View {
    @FetchRequest(sortDescriptors: []) var favourites: FetchedResults<Favourite>
    @Environment(\.managedObjectContext) var context
    @EnvironmentObject var viewModel: ViewModel
    var recipe: Favourite
    
    
    var body: some View {
        ScrollView{
            AsyncImage(url: URL(string:recipe.image ?? "no image")){ image in
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
                Text(recipe.title ?? "food")
                    .font(.largeTitle)
                    .bold()
                    .multilineTextAlignment(.center)
                
                ScrollView(.horizontal, showsIndicators: false){
                    HStack{
                        foodSpecification(imageName: "clock", title: "Prep Mins", infoSlot: recipe.prepmins ?? "")
                        foodSpecification(imageName: "frying.pan", title: "Cook Mins", infoSlot: recipe.cookmins ?? "")
                        foodSpecification(imageName: "stethoscope.circle", title: "Health Score", infoSlot: recipe.healthscore ?? "")
                        foodSpecification(imageName: "hand.thumbsup", title: "Likes", infoSlot: recipe.likes ?? "")
                        foodSpecification(imageName: "person.3", title: "Serves", infoSlot: recipe.serves ?? "")
                    }
                    
                }

                    VStack{
                        Text("Directions")
                            .font(.headline)
                        Text("no directions found")
                        List {
                            ForEach(viewModel.ingredientArray, id: \.self){ item in
                                Text(item)
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

  
}


//struct RecipeView_Previews: PreviewProvider {
//    static var previews: some View {
//        RecipeView()
//    }
//}

struct FavFoodSpecification: View {
    var title: String
    var infoSlot: String
    var body: some View {
        VStack{
            Text(title)
            Text(infoSlot)
        }.padding()
    }
}
