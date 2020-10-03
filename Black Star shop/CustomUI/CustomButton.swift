//
//  CustomButton.swift
//  Black Star shop
//
//  Created by mac on 26.08.2020.
//  Copyright © 2020 Sofya Zakharova. All rights reserved.
//

import UIKit

class CustomButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButton()
    }
    
    required init?(coder: NSCoder) {
           super.init(coder: coder)
             setupButton()
         }
    
   private func setupButton() {
    backgroundColor = #colorLiteral(red: 0.203973435, green: 0.3506513131, blue: 1, alpha: 1)
    
    setTitleColor(.white, for: .normal)
        titleLabel?.font = UIFont(name: "AvenirNext-DemiBold", size: 18)
        layer.cornerRadius = layer.frame.height/2
    }
   
}
