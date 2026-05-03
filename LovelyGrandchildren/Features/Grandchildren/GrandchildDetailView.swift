import SwiftUI

struct GrandchildDetailView: View {
    let child: Grandchild
    @State private var selectedTab: ProfileTab = .profile

    enum ProfileTab { case profile, event, parent }

    let primaryPink = Color(red: 230/255, green: 103/255, blue: 199/255)
    let primaryBlue = Color(red: 126/255, green: 197/255, blue: 255/255)

    var body: some View {
        ZStack {
            Image("bg")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
                .frame(maxWidth: .infinity, maxHeight: .infinity)

            VStack(spacing: 0) {
                Spacer().frame(height: 200)

                // Top hero
                ZStack(alignment: .bottom) {
                    VStack(spacing: 12) {
                        Text(child.name.uppercased())
                            .font(.custom("Jua-Regular", size: 28))
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 10)
                            .background(primaryBlue)
                            .clipShape(RoundedRectangle(cornerRadius: 16))
                            .padding(.horizontal, 24)

                        Image(child.imageName)
                            .resizable()
                            .scaledToFit()
                            .frame(height: 180)
                            .frame(maxWidth: .infinity)
                            .padding(.bottom, 16)
                            .background(child.color)
                            .padding(.horizontal, 24)
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                    }
                    .padding(.top, 16)
                }
                .frame(maxWidth: .infinity)

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
                    .padding(.bottom, 80) // leave room for tab bar
                }
            }
        }
        // Tab bar pinned to bottom via overlay
        .overlay(alignment: .bottom) {
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
        .navigationBarTitleDisplayMode(.inline)
        .ignoresSafeArea(edges: .bottom)
    }
}


private struct TabBarButton: View {
    let icon: String
    let label: String
    let tab: GrandchildDetailView.ProfileTab
    @Binding var selected: GrandchildDetailView.ProfileTab
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


private struct ProfileTabView: View {
    let child: Grandchild
    let primaryBlue = Color(red: 126/255, green: 197/255, blue: 255/255)

    private var formattedBirthday: String {
        let f = DateFormatter()
        f.dateFormat = "d MMMM yyyy"
        f.calendar = Calendar(identifier: .gregorian)
        f.locale = Locale(identifier: "en_GB")
        return f.string(from: child.birthday)
    }

    var body: some View {
        VStack(spacing: 14) {
            // Birthday
            HStack(spacing: 12) {
                Image(systemName: "birthday.cake.fill")
                    .foregroundColor(.pink)
                    .font(.system(size: 20))
                VStack(alignment: .leading, spacing: 2) {
                    Text("Birthday")
                        .font(.custom("Jua-Regular", size: 12))
                        .foregroundColor(.gray)
                    Text(formattedBirthday)
                        .font(.custom("Jua-Regular", size: 16))
                        .foregroundColor(.black)
                }
                Spacer()
            }
            .padding(14)
            .background(.white)
            .clipShape(RoundedRectangle(cornerRadius: 16))

            // Socials
            VStack(alignment: .leading, spacing: 10) {
                Text("Official Accounts")
                    .font(.custom("Jua-Regular", size: 14))
                    .foregroundColor(.gray)

                ForEach(child.socials) { social in
                    Link(destination: URL(string: social.url)!) {
                        HStack(spacing: 12) {
                            ZStack {
                                Circle()
                                    .fill(social.platform.color)
                                    .frame(width: 36, height: 36)
                                Image(systemName: social.platform.icon)
                                    .font(.system(size: 16))
                                    .foregroundColor(.white)
                            }
                            VStack(alignment: .leading, spacing: 2) {
                                Text(social.platform.rawValue)
                                    .font(.custom("Jua-Regular", size: 12))
                                    .foregroundColor(.gray)
                                Text("@\(social.handle)")
                                    .font(.custom("Jua-Regular", size: 16))
                                    .foregroundColor(.black)
                            }
                            Spacer()
                            Image(systemName: "arrow.up.right")
                                .font(.system(size: 12))
                                .foregroundColor(.gray)
                        }
                        .padding(14)
                        .background(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                    }
                }
            }

            // Merchandise
            if let merch = child.merchandiseURL, let url = URL(string: merch) {
                Link(destination: url) {
                    HStack(spacing: 12) {
                        Image(systemName: "cart.fill")
                            .font(.system(size: 20))
                            .foregroundColor(.white)
                        Text("Merchandise — BUY NOW !!")
                            .font(.custom("Jua-Regular", size: 16))
                            .foregroundColor(.white)
                        Spacer()
                        Image(systemName: "arrow.up.right")
                            .foregroundColor(.white.opacity(0.8))
                    }
                    .padding(16)
                    .background(primaryBlue)
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                }
            }
        }.padding(.bottom, 20)
    }
}

private struct EventTabView: View {
    let child: Grandchild

    private var events: [Event] {
        Event.forChild(id: child.id).sorted { $0.date < $1.date }
    }

    var body: some View {
        VStack(spacing: 12) {
            if events.isEmpty {
                VStack(spacing: 12) {
                    Image(systemName: "calendar.badge.exclamationmark")
                        .font(.system(size: 40))
                        .foregroundColor(.gray.opacity(0.4))
                    Text("No events yet")
                        .font(.custom("Jua-Regular", size: 18))
                        .foregroundColor(.gray)
                }
                .padding(.top, 40)
            } else {
                ForEach(events) { event in
                    EventBox(event: event)
                }
            }
        }
    }
}


private struct ParentTabView: View {
    let child: Grandchild
    let primaryPink = Color(red: 230/255, green: 103/255, blue: 199/255)

    private var parents: [Parent] {
        Parent.find(ids: child.parentIds)
    }

    var body: some View {
        VStack(spacing: 12) {
            ForEach(parents) { parent in
                Link(destination: URL(string: parent.instagramURL)!) {
                    HStack(spacing: 14) {
                        Image(parent.imageName)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 70, height: 70)
                            .clipShape(RoundedRectangle(cornerRadius: 12))

                        VStack(alignment: .leading, spacing: 6) {
                            Text(parent.name)
                                .font(.custom("Jua-Regular", size: 18))
                                .foregroundColor(primaryPink)

                            HStack(spacing: 6) {
                                Image(systemName: "camera.fill")
                                    .font(.system(size: 14))
                                    .foregroundColor(.gray)
                                Text(parent.instagramHandle)
                                    .font(.custom("Jua-Regular", size: 14))
                                    .foregroundColor(.gray)
                            }
                        }

                        Spacer()

                        Image(systemName: "arrow.up.right")
                            .foregroundColor(.gray.opacity(0.5))
                    }
                    .padding(24)
                    .background(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                    .shadow(color: .black.opacity(0.05), radius: 6, x: 0, y: 3)
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        GrandchildDetailView(child: Grandchild.mockList[0])
    }
}
