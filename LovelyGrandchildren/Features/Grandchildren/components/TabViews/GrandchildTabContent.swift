import SwiftUI

struct GrandchildTabContent: View {
    let mascot: Mascot
    let selectedTab: ProfileTab

    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 16) {
                switch selectedTab {
                case .profile: ProfileTabView(mascot: mascot)
                case .event:   EventTabView(mascot: mascot)
                case .parent:  ParentTabView(mascot: mascot)
                }
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 20)
            .padding(.bottom, 20)
        }
    }
}
