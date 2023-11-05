import SwiftUI
import Kingfisher

// Side menu View
struct SideMenuView: View {
    @EnvironmentObject var authViewModel: AuthViewModel

    var body: some View {
        if let user = authViewModel.currentUser {
            VStack(alignment: .leading, spacing: 32) {
                // profile and user name
                VStack(alignment: .leading) {
                    // Profile Image
                    KFImage(URL(string: user.profileImageUrl))
                        .resizable()
                        .scaledToFit()
                        .clipShape(Circle())
                        .frame(width: 48, height: 48)
                        .foregroundColor(Color.black)
                    
                    // User Name
                    VStack(alignment: .leading, spacing: 4) {
                        Text(user.fullname)
                            .font(.headline)
                            .foregroundColor(Color.black)

                        Text("@\(user.username)")
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                }
                .padding(.leading)
                
                // User profile, bookmark, settings and Logout
                ForEach(SideMenuViewModel.allCases, id: \.rawValue) { viewModel in
                    navigationLink(for: viewModel, user: user)
                }

                Spacer()
            }
        }
    }

    @ViewBuilder
    private func navigationLink(for viewModel: SideMenuViewModel, user: User) -> some View {
        switch viewModel {
        case .profile:
            NavigationLink(destination: ProfileView(user: user)) {
                SideMenuOptionRowView(viewModel: viewModel)
            }
        case .settings:
            NavigationLink(destination: SettingsView( viewModel: ProfileViewModel(user: user))) {
                SideMenuOptionRowView(viewModel: viewModel)
            }
        case .logout:
            Button(action: {
                authViewModel.signOut()
            }) {
                SideMenuOptionRowView(viewModel: viewModel)
            }
        default:
            SideMenuOptionRowView(viewModel: viewModel)
        }
    }
}

// Add your preview provider here if needed
struct SideMenuView_Previews: PreviewProvider {
    static var previews: some View {
        SideMenuView().environmentObject(AuthViewModel())
    }
}
