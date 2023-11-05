//
//  NewStoriesView.swift
//  Spartagram
//
//  Created by Ermiyas Mesfin on 10/24/23.
//

import SwiftUI
import Kingfisher

struct NewStoriesView: View {
    @State private var caption = ""
    @State private var showImagePicker = false
    @State private var selectedImage: UIImage?
    @State private var showActionSheet = false
    @State private var uploadStatus: UploadStatus = .idle
    @State private var useCamera = false

    @Environment(\.presentationMode) var presentaionMode
    @EnvironmentObject var authViewModel: AuthViewModel
    @ObservedObject var viewModel =  UploadStoryViewModel()
    var body: some View {
        VStack {
            HStack {
                
                // Cancel and Post button
                Button {
                    presentaionMode.wrappedValue.dismiss()
                } label: {
                    Text("Cancel")
                        .foregroundColor(Color.black)
                        .padding(.horizontal)
                        .padding(.vertical, 8)
                        .background(Color.gray)
                        .clipShape(Capsule())
                }
                
                Spacer()
                
                Button {
                    uploadStatus = .uploading // Set status to uploading
                    uploadStory()
                } label: {
                    LabelView() // Reflect the upload status
                }
                .padding(.horizontal)
                .padding(.vertical, 8)
                .background(Color(hex:"#C0DBBE" ))
                .foregroundColor(Color.black)
                .clipShape(Capsule())
            }
            .padding()
            
            
            // Wirte your post
            HStack (alignment: .top){
                
                // profile picture
                VStack {
                    if let user = authViewModel.currentUser {
                        KFImage(URL(string: user.profileImageUrl))
                            .resizable()
                            .scaledToFit()
                            .clipShape(Circle())
                            .frame(width: 64, height: 64)
                    }
                    //Image Uploader
                    Image(systemName: "photo.circle.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 64, height: 64)
                        .onTapGesture {
                            self.showActionSheet = true
                        }
                        .actionSheet(isPresented: $showActionSheet) {
                            ActionSheet(title: Text("Choose Image"), buttons: [
                                .default(Text("Take Photo")) {
                                    self.useCamera = true
                                    self.showImagePicker = true
                                },
                                .default(Text("Choose From Library")) {
                                    self.useCamera = false
                                    self.showImagePicker = true
                                },
                                .cancel()
                            ])
                        }
                        .sheet(isPresented: $showImagePicker) {
                            ImagePicker(selectedImage: $selectedImage, useCamera: useCamera)
                        }
                }

                // Text area
                
                VStack {
                    TextArea("What's new happening ? ", text: $caption)
                        .background(Color.gray.opacity(0.2))
                        .frame(height: 150)
                    
                    if let selectedImage = selectedImage {
                        Image(uiImage: selectedImage)
                            .resizable()
                            .scaledToFit()
                            .frame(maxWidth: 300, maxHeight: 200) // Adjust frame as needed
                            .cornerRadius(10) // Optional: for rounded corners
                            .padding(.top, 10)
                    }
                }
                
            }
            .padding()
            
            Spacer()
        }
        .onReceive(viewModel.$didUploadStory) { success in
            if success {
                presentaionMode.wrappedValue.dismiss()
            }
        }
    }
    
    private func uploadStory() {
        if let image = selectedImage {
            StoryImageUploader.uploadImage(image: image) { result in
                switch result {
                case .success(let imageUrl):
                    viewModel.uploadStory(withCaption: caption, imageUrl: imageUrl)
                    uploadStatus = .success
                case .failure:
                    uploadStatus = .failure
                }
            }
        } else {
            viewModel.uploadStory(withCaption: caption, imageUrl: nil)
            uploadStatus = .success
        }
    }

    @ViewBuilder
    private func LabelView() -> some View {
        switch uploadStatus {
        case .uploading:
            ProgressView()
        case .success:
            Text("Posted").onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    uploadStatus = .idle  // Reset status after a delay
                }
            }
        case .failure:
            Text("Retry")
        default:
            Text("Post")
        }
    }
}

enum UploadStatus {
    case idle, uploading, success, failure
}

#Preview {
    NewStoriesView()
}
