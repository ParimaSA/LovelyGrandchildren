import SwiftUI

struct GrandchildTabBar: View {
    enum ProfileTab { case profile, event, parent }

    @Binding var selectedTab: ProfileTab

    private let primaryPink = Color(red: 230/255, green: 103/255, blue: 199/255)

    var body: some View {
        HStack(spacing: 0) {
            TabBarButton(icon: "person.fill",   label: "PROFILE", tab: .profile, selected: $selectedTab, color: primaryPink)
            TabBarButton(icon: "calendar",      label: "EVENT",   tab: .event,   selected: $selectedTab, color: primaryPink)
            TabBarButton(icon: "person.2.fill", label: "PARENT",  tab: .parent,  selected: $selectedTab, color: primaryPink)
        }
        .frame(height: 64)
        .background(.white)
        .shadow(color: .black.opacity(0.08), radius: 8, x: 0, y: -2)
        .padding(.bottom, 56)
    }

    private struct TabBarButton: View {
        let icon: String
        let label: String
        let tab: ProfileTab
        @Binding var selected: ProfileTab
        let color: Color

        var isSelected: Bool { selected == tab }

        var body: some View {
            Button { selected = tab } label: {
                VStack(spacing: 4) {
                    Image(systemName: icon)
                        .font(.system(size: 22))
                    Text(label)
                        .font(.custom("Jua-Regular", size: 10))
                }
                .foregroundColor(isSelected ? color : .gray.opacity(0.5))
                .frame(maxWidth: .infinity)
            }
        }
    }
}
