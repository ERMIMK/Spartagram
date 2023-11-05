//
//  CustomInputField.swift
//  Spartagram
//
//  Created by Ermiyas Mesfin on 10/24/23.
//

import SwiftUI


// Custom Input Field fro prompting user input
struct CustomInputField: View {
    
    let imageName: String                   // Image Name for the text field
    let placeholderText: String             // PlaceHolder
    var isSecureField: Bool? = false        // Ask to secure or not
    
    @Binding var text: String               // Binding input text
    
    var body: some View {
        VStack {
            HStack {
                Image(systemName: imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20, height: 20)
                    .foregroundColor(Color(.darkGray))
                if isSecureField ?? false {
                    SecureField(placeholderText, text: $text)
                }else {
                    TextField(placeholderText, text: $text)
                }
            }
            
            Divider()
                .background(Color.gray)
        }
    }
}

#Preview {
    CustomInputField(imageName: "envelope", 
                     placeholderText: "Email",
                     text: .constant(""))
}
