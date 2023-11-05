//
//  ContentView.swift
//  Spartagram
//
//  Created by Ermiyas Mesfin on 10/22/23.
//

import SwiftUI
import Kingfisher

struct ContentView: View {
    @Environment(\.colorScheme) var colorScheme
    @State private var showMenu = false
    @EnvironmentObject var viewModel: AuthViewModel
    
    
    var body: some View {

        Group {
            // No user logged in
            if viewModel.userSession == nil {
                LoginView()
            }else {
                // user have a logged in
                mainInterfeceView
            }
        }
    }
}

#Preview {
    NavigationView{
        ContentView()
    }
}


extension ContentView {
    
    var mainInterfeceView: some View {
        
        ZStack(alignment: .topLeading){
            MainTabView()
                .navigationBarHidden(showMenu)
            
            if showMenu {
                ZStack{
                    Color(.black)
                        .opacity(showMenu ? 0.25 : 0.0)
                }.onTapGesture {
                    withAnimation(.easeInOut){
                        showMenu = false
                    }
                }
                .ignoresSafeArea()
            }
            
            SideMenuView()
                .frame(width:300)
                .offset(x: showMenu ? 0: -300, y:0)
                .background(showMenu ? Color(hex: "#EDF5EF"): Color.clear)
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            
            
            //Navigation logo
            ToolbarItem(placement: .principal) {
                Image(colorScheme == .light ? "Black_logo" : "White_logo")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 60)
                    .padding(.bottom)
                
            }
            
            
            // Navigation for Side menu view
            ToolbarItem(placement: .navigationBarLeading){
                if viewModel.currentUser != nil {
                    Button {
                        withAnimation(.easeInOut){
                            showMenu.toggle()
                        }
                        
                    }label:{
                        
                        // Profile picture
                        Image(systemName: "line.3.horizontal")
                            .frame(width: 48, height: 48)
                            .foregroundColor(Color.primary)
                    }
                }
            }
        }
        .onAppear {
            showMenu = false
            
        }
    }
}
