//
//  NetworkManager.swift
//  Black Star shop
//
//  Created by mac on 25.08.2020.
//  Copyright © 2020 Sofya Zakharova. All rights reserved.
//

import Foundation

class NetworkManager {

    static let shared = NetworkManager()
    
    private init() {}
    
    func fetchDataCategory(urlString: String, with completion: @escaping ([Category]) -> Void) {
        
        guard let url = URL(string: urlString) else {return}
        
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            
            if let error = error {print(error)}
            guard let data = data else {return}
            guard let json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) else {return}
            var categories = [Category]()
            if let jsonDict = json as? [String: [String: Any]] {
                for (_, category) in jsonDict {
                    if let name = category["name"] as? String,
                        let image = category["image"] as? String,
                        let subcategories = category["subcategories"] as? [[String:Any]] {
                        var subcategoryList = [Subcategory]()
                        
                        for subcategory in subcategories {
                            var subcategoryObject = Subcategory(id: "", name: subcategory["name"] as? String ?? "None")
                            
                            if let id = subcategory["id"] as? Int {
                                subcategoryObject.id = "\(id)"
                            } else if let id = subcategory["id"] as? String{
                                subcategoryObject.id = id
                            }
                            
                            subcategoryList.append(subcategoryObject)
                        }
                        
                        categories.append(Category(name: name, image: image, subcategories: subcategoryList))
                        
                    }
                    
                    categories.sort(by: { $0.name < $1.name })
                    completion(categories)
                    
                }
            }
            
        }.resume()
        
    }
    
    
    func fetchDataProduct(urlString: String, with completion: @escaping ([Product]) -> Void) {
        
        guard let url = URL(string: urlString) else {return}
        
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            
            if let error = error {print(error)}
            guard let data = data else {return}
            
            do {
                
                let ProductResponse = try JSONDecoder().decode(ProductDict.self, from: data)
                
                var products = [Product]()
                for (_, product) in ProductResponse {
                    products.append(product)
                }
                
                completion(products)
                
                
            } catch let jsonError {
                print(jsonError)
                
            }
            
        }.resume()
        
    }
}
