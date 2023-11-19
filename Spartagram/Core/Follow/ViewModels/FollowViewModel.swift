//
//  FollowViewModel.swift
//  Spartagram
//
//  Created by Ermiyas Mesfin on 11/17/23.
//

import Foundation


class FollowViewModel: ObservableObject {
    
    @Published var follower = [Post]()
    @Published var following = [Post]()
    
    private let services = FollowService()
    
    // Toggle between User follower and following
    func follows(forFilter filter: FollowFilterViewModel) -> [Post] {
        switch filter {
        case .follower :
            return follower
        case .following :
            return following
            
        }
    }

    // FectchUserFollowers
    func FetchUserFollowers() {
        services.FetchUserFollowers()
    }
    // Fetch user followings
    func FetchUSerFollowings() {
        services.FetchUSerFollowings()
    }

    // Fetch user follower number
    func FetchFollowerNum() {
        services.FetchFollowerNum()
    }
    
    // Fetch user following number
    func FetchFollowingNum() {
        services.FetchFollowingNum()
    }
    
}


