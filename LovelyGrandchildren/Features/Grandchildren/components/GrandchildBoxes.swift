import SwiftUI

struct GrandchildBoxesSection: View {
    private let boxSize: CGFloat = 100
    private let spacing: CGFloat = 12
    private let speed: CGFloat = 35

    @State private var manualOffset: CGFloat = 0
    @StateObject private var service = FirestoreService()  // firestore


    //var children: [Grandchild] = Grandchild.mockList

    private var itemWidth: CGFloat { boxSize + spacing }
    private var contentWidth: CGFloat { CGFloat(service.mascots.count) * itemWidth }

    var body: some View {
        GeometryReader { geo in
            ZStack {
                // Scrolling content
                TimelineView(.animation) { context in
                    let offset = normalizedOffset(for: context.date)
                    let mascots = service.mascots

                    HStack(spacing: spacing) {
                        // Duplicate list for seamless loop
//                        ForEach(0..<(children.count * 2), id: \.self) { index in
//                            let child = children[index % children.count]
//
//                            NavigationLink(destination: GrandchildDetailView(child: child)) {
//                                GrandchildBox(child: child, boxSize: boxSize)
//                            }
//                            .buttonStyle(.plain)
//                        }
                        ForEach(0..<(mascots.count * 2), id: \.self) { index in
                            let mascot = mascots[index % mascots.count]

                            NavigationLink(destination: GrandchildDetailView(mascot: mascot)) {
                                GrandchildBox(mascot: mascot, boxSize: boxSize)
                            }
                            .buttonStyle(.plain)
                        }
                    }
                    .frame(width: contentWidth * 2, alignment: .leading)
                    .offset(x: -offset)
                }
                .frame(width: geo.size.width, height: boxSize, alignment: .leading)
                .clipped()

                // Arrow buttons on top
                ArrowOverlay(
                    height: boxSize,
                    onLeft:  { manualOffset -= itemWidth },
                    onRight: { manualOffset += itemWidth }
                )
                .frame(width: geo.size.width, height: boxSize)
                .allowsHitTesting(true)
                .zIndex(10)
            }
            .frame(width: geo.size.width, height: boxSize)
        }
        .frame(height: boxSize)
        .onAppear { service.fetchMascots() } 
    }

    private func normalizedOffset(for date: Date) -> CGFloat {
        let time = date.timeIntervalSinceReferenceDate
        let raw  = CGFloat(time) * speed + manualOffset
        let rem  = raw.truncatingRemainder(dividingBy: contentWidth)
        return rem >= 0 ? rem : rem + contentWidth
    }
}


private struct ArrowOverlay: View {
    let height: CGFloat
    let onLeft: () -> Void
    let onRight: () -> Void

    private let primaryBlue = Color(red: 126/255, green: 197/255, blue: 255/255)

    var body: some View {
        HStack {
            Button(action: onLeft) {
                ZStack {
                    Rectangle().fill(primaryBlue)
                    Image(systemName: "chevron.left")
                        .font(.system(size: 24, weight: .bold))
                        .foregroundColor(.white)
                }
                .frame(width: 44, height: height)
            }
            .buttonStyle(.plain)

            Spacer()

            Button(action: onRight) {
                ZStack {
                    Rectangle().fill(primaryBlue)
                    Image(systemName: "chevron.right")
                        .font(.system(size: 24, weight: .bold))
                        .foregroundColor(.white)
                }
                .frame(width: 44, height: height)
            }
            .buttonStyle(.plain)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.clear)
    }
}
