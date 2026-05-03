import SwiftUI

struct EventDetailView: View {
    let event: Event
    
    var body: some View {
        Text("Event Detail View")
    }
}

#Preview {
    EventDetailView(event: Event.mockList[0])
}
