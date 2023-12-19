//
//  ProductsView.swift
//  StoreApp
//
//  Created by nika razmadze on 19.12.23.
//

import SwiftUI

struct ProductsView: View {
    @EnvironmentObject var viewModel: MainViewModel
    let category: String
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: Array(repeating: .init(.flexible()), count: 2)) {
                ForEach(viewModel.products.filter { $0.category == category }) { product in
                    NavigationLink(destination: ProductDetailView(product: product)) {
                        VStack(alignment: .leading) {
                            Image(product.thumbnail)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                            Text(product.title)
                                .font(.headline)
                            Text("$\(String(format: "%.1f", product.price))")
                                .font(.subheadline)
                        }
                        .padding()
                    }
                }
            }
        }
        .navigationBarTitle(category, displayMode: .inline)
    }
}

#Preview {
    ProductsView(category: "smartphone")
}
