//
//  CategoriesView.swift
//  StoreApp
//
//  Created by nika razmadze on 19.12.23.
//

import SwiftUI

struct CategoriesView: View {
    let categories: [String]
    @Binding var isShown: Bool
    @Binding var path: NavigationPath
    
    var body: some View {
        NavigationStack(path: $path){
            VStack(alignment: .leading) {
                ForEach(categories, id: \.self) { category in
                    NavigationLink(value: category){
                        Text(category)
                            .padding()
                            .bold()
                            .onTapGesture {
                                withAnimation {
                                    self.isShown = false
                                }
                            }
                    }
                    .navigationDestination(for: String.self) { category in
                        ProductsView(category: category)
                    }
                }
                Spacer()
            }
            .padding(.top, 20)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(Color.gray.opacity(0.5))
            .edgesIgnoringSafeArea(.bottom)
            .offset(x: isShown ? 0 : -UIScreen.main.bounds.width)
        }
    }
}

#Preview {
    CategoriesView(categories: ["a", "b", "c"], isShown: .constant(true), path: .constant(NavigationPath()))
}
