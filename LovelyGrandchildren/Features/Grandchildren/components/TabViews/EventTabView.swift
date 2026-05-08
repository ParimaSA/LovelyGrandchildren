import SwiftUI

struct EventTabView: View {
    let mascot: Mascot
    @StateObject private var service = FirestoreService()

//    private var events: [Event] {
//        Event.forChild(id: Int(child.id)).sorted { $0.date < $1.date }
//    }

//    var body: some View {
//        VStack(spacing: 12) {
//            if events.isEmpty {
//                VStack(spacing: 12) {
//                    Image(systemName: "calendar.badge.exclamationmark")
//                        .font(.system(size: 40))
//                        .foregroundColor(.gray.opacity(0.4))
//                    Text("No events yet")
//                        .font(.custom("Jua-Regular", size: 18))
//                        .foregroundColor(.gray)
//                }
//                .padding(.top, 40)
//            } else {
//                ForEach(events) { event in
//                    EventBox(event: event)
//                }
//            }
//        }
//    }
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
