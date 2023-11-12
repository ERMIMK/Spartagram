//
//  PasswordResetViewModel.swift
//  Spartagram
//
//  Created by Ermiyas Mesfin on 10/30/23.
//

import Foundation
import Firebase

import Foundation
import Firebase

class PasswordResetViewModel: ObservableObject {
    
    @Published var alertTitle = ""
    @Published var alertMessage = ""
    @Published var showAlert = false
    
    // Send reset email to user
    func sendPasswordReset(email: String) {
        if !email.isEmpty {
            Auth.auth().sendPasswordReset(withEmail: email) { error in
                if let error = error {
                    self.alertTitle = "Error"
                    self.alertMessage = error.localizedDescription
                } else {
                    self.alertTitle = "Success"
                    self.alertMessage = "Password reset link sent to \(email)"
                }
                self.showAlert = true
            }
        } else {
            self.alertTitle = "Error"
            self.alertMessage = "Please enter your email address."
            self.showAlert = true
        }
    }
}


