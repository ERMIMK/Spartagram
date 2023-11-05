//
//  LoginView.swift
//  Spartagram
//
//  Created by Ermiyas Mesfin on 10/24/23.
//

import SwiftUI

struct LoginView: View {
    
    // Email and Password
    @State private var email = ""
    @State private var password = ""
    @EnvironmentObject var viewModel: AuthViewModel
    @State private var showPassword = false
    var body: some View {
        
        // parent container
        VStack {
            
            //Header View with the title "Welcome Back."
            AuthHeaderView(title1: "Welcome Back.")
            
            // Email and Password textfield
            LoginTextfield
            
            // Reset password view...
            ResetPasswordButton
            
            // Login Button
            LoginButton
            
            Spacer()
            
            //Sign Up Navigation bar
            SignUpButtonNav
            
        }
        .ignoresSafeArea()
    }
}

//#Preview {
//    LoginView()
//}


extension LoginView {
    
    // Email and Password textfield
    var LoginTextfield: some View {
        VStack(spacing: 40){

            CustomInputField(imageName: "envelope", placeholderText: "Email", text: $email)
            
            HStack{
                CustomInputField(imageName: "lock",
                                 placeholderText: "Password",
                                 isSecureField: !showPassword,
                                 text: $password)
                Button(action: {
                    self.showPassword.toggle()
                }) {
                    Image(systemName: showPassword ? "eye" : "eye.slash")
                }
                .foregroundColor(Color.primary)
            }
            
        }
        .padding(.horizontal, 32 )
        .padding(.top, 47)
    }
    
    // Reset password view...
    var ResetPasswordButton: some View  {
        HStack {
            Spacer()
            
            NavigationLink {
                PasswordResetView()
            } label: {
                Text("Forgot Password?")
                    .font(.caption)
                    .fontWeight(.bold)
                    .foregroundColor(Color.primary)
                    .padding(.top)
                    .padding(.trailing, 24)

                
            }
            .navigationBarBackButtonHidden(true)
        }
        
    }
    
    // Login Button extension
    var LoginButton: some View {
        Button {
            viewModel.login(withEmail: email, password: password)
            
        } label: {
            
            Text("Sign In")
                .font(.headline)
                .foregroundColor(Color.init(hex: "#1C2D25"))
                .frame(width: 340, height: 50)
                .background(Color.init(hex: "#A6CAB5"))
                .clipShape(Capsule())
                .padding()
                
        }
        .shadow(color: .gray.opacity(0.5),radius: 10, x: 0, y: 0)

    }
    
    // Sign Up navigation bar
    var SignUpButtonNav: some View {
        NavigationLink {
            RegistrationView()
                .navigationBarBackButtonHidden(true)
        } label: {
            HStack {
                
                Text("Don't have an account?")
                    .font(.footnote)
    
                Text("Sign UP here!")
                    .font(.footnote)
                    .fontWeight(.semibold)
                    
            }
                     
        }
        .foregroundColor(Color.primary)
        .padding(.bottom, 40)
        .alert(isPresented: $viewModel.showAlert) {
            Alert (
                title: Text("Login Error"),
                message: Text(viewModel.errorString ?? "There was an error during login."),
                dismissButton: .default(Text("OK"))
            )

        }
    }
}
