//
//  NotificationsView.swift
//  Spartagram
//
//  Created by Ermiyas Mesfin on 10/22/23.
//

import SwiftUI

struct NotificationsView: View {
    var body: some View {
        VStack{
            Text("Notifications")
                .font(.headline)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
                .padding(.vertical)
                .foregroundColor(Color.primary)
            
            
            List {
                ForEach(0..<7, id: \.self) { _ in
                    NotificationsRowView(viewModel: NotificationRowViewModel())
                }
            }
            .listStyle(PlainListStyle())
        }
    }
}
#Preview {
    NotificationsView()
}
