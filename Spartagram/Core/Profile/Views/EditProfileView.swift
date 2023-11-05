import SwiftUI
import Firebase

struct EditProfileView: View {
    
    @EnvironmentObject var authViewModel: AuthViewModel
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>

    @State private var showImagePicker = false
    @State private var selectedImage: UIImage?
    @State private var profileImage: Image?

    @State private var emailUpdate = ""
    @State private var usernameUpdate = ""
    @State private var fullnameUpdate = ""
    @State private var bioUpdate = ""

    private let defaultProfileImageName = "Default_profile"
    
    var body: some View {
        VStack {
            HStack{
                Button {
                    mode.wrappedValue.dismiss()
                } label: {
                    Text("Cancel")
                        .fontWeight(.bold)
                        .foregroundColor(Color.white)
                        .padding(.horizontal)
                        .padding(.vertical, 8)
                        .background(Color(hex: "#1C282F"))
                        .clipShape(Capsule())
                }
                
                Spacer()
                
                Button {
                    if let selectedImage = selectedImage {
                        authViewModel.uploadProfileImage(selectedImage)
                    }
                    mode.wrappedValue.dismiss()
                    print("DEBUG: IMAGE UPDATED")

                } label: {
                    Text("Update")
                        .foregroundColor(Color.black)
                        .fontWeight(.bold)
                        .padding(.horizontal)
                        .padding(.vertical, 8)
                        .background(Color(hex: "#8FC18A"))
                        .clipShape(Capsule())
                }
            }
            .padding(.horizontal)
            .padding(.top)
            Spacer()
            
            VStack {
                Button(action: {
                    showImagePicker.toggle()
                }) {
                    if let profileImage = profileImage {
                        profileImage
                            .resizable()
                            .scaledToFit()
                            .frame(width: 120, height: 120)
                            .clipShape(Circle())
                            .padding(.top, 44)
                    } else {
                        Image(systemName: "photo.circle")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 120, height: 120)
                            .padding(.top, 44)
                            .foregroundColor(Color.init(hex: "#A6CAB5"))
                    }
                }
                .sheet(isPresented: $showImagePicker, onDismiss: loadImage) {
                    ImagePicker(selectedImage: $selectedImage, useCamera: false)
                }
                
                Text ("Change profile")
                    .font(.headline)
                    .fontWeight(.bold)
                    .foregroundColor(Color.primary)
                    .multilineTextAlignment(.center)
            }
            
            VStack(spacing: 40) {
                CustomInputField(imageName: "person", placeholderText: "Fullname", text: $fullnameUpdate)
                CustomInputField(imageName: "at", placeholderText: "User Name", text: $usernameUpdate)
                CustomInputField(imageName: "envelope", placeholderText: "Email", text: $emailUpdate)
                CustomInputField(imageName: "pencil.line", placeholderText: "Bio", text: $bioUpdate)
                
                Spacer()
            }
            .padding(.horizontal, 32)
            .padding(.top, 47)
        }
    }
    
    func loadImage() {
        guard let selectedImage = selectedImage else { return }
        profileImage = Image(uiImage: selectedImage)
    }
}

