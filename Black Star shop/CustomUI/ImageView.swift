//
//  ImageView.swift
//  Black Star shop
//
//  Created by mac on 18.09.2020.
//  Copyright © 2020 Sofya Zakharova. All rights reserved.
//

import UIKit

class ImageView: UIImageView {
    
   // var imageFromURL : UIImage?
    
  //  self.image = nil

    func fetchImage(from url: String) {
       // self.image = nil
        guard let imageUrl = URL(string: url) else {return}
        
       if let cachedImage = getImageFromCach(url: imageUrl) {
          image = cachedImage
       }
        
        ImageManager.shared.getImage(from: imageUrl) { (data, responce) in
            DispatchQueue.main.async {
               // self.imageFromURL = UIImage(data: data)
                self.image = UIImage(data: data)
            }
            self.saveDataToCache(with: data, responce: responce)
        }
    }
   
    
    private func getImageFromCach(url: URL) -> UIImage? {
        let urlRequest = URLRequest(url: url)
        if let cachedResponse = URLCache.shared.cachedResponse(for: urlRequest) {
            image = UIImage(data: cachedResponse.data)
        }
        return UIImage(named: "tshirt")
    }

    private func saveDataToCache(with data: Data, responce: URLResponse){
        guard let urlResponce = responce.url else {return}
        let cachedResponse = CachedURLResponse(response: responce, data: data)
        let urlRequest = URLRequest(url: urlResponce)
        URLCache.shared.storeCachedResponse(cachedResponse, for: urlRequest)
        
    }
}
