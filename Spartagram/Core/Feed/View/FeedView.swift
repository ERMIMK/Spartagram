//
//  FeedView.swift
//  Spartagram
//
//  Created by Ermiyas Mesfin on 10/22/23.
//

import SwiftUI

struct FeedView: View {
    
    @State private var shaowNewStoriesView = false
    @ObservedObject var viewModel = FeedViewModel()
    
    
    var body: some View {
        
        ZStack(alignment: .bottomTrailing){
            ScrollView {
                LazyVStack {
                    ForEach(viewModel.posts) { post in
                        StoriesRowView(post: post, onChange: {
                            viewModel.fetchStories()
                        })
                    }
                    
                }
            }
            .refreshable {
                viewModel.fetchStories()
            }
            
            Button {
                shaowNewStoriesView.toggle()
            } label: {
                Image (systemName: "pencil.and.outline")
                    .resizable()
                    .renderingMode(/*@START_MENU_TOKEN@*/.template/*@END_MENU_TOKEN@*/)
                    .frame(width: 32, height: 32)
                    .padding()
                    .offset(x: 0, y: -1)
                    .foregroundColor(.white)
                
            }
            .background(Color(hex: "#8FC18A"))
            .foregroundColor(.white)
            .clipShape(Circle())
            .padding()
            .fullScreenCover(isPresented: $shaowNewStoriesView) {
                NewStoriesView()
            }
        
        }
        .onAppear {
            viewModel.fetchStories()
        }
        
    }
}

#Preview {
    FeedView()
}


