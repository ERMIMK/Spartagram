//
//  FeedViewModel.swift
//  Spartagram
//
//  Created by Ermiyas Mesfin on 10/26/23.
//

import Foundation


class  FeedViewModel: ObservableObject {
    @Published var posts = [Post]()
    let service = StoriesService()
    let userService = UserService()
    
    init() {
        fetchStories()
    }
    
    func fetchStories() {
        service.fetchStories { [weak self] posts in
            DispatchQueue.main.async {
                self?.posts = posts
            }

            for i in 0 ..< posts.count {
                let uid = posts[i].uid

                self?.userService.fetchUser(withUid: uid) { user in
                    DispatchQueue.main.async {
                        self?.posts[i].user = user
                    }
                }
            }
        }
    }

}
