//
//  SettingsView.swift
//  Spartagram
//
//  Created by Ermiyas Mesfin on 10/29/23.
//

import SwiftUI
import Kingfisher

struct SettingsView: View {
    
    @EnvironmentObject var authViewModel: AuthViewModel
    @ObservedObject var viewModel: ProfileViewModel
    
    var body: some View {
        
        List {
            Section {
                HStack{
                    
                    KFImage(URL(string: viewModel.user.profileImageUrl))
                        .resizable()
                        .scaledToFit()
                        .clipShape(Circle())
                        .frame (width: 72, height: 72)
                        .background (Color(.systemGray3))
                        .clipShape (Circle())
                
                    VStack (alignment: .leading, spacing: 4){
                        
                        Text (viewModel.user.fullname)
                            .fontWeight (.semibold)
                            .padding(.top,4)
                        
                        Text(viewModel.user.email)
                            .font(.footnote)
                            .accentColor(.gray)
                    }
                }
            }
            
            Section ("General"){
                HStack{
                    
                    SettingsRowView(imageName: "gear", title: "Version", tintColor: Color(.systemGray))
                    
                    Spacer()
                    
                    Text("1.0")
                        .font(.subheadline)
                        .foregroundColor(Color.primary)
                }
            }
            
            
            Section("Account") {
                
                
                Button(action: {
                    authViewModel.signOut()
                }, label: {
                    SettingsRowView(imageName: "arrow.left.circle.fill", title: "Sign Out", tintColor: Color(.red))
                    
                })
                
                Button(action: {
                    
                }, label: {
                    SettingsRowView(imageName: "xmark.circle.fill", title: "Delete Account", tintColor: Color(.red))
                    
                })
            }
            
            
        }
    }
    
}

//#Preview {
//   SettingsView( viewModel: ProfileViewModel(user: viewModel.user))}
