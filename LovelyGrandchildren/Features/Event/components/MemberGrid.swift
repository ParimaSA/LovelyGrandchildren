import SwiftUI

struct MemberGridView: View {
    let members: [Mascot]

    private let columns = Array(repeating: GridItem(.flexible()), count: 4)

    var body: some View {
        LazyVGrid(columns: columns, spacing: 16) {
            ForEach(members) { mascot in
                NavigationLink(destination: GrandchildDetailView(mascot: mascot)) {
                    VStack(spacing: 6) {
                        ZStack {
                            Circle()
                                .fill(mascot.themeColor)
                                .frame(width: 64, height: 64)

                            Image(mascot.mascot_image)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 64, height: 64)
                                .clipShape(Circle())
                        }

                        Text(mascot.name)
                            .font(.custom("Jua-Regular", size: 11))
                            .foregroundColor(.black.opacity(0.7))
                            .lineLimit(1)
                    }
                }
                .buttonStyle(.plain)
            }
        }
        .padding(16)
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }
}
