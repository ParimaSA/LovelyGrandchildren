import SwiftUI

struct EventDetailView: View {
    let event: Event

    private let primaryPink = Color(red: 230/255, green: 103/255, blue: 199/255)

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

    private var members: [Grandchild] {
        Grandchild.mockList.filter { event.memberIds.contains($0.id) }
    }

    var body: some View {
        ZStack {
            Image("bg")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
                .frame(maxWidth: .infinity, maxHeight: .infinity)

            VStack(spacing: 0) {
                Spacer().frame(height: 200)

                // Header
                VStack(spacing: 0) {
                    Text(event.name)
                        .font(.custom("IrishGrover-Regular", size: 32))
                        .foregroundColor(primaryPink)
                        .padding(.horizontal, 20)

                    Image("flowers")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 30)
                        .padding(.horizontal, 20)

                    Spacer().frame(height: 20)
                }

                // Content
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 20) {
                        // Date & Location Card
                        VStack(alignment: .leading, spacing: 12) {
                            HStack(spacing: 10) {
                                Image(systemName: "calendar")
                                    .foregroundColor(.black.opacity(0.5))
                                Text("\(formattedDate) — \(formattedTime)")
                                    .font(.custom("Jua-Regular", size: 16))
                            }

                            HStack(spacing: 10) {
                                Image(systemName: "mappin.and.ellipse")
                                    .foregroundColor(.black.opacity(0.5))
                                Text(event.location)
                                    .font(.custom("Jua-Regular", size: 16))
                            }
                        }
                        .padding(16)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(.white.opacity(0.85))
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                        .padding(.horizontal, 20)

                        // Map
                        EventMapView(locationName: event.location)
                            .frame(height: 200)
                            .clipShape(RoundedRectangle(cornerRadius: 16))
                            .padding(.horizontal, 20)

                        // Members
                        VStack(spacing: 8) {
                            Text("Members")
                                .font(.custom("Jua-Regular", size: 18))
                                .foregroundColor(.black.opacity(0.7))
                                .padding(.horizontal, 20)

                            MemberGridView(members: members)
                                .padding(.horizontal, 20)
                        }

                        Spacer().frame(height: 40)
                    }
                    .padding(.top, 10)
                }
            }
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack {
        EventDetailView(event: Event.mockList[0])
    }
}
