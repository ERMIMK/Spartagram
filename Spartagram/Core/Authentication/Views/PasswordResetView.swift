//
//  PasswordResetView.swift
//  Spartagram
//
//  Created by Ermiyas Mesfin on 10/29/23.
//

import SwiftUI

struct PasswordResetView: View {
    
    @State private var email = ""
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var viewModel = PasswordResetViewModel()
    
    var body: some View {
        VStack() {
            AuthHeaderView(title1: "Reset Password")

            
            HStack(spacing: 50){
                
                Spacer ()
                
                Text("An email will be send to your your email address with reset instruction")
                    .font(.subheadline)
                    .fontWeight(.bold)
                    .foregroundColor(Color.gray)
                    .multilineTextAlignment(.center)
                    .padding(.top)
                
                Spacer()
            }
            
            VStack(spacing: 20){

                CustomInputField(imageName: "envelope", placeholderText: "Email", text: $email)
                    .padding(.horizontal)
                
        
                Button {
                    viewModel.sendPasswordReset(email: email)
                    self.presentationMode.wrappedValue.dismiss()
                } label: {
                    
                    Text("Send Reset Link")
                        .font(.headline)
                        .foregroundColor(Color.init(hex: "#1C2D25"))
                        .frame(width: 340, height: 50)
                        .background(Color.init(hex: "#A6CAB5"))
                        .clipShape(Capsule())
                        .padding()
                }
                .shadow(color: .gray.opacity(0.5),radius: 10, x: 0, y: 0)
                
                Spacer()
                
                Button {
                    self.presentationMode.wrappedValue.dismiss()
                } label: {
                    
                    Text("Back")
                        .font(.headline)
                        .foregroundColor(Color.white)
                        .frame(width: 200, height: 50)
                        .background(Color.gray)
                        .clipShape(Capsule())
                        .padding()
                }
                .shadow(color: .gray.opacity(0.5),radius: 10, x: 0, y: 0)
                

            }
            .padding(.top, 20.0)
            
            Spacer()
                
            
        }
        .ignoresSafeArea()
        .navigationBarBackButtonHidden(true)
        .alert(isPresented: $viewModel.showAlert) {  // Alert modifier
            Alert(title: Text(viewModel.alertTitle),
                  message: Text(viewModel.alertMessage),
                  dismissButton: .default(Text("OK")))
        }
        
    }
}

#Preview {
    PasswordResetView()
}
