import SwiftUI
import Foundation
import FirebaseFirestore

enum EventType: String {
    case concert  = "Concert"
    case meeting  = "Meeting"
    case fanSign  = "Fan Sign"
    case ticket = "Ticket"

    var imageName: String {
        switch self {
        case .concert:  return "concert"
        case .meeting:  return "meeting"
        case .fanSign:  return "fansign"
        case .ticket: return "ticket"
        }
    }
    
    var color: Color {
        switch self {
        case .concert:  return Color(red: 1.000, green: 0.847, blue: 0.969) // FFD8F7 pink
        case .meeting:  return Color(red: 0.765, green: 0.882, blue: 1.000) // C3E1FF blue
        case .fanSign:  return Color(red: 1.000, green: 0.976, blue: 0.639) // FFF9A3 yellow
        case .ticket: return Color(red: 0.722, green: 1.000, blue: 0.639) // B8FFA3 green
        }
    }}

struct Event: Identifiable, Codable {
    @DocumentID var id: String?
    var name: String
    var type: String
    var date: Timestamp
    var place: String
    var members: [String]
    var geolocation: GeoPoint?
    
    // Formatted date: "7 March 2026, 16:00"
    var dateFormatted: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "d MMMM yyyy, HH:mm"
        formatter.locale = Locale(identifier: "en_US")
        formatter.timeZone = TimeZone(identifier: "Asia/Bangkok")
        return formatter.string(from: date.dateValue())
    }
    
    // Map string → EventType enum
    var eventType: EventType {
        switch type.lowercased() {
        case "concert":  return .concert
        case "meeting":  return .meeting
        case "fansign", "fan sign": return .fanSign
        case "ticket":  return .ticket
        default:         return .concert
        }
    }
}
