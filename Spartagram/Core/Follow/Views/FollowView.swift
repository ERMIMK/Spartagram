//
//  FollowView.swift
//  Spartagram
//
//  Created by Ermiyas Mesfin on 11/17/23.
//

import SwiftUI


struct FollowView: View {
    
    
    @State private var selectedFilter: FollowFilterViewModel = .follower
    @Environment(\.presentationMode) var presentationMode
    
    init(selectedFilter: FollowFilterViewModel) {
            self._selectedFilter = State(initialValue: selectedFilter)
        }
    
    var body: some View {
        VStack {
            HStack {
                Button() {
                    presentationMode.wrappedValue.dismiss()
                }label: {
                    Image(systemName: "arrowshape.backward.fill")
                }
                .padding()
                .accentColor(.green)
                
                Spacer()
            }
            
            
            
            HStack {
                ForEach(FollowFilterViewModel.allCases, id: \.rawValue) { item in
                    VStack {
                        Text (item.title)
                            .font(.subheadline)
                            .fontWeight(selectedFilter == item ? .semibold: .regular )
                            .foregroundColor(selectedFilter == item ? .green : .gray)
                        
                        if selectedFilter == item {
                            Capsule()
                                .foregroundColor(Color(.systemGreen))
                                .frame(height:3)
                                
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
            .padding(.top)
            
            Spacer()
        }
    }
    
}


#Preview {
    FollowView(selectedFilter: .follower)
}
