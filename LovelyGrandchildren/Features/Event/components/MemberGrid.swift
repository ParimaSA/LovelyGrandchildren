import SwiftUI

struct MemberGridView: View {
    let members: [Grandchild]

    private let columns = Array(repeating: GridItem(.flexible()), count: 4)

    var body: some View {
        LazyVGrid(columns: columns, spacing: 16) {
            ForEach(members) { child in
                NavigationLink(destination: GrandchildDetailView(child: child)) {
                    VStack(spacing: 6) {
                        ZStack {
                            Circle()
                                .fill(child.color)
                                .frame(width: 64, height: 64)

                            Image(child.imageName)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 64, height: 64)
                                .clipShape(Circle())
                        }

                        Text(child.name)
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
