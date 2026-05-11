import SwiftUI

struct EventTabView: View {
    let mascot: Mascot
    @StateObject private var service = FirestoreService()

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            let mascotEvents = service.events(for: mascot.id ?? "")

            if mascotEvents.isEmpty {
                Text("No upcoming events")
                    .font(.custom("Jua-Regular", size: 16))
                    .foregroundColor(.gray)
                    .frame(maxWidth: .infinity)
                    .padding(.top, 20)
            } else {
                ForEach(mascotEvents) { event in
                    EventBox(event: event)
                }
            }
        }
        .onAppear { service.fetchEvents() }
    }
}
