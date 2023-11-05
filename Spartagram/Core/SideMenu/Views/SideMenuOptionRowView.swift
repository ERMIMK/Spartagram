//
//  SideMenuOptionRowView.swift
//  Spartagram
//
//  Created by Ermiyas Mesfin on 10/23/23.
//

import SwiftUI

struct SideMenuOptionRowView: View {
    let viewModel: SideMenuViewModel
    
    var body: some View {
        HStack (spacing: 16){
            Image(systemName: viewModel.imageName)
                .font(.headline)
                .foregroundColor(Color.black)
            
            Text(viewModel.title)
                .font(.subheadline)
                .foregroundColor(Color.black)
            Spacer()
        }
        .frame(height: 40)
        .padding(.horizontal)
    }
}

#Preview {
    SideMenuOptionRowView(viewModel: .profile)
}
