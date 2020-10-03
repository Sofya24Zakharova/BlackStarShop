//
//  CategoryModel.swift
//  Black Star shop
//
//  Created by mac on 25.08.2020.
//  Copyright © 2020 Sofya Zakharova. All rights reserved.
//

import Foundation

struct Category {
    let name: String
    let image: String
    let subcategories: [Subcategory]
}

struct Subcategory {
    var id: String
    let name: String
}


