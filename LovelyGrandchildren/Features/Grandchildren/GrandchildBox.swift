import SwiftUI

struct GrandchildBox: View {
    let child: Grandchild
    let boxSize: CGFloat

    var body: some View {
        ZStack(alignment: .bottom) {
            // Background color
            RoundedRectangle(cornerRadius: 20)
                .fill(child.color)
                .frame(width: boxSize, height: boxSize)

            // Child photo — fills the box, clipped to rounded rect
            Image(child.imageName)
                .resizable()
                .scaledToFill()
                .frame(width: boxSize, height: boxSize)
                .clipShape(RoundedRectangle(cornerRadius: 20))

            // Name label at the bottom
            Text(child.name)
                .font(.caption.bold())
                .foregroundColor(.white)
                .padding(.horizontal, 6)
                .padding(.vertical, 3)
                .background(.black.opacity(0.35))
                .clipShape(Capsule())
                .padding(.bottom, 8)
        }
        .frame(width: boxSize, height: boxSize)
    }
}
