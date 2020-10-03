//
//  CategoryTableViewCell.swift
//  Black Star shop
//
//  Created by mac on 26.08.2020.
//  Copyright © 2020 Sofya Zakharova. All rights reserved.
//

import UIKit
protocol ReloadCellDelegate {
    func reloadCell(at index: IndexPath?)
}

class CategoryTableViewCell: UITableViewCell {

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var categoryImage: ImageView!
    @IBOutlet weak var categoryLabel: UILabel!
    
    var index: IndexPath?
    var delegate : ReloadCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        activityIndicator.startAnimating()
        activityIndicator.hidesWhenStopped = true
    }
    
    func configureCell(with object: Category) {
        activityIndicator.startAnimating()
        categoryImage.layer.cornerRadius = categoryImage.frame.height / 2
        
        categoryLabel.text = object.name
        
        categoryImage.isHidden = false
        
        //categoryImage.image = categoryImage.fetchImage(from: Urls.urlForimages+"\(object.image)")
        
        //delegate?.getImage(image: true)
        
       categoryImage.image =  categoryImage.fetchImage(from: Urls.urlForimages+"\(object.image)")
        delegate?.reloadCell(at: index)
        
        activityIndicator.stopAnimating()
        
        /*
        DispatchQueue.global().async {
            let stringURL = Urls.urlForimages+"\(object.image)"
            if let imageURL = URL(string: stringURL),
                let imageData = try? Data(contentsOf: imageURL) {
                DispatchQueue.main.async {
                    self.categoryImage.image = UIImage(data: imageData) ?? UIImage(named: "tshirt")
                    self.activityIndicator.stopAnimating()
                }
            }
        }
 */
    }
    
    func configureSubcategoryCell(with object: Subcategory) {
        categoryLabel.text = object.name
        
        categoryImage.isHidden = true
    }
}
