//
//  SearchBar.swift
//  Spartagram
//
//  Created by Ermiyas Mesfin on 10/26/23.
//

import SwiftUI

struct SearchBar: View {
    
    @Binding var text: String
    
    var body: some View {
        
        HStack {
            TextField ("Search...", text: $text)
                .padding(8)
                .padding(.horizontal, 24)
                .background(Color(.systemGray6))
                .overlay (
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                            .padding(.leading, 8)
                        
                    }
                
                )
        }
    }

}

#Preview {
    SearchBar(text: .constant(""))
}
