import SwiftUI

struct ProfilePhotoSelectorView: View {
    @State private var showImagePicker = false
    @State private var selectedImage: UIImage?
    @State private var profileImage: Image?
    @EnvironmentObject var viewModel: AuthViewModel

    // Default profile image name
    private let defaultProfileImageName = "Default_profile"

    var body: some View {
        VStack {
            
            // Header View displayinh add a profile photo
            AuthHeaderView(title1: "Add a profile photo")
            
            // Image picker button
            imagePickerButton
            
            Spacer()

            // Continue Button
            if let _ = selectedImage {
                continueButton
            }

            // Skip Button
            Button(action: {
                guard let defaultImage = UIImage(named: defaultProfileImageName) else { return }
                viewModel.uploadProfileImage(defaultImage)
                // Proceed with the flow after setting the default image
            }) {
                Text("Skip")
                    .font(.headline)
                    .fontWeight(.bold)
                    .foregroundColor(Color.black)
                    .frame(width: 340, height: 50)
                    .background(Color.init(hex: "#A6CAB5"))
                    .clipShape(Capsule())
                    .padding()
            }
            .shadow(color: Color.gray.opacity(0.5), radius: 10, x: 0, y: 0)

            Spacer()
        }
        .navigationBarBackButtonHidden(true)
        .ignoresSafeArea()
    }

    
    // Continue Button
    var continueButton: some View {
        Button(action: {
            if let selectedImage = selectedImage {
                viewModel.uploadProfileImage(selectedImage)
            }
        }) {
            Text("Continue")
                .font(.headline)
                .fontWeight(.bold)
                .foregroundColor(Color.black)
                .frame(width: 340, height: 50)
                .background(Color.init(hex: "#A6CAB5"))
                .clipShape(Capsule())
                .padding()
        }
        .shadow(color: Color.gray.opacity(0.5), radius: 10, x: 0, y: 0)
    }

    // Load selected image 
    func loadImage() {
        guard let selectedImage = selectedImage else { return }
        profileImage = Image(uiImage: selectedImage)
    }
}

// Your ImagePicker and AuthHeaderView structures should be here

struct ProfilePhotoSelectorView_Previews: PreviewProvider {
    static var previews: some View {
        ProfilePhotoSelectorView()
    }
}

extension ProfilePhotoSelectorView {
    
    //profile image selector
    var imagePickerButton: some View {
        
        Button(action: {
            showImagePicker.toggle()
        }) {
            if let profileImage = profileImage {
                profileImage
                    .resizable()
                    .scaledToFit()
                    .frame(width: 180, height: 180)
                    .clipShape(Circle())
                    .padding(.top, 44)
            } else {
                Image(systemName: "photo.circle")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 180, height: 180)
                    .padding(.top, 44)
                    .foregroundColor(Color.init(hex: "#A6CAB5"))
                
            }
        }
        .sheet(isPresented: $showImagePicker, onDismiss: loadImage) {
            ImagePicker(selectedImage: $selectedImage, useCamera: false)
        }
    }
}
