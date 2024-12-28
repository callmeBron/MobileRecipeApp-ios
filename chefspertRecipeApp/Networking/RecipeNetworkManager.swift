import Foundation

// create a URL + Session

class RecipeNetworkManager {
    let apiKey = "1590c289513443ca8f33a5c3d9de9279"
    //"1590c289513443ca8f33a5c3d9de9279"
    //"edc157bb1bf9467a91fefa792137dc9f"
    //"bd4196aaee08464caef99edfba2d9d28"
    //"969493ec42a540f3810c3ad7bcb5da93"
    
    var allRecipe: ComplexRecipeSearch?
    var vegeterianRecipe: ComplexRecipeSearch?
    var pescetarianRecipe: ComplexRecipeSearch?
    var randomRecipe: ComplexRecipeSearch?
    var searchedRecipe: ComplexRecipeSearch?
    
    var recipeInformation: ComplexRecipeSearch?
    
    func fetchAllRecipes(completion: @escaping (ComplexRecipeSearch) -> ()){
       
        let url = "https://api.spoonacular.com/recipes/complexSearch?apiKey=\(apiKey)&number=5&addRecipeInformation=true"
        
        guard let safeURL =  URL(string: url)  else { return }
        //Create a request
        let request = URLRequest(url: safeURL)
        //create a service group for async calls
        let serviceGroup = DispatchGroup()
        serviceGroup.enter()
        
        //create a task
        let task = URLSession.shared.dataTask(with: request){ data, response, error in
            guard let data = data else{return}
            do{
                //decode data
                let decodedData = try JSONDecoder().decode(ComplexRecipeSearch.self, from: data)
                self.allRecipe = decodedData
                serviceGroup.leave()
                
            }catch let error{
                print("fetch all recipes: \(error.localizedDescription)")
            }
            
            print(" ive called all recipes")
        }
        task.resume()
        
        serviceGroup.notify(queue: DispatchQueue.global()){ [weak self] in
            DispatchQueue.main.async {
                guard let safeAllRecipe = self?.allRecipe else {return}
                completion(safeAllRecipe)
            }
            
        }
    }
        
        func fetchSearchedRecipes(for foodSearch: String, completion: @escaping (ComplexRecipeSearch) -> ()){
            let url = "https://api.spoonacular.com/recipes/complexSearch?apiKey=\(apiKey)&query=\(foodSearch)&addRecipeInformation=true"
            
            guard let safeURL =  URL(string: url)  else { return }
            //Create a request
            let request = URLRequest(url: safeURL)
            
            //create a service group for async calls
            let serviceGroup = DispatchGroup()
            serviceGroup.enter()
            
            //create a task
            let task = URLSession.shared.dataTask(with: request){ data, response, error in
                guard let data = data else{return}
                do{
                    //decode data
                    let decodedData = try JSONDecoder().decode(ComplexRecipeSearch.self, from: data)
                    self.searchedRecipe = decodedData
                    serviceGroup.leave()
                    
                }catch let error{
                    print(error.localizedDescription)
                }
                
                
            }
            task.resume()
            
            serviceGroup.notify(queue: DispatchQueue.global()){ [weak self] in
                DispatchQueue.main.async {
                    guard let safeSearchedRecipe = self?.searchedRecipe else {return}
                    completion(safeSearchedRecipe)
                }
                
            }
        }
        
        
        
        
    func fetchDietSpecificRecipes(for dietType: String ,completion: @escaping (ComplexRecipeSearch) -> ()){
       
        let url = "https://api.spoonacular.com/recipes/complexSearch?apiKey=\(apiKey)&diet=\(dietType)&number=6&addRecipeInformation=true"
        
        guard let safeURL =  URL(string: url)  else { return }
        //Create a request
        let request = URLRequest(url: safeURL)
        //create a service group for async calls
        let serviceGroup = DispatchGroup()
        serviceGroup.enter()
        
        //create a task
        let task = URLSession.shared.dataTask(with: request){ data, response, error in
            guard let data = data else{return}
            do{
                //decode data
                let decodedData = try JSONDecoder().decode(ComplexRecipeSearch.self, from: data)
                self.vegeterianRecipe = decodedData
                serviceGroup.leave()
                
            }catch let error{
                print("fetch diet specific: \(error.localizedDescription)")
            }
        
        }
        task.resume()
        
        serviceGroup.notify(queue: DispatchQueue.global()){ [weak self] in
            DispatchQueue.main.async {
                guard let safeVegeterianRecipe = self?.vegeterianRecipe else {return}
                completion(safeVegeterianRecipe)
            }
            
        }
    }
  
        
    func fetchRecipeInformation(for id: Int, completion: @escaping (ComplexRecipeSearch) ->()){
        let url = "https://api.spoonacular.com/recipes/\(id)/information&apiKey=\(apiKey)"
        
        guard let safeURL = URL(string: url) else {return}
        let request = URLRequest(url: safeURL)
        
        let serviceGroup = DispatchGroup()
        serviceGroup.enter()
        
        let task = URLSession.shared.dataTask(with: request){ data, response, error in
            guard let data = data else {return}
            do{
                let decodedData = try JSONDecoder().decode(ComplexRecipeSearch.self, from: data)
                self.recipeInformation = decodedData
                serviceGroup.leave()
            }catch let error{
                print(error.localizedDescription)
            }
        }
        task.resume()
        
        
        serviceGroup.notify(queue: DispatchQueue.global()){ [weak self] in
            DispatchQueue.main.async {
                guard let safeRecipeDetails = self?.recipeInformation else {return}
                completion(safeRecipeDetails)
            }
            
        }
        
    }
  
   
}


