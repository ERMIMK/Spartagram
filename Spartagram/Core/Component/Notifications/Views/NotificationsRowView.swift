//
//  NotificationsRowView.swift
//  Spartagram
//
//  Created by Ermiyas Mesfin on 11/14/23.
//

import SwiftUI

struct NotificationsRowView: View {
    
    @ObservedObject var viewModel: NotificationRowViewModel
    
    
    var body: some View {
        VStack(alignment: .leading){
            
            HStack(alignment: .top, spacing: 12){
                
                // Notification Profile Image
                Circle()
                    .scaledToFit()
                    .frame(width: 40, height: 40)
                    .foregroundColor(Color.primary)
                
                VStack(alignment: .leading, spacing: 4) {
                    
                    // User Info and notification timestamp
                    HStack {
                        Text("@userName")
                            .font(.caption).bold()
                            .foregroundColor(Color.primary)
                        Text("2hr")
                            .font(.caption).bold()
                            .foregroundColor(Color.gray)
                    }
                    
                    // Notification discription
                    Text("Ermi Started following you")
                        .font(.subheadline)
                        .multilineTextAlignment(/*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/)
                        .foregroundColor(Color.primary)
                }
                
                Spacer()
            }
        }
        .padding()
        .padding(.horizontal)
        .background(Color(UIColor { traitCollection in
            return traitCollection.userInterfaceStyle == .dark ? UIColor(hex: "#1C282F")! : UIColor(hex: "#F2FFDB")!
        }))
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .edgesIgnoringSafeArea(.all)
        .swipeActions(edge: .trailing, allowsFullSwipe: true) {
            Button(role: .destructive) {
                viewModel.deleteAction()
            } label: {
                Label("Delete", systemImage: "trash")
            }
        }
    }
}


#Preview {
    NotificationsRowView(viewModel: NotificationRowViewModel())
}
