import SwiftUI

struct GrandchildBoxesSection: View {
    private let boxSize: CGFloat = 100
    private let spacing: CGFloat = 12
    private let speed: CGFloat = 35

    @State private var manualOffset: CGFloat = 0
    @StateObject private var service = FirestoreService() // firstore

    private var itemWidth: CGFloat { boxSize + spacing }
    private var contentWidth: CGFloat { CGFloat(service.mascots.count) * itemWidth }

    var body: some View {
        GeometryReader { geo in
            ZStack {
                // Scrolling content
                if service.mascots.isEmpty {
                    // Show loading when no mascots
                    HStack(spacing: spacing) {
                        ForEach(0..<6, id: \.self) { _ in
                            RoundedRectangle(cornerRadius: 20)
                                .fill(Color.gray.opacity(0.3))
                                .frame(width: boxSize, height: boxSize)
                        }
                    }
                    .frame(width: geo.size.width, height: boxSize, alignment: .leading)
                } else {
                    TimelineView(.animation) { context in
                        let offset = normalizedOffset(for: context.date)
                        let mascots = service.mascots

                        HStack(spacing: spacing) {
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
                }

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
        .onAppear {
            // Only fetch if empty
            if service.mascots.isEmpty {
                service.fetchMascots()
            }
        }
    }

    private func normalizedOffset(for date: Date) -> CGFloat {
        guard contentWidth > 0 else { return 0 }
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
                    Rectangle()
                        .fill(primaryBlue)
                        .frame(width: 44, height: height)
                    Image(systemName: "chevron.left")
                        .font(.system(size: 24, weight: .bold))
                        .foregroundColor(.white)
                }
            }
            .buttonStyle(.plain)

            Spacer()

            Button(action: onRight) {
                ZStack {
                    Rectangle()
                        .fill(primaryBlue)
                        .frame(width: 44, height: height)
                    Image(systemName: "chevron.right")
                        .font(.system(size: 24, weight: .bold))
                        .foregroundColor(.white)
                }
            }
            .buttonStyle(.plain)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.clear)
    }
}
