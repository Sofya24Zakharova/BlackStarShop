//
//  ProductModel.swift
//  Black Star shop
//
//  Created by mac on 28.08.2020.
//  Copyright © 2020 Sofya Zakharova. All rights reserved.
//

import Foundation

struct Product: Codable {
    let name: String
    let description: String
    let mainImage: String
    let productImages: [ProductImage]
    let colorName : String
    let price: String
    let offers : [Sizes]
}

struct ProductImage : Codable {
    let imageURL : String
}

struct Sizes : Codable {
    let size : String
}

typealias ProductDict = [String: Product]
