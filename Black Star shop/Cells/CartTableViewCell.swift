//
//  CartTableViewCell.swift
//  Black Star shop
//
//  Created by mac on 30.09.2020.
//  Copyright © 2020 Sofya Zakharova. All rights reserved.
//

import UIKit

protocol CartCellDelegate{
    func trashButtonTapped(at index: IndexPath?)
}

class CartTableViewCell: UITableViewCell {

    @IBOutlet weak var cartImage: UIImageView!
    
    @IBOutlet weak var cartNameLabel: UILabel!
    
    @IBOutlet weak var cartPriceLabel: UILabel!
    
    @IBOutlet weak var cartColorLabel: UILabel!
    
    @IBOutlet weak var cartSizeLabel: UILabel!
    
    var delegate: CartCellDelegate?
    var index: IndexPath?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func trashButtonTapped(_ sender: Any) {
        delegate?.trashButtonTapped(at: index)
    }
}
