//
//  ProfileViewModel.swift
//  Spartagram
//
//  Created by Ermiyas Mesfin on 10/26/23.
//

import Foundation


class ProfileViewModel: ObservableObject {
    
    @Published var posts = [Post]()
    @Published var likedPosts = [Post]()
    
    
    private let service = StoriesService()
    private let userService = UserService()
    private let followService = FollowService()
    
    let user: User
    
    init(user: User) {
        self.user = user
        self.fetchUserPosts()
        self.fetchUserLikedPosts()
    }
    
    var actionButtonTitle: String {
        return user.isCurrentUser ? "Edit Profile" : "Follow"
    }
    
    
    func posts(forFilter filter: StoryFilterViewModel) -> [Post] {
        
        switch filter {
        case .likes:
            return likedPosts
        case .stories:
            return posts
        }
    }
    
    func fetchUserPosts() {
        guard let uid = user.id else {return}
        service.fetchPosts(uid: uid) { posts in
            self.posts = posts
            
            for i in 0 ..< posts.count {
                self.posts[i].user = self.user
                
            }
        }
        
    }
    
    func fetchUserLikedPosts() {
        
        guard let uid = user.id else {return}
        service.fetchLikedPosts(forUid: uid) { posts in
            self.likedPosts = posts
            
            for i in 0 ..< posts.count {
                let uid = posts[i].uid 
                
                self.userService.fetchUser(withUid: uid) { user in
                    self.likedPosts[i].user = user
                }
            }
        }
    }
    
    func refreshProfileData() {
        fetchUserPosts()
        fetchUserLikedPosts()
    }
    
    // Function for following a user
    func followUser() {
        followService.followUser()
    }
    
    func unfollowUser(){
        followService.unfollowUser()
    }
}


 
