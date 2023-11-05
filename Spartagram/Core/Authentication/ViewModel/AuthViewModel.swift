
//
//  AuthViewModel.swift
//  Spartagram
//
//  Created by Ermiyas Mesfin on 10/24/23.
//

import SwiftUI
import Firebase


class AuthViewModel: ObservableObject {
    
    @Published var userSession: FirebaseAuth.User?          // publish User Session
    @Published var didAuthenticateUser = false              // Audthenticate User
    @Published var currentUser: User?                       // Current user info
    private var tempUserSession: FirebaseAuth.User?         // temp user session firebase
    private let service = UserService()
    
    
    // Sign in or login Error handler
    @Published var errorString: String?  // Store the error message
    @Published var showAlert: Bool = false  // Flag to control the alert visibility
    
    // initilaizer
    init () {
        self.userSession = Auth.auth().currentUser
        self.fetchUser()
    }
    
    
    // Loging in users function
    func login(withEmail email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            // if login failed
            if let error = error {
                DispatchQueue.main.async {
                    self.errorString = error.localizedDescription
                    self.showAlert = true  // Trigger the alert
                    self.fetchUser()       // fetch User
                }
                return
            }
            
            // logged in worked
            guard let user = result?.user else { return }
            self.userSession = user
            print("DEBUG: Did log user in...")
            
        }
    }
    
    //Registering users function
    func register(withEmail email: String, password: String, fullname: String, username: String ){
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            
            if let error = error {
                DispatchQueue.main.async {
                    self.errorString = error.localizedDescription // init error
                    self.showAlert = true  // Trigger the alert
                }
                return
            }
                
            guard let user = result?.user else {
                return
            }
                        
            self.tempUserSession = user
            
            let data = ["email": email,
                        "username": username.lowercased(),
                        "fullname": fullname,
                        "uid": user.uid]
            
            Firestore.firestore().collection("users")
                .document(user.uid)
                .setData(data) { _ in
                    self.didAuthenticateUser = true
                }
            
        }
        
    }
    
    // logout function
    func signOut() {
        // sets user session to nil so it will show login view
        userSession = nil
        //signs user out on server
        try? Auth.auth().signOut()
        self.fetchUser()
    }
    
    // Function for uploading image
    func uploadProfileImage(_ image: UIImage) {
        guard let uid = tempUserSession?.uid else {return}
        
        
        //call image uploader function
        ImageUploader.uploadImage(image: image) { profileImageUrl in
            Firestore.firestore().collection("users")
                .document(uid)
                .updateData(["profileImageUrl": profileImageUrl]) { _ in
                    self.userSession = self.tempUserSession
                    self.fetchUser()
                }
        }
    }
    
    // Function for fetching User
    func fetchUser() {
        
        guard let uid = self.userSession?.uid else { return }
        service.fetchUser(withUid: uid) { user in
            self.currentUser = user //current user
        }
    }
}




