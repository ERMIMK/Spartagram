//
//  UserRowView.swift
//  Spartagram
//
//  Created by Ermiyas Mesfin on 10/22/23.
//

import SwiftUI
import Kingfisher

struct UserRowView: View {
    let user: User
    
    var body: some View {
        HStack(spacing:12) {
            
            // profile picture
            UserProfilePicfture
            
            //user name and name
            UserProfileName
            
            Spacer()
        }
        .padding(.horizontal)
        .padding(.vertical, 4)
    }
}


extension UserRowView {
    
    var UserProfilePicfture: some View {
        KFImage(URL(string: user.profileImageUrl))
            .resizable()
            .scaledToFit()
            .clipShape(Circle())
            .frame(width: 55, height: 55)
    }
    
    var UserProfileName: some View {
        
        VStack (alignment: .leading, spacing:4) {
            Text(user.username)
                .font(.subheadline).bold()
                .foregroundColor(Color.primary)
                
            Text(user.fullname)
                .font(.subheadline)
                .foregroundColor(.gray)
        }
    }
    
}
