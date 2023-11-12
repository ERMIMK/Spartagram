//
//  ProfileView.swift
//  Spartagram
//
//  Created by Ermiyas Mesfin on 10/22/23.
//

import SwiftUI
import Kingfisher


struct ProfileView: View {
    
    @State private var selectedFilter: StoryFilterViewModel = .stories
    @ObservedObject var viewModel: ProfileViewModel
    @Environment(\.presentationMode) var mode
    @Namespace var animation
    @State private var showingEditProfile = false
    
    var authViewModel: AuthViewModel
    private let showBackButton: Bool
    
    
    init(user: User, showBackButton: Bool = true) {
        self.showBackButton = showBackButton
        self.viewModel = ProfileViewModel(user: user)
        self.authViewModel = AuthViewModel()
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            
            //header & Profile picture function
            headerView
                
            //User information function
            UserInfoDetails

            
            //Stores Bar
            StoriesFilterBar
            
            // Posts view and liked posts view
            postsView
            Spacer()
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
        .onAppear {
            viewModel.refreshProfileData()
        }
    }
}

#Preview {
    ProfileView(user: User(id: NSUUID().uuidString, username: "@UserName", fullname: "First LastName", profileImageUrl: "", email: "email@email.com"))
}



extension ProfileView {
    
    
    // header view
    var headerView: some View {
        
        ZStack(alignment: .bottomLeading ){
            Color(.gray)
                .ignoresSafeArea()
            VStack {
                
                // Back button
                
                if showBackButton {
                    Button {
                        mode.wrappedValue.dismiss()
                    }label: {
                        Image(systemName: "arrow.left")
                            .resizable()
                            .frame(width: 20, height: 20)
                            .foregroundColor(.white)
                            .offset(x:16, y: 12)
                    }
                }
                
                Spacer()
                // profile picture
                
                KFImage(URL(string: viewModel.user.profileImageUrl))
                    .resizable()
                    .scaledToFit()
                    .clipShape(Circle())
                    .frame(width: 90, height: 90)
                    .offset(x:16, y:24)
                
                
            }
            .sheet(isPresented: $showingEditProfile) {
                // Use the existing authViewModel instance
                EditProfileView()
                    .environmentObject(authViewModel)
            }
            
        }
        .frame(height: 100)
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
        
    }
    
    // Action Buttons
    var actionButtons:some View {
        HStack (spacing:12) {
            
            
            //edit profile
            Button {
                if viewModel.user.isCurrentUser {
                    showingEditProfile.toggle()
                } else {
                    // Follow/Unfollow action
                }
            } label: {
                Text(viewModel.actionButtonTitle)
                    .font(.subheadline).bold()
                    .foregroundColor(Color.primary)
                    .frame(width:120, height: 32)
                    .overlay(RoundedRectangle(cornerRadius: 20).stroke(Color.gray,lineWidth: 0.75))
                
            }
            
        }
        .padding(.trailing)
        
    }
    
    // User Info Details
    var UserInfoDetails: some View {
        VStack (alignment: .leading, spacing: 4) {
            
            // Full Name
            Text (viewModel.user.fullname)
                .font(.title2).bold()
                .padding(.top, 30.0)
            // User Name
            Text("@\(viewModel.user.username)")
                .font(.subheadline)
                .foregroundColor(.gray)
            
            //Bio
            Text("MSU '25")
                .font(.subheadline)
                .padding(.vertical)
            
            //action bottons function
            actionButtons
            
            
            // User Stats View
            UserStatsView()
                .padding(.vertical)
            
        }
        .padding(.horizontal)
    }
    
    // Stories Filter Bar
    var StoriesFilterBar: some View {
        HStack {
            ForEach(StoryFilterViewModel.allCases, id: \.rawValue) { item in
                VStack {
                    Text (item.title)
                        .font(.subheadline)
                        .fontWeight(selectedFilter == item ? .semibold: .regular )
                        .foregroundColor(selectedFilter == item ? .green : .gray)
                    
                    if selectedFilter == item {
                        Capsule()
                            .foregroundColor(Color(.systemGreen))
                            .frame(height:3)
                            .matchedGeometryEffect(id: "filter", in: animation)
                        
                    } else {
                        Capsule()
                            .foregroundColor(Color(.clear))
                            .frame(height:3)
                    }
                    
                    
                }
                
                .onTapGesture {
                    withAnimation(.easeInOut) {
                        self.selectedFilter = item
                    }
                }
            }
        }
        .overlay(Divider().offset(x:0, y:16))
    }
    
    // posts view
    var postsView: some View {
        ScrollView {
            LazyVStack{
                ForEach(viewModel.posts(forFilter: self.selectedFilter)) { post in
                    StoriesRowView(post: post)
                    
                }
            }
        }
    }
    
}

