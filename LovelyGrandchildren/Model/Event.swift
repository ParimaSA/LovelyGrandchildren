import SwiftUI

enum EventType: String {
    case concert  = "Concert"
    case meeting  = "Meeting"
    case fanSign  = "Fan Sign"
    case birthday = "Birthday"

    var imageName: String {
        switch self {
        case .concert:  return "music.mic"
        case .meeting:  return "person.3.fill"
        case .fanSign:  return "hand.wave.fill"
        case .birthday: return "birthday.cake.fill"
        }
    }
    
    var color: Color {
        switch self {
        case .concert:  return Color(red: 1.000, green: 0.847, blue: 0.969) // FFD8F7 pink
        case .meeting:  return Color(red: 0.765, green: 0.882, blue: 1.000) // C3E1FF blue
        case .fanSign:  return Color(red: 1.000, green: 0.976, blue: 0.639) // FFF9A3 yellow
        case .birthday: return Color(red: 0.722, green: 1.000, blue: 0.639) // B8FFA3 green
        }
    }}

struct Event: Identifiable {
    let id: Int
    let name: String
    let type: EventType
    let date: Date
    let location: String
    let memberIds: [Int]   // grandchild ids
}

extension Event {
    static let mockList: [Event] = {
        var cal = Calendar(identifier: .gregorian)
        func date(_ year: Int, _ month: Int, _ day: Int, hour: Int = 10) -> Date {
            DateComponents(calendar: cal, year: year, month: month, day: day, hour: hour).date!
        }
        return [
            Event(id: 1, name: "BTS World Tour",          type: .concert,  date: date(2026, 3, 26, hour: 19), location: "IMPACT Arena, Bangkok",    memberIds: [1, 2, 3]),
            Event(id: 2, name: "Label Meeting",            type: .meeting,  date: date(2026, 4, 2,  hour: 10), location: "HYBE Office, Seoul",        memberIds: [1, 4, 5]),
            Event(id: 3, name: "Stray Kids Fan Sign",      type: .fanSign,  date: date(2026, 4, 10, hour: 14), location: "SM Town, Gangnam",          memberIds: [2, 6, 7]),
            Event(id: 4, name: "Emma's Birthday Party",    type: .birthday, date: date(2026, 4, 20, hour: 15), location: "Home Backyard",             memberIds: [1, 3, 8]),
            Event(id: 5, name: "BLACKPINK Encore Concert", type: .concert,  date: date(2026, 5, 1,  hour: 18), location: "Rajamangala Stadium",       memberIds: [4, 9, 10]),
            Event(id: 6, name: "Fan Meeting Planning",     type: .meeting,  date: date(2026, 5, 8,  hour: 11), location: "Conference Room B",         memberIds: [5, 11, 12]),
            Event(id: 7, name: "TWICE Fan Sign Event",     type: .fanSign,  date: date(2026, 5, 17, hour: 13), location: "Coex Mall, Seoul",          memberIds: [6, 7, 8]),
            Event(id: 8, name: "Liam's Birthday Bash",     type: .birthday, date: date(2026, 5, 25, hour: 14), location: "Fun Zone Arcade",           memberIds: [2, 9, 11]),
        ]
    }()

    static func forChild(id: Int) -> [Event] {
        mockList.filter { $0.memberIds.contains(id) }
    }
}
