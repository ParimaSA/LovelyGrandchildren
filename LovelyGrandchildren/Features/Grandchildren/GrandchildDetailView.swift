import SwiftUI

struct GrandchildDetailView: View {
    let child: Grandchild
    
    var body: some View {
        Text("Grandchild Detail View")
    }
}

#Preview {
    NavigationStack {
        GrandchildDetailView(child: Grandchild.mockList[0])
    }
}
