import Foundation


// MARK: - ComplexSearch
struct ComplexRecipeSearch: Codable {
    let results: [Result]
    let offset, number, totalResults: Int
}

// MARK: - ComplexSearch - Result

struct Result: Codable, Hashable  {
    let vegetarian, vegan, glutenFree, dairyFree: Bool
    let veryHealthy, cheap, veryPopular, sustainable: Bool
    let lowFodmap: Bool
    let weightWatcherSmartPoints: Int
    let gaps: String
    let preparationMinutes, cookingMinutes: Int?
    let aggregateLikes, healthScore: Int
    let creditsText, sourceName: String
    let pricePerServing: Double
    let id: Int
    let title: String
    let readyInMinutes, servings: Int
    let sourceURL: String
    let image: String
    let imageType, summary: String
    let cuisines, dishTypes, diets, occasions: [String]
    let spoonacularScore: Double
    let spoonacularSourceURL: String
    let license: String?

    enum CodingKeys: String, CodingKey {
        case vegetarian, vegan, glutenFree, dairyFree, veryHealthy, cheap, veryPopular, sustainable, lowFodmap, weightWatcherSmartPoints, gaps, preparationMinutes, cookingMinutes, aggregateLikes, healthScore, creditsText, sourceName, pricePerServing, id, title, readyInMinutes, servings
        case sourceURL = "sourceUrl"
        case image, imageType, summary, cuisines, dishTypes, diets, occasions, spoonacularScore
        case spoonacularSourceURL = "spoonacularSourceUrl"
        case license
    }
    
    enum ImageType: String, Codable {
        case jpg = "jpg"
    }
    
    static func == (lhs: Result, rhs: Result) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
