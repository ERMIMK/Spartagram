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
            KFImage(URL(string: user.profileImageUrl))
                .resizable()
                .scaledToFit()
                .clipShape(Circle())
                .frame(width: 55, height: 55)
            
            
            //user name and name
            
            VStack (alignment: .leading, spacing:4) {
                Text(user.username)
                    .font(.subheadline).bold()
                    .foregroundColor(Color.primary)
                    
                Text(user.fullname)
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            Spacer()
        }
        .padding(.horizontal)
        .padding(.vertical, 4)
    }
}

//#Preview {
//    UserRowView(user: <#T##User#>)
//}
