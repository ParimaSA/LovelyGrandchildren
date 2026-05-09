import SwiftUI

struct ParentTabView: View {
    let mascot: Mascot
    let primaryPink = Color(red: 230/255, green: 103/255, blue: 199/255)
    
    @StateObject private var service = FirestoreService()
    @State private var isLoading = true

    var body: some View {
        VStack(spacing: 12) {
            if isLoading {
                VStack {
                    ProgressView().tint(primaryPink)
                    Text("Loading parents...")
                        .font(.custom("Jua-Regular", size: 14))
                        .foregroundColor(.gray)
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 50)
            } else if service.parents.isEmpty {
                VStack(spacing: 12) {
                    Image(systemName: "person.slash")
                        .font(.system(size: 50))
                        .foregroundColor(.gray.opacity(0.5))
                    Text("No parents found")
                        .font(.custom("Jua-Regular", size: 16))
                        .foregroundColor(.gray)
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 50)
            } else {
                ForEach(Array(service.parents.enumerated()), id: \.element.id) { index, parent in
                    if let url = URL(string: "https://instagram.com/\(parent.ig_account)") {
                        Link(destination: url) {
                            ParentCard(parent: parent, index: index)
                        }
                    }
                }
            }
        }
        .onAppear {
            guard let mascotId = mascot.id else {
                isLoading = false
                return
            }
            service.fetchParents(for: mascotId)
            
            // Set loading false after a short delay or when parents load
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                isLoading = false
            }
        }
        .onReceive(service.$parents) { parents in
            // Update loading state when parents are loaded
            if !parents.isEmpty || !isLoading {
                isLoading = false
            }
        }
    }
}

struct ParentCard: View {
    let parent: Parent
    let index: Int
    private let cardHeight: CGFloat = 100  // Fixed height for the card

    // colors
    private var boxColor: Color {
        index % 2 == 0
            ? Color(red: 255/255, green: 211/255, blue: 212/255)  // FFD3D4
            : Color(red: 227/255, green: 214/255, blue: 255/255)  // E3D6FF
    }

    private var textColor: Color {
        index % 2 == 0
            ? Color(red: 255/255, green: 110/255, blue: 112/255)  // FF6E70
            : Color(red: 147/255, green: 145/255, blue: 255/255)  // 9391FF
    }

    var body: some View {
        HStack(spacing: 0) {
            // Image section - fixed height matching the card
            AsyncImage(url: URL(string: parent.parent_image)) { phase in
                switch phase {
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFill()
                case .empty:
                    boxColor.opacity(0.5)
                        .overlay(ProgressView())
                case .failure:
                    boxColor.opacity(0.5)
                        .overlay(
                            Image(systemName: "person.fill")
                                .font(.system(size: 36))
                                .foregroundColor(textColor)
                        )
                @unknown default:
                    EmptyView()
                }
            }
            .frame(width: 100, height: cardHeight)
            .clipped()

            // Text content
            VStack(alignment: .leading, spacing: 8) {
                Text(parent.parent_name)
                    .font(.custom("Jua-Regular", size: 18))
                    .foregroundColor(textColor)

                HStack(spacing: 6) {
                    Image(systemName: "camera.fill")
                        .font(.system(size: 14))
                        .foregroundColor(textColor.opacity(0.7))
                    
                    Text(parent.ig_account)
                        .font(.custom("Jua-Regular", size: 14))
                        .foregroundColor(textColor.opacity(0.7))
                    
                    Image(systemName: "arrow.up.right")
                        .font(.system(size: 12))
                        .foregroundColor(textColor.opacity(0.6))
                }
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 12)
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .frame(height: cardHeight)
        .background(boxColor)
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .shadow(color: .black.opacity(0.05), radius: 6, x: 0, y: 3)
    }
}
