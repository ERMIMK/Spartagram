//
//  AuthHeaderView.swift
//  Spartagram
//
//  Created by Ermiyas Mesfin on 10/24/23.
//

import SwiftUI

// Header template for the authentiction views
struct AuthHeaderView: View {
    
    let title1: String          // prompt title
    var body: some View {
        
        
        //Header
        VStack (alignment: .center) {
            HStack { Spacer() }
            Image("Colored_logo")
                .resizable()
                .scaledToFit()
                .frame(width: 150, height: 150)
    
            
            
            Text (title1)
                .font(.title)
                .fontWeight(.heavy)
                .foregroundColor(Color.init(hex: "#1C2D25"))
        }
        .frame(height: 280)
        .padding(.leading)
        .background(Color.init(hex: "#A6CAB5"))
        .foregroundColor(Color.init(hex: "#1C2D25"))
        .clipShape(RoundedShape(corners: [.bottomLeft, .bottomRight]))
    }
}

#Preview {
    AuthHeaderView(title1: "Welcome Back!")
}
