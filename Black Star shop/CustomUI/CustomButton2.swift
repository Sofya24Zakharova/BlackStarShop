//
//  CustomButton2.swift
//  Black Star shop
//
//  Created by mac on 26.08.2020.
//  Copyright © 2020 Sofya Zakharova. All rights reserved.
//

import UIKit

 class CustomButton2: UIButton {

    override init(frame: CGRect) {
           super.init(frame: frame)
        setupButton()
        
       }
       required init?(coder: NSCoder) {
           super.init(coder: coder)
        setupButton()
       }
       
      private func setupButton() {
        backgroundColor = .systemPink
        setTitleColor(.black, for: .normal)
        titleLabel?.font = UIFont(name: "AvenirNext-DemiBold", size: 12)
        layer.cornerRadius = layer.frame.height/3
        
        
    }
}
