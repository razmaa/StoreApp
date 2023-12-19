//
//  MainViewModel.swift
//  StoreApp
//
//  Created by nika razmadze on 19.12.23.
//

import SwiftUI

class MainViewModel: ObservableObject {
    @Published var products = [Product]()
    @Published var categories = [String]()
    @Published var balance = 1000.0
    @Published var cart = [Product]()
    
    init() {
        fetchProducts()
    }
    
    func fetchProducts() {
        let url = URL(string: "https://dummyjson.com/products")!
        URLSession.shared.dataTask(with: url) {(data, response, error) in
            do {
                if let data = data {
                    let decodedData = try JSONDecoder().decode(Response.self, from: data)
                    DispatchQueue.main.async {
                        self.products = decodedData.products
                        self.categories = Array(Set(decodedData.products.map { $0.category }))
                    }
                } else {
                    print("No data")
                }
            } catch {
                print("Error: \(error)")
            }
        }.resume()
    }
    
    func addToCart(product: Product) {
        cart.append(product)
    }
    
    func checkout() -> Bool {
        let total = cart.reduce(0) { $0 + $1.price }
        guard balance >= total else {
            return false
        }
        
        balance -= total
        cart.removeAll()
        return true
    }
}
