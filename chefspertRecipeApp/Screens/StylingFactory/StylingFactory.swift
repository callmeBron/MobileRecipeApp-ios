import SwiftUI
//custom font, colors and custom modifiers
struct CustomColors {
    static let logoBlueColor = Color("logoBlue")
    
}

// MARK:- RecipeCardStyling
struct FoodItemCardModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(width: 160, height: 217, alignment: .top)
            .background(LinearGradient(gradient: Gradient(colors: [Color(.gray).opacity(0.3),Color(.gray)]), startPoint: .top, endPoint: .bottom))
            .clipShape(RoundedRectangle(cornerRadius: 20, style:.continuous))
            .shadow(color: Color.black.opacity(0.3),radius: 5, x: 0, y: 8)
    }
}

struct PlacerHolderImageModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(width: 40, height: 40, alignment: Alignment.center)
            .foregroundColor(Color.white.opacity(0.7))
            .scaledToFit()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}
struct FoodCardTitelModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.headline)
            .foregroundColor(.white)
            .shadow(color:.black, radius: 3, x: 0, y: 0)
            .frame(maxWidth: 136)
            .padding()
    }
}

// MARK:- Recipe List View Styling
struct HomeScreenTitleModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.title2)
            .bold()
            .padding(.leading)
            .padding(.top)
    }
}
   
struct RecipeCountTitleModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .foregroundColor(.secondary)
            .font(.headline)
            .fontWeight(.medium)
            .opacity(0.7)
            .padding(.leading)
    }
}

// MARK:- Home Screen Styling

struct RecipeSearchImageModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(width: 40 , height: 40)
            .clipShape(Circle())
            .shadow(color: Color.black.opacity(0.3),radius: 8, x: 0, y: 5)
    }
}
