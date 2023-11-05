//
//  TextArea.swift
//  Spartagram
//
//  Created by Ermiyas Mesfin on 10/24/23.
//

import SwiftUI


// Text Area prompt view
struct TextArea: View {
    @Binding var text: String       // User input
    let placeholder: String         // PlaceHolder Text
    
    
    // Initilizer
    init(_ placeholder: String, text: Binding<String>) {
        self.placeholder = placeholder // placeholder init
        self._text = text              // text init
        UITextView.appearance().backgroundColor = .clear
    }
    
    var body: some View {
    
        // Text area view 
        ZStack(alignment: .topLeading) {
            if text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                Text(placeholder)
                    .foregroundColor(Color.gray)
                    .padding(.top, 8)
                    .padding(.horizontal, 4)
            }
            
            TextEditor(text: $text)
                .padding(4)
        }
        .font(.body)
    }
}
