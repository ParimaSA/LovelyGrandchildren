import Foundation
import FirebaseFirestore
import SwiftUI

struct SocialAccount: Identifiable {
    let id = UUID()
    let platform: SocialPlatform
    let handle: String
    let url: String
}

enum SocialPlatform: String {
    case instagram = "Instagram"
    case twitter   = "Twitter"
    case tiktok    = "TikTok"

    var icon: String {
        switch self {
        case .instagram: return "camera.fill"
        case .twitter:   return "bird.fill"
        case .tiktok:    return "music.note"
        }
    }

    var color: Color {
        switch self {
        case .instagram: return Color(red: 0.957, green: 0.561, blue: 0.694)
        case .twitter:   return Color(red: 0.502, green: 0.871, blue: 0.918)
        case .tiktok:    return .black
        }
    }
}

struct Mascot: Identifiable, Codable {
    @DocumentID var id: String?
    var name: String
    var birth_date: Timestamp
    var ig_account: String
    var x_account: String
    var tiktok_account: String
    var merchandise_link: String?
    var mascot_image: String

    
    var birthDay: String {
        let f = DateFormatter()
        f.dateFormat = "d"
        return f.string(from: birth_date.dateValue())
    }
    
    var birthMonth: String {
        let f = DateFormatter()
        f.dateFormat = "MMM"
        f.locale = Locale(identifier: "en_US")
        return f.string(from: birth_date.dateValue()).uppercased()
    }
    
    // Build socials from Firestore fields using SocialPlatform colors/icons
    var socials: [SocialAccount] {
        [
            SocialAccount(
                platform: .instagram,
                handle: ig_account,
                url: "https://instagram.com/\(ig_account)"
                
            ),
            SocialAccount(
                platform: .twitter,
                handle: x_account,
                url: "https://x.com/\(x_account)"
            ),
            SocialAccount(
                platform: .tiktok,
                handle: tiktok_account,
                url: "https://tiktok.com/@\(tiktok_account)"
            ),
        ].filter { !$0.handle.isEmpty }  // skip empty accounts
    }
}

extension Mascot {
    static let colorPalette: [Color] = [
        Color(red: 0.957, green: 0.561, blue: 0.694),  // pink
        Color(red: 1.000, green: 0.800, blue: 0.502),  // yellow-orange
        Color(red: 1.000, green: 0.945, blue: 0.463),  // yellow
        Color(red: 0.682, green: 0.835, blue: 0.506),  // green
        Color(red: 0.502, green: 0.871, blue: 0.918),  // light blue
        Color(red: 0.624, green: 0.659, blue: 0.855),  // purple-blue
        Color(red: 0.808, green: 0.576, blue: 0.847),  // purple
    ]
    // index  % 7 colors
    var themeColor: Color {
        guard let id = id, let index = Int(id) else {
            return Mascot.colorPalette[0]
        }
        return Mascot.colorPalette[index % Mascot.colorPalette.count]
    }
    
}
