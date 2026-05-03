import SwiftUI

struct RecentEvents: View {
    private var recentEvents: [Event] {
        Array(Event.mockList
            .sorted { $0.date < $1.date }
            .prefix(2))
    }

    var body: some View {
        VStack(spacing: 12) {
            ForEach(recentEvents) { event in
                EventBox(event: event)
            }
        }
        .padding(.horizontal, 16)
    }
}

#Preview {
    RecentEvents()
        .padding()
        .background(Color.gray.opacity(0.1))
}
