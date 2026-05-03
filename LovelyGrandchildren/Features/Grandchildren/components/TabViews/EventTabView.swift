import SwiftUI

struct EventTabView: View {
    let child: Grandchild

    private var events: [Event] {
        Event.forChild(id: child.id).sorted { $0.date < $1.date }
    }

    var body: some View {
        VStack(spacing: 12) {
            if events.isEmpty {
                VStack(spacing: 12) {
                    Image(systemName: "calendar.badge.exclamationmark")
                        .font(.system(size: 40))
                        .foregroundColor(.gray.opacity(0.4))
                    Text("No events yet")
                        .font(.custom("Jua-Regular", size: 18))
                        .foregroundColor(.gray)
                }
                .padding(.top, 40)
            } else {
                ForEach(events) { event in
                    EventBox(event: event)
                }
            }
        }
    }
}
