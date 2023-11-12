//
//  SavedStoriesRowView.swift
//  Spartagram
//
//  Created by Ermiyas Mesfin on 11/10/23.
//

import SwiftUI

struct SavedStoriesRowView: View {
    @ObservedObject var viewModel: fetchedUserSavedPosts
    var body: some View {
        ScrollView {
            LazyVStack {
                ForEach(viewModel.SavedPosts) { SavedPosts in
                    StoriesRowView(post: SavedPosts)
                        .padding()
                }
            }
        }
        .onAppear() {
            viewModel.fetchUserSavedPosts()
        }
    }

}

//#Preview {
//    SavedStoriesRowView()
//}
