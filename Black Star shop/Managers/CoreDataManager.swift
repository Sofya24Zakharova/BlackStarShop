//
//  CoreDataManager.swift
//  Black Star shop
//
//  Created by mac on 25.09.2020.
//  Copyright © 2020 Sofya Zakharova. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class CoreDataManager {
    
    static let shared = CoreDataManager()
    
    private init() {}
    
    private var context : NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    // MARK: - Core Data stack
    
    private var persistentContainer: NSPersistentContainer = {
       
        let container = NSPersistentContainer(name: "Black_Star_shop")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
              
           if let error = error as NSError? {
                
                  fatalError("Unresolved error \(error), \(error.userInfo)")
              }
          })
          return container
      }()
    
    
    func saveProductToCart(with product: Product, size: String, image: UIImage){
        
        guard  let entity = NSEntityDescription.entity(forEntityName: "CartProduct", in: context) else {return}
           
        let cartObject = CartProduct(entity: entity, insertInto: context)
        let jpg = image.jpegData(compressionQuality: 0.75)
        
        cartObject.mainImage = jpg
        cartObject.name = product.name
        cartObject.colorName = product.colorName
        cartObject.price = product.price
        cartObject.size = size
        
    saveContext()
    
    }
    
    func fetchCartProduct() -> [CartProduct] {
        
        let fetchRequest : NSFetchRequest<CartProduct> = CartProduct.fetchRequest()
        
        do {
            return try context.fetch(fetchRequest)
        } catch let error {
            print(error)
            return []
        }
        
    }
    
    func delete(product: CartProduct) {
        context.delete(product)
        saveContext()
    }
    
    // MARK: - Core Data Saving support
    
  private func saveContext() {
    
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                print(nserror, nserror.userInfo)
            }
        }
    }
}
