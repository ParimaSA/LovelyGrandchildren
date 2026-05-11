// handles all Firebase calls

import Foundation
import FirebaseFirestore
import Combine

class FirestoreService: ObservableObject {
    private let db = Firestore.firestore()
    
    @Published var mascots: [Mascot] = []
    @Published var events: [Event] = []
    @Published var parents: [Parent] = []
    
    // Fetch all mascots from "mascot" collection
    func fetchMascots() {
        db.collection("mascot")
            .addSnapshotListener { snapshot, error in
                if let error = error {
                    print("Error: \(error.localizedDescription)")
                    return
                }
                
                self.mascots = snapshot?.documents.compactMap {
                    try? $0.data(as: Mascot.self)
                } ?? []
            }
    }
    
    // Fetch all events for "event" collection
    func fetchEvents() {
        db.collection("event")
            .addSnapshotListener { snapshot, error in
                if let error = error {
                    print("Event fetch error: \(error)")
                    return
                }
                self.events = snapshot?.documents.compactMap {
                    try? $0.data(as: Event.self)
                } ?? []
            }
    }
    
    // Events for a specific mascot
    func events(for mascotId: String) -> [Event] {
        events.filter { $0.members.contains(mascotId) }
    }
    
    // Fetch parents
    func fetchParents(for mascotId: String) {
        db.collection("parent")
            .whereField("mascot_id", isEqualTo: mascotId)
            .addSnapshotListener { snapshot, error in
                if let error = error {
                    print("Error fetching parents: \(error.localizedDescription)")
                    return
                }
                
                self.parents = snapshot?.documents.compactMap {
                    try? $0.data(as: Parent.self)
                } ?? []
            }
    }
}
