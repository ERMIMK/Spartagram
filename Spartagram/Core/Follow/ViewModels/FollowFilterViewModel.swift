//
//  FollowFilterViewModel.swift
//  Spartagram
//
//  Created by Ermiyas Mesfin on 11/17/23.
//

import Foundation

enum FollowFilterViewModel: Int, CaseIterable {
    
    case follower
    case following
    
    
    var title: String {
        switch self {
        case .follower: return "Follower"
        case .following: return "Following"
            
        }
    }
}
