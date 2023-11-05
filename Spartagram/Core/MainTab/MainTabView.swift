import SwiftUI

struct MainTabView: View {
    @State private var selectedIndex = 0
    @EnvironmentObject var authViewModel: AuthViewModel

    var body: some View {
        TabView(selection: $selectedIndex) {
            // Home tab view
            FeedView()
                .tabItem {
                    Image(systemName: "house")
                        .imageScale(.small)
                }.tag(0)

            // Explore tab view
            ExploreView()
                .tabItem {
                    Image(systemName: "magnifyingglass")
                        .imageScale(.small)
                }.tag(1)

            // Notification tab view
            NotificationsView()
                .tabItem {
                    Image(systemName: "bell")
                        .imageScale(.small)
                }.tag(2)

            // Profile tab
            if let user = authViewModel.currentUser {
                ProfileView(user: user, showBackButton: false)
                    .tabItem {
                        Image(systemName: "person.fill")
                            .imageScale(.small)
                    }.tag(3)
                    
            }
            }
        .accentColor(.green) // Set the accent color for the TabView
    }
}

// Preview provider here
struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView().environmentObject(AuthViewModel()) // Example AuthViewModel
    }
}
