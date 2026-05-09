import SwiftUI
import FirebaseCore

struct EventDetailView: View {
    let event: Event

    private let primaryPink = Color(red: 230/255, green: 103/255, blue: 199/255)
    @StateObject private var service = FirestoreService()

    private var members: [Mascot] {
        service.mascots.filter { mascot in
            guard let id = mascot.id else { return false }
            return event.members.contains(id)
        }
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
                                Text(event.dateFormatted)
                                    .font(.custom("Jua-Regular", size: 16))
                            }

                            HStack(spacing: 10) {
                                Image(systemName: "mappin.and.ellipse")
                                    .foregroundColor(.black.opacity(0.5))
                                Text(event.place)
                                    .font(.custom("Jua-Regular", size: 16))
                            }
                        }
                        .padding(16)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(.white.opacity(0.85))
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                        .padding(.horizontal, 20)

                        // Map
                        EventMapView(event: event)
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
        .onAppear {
            service.fetchMascots()
            service.fetchEvents()
        }
    }
}

#Preview {
    struct PreviewWrapper: View {
        @StateObject private var service = FirestoreService()
        @State private var event: Event?
        @State private var isLoading = true
        
        var body: some View {
            Group {
                if let event = event {
                    NavigationStack {
                        EventDetailView(event: event)
                    }
                } else if isLoading {
                    VStack {
                        ProgressView("Loading events from Firestore...")
                        Text("Make sure you have internet connection")
                            .font(.caption)
                            .foregroundColor(.gray)
                            .padding(.top, 8)
                    }
                } else if service.events.isEmpty {
                    VStack {
                        Image(systemName: "exclamationmark.triangle")
                            .font(.system(size: 40))
                            .foregroundColor(.orange)
                        Text("No events found in Firestore")
                            .font(.headline)
                            .padding(.top, 8)
                        Text("Please add events to your Firestore database")
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                } else {
                    VStack {
                        Text("Events loaded but not showing?")
                            .foregroundColor(.red)
                        Button("Retry") {
                            event = service.events.first
                        }
                    }
                }
            }
            .onAppear {
                isLoading = true
                service.fetchMascots()
                service.fetchEvents()
                
            }
            .onReceive(service.$events) { events in
                if event == nil && !events.isEmpty {
                    event = events.first
                }
            }
        }
    }
    
    return PreviewWrapper()
}
