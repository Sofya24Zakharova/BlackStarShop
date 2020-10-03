//
//  ImageManager.swift
//  Black Star shop
//
//  Created by mac on 19.09.2020.
//  Copyright © 2020 Sofya Zakharova. All rights reserved.
//

import Foundation

class ImageManager {
    
    static let shared = ImageManager()
    
    private init() {}
    
    func getImage(from url: URL, complition: @escaping (Data, URLResponse) -> Void)  {
        
        URLSession.shared.dataTask(with: url) { (data, responce, error) in
            if let error = error {print(error); return }
            guard let data = data, let responce = responce else {return}
            guard let responceURL = responce.url else { return }
            guard responceURL == url else {return}
            
            complition(data, responce)
            
        }.resume()
  
    }
 
}
