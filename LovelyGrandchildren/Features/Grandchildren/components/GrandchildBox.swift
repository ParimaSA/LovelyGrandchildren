import SwiftUI

struct GrandchildBox: View {
    let mascot: Mascot
    let boxSize: CGFloat

    var body: some View {
        ZStack(alignment: .bottom) {
            // Background color
            RoundedRectangle(cornerRadius: 20)
                .fill(mascot.themeColor)
                .frame(width: boxSize, height: boxSize)

            // Child photo
            Image(mascot.mascot_image)
                .resizable()
                .scaledToFill()
                .frame(width: boxSize, height: boxSize)
                .clipShape(RoundedRectangle(cornerRadius: 20))

            // Name label at the bottom
            Text(mascot.name)
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
