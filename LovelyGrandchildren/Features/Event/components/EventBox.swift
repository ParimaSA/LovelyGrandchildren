import SwiftUI

struct EventBox: View {
    let event: Event

    private var formattedDate: String {
        let f = DateFormatter()
        f.dateFormat = "d MMMM yyyy"
        f.calendar = Calendar(identifier: .gregorian)
        f.locale = Locale(identifier: "en_GB")
        return f.string(from: event.date)
    }

    private var formattedTime: String {
        let f = DateFormatter()
        f.dateFormat = "h:mm a"
        f.calendar = Calendar(identifier: .gregorian)
        return f.string(from: event.date)
    }

    var body: some View {
        NavigationLink(destination: EventDetailView(event: event)) {
            HStack(spacing: 0) {
                // Left — Content
                VStack(alignment: .leading, spacing: 8) {
                    Text(event.name)
                        .font(.custom("Jua-Regular", size: 20))
                        .foregroundColor(.black)
                        .lineLimit(2)

                    HStack(spacing: 6) {
                        Image(systemName: "calendar")
                            .font(.system(size: 13, weight: .medium))
                            .foregroundColor(.black.opacity(0.5))

                        Text("\(formattedDate)  —  \(formattedTime)")
                            .font(.custom("Jua-Regular", size: 13))
                            .foregroundColor(.black.opacity(0.6))
                    }
                    .padding(.leading, 12)

                    HStack(spacing: 6) {
                        Image(systemName: "mappin.and.ellipse")
                            .font(.system(size: 13, weight: .medium))
                            .foregroundColor(.black.opacity(0.5))

                        Text(event.location)
                            .font(.custom("Jua-Regular", size: 13))
                            .foregroundColor(.black.opacity(0.6))
                            .lineLimit(1)
                    }
                    .padding(.leading, 12)
                }
                .padding(.leading, 16)
                .padding(.vertical, 16)
                .frame(maxWidth: .infinity, alignment: .leading)

                // Right — Image
                ZStack {
                    event.type.color
                        .clipShape(
                            UnevenRoundedRectangle(
                                topLeadingRadius: 0,
                                bottomLeadingRadius: 0,
                                bottomTrailingRadius: 16,
                                topTrailingRadius: 16
                            )
                        )

                    Image(event.type.imageName)
                        .font(.system(size: 36, weight: .medium))
                        .foregroundColor(.black.opacity(0.4))
                }
                .frame(width: 90)
            }
            .frame(maxWidth: .infinity)
            .frame(height: 110)
            .background(event.type.color)
            .clipShape(RoundedRectangle(cornerRadius: 16))
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    VStack(spacing: 12) {
        ForEach(Event.mockList) { event in
            EventBox(event: event)
        }
    }
    .padding()
    .background(Color.gray.opacity(0.1))
}
