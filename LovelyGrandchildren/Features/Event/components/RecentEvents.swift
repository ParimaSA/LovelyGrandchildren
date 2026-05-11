import SwiftUI
import FirebaseCore

struct RecentEvents: View {
    @StateObject private var service = FirestoreService()
    private var sortedRecentEvents: [Event] {
            service.events
                .sorted { $0.date.dateValue() < $1.date.dateValue() }
                .prefix(2)
                .map { $0 }
        }

    var body: some View {
        VStack(spacing: 12) {
            if service.events.isEmpty {ProgressView().padding()
            } else {
                ForEach(sortedRecentEvents) { event in
                    NavigationLink(destination: EventDetailView(event: event)) {
                        EventBox(event: event)
                    }
                }
            }
        }
        .padding(.horizontal, 16)
        .onAppear {
            service.fetchEvents()
        }
    }
}

#Preview {
    RecentEvents()
        .padding()
        .background(Color.gray.opacity(0.1))
}
