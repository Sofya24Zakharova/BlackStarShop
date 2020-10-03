//
//  ProductListUICollectionViewController.swift
//  Black Star shop
//
//  Created by mac on 28.08.2020.
//  Copyright © 2020 Sofya Zakharova. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Product"

class ProductListUICollectionViewController: UICollectionViewController {
    
    let itemPerRow : CGFloat = 2
    
    let sectionInserts = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var id : String?
    
    var titleName : String?
    
    var products = [Product]()
    
    var productToNextVC : Product?
    
    let countCells : CGFloat = 2.0
    
    let spacingCells : CGFloat = 2.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        activityIndicator.startAnimating()
        activityIndicator.hidesWhenStopped = true
        
        title = titleName ?? ""
        
        guard let id = id else {return}
        
        NetworkManager.shared.fetchDataProduct(urlString: Urls.urlForProductList+id) { (ProductList) in
            DispatchQueue.main.async {
                self.products = ProductList
                self.activityIndicator.stopAnimating()
                self.collectionView.reloadData()
               
            }
        }
  
    }

    @IBAction func categoriesTapped(_ sender: Any) {
        
        navigationController?.popViewController(animated: true)
    }
    
    
    // MARK: UICollectionViewDataSource

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return products.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ProductListCollectionViewCell
        
        let product = products[indexPath.row]
        
        cell.delegate = self
        
        cell.configureCollectioViewCell(with: product)
    
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "ShowDitail", sender: products[indexPath.row])
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowDitail", let item = sender as? Product {
            let nextVC = segue.destination as! ProductViewController
            nextVC.product = item
        }
    }
}

extension ProductListUICollectionViewController: BuyButtonTappedDelegate {
    func tapButton(tapped: Product?) {
        
        if let item = tapped {
            performSegue(withIdentifier: "ShowDitail", sender: item)
            
        }
    }  
}

extension ProductListUICollectionViewController : UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
          let frameVC = collectionView.frame
         
         let spacingBetwin: CGFloat = 10 * 3
         let availableWidth = frameVC.width - spacingBetwin
         let widthPerItem = availableWidth / 2

         return CGSize(width: widthPerItem, height: 220)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInserts
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInserts.left
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInserts.left
    }
}
