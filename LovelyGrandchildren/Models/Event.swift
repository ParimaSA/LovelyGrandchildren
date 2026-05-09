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

//extension Event {
//    static let mockList: [Event] = {
//        var cal = Calendar(identifier: .gregorian)
//        func date(_ year: Int, _ month: Int, _ day: Int, hour: Int = 10) -> Date {
//            DateComponents(calendar: cal, year: year, month: month, day: day, hour: hour).date!
//        }
//        return [
//            Event(id: 1, name: "BTS World Tour",          type: .concert,  date: date(2026, 3, 26, hour: 19), location: "IMPACT Arena, Bangkok",    memberIds: [1, 2, 3]),
//            Event(id: 2, name: "Label Meeting",            type: .meeting,  date: date(2026, 4, 2,  hour: 10), location: "HYBE Office, Seoul",        memberIds: [1, 4, 5]),
//            Event(id: 3, name: "Stray Kids Fan Sign",      type: .fanSign,  date: date(2026, 4, 10, hour: 14), location: "SM Town, Gangnam",          memberIds: [2, 6, 7]),
//            Event(id: 4, name: "Emma's Birthday Party",    type: .ticket, date: date(2026, 4, 20, hour: 15), location: "Home Backyard",             memberIds: [1, 3, 8]),
//            Event(id: 5, name: "BLACKPINK Encore Concert", type: .concert,  date: date(2026, 5, 1,  hour: 18), location: "Rajamangala Stadium",       memberIds: [4, 9, 10]),
//            Event(id: 6, name: "Fan Meeting Planning",     type: .meeting,  date: date(2026, 5, 8,  hour: 11), location: "Conference Room B",         memberIds: [5, 11, 12]),
//            Event(id: 7, name: "TWICE Fan Sign Event",     type: .fanSign,  date: date(2026, 5, 17, hour: 13), location: "Coex Mall, Seoul",          memberIds: [6, 7, 8]),
//            Event(id: 8, name: "Liam's Birthday Bash",     type: .ticket, date: date(2026, 5, 25, hour: 14), location: "Fun Zone Arcade",           memberIds: [2, 9, 11]),
//        ]
//    }()
//
//    static func forChild(id: Int) -> [Event] {
//        mockList.filter { $0.memberIds.contains(id) }
//    }
//}
