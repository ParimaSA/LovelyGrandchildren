import SwiftUI

typealias ProfileTab = GrandchildTabBar.ProfileTab

struct GrandchildDetailView: View {
    let mascot: Mascot
    
    @State private var selectedTab: ProfileTab = .profile

    let primaryBlue = Color(red: 126/255, green: 197/255, blue: 255/255)
    let primaryPink = Color(red: 230/255, green: 103/255, blue: 199/255)

    var body: some View {
        ZStack {
            // Background
            Image("bg")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
                .frame(maxWidth: .infinity, maxHeight: .infinity)

            VStack(spacing: 0) {
                Spacer().frame(height: 200)

                // Header
                Text("Grandchildren")
                    .font(.custom("IrishGrover-Regular", size: 32))
                    .foregroundColor(primaryPink)

                Image("flowers")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 30)

                Spacer().frame(height: 20)
                
                // Image
                ZStack(alignment: .bottom) {
                    VStack(spacing: 12) {
                        Text(mascot.name.uppercased())
                            .font(.custom("Jua-Regular", size: 28))
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 10)
                            .background(primaryBlue)
                            .clipShape(RoundedRectangle(cornerRadius: 16))
                            .padding(.horizontal, 24)

                        Image(mascot.mascot_image)
                            .resizable()
                            .scaledToFit()
                            .frame(height: 180)
                            .frame(maxWidth: .infinity)
                            .padding(.bottom, 16)
                            .background(mascot.themeColor)
                            .padding(.horizontal, 24)
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                    }
                    .padding(.top, 16)
                }
                .frame(maxWidth: .infinity)

                // Tab Content
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 16) {
                        GrandchildTabContent(mascot: mascot, selectedTab: selectedTab)
                    }
                    .padding(.horizontal, 20)
                    .padding(.vertical, 20)
                    .padding(.bottom, 80)
                }
            }
        }
        // Tab Bar
        .overlay(alignment: .bottom) {
            GrandchildTabBar(selectedTab: $selectedTab)
        }
        .navigationBarTitleDisplayMode(.inline)
        .ignoresSafeArea(edges: .bottom)
    }
}


private struct ChildHeaderView: View {
//    let child: Grandchild
    let mascot: Mascot
    let primaryBlue: Color

    var body: some View {
        ZStack(alignment: .bottom) {
            VStack(spacing: 12) {
                Text(mascot.name.uppercased())
                    .font(.custom("Jua-Regular", size: 28))
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 10)
                    .background(primaryBlue)
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                    .padding(.horizontal, 24)
                    // AsyncImage since mascot_image is a URL string
                    AsyncImage(url: URL(string: mascot.mascot_image)) { image in
                        image.resizable().scaledToFit()
                    } placeholder: {
                        ProgressView()
                    }
                    .frame(height: 180)
                    .frame(maxWidth: .infinity)
                    .padding(.bottom, 16)
                    .background(mascot.themeColor )
                    .padding(.horizontal, 24)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
            }
            .padding(.top, 16)
        }
        .frame(maxWidth: .infinity)
    }
}


#Preview {
    struct PreviewWrapper: View {
        @StateObject private var service = FirestoreService()
        @State private var mascot: Mascot?
        
        var body: some View {
            Group {
                if let mascot = mascot {
                    NavigationStack {
                        GrandchildDetailView(mascot: mascot)
                    }
                } else if service.mascots.isEmpty {
                    VStack {
                        ProgressView("Loading mascots from Firestore...")
                        Text("Make sure you have internet connection")
                            .font(.caption)
                            .foregroundColor(.gray)
                            .padding(.top, 8)
                    }
                } else {
                    // Show first mascot from Firestore
                    NavigationStack {
                        GrandchildDetailView(mascot: service.mascots[0])
                    }
                }
            }
            .onAppear {
                service.fetchMascots()
            }
            .onReceive(service.$mascots) { mascots in
                if mascot == nil && !mascots.isEmpty {
                    mascot = mascots[0]
                }
            }
        }
    }
    
    return PreviewWrapper()
}
