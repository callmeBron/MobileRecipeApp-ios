import Foundation


    // MARK: - ComplexSearch
    struct ComplexRecipeSearch: Codable {
        let results: [Result]
        let offset, number, totalResults: Int
    }

    // MARK: - ComplexSearch - Result
struct Result: Codable, Hashable {
    
    static func == (lhs: Result, rhs: Result) -> Bool {
        return lhs.id == rhs.id
    }
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
        let id: Int
        let title: String
        let image: String
        let imageType: ImageType
        let vegetarian, vegan, glutenFree, dairyFree: Bool
        let veryHealthy, cheap, veryPopular, sustainable: Bool
        let preparationMinutes, cookingMinutes, aggregateLikes, healthScore: Int
        let readyInMinutes, servings: Int
        let analyzedInstructions: [AnalyzedInstruction]
        
        enum CodingKeys: String, CodingKey {
            case id, title, readyInMinutes, servings
            case vegetarian, vegan, glutenFree, dairyFree
            case veryHealthy, cheap, veryPopular, sustainable
            case preparationMinutes, cookingMinutes, aggregateLikes, healthScore
            case analyzedInstructions
            case image, imageType
            
        }
    enum ImageType: String, Codable {
        case jpg = "jpg"
    }

    }

    
// MARK: - AnalyzedInstruction
struct AnalyzedInstruction: Codable {
    let name: String
    let steps: [Step]
}
// MARK: - Step
struct Step: Codable {
    let number: Int
    let step: String
    let ingredients, equipment: [Ent]
}
// MARK: - Ent
struct Ent: Codable {
    let id: Int
    let name, localizedName, image: String
}

