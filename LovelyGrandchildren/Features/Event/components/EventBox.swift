import SwiftUI
import FirebaseCore

struct EventBox: View {
    let event: Event

    var body: some View {
        NavigationLink(destination: EventDetailView(event: event)) {
            HStack(spacing: 0) {
                // Left — Content
                VStack(alignment: .leading, spacing: 8) {
                    // Event Name
                    Text(event.name)
                        .font(.custom("Jua-Regular", size: 20))
                        .foregroundColor(.black)
                        .lineLimit(2)
                        .multilineTextAlignment(.leading)

                    // Date
                    HStack(spacing: 6) {
                        Image(systemName: "calendar")
                            .font(.system(size: 13, weight: .medium))
                            .foregroundColor(.black.opacity(0.5))

                        Text(event.dateFormatted)
                            .font(.custom("Jua-Regular", size: 13))
                            .foregroundColor(.black.opacity(0.6))
                    }
                    .padding(.leading, 12)

                    // Place
                    HStack(spacing: 6) {
                        Image(systemName: "mappin.and.ellipse")
                            .font(.system(size: 13, weight: .medium))
                            .foregroundColor(.black.opacity(0.5))

                        Text(event.place)
                            .font(.custom("Jua-Regular", size: 13))
                            .foregroundColor(.black.opacity(0.6))
                            .lineLimit(1)
                    }
                    .padding(.leading, 12)
                    
                    // Members Count
                    if !event.members.isEmpty {
                        HStack(spacing: 6) {
                            Image(systemName: "person.2")
                                .font(.system(size: 11, weight: .medium))
                                .foregroundColor(.black.opacity(0.4))
                            
                            Text("\(event.members.count) member\(event.members.count != 1 ? "s" : "") attending")
                                .font(.custom("Jua-Regular", size: 11))
                                .foregroundColor(.black.opacity(0.5))
                        }
                        .padding(.leading, 12)
                    }
                }
                .padding(.leading, 16)
                .padding(.vertical, 12)
                .frame(maxWidth: .infinity, alignment: .leading)

                // Right — Image
                ZStack {
                    event.eventType.color
                        .clipShape(
                            UnevenRoundedRectangle(
                                topLeadingRadius: 0,
                                bottomLeadingRadius: 0,
                                bottomTrailingRadius: 16,
                                topTrailingRadius: 16
                            )
                        )
                    
                    Image(event.eventType.imageName)
                        .font(.system(size: 36, weight: .medium))
                        .foregroundColor(.black.opacity(0.35))
                }
                .frame(width: 90)
            }
            .frame(height: event.members.isEmpty ? 110 : 130)
            .background(event.eventType.color)
            .clipShape(RoundedRectangle(cornerRadius: 16))
        }
        .buttonStyle(.plain)
    }
    
}
#Preview {
    struct PreviewWrapper: View {
        @StateObject private var service = FirestoreService()

        var body: some View {
            VStack(spacing: 12) {
                if service.events.isEmpty {
                    Text("Loading...")
                } else {
                    ForEach(service.events.prefix(3)) { event in
                        EventBox(event: event)
                    }
                }
            }
            .padding()
            .background(Color.gray.opacity(0.1))
            .onAppear {
                service.fetchEvents()
            }
        }
    }
    
    return PreviewWrapper()
}
