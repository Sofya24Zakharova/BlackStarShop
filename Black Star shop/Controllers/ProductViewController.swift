//
//  ProductViewController.swift
//  Black Star shop
//
//  Created by mac on 07.09.2020.
//  Copyright © 2020 Sofya Zakharova. All rights reserved.
//

import UIKit

class ProductViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var pageControl: UIPageControl!
    
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var colorLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    let transparentView = UIView()
    
    let addedToCartView = UIView()
    
    let sizeWindow = SizeWindowView()
    
    let sizeTableViewHight : CGFloat = 200
    
    let screenSize = UIScreen.main.bounds.size
    
    var productImages = [UIImage]()
    
    var currentIndex = 0
    
    var product : Product?
    
    var priceDouble : Double?
    
    var imageToSave : UIImage?
    
    let popUpWindow : AddedToCartView = {
        let view = AddedToCartView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let pr = product else {return}
        
        priceDouble = Double(pr.price)
        
        priceLabel.text = String(format: "%.f", priceDouble!) + "₽"
        
        descriptionLabel.text = product?.description
        colorLabel.text = product?.colorName
        productNameLabel.text = product?.name
        
        
        guard let urlImages = product?.productImages else {return}
        productImages = getProductImages(with: urlImages)

        pageControl.numberOfPages = productImages.count
        
        //sizeWindow.data = product
        
        sizeWindow.delegate = self
        
        sizeWindow.frame = CGRect(x: 0, y: screenSize.height, width: screenSize.width, height: sizeTableViewHight)
      
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        currentIndex = Int(scrollView.contentOffset.x / collectionView.frame.size.width )
        pageControl.currentPage = currentIndex
    }
    
    @IBAction func addToCartTapped(_ sender: Any) {
        
        sizeWindow.data = product
        imageToSave = productImages.first
        
        transparentView.backgroundColor = UIColor.black
        transparentView.frame = self.view.frame
        view.addSubview(transparentView)
        view.addSubview(sizeWindow)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(clickTransparentView))
        transparentView.addGestureRecognizer(tapGesture)
        
        transparentView.alpha = 0
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseOut, animations: {
            self.transparentView.alpha = 0.7
            
            self.sizeWindow.alpha = 1
            
            self.sizeWindow.frame = CGRect(x: 0, y: self.screenSize.height - self.sizeTableViewHight, width: self.screenSize.width, height: self.sizeTableViewHight)
            
        }, completion: nil)
        
        
    }
    
    @objc func clickTransparentView() {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseInOut, animations: {
            self.transparentView.alpha = 0
            self.sizeWindow.alpha = 0
        }, completion: nil)
    }
}

extension ProductViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        productImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "imageCell", for: indexPath) as! SliderCollectionViewCell
        
        cell.productImageView.image = productImages[indexPath.row]
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        CGSize(width: collectionView.frame.size.width, height: collectionView.frame.size.height)
    }
    
    
    func getProductImages(with objects: [ProductImage]) -> [UIImage] {
        var arrayOfImages = [UIImage]()
        
        for i in objects {
            let stringURL = Urls.urlForimages+"\(i.imageURL)"
            
            if let imageURL = URL(string: stringURL),
                let imageData = try? Data(contentsOf: imageURL),
                let image = UIImage(data: imageData) {
                arrayOfImages.append(image)
            }
        }
        
        return arrayOfImages
    }
    private func showPopUpView() {
        
        view.addSubview(popUpWindow)
        UIView.animate(withDuration: 1, animations: {
            self.popUpWindow.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
            self.popUpWindow.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
            self.popUpWindow.heightAnchor.constraint(equalToConstant: 100).isActive = true
            self.popUpWindow.widthAnchor.constraint(equalToConstant: self.view.frame.width - 20).isActive = true
        }) { (_) in
            UIView.animate(withDuration: 1, delay: 1, options: .curveEaseOut, animations: {
                self.popUpWindow.alpha = 0
            }, completion: nil)
        }
    }
    
}

extension ProductViewController: SizeWindowDelegate {
    func didSelectSize(product: Product, size: String, isTapped: Bool) {
        
       // if isTapped {
            UIView.animate(withDuration: 0.5, delay: 0.1, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseInOut, animations: {
                self.sizeWindow.frame = CGRect(x: 0, y: self.screenSize.height, width: self.screenSize.width, height: self.sizeTableViewHight)
                self.transparentView.alpha = 0
            }, completion: nil)
            
            guard let img = imageToSave ?? UIImage(named: "tshirt") else {return}
            
            CoreDataManager.shared.saveProductToCart(with: product, size: size, image: img)
            
            showPopUpView()
        //}
    }
    
    
}
