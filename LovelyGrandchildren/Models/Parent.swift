import Foundation
import FirebaseFirestore
import SwiftUI

struct Parent: Identifiable, Codable {
    @DocumentID var id: String?
    var parent_name: String
    var ig_account: String
    var parent_image: String
    var mascot_id: String
}
