//
//  AddToCartView.swift
//  Black Star shop
//
//  Created by mac on 29.09.2020.
//  Copyright © 2020 Sofya Zakharova. All rights reserved.
//

import UIKit

class AddedToCartView: UIView {
    
    private let alertLabel : UILabel = {
        let label = UILabel()
        label.text = "Добавлено в корзину"
        label.textAlignment = .center
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
  
   private func setup() {
    
    backgroundColor = #colorLiteral(red: 0.2209611078, green: 0.2429643758, blue: 0.8787775832, alpha: 1)
        layer.cornerRadius = 12
        self.addSubview(alertLabel)
        alertLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        alertLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
     
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
       setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
