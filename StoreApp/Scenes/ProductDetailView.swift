//
//  ProductDetailView.swift
//  StoreApp
//
//  Created by nika razmadze on 19.12.23.
//

import SwiftUI

struct ProductDetailView: View {
    @EnvironmentObject var viewModel: MainViewModel
    let product: Product
    
    var body: some View {
        VStack {
            Image(product.thumbnail)
                .resizable()
                .aspectRatio(contentMode: .fit)
            
            Text(product.title)
                .font(.title)
                .padding(.top)
            
            Text(String(format: "%.f",product.rating))
                .font(.subheadline)
                .foregroundColor(.gray)
            
            Text(product.description)
                .padding()
            
            Text("$\(String(format: "%.2f",product.price))")
                .font(.title)
                .fontWeight(.bold)
                .padding(.bottom)
            
            HStack {
                Button(action: {
                    viewModel.addToCart(product: product)
                }) {
                    Text("Add to Cart")
                        .padding()
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(10)
                }
                Button(action: {
                    let success = viewModel.checkout()
                }) {
                    Text("Checkout")
                        .padding()
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(10)
                }
                
            }
            
            Spacer()
        }
        .padding()
        .navigationTitle(product.title)
    }
}

#Preview {
    ProductDetailView(product: Product(id: 1, title: "h", description: "j", price: 8.0, discountPercentage: 0.1, rating: 5, stock: 4, brand: "g", category: "h", thumbnail: "photo", images: ["home.fill", "person.circle"]))
}
