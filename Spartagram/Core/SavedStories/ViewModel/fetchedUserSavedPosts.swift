//
//  fetchedUserSavedPosts.swift
//  Spartagram
//
//  Created by Ermiyas Mesfin on 11/10/23.
//

import Foundation

class fetchedUserSavedPosts: ObservableObject {
    
    private let service = StoriesService()
    private let userService = UserService()
    @Published var SavedPosts = [Post]()
    
    let user: User
    
    init(user: User) {
        self.user = user
        self.fetchUserSavedPosts()
    }
    
    func fetchUserSavedPosts() {
        
        guard let uid = user.id else {return}
        service.fetchSavedPosts(forUid: uid) { posts in
            self.SavedPosts = posts
            
            for i in 0 ..< posts.count {
                let uid = posts[i].uid
                
                self.userService.fetchUser(withUid: uid) { user in
                    self.SavedPosts[i].user = user
                }
            }
        }
    }

}
    
