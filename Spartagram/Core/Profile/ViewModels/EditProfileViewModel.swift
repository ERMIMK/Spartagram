import Foundation
import SwiftUI
import Firebase
import FirebaseStorage

class EditProfileViewModel: ObservableObject {
    
    @Published var emailUpdate: String = ""
    @Published var usernameUpdate: String = ""
    @Published var fullnameUpdate: String = ""
    @Published var bioUpdate: String = ""
    @Published var selectedImage: UIImage?
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    @Published var successMessage: String?
    
    private var authViewModel: AuthViewModel
    
    init(authViewModel: AuthViewModel) {
        self.authViewModel = authViewModel
    }
    
    func uploadProfileImage(_ image: UIImage) {
        guard let uid = authViewModel.userSession?.uid else { return }
        
        isLoading = true
        
        ImageUploader.uploadImage(image: image) { profileImageUrl in
            let usersRef = Firestore.firestore().collection("users")
            usersRef.document(uid).updateData(["profileImageUrl": profileImageUrl]) { error in
                self.isLoading = false
                
                if let error = error {
                    self.errorMessage = error.localizedDescription
                } else {
                    self.successMessage = "Profile image updated successfully."
                    self.authViewModel.fetchUser()  // Fetch the updated user data
                }
            }
        }
    }
    
    func updateUserProfile() {
        guard let uid = authViewModel.userSession?.uid,
              !fullnameUpdate.isEmpty,
              !usernameUpdate.isEmpty,
              !emailUpdate.isEmpty else {
            self.errorMessage = "Required fields are missing."
            return
        }
        
        isLoading = true
        
        let updateData: [String: Any] = [
            "fullname": fullnameUpdate,
            "username": usernameUpdate,
            "email": emailUpdate,
            "bio": bioUpdate
        ]
        
        let usersRef = Firestore.firestore().collection("users")
        usersRef.document(uid).updateData(updateData) { error in
            self.isLoading = false
            
            if let error = error {
                self.errorMessage = error.localizedDescription
            } else {
                self.successMessage = "Profile successfully updated."
                self.authViewModel.fetchUser()  // Fetch the updated user data
            }
        }
    }
}
