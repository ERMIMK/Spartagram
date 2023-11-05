//
//  ExploreView.swift
//  Spartagram
//
//  Created by Ermiyas Mesfin on 10/22/23.
//

import SwiftUI


// Explore View : to search for other user
struct ExploreView: View {
    
    @ObservedObject var viewModel = ExplorerViewModel()
    
    var body: some View {
        NavigationView{
            VStack {
                
                SearchBar (text: $viewModel.searchText)
                    .padding()
                
                ScrollView {
                    LazyVStack{
                        ForEach(viewModel.searchableUsers) { user in
                            NavigationLink{
                                ProfileView(user: user)
                            } label: {
                                UserRowView(user: user)
                            }
                            
                        }
                    }
                }
            }
            .navigationTitle("Explore")
            .navigationBarTitleDisplayMode(.inline)
            
        }
    }
}

#Preview {
    ExploreView()
}
