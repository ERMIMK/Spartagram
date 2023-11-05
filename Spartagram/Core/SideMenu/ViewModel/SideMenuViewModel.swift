//
//  SideMenuViewModel.swift
//  Spartagram
//
//  Created by Ermiyas Mesfin on 10/23/23.
//

import Foundation


// View Model for Side View
enum SideMenuViewModel: Int, CaseIterable {
    case profile    // Profile
    case bookmarks  // Saved posts
    case settings   // Settings
    case logout     // Logout
    
    var title: String {
        switch self {
        case .profile: return "Profile"
        case .bookmarks: return "Saved"
        case .settings: return "Settings"
        case .logout: return "Logout"
        }
    }
    
    var imageName: String {
        switch self {
        case .profile: return "person"
        case .bookmarks: return "bookmark"
        case .settings: return "gear"
        case .logout: return "arrow.left.square"
            
        }
        
    }
}



