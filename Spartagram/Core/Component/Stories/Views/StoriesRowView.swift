//
//  StoriesRowView.swift
//  Spartagram
//
//  Created by Ermiyas Mesfin on 10/22/23.
//

import SwiftUI
import Kingfisher
import UIKit


struct StoriesRowView: View {
    
    @ObservedObject var viewModel: StoryRowViewModel
    @State private var postSettingShowAction = false
    @State private var showingDeletionAlert = false
    
    var onChange: () -> Void
    
    init(post: Post, onChange: @escaping () -> Void = {}) {
        self.viewModel = StoryRowViewModel(post: post)
        self.onChange = onChange

        }
    var body: some View {
        
        VStack (alignment: .leading){
            
            // profile image +user info + story
            if let user = viewModel.post.user {
                HStack(alignment: .top, spacing: 12) {
                    KFImage(URL(string: user.profileImageUrl))
                        .resizable()
                        .scaledToFit()
                        .clipShape(Circle())
                        .frame(width: 56, height: 56)
                        .foregroundColor(Color(.black))
                    
                    // user info and story caption
                    VStack(alignment: .leading, spacing: 4) {
                        
                        // user info
                        
                        HStack {
                            Text(user.fullname)
                                .font(.subheadline).bold()
                                .foregroundColor(Color.primary)
                            Text("@\(user.username)")
                                .foregroundColor(.gray)
                                .font(.caption)
                            
                            Spacer()
                            
                            let date = viewModel.post.timestamp.dateValue()
                            Text(viewModel.timeElapsedSinceDate(date))
                                .foregroundColor(.gray)
                                .font(.caption)
                        }
                        
                        // story Cpation
                        Text(viewModel.post.caption)
                            .font(.subheadline)
                            .multilineTextAlignment(/*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/)
                            .foregroundColor(Color.primary)
                        
                        
                        }
                    }
                if let imageUrl = viewModel.post.imageUrl, !imageUrl.isEmpty {
                    KFImage(URL(string: imageUrl))
                        .resizable()
                        .scaledToFit()
                        .cornerRadius(10) // Optional: for rounded corners
                        .padding(.top, 8) // Space between caption and image
                }
            }
            
            // action botton
            HStack {
                
                Spacer()
                //comment button
                Button {
                    //action here
                } label: {
                    Image(systemName: "bubble.left")
                        .font(.subheadline)
                        .foregroundColor(Color.primary)
                }
                Spacer()
                //like
                Button {
                    let impactMed = UIImpactFeedbackGenerator(style: .medium)
                        impactMed.impactOccurred()
                    
                    viewModel.post.didLike ?? false ?
                    viewModel.unlikeStory() :
                    viewModel.likeStory()
                    
                } label: {
                    Image(systemName: viewModel.post.didLike ?? false ? "heart.fill": "heart")
                        .font(.subheadline)
                        .foregroundColor(viewModel.post.didLike ?? false ? Color.red : Color.primary)
                }
                
                Spacer()
                
                //repost
                Button {
                    //action here
                } label: {
                    Image(systemName: "arrow.2.squarepath")
                        .font(.subheadline)
                        .foregroundColor(Color.primary)
                }
                Spacer()
                
                //save
                Button {
                    let impactMed = UIImpactFeedbackGenerator(style: .medium)
                        impactMed.impactOccurred()
                    
                    viewModel.post.didSave ?? false ?
                    viewModel.unSavePost() :
                    viewModel.SavePost()
                } label: {
                    Image(systemName: viewModel.post.didSave ?? false ? "bookmark.fill" : "bookmark")
                        .font(.subheadline)
                        .foregroundColor(viewModel.post.didSave ?? false ? Color.green : Color.primary)
                }
                
                Spacer()
                
                
                // post settings
                Button {
                    postSettingShowAction = true
                } label: {
                    Image(systemName: "ellipsis")
                        .font(.subheadline)
                        .foregroundColor(Color.primary)
                }
                .actionSheet(isPresented: $postSettingShowAction) {
                    ActionSheet(title: Text("Story settings"),
                        buttons: [
                            .default(Text("Delete post")) {
                                viewModel.deleteStory()
                                showingDeletionAlert = true
                                onChange()
                                
                            },
                            .default(Text("Hide post")) {
                                // Code to hide post
                            },
                            .default(Text("Report")) {
                                // Code to report
                            },
                            .cancel()
                        ])
                }
                .alert(isPresented: $showingDeletionAlert) {
                    Alert(
                        title: Text(showingDeletionAlert ? "Success" : "Error"),
                        message: Text(showingDeletionAlert ? "The post has been successfully deleted." : "There was an error deleting the post."),
                        dismissButton: .default(Text("OK")) {
                            
                        }
                    )
                }


            
                Spacer()
                
                
            }
            .padding()
            
            
        }
        .padding()
        .background(Color(UIColor { traitCollection in
            return traitCollection.userInterfaceStyle == .dark ? UIColor(hex: "#1C282F")! : UIColor(hex: "#F2FFDB")!
        }))
        //.background(Color(hex: "#1C282F"))
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .edgesIgnoringSafeArea(.all)
        .padding(.horizontal)
        Divider()
            .padding(.horizontal)
    }

}

// UI Color : Hex
extension UIColor {
    convenience init?(hex: String) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")

        var rgb: UInt64 = 0

        Scanner(string: hexSanitized).scanHexInt64(&rgb)

        let red = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((rgb & 0x00FF00) >> 8) / 255.0
        let blue = CGFloat(rgb & 0x0000FF) / 255.0

        self.init(red: red, green: green, blue: blue, alpha: 1.0)
    }
}

// Color : Hex
extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }
        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue: Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}


//#Preview {
//    StoriesRowView(post: Post)
//}
