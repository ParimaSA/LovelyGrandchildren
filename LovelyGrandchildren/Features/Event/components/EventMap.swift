import SwiftUI
import MapKit

struct EventMapView: View {
    let locationName: String

    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 13.7563, longitude: 100.5018),
        span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
    )
    @State private var pin: [MapPin] = []

    struct MapPin: Identifiable {
        let id = UUID()
        let coordinate: CLLocationCoordinate2D
    }

    var body: some View {
        Map(coordinateRegion: $region, annotationItems: pin) { p in
            MapMarker(coordinate: p.coordinate, tint: Color(red: 230/255, green: 103/255, blue: 199/255))
        }
        .onAppear { geocode() }
    }

    private func geocode() {
        CLGeocoder().geocodeAddressString(locationName) { placemarks, _ in
            if let coord = placemarks?.first?.location?.coordinate {
                region.center = coord
                pin = [MapPin(coordinate: coord)]
            }
        }
    }
}
