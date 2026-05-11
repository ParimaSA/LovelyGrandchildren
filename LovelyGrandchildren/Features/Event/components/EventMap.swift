import SwiftUI
import MapKit
import FirebaseFirestore

struct EventMapView: View {
    let event: Event
    
    @StateObject private var service = FirestoreService()
    @State private var isLoading = true
    @State private var hasEvent: Event?
    @State private var errorMessage: String?
    
    @State private var position: MapCameraPosition = .automatic
    @State private var markerCoordinate: CLLocationCoordinate2D?

    var body: some View {
        ZStack {
            if let hasEvent = hasEvent {
                Map(position: $position) {
                    if let coord = markerCoordinate {
                        Marker(hasEvent.place, coordinate: coord)
                            .tint(Color(red: 230/255, green: 103/255, blue: 199/255))
                    }
                }
                .ignoresSafeArea()
                .onAppear {
                    setupMap(for: hasEvent)
                }
            } else if isLoading {
                loadingView
            } else {
                errorView
            }
        }
        .onAppear {
            setupEvent()
        }
    }
    
    private func setupEvent() {
        hasEvent = event
        isLoading = false
    }
    
    private func setupMap(for event: Event) {
        
        // Check Geopoint from Firestore
        if let geo = event.geolocation {
            let coord = CLLocationCoordinate2D(latitude: geo.latitude, longitude: geo.longitude)
            updateMap(to: coord)
        } else {
            // Fallback: search by place name
            let request = MKLocalSearch.Request()
            request.naturalLanguageQuery = event.place
            
            let search = MKLocalSearch(request: request)
            search.start { response, error in
                if let coord = response?.mapItems.first?.placemark.coordinate {
                    updateMap(to: coord)
                }
            }
        }
    }
    
    private func updateMap(to coordinate: CLLocationCoordinate2D) {
        self.markerCoordinate = coordinate
        // Smoothly move the camera to the new location
        self.position = .region(MKCoordinateRegion(
            center: coordinate,
            span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        ))
    }
    
    private var loadingView: some View {
        VStack {
            ProgressView().tint(Color(red: 230/255, green: 103/255, blue: 199/255))
            Text("Loading event details...")
                .font(.custom("Jua-Regular", size: 14))
                .foregroundColor(.gray)
        }
    }
    
    private var errorView: some View {
        VStack(spacing: 12) {
            Image(systemName: "exclamationmark.triangle")
                .font(.system(size: 40))
                .foregroundColor(.orange)
            Text(errorMessage ?? "Event not found")
                .font(.custom("Jua-Regular", size: 18))
            Text("Please check your internet connection")
                .font(.custom("Jua-Regular", size: 12))
                .foregroundColor(.gray)
        }
    }
}
