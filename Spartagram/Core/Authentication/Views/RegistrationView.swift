//
//  RegistrationView.swift
//  Spartagram
//
//  Created by Ermiyas Mesfin on 10/24/23.
//

import SwiftUI

struct RegistrationView: View {
    
    @State private var email = ""       //email variable
    @State private var username = ""    //username variable
    @State private var fullname = ""    //Fullname Variable
    @State private var password = ""    //Password Variable
    
    @EnvironmentObject var viewModel: AuthViewModel          //Authenticatetion var
    @Environment(\.presentationMode) var presentationMode
    @State private var showPassword = false                 // variable for hiding the pasword or not

    
    var body: some View {
        
        VStack {
            //Header
            NavigationLink(destination: ProfilePhotoSelectorView(),
                           isActive: $viewModel.didAuthenticateUser,
                           label: { })
            
            AuthHeaderView(title1: "Create your account!")
            
            // inputs
            UserRegestrationInputs
            
            // Button for Creating account
            SignUpButton

            Spacer()
            
            // Button To take back to login page
            Button {
                presentationMode.wrappedValue.dismiss()
        
            }label: {
                HStack {
                    
                    Text("have an account?")
                        .font(.footnote)
        
                    Text("Login in here!")
                        .font(.footnote)
                        .fontWeight(.semibold)
                        
                }
            }
            .foregroundColor(Color.primary)
            .padding(.bottom, 40)
        }
        .ignoresSafeArea()
        .alert(isPresented: $viewModel.showAlert) {
            Alert (
                title: Text("Login Error"),
                message: Text(viewModel.errorString ?? "There was an error during login."),
                dismissButton: .default(Text("OK"))
            )

        }
    }
}


//#Preview {
//    RegistrationView()
//}

extension RegistrationView {
    
    // User input extenstion
    var UserRegestrationInputs: some View {
        VStack(spacing: 40) {
            
            // email input
            CustomInputField(imageName: "envelope",
                             placeholderText: "Email",
                             text: $email)
            // username input
            CustomInputField(imageName: "person",
                             placeholderText: "Userename",
                             text: $username)
            //Full name input
            CustomInputField(imageName: "person.text.rectangle",
                             placeholderText: "Full Name",
                             text: $fullname)
            //password input
            HStack{
                CustomInputField(imageName: "lock",
                                 placeholderText: "New Password",
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
        .padding(32)
    }
    
    //SignUpButton
    var SignUpButton: some View {
        
        Button {
            viewModel.register(withEmail: email, password: password, fullname: fullname, username: username)
            
        } label: {
            
            Text("Create your account")
                .font(.headline)
                .foregroundColor(Color.init(hex: "#1C2D25"))
                .frame(width: 340, height: 50)
                .background(Color.init(hex: "#A6CAB5"))
                .clipShape(Capsule())
                .padding()
        }
        .shadow(color: .gray.opacity(0.5),radius: 10, x: 0, y: 0)
    }
    
}
