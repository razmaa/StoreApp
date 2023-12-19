//
//  MainView.swift
//  StoreApp
//
//  Created by nika razmadze on 19.12.23.
//

import SwiftUI

struct MainView: View {
    @StateObject var viewModel = MainViewModel()
    @State var path = NavigationPath()
    @State private var showingAlert = false
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var isSideMenuShown = false
    
    var body: some View {
        NavigationStack(path: $path) {
            ZStack{
                
                if isSideMenuShown {
                    CategoriesView(categories: Array(viewModel.categories), isShown: $isSideMenuShown, path: $path )
                }
                
                
                VStack {
                    ScrollView {
                        LazyVGrid(columns: Array(repeating: .init(.flexible()), count: 2)) {
                            ForEach(viewModel.products) { product in
                                VStack(alignment: .leading) {
                                    Image(product.thumbnail)
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                    Text(product.title)
                                        .font(.headline)
                                    Text(String(format: "%.2f", product.price))
                                        .font(.subheadline)
                                }
                                .padding()
                            }
                        }
                    }
                }
                .blur(radius: isSideMenuShown ? 5 : 0)
                .disabled(isSideMenuShown)
            }
            HStack{
                Text("Balance: \(String(format: "%.1f" , viewModel.balance))")
                Text("Items in Cart: \(viewModel.cart.count)")
                Text("Total Amount: \(String(format: "%.1f" ,viewModel.cart.reduce(0) { $0 + $1.price }))")
            }
            Button(action: {
                let success = viewModel.checkout()
                if success {
                    alertTitle = "Success"
                    alertMessage = "Purchase successful"
                } else {
                    alertTitle = "Error"
                    alertMessage = "Not enough balance"
                }
                showingAlert = true
            }) {
                Text("Checkout")
            }
            .buttonStyle(.borderedProminent)
            .alert(isPresented: $showingAlert) {
                Alert(title: Text(alertTitle), message: Text(alertMessage), dismissButton: .default(Text("OK")))
            }
            .navigationBarTitle("Products", displayMode: .inline)
            .navigationBarItems(leading: Button(action: {
                withAnimation {
                    self.isSideMenuShown.toggle()
                }
            }) {
                Image(systemName: isSideMenuShown ? "xmark" : "line.horizontal.3")
                    .imageScale(.large)
            }, trailing: Image(systemName: "cart"))
        }
    }
}



#Preview {
    MainView()
}

