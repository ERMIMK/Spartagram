//
//  UserStatsView.swift
//  Spartagram
//
//  Created by Ermiyas Mesfin on 10/23/23.
//

import SwiftUI


// View for user stat like follower and following
struct UserStatsView: View {
    var body: some View {
        
        HStack(spacing: 24){
            
            // Following
            HStack(spacing: 4) {
                Text("0")
                    .font(.subheadline)
                    .bold()
                
                Text("Following")
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            
            //Follower
            HStack {
                Text("120.4M")
                    .font(.subheadline)
                    .bold()
                
                Text("Follower")
                    .font(.caption)
                    .foregroundColor(.gray)
            }
        }
    }
}

#Preview {
    UserStatsView()
}
