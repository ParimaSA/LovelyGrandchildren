import SwiftUI

struct GrandchildTabContent: View {
    let child: Grandchild
    let selectedTab: ProfileTab

    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 16) {
                switch selectedTab {
                case .profile: ProfileTabView(child: child)
                case .event:   EventTabView(child: child)
                case .parent:  ParentTabView(child: child)
                }
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 20)
            .padding(.bottom, 80)
        }
    }
}
