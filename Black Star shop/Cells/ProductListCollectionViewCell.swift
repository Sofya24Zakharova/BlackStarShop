//
//  ProductListCollectionViewCell.swift
//  Black Star shop
//
//  Created by mac on 13.09.2020.
//  Copyright © 2020 Sofya Zakharova. All rights reserved.
//

import UIKit

protocol BuyButtonTappedDelegate {
    func tapButton(tapped : Product?)
}

class ProductListCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var button: CustomButton2!
    
    var delegate : BuyButtonTappedDelegate?
    
    var item : Product!
    
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var purchaseImage: UIImageView!
    
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
     override func awakeFromNib() {
           super.awakeFromNib()
           
           activityIndicator.startAnimating()
           activityIndicator.hidesWhenStopped = true
       }
    
    @IBAction func buyButtonTapped(_ sender: Any) {
        delegate?.tapButton(tapped: item)
        
    }
    
    func configureCollectioViewCell(with object: Product) {
        
        item = object
        
        guard let doublelPrice = Double(object.price) else {return}
        priceLabel.text = String(format: "%.f", doublelPrice) + "₽"
        productNameLabel.text = object.name
        
        DispatchQueue.global().async {
            let stringURL = Urls.urlForimages+"\(object.mainImage)"
            if let imageURL = URL(string: stringURL),
                let imageData = try? Data(contentsOf: imageURL) {
                DispatchQueue.main.async {
                    self.purchaseImage.image = UIImage(data: imageData) ?? UIImage(named: "tshirt")
                    self.activityIndicator.stopAnimating()
                }
            }
        }
        
    }
}

