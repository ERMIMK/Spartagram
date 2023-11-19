import SwiftUI

struct UserStatsView: View {
    // State variable to manage the presentation of the FollowView
    @State private var showFollowView = false
    @State private var selectedFilter: FollowFilterViewModel = .follower // default value

    var body: some View {
        HStack(spacing: 24) {
            // Button for Following
            Button(action: {
                self.selectedFilter = .following
                self.showFollowView = true
            }) {
                HStack(spacing: 4) {
                    Text("0")
                        .font(.subheadline)
                        .bold()

                    Text("Following")
                        .font(.caption)
                        .foregroundColor(.gray)
                }
            }

            // Button for Follower
            Button(action: {
                self.selectedFilter = .follower
                self.showFollowView = true
            }) {
                HStack {
                    Text("120.4M")
                        .font(.subheadline)
                        .bold()

                    Text("Follower")
                        .font(.caption)
                        .foregroundColor(.gray)
                }
            }
        }
        // Full Screen Cover
        .fullScreenCover(isPresented: $showFollowView) {
            FollowView(selectedFilter: self.selectedFilter)
        }
    }
}
