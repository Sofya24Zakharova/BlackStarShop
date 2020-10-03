//
//  CartViewController.swift
//  Black Star shop
//
//  Created by mac on 30.09.2020.
//  Copyright © 2020 Sofya Zakharova. All rights reserved.
//

import UIKit

class CartViewController: UIViewController {

    @IBOutlet weak var totalPriceLabel: UILabel!
    
    var cartProducts : [CartProduct] = []
    
    @IBOutlet weak var checkOutButton: CustomButton!
    @IBOutlet weak var tabelView: UITableView!
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let cartProducts1 = CoreDataManager.shared.fetchCartProduct()
        let reversedProducts  = Array(cartProducts1.reversed())
        cartProducts = reversedProducts
 
        tabelView.reloadData()
        totalPriceLabel.text = "\(Int(getTotalPrice()))₽"
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabelView.allowsSelection = false
        
        title = "Корзина"

        tabelView.delegate = self
        tabelView.dataSource = self
    }
    
}

extension CartViewController: UITableViewDelegate, UITableViewDataSource{
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        cartProducts.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
    
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cartCell", for: indexPath) as! CartTableViewCell
        
        let cartProduct = cartProducts[indexPath.row]
        
        cell.cartNameLabel.text = cartProduct.name
        cell.cartColorLabel.text = cartProduct.colorName
        cell.cartSizeLabel.text = cartProduct.size
       
        cell.delegate = self
        cell.index = indexPath
        
        let priceString = String(cartProduct.price ?? "")
        let priceDouble = Double(priceString)
        cell.cartPriceLabel.text  = String(format: "%.f", priceDouble ?? "") + "₽"
        
        if let image = cartProduct.mainImage {
            cell.cartImage.image = UIImage(data: image)
        }
        
        return cell
    }
    
    private func getTotalPrice() -> Float {
        
        var totalPrise : Float = 0
        for product in cartProducts {
            if let price = Float(product.price ?? "0") {
            totalPrise += price
        }
        }
        return totalPrise
    }
}

extension CartViewController : CartCellDelegate{
    
    func trashButtonTapped(at index: IndexPath?) {
        guard let index = index else { return }
        let  productToDelite = cartProducts[index.row]
    
        cartProducts.remove(at: index.row)
        tabelView.deleteRows(at: [index], with: .fade)
        CoreDataManager.shared.delete(product: productToDelite)
        totalPriceLabel.text = "\(Int(getTotalPrice()))₽"
   }
}


    

