//import SwiftUI
//import MapKit
//
//struct EventMapView: View {
//    let locationName: String
//
//    @State private var region = MKCoordinateRegion(
//        center: CLLocationCoordinate2D(latitude: 13.7563, longitude: 100.5018),
//        span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
//    )
//    @State private var pin: [MapPin] = []
//
//    struct MapPin: Identifiable {
//        let id = UUID()
//        let coordinate: CLLocationCoordinate2D
//    }
//
//    var body: some View {
//        Map(coordinateRegion: $region, annotationItems: pin) { p in
//            MapMarker(coordinate: p.coordinate, tint: Color(red: 230/255, green: 103/255, blue: 199/255))
//        }
//        .onAppear { geocode() }
//    }
//
//    private func geocode() {
//        CLGeocoder().geocodeAddressString(locationName) { placemarks, _ in
//            if let coord = placemarks?.first?.location?.coordinate {
//                region.center = coord
//                pin = [MapPin(coordinate: coord)]
//            }
//        }
//    }
//}

import SwiftUI
import MapKit
import FirebaseFirestore

struct EventMapView: View {
    let eventId: String
    
    @StateObject private var service = FirestoreService()
    @State private var event: Event?
    @State private var isLoading = true
    
    @State private var position: MapCameraPosition = .automatic
    @State private var markerCoordinate: CLLocationCoordinate2D?

    var body: some View {
        ZStack {
            if let event = event {
                Map(position: $position) {
                    if let coord = markerCoordinate {
                        Marker(event.place, coordinate: coord)
                            .tint(Color(red: 230/255, green: 103/255, blue: 199/255))
                    }
                }
                .ignoresSafeArea()
                .navigationTitle(event.place)
                .onAppear {
                    setupMap(for: event)
                }
            } else if isLoading {
                loadingView
            } else {
                errorView
            }
        }
        .onAppear {
            fetchEventData()
        }
    }

    private func fetchEventData() {
        service.fetchEvents()
    }

    private func setupMap(for event: Event) {
        // Check if we have manual Geopoint from Firestore
        if let geo = event.geolocation {
            let coord = CLLocationCoordinate2D(latitude: geo.latitude, longitude: geo.longitude)
            updateMap(to: coord)
        } else {
            // Modern Geocoding using MKLocalSearch (Replacement for CLGeocoder)
            let request = MKLocalSearch.Request()
            request.naturalLanguageQuery = event.place
            
            let search = MKLocalSearch(request: request)
            search.start { response, error in
                if let coord = response?.mapItems.first?.location.coordinate {
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
            Image(systemName: "exclamationmark.triangle").font(.system(size: 40)).foregroundColor(.orange)
            Text("Event not found").font(.custom("Jua-Regular", size: 18))
        }
    }
}
