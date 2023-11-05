//
//  StoryRowViewModel.swift
//  Spartagram
//
//  Created by Ermiyas Mesfin on 10/26/23.
//

import Foundation

class StoryRowViewModel: ObservableObject {

    @Published var post: Post
    private let service = StoriesService()

    
    init(post: Post) {
        self.post = post
        
        checkIfUserLikedPost()
    }
    
    
    
    
    // Like Story function
    func likeStory() {
        service.likeStory(post) {
            self.post.didLike = true
        }
    }
    // Unlike Story function
    func unlikeStory() {
        service.unlikeStory(post) {
            self.post.didLike = false
        }
    }
    // Check If User Liked Post
    func checkIfUserLikedPost() {
        service.checkIfUserLikedPost(post) { didLike in
            if didLike {
                self.post.didLike = true
            }
        }
    }
    
    
    
}

