//
//  StoryFilterViewModel.swift
//  Spartagram
//
//  Created by Ermiyas Mesfin on 10/22/23.
//

import Foundation


// Story filter for User posts and likes
enum StoryFilterViewModel: Int, CaseIterable {
    case stories
    case likes
    
    var title: String {
        switch self {
        case .stories: return "Stories"   // User posts
        case .likes: return "Likes"       // User Likes
        
        }
    }
}


