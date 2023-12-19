//
//  ProductModel.swift
//  StoreApp
//
//  Created by nika razmadze on 19.12.23.
//

import Foundation

struct Product: Identifiable, Decodable {
    let id: Int
    let title: String
    let description: String
    let price: Double
    let discountPercentage: Double
    let rating: Double
    let stock: Int
    let brand: String
    let category: String
    let thumbnail: String
    let images: [String]
}

struct Response: Decodable {
    let products: [Product]
    let total: Int
    let skip: Int
    let limit: Int
}
