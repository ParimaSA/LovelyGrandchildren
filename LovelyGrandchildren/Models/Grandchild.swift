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

struct Grandchild: Identifiable {
    let id: Int
    let name: String
    let imageName: String
    let color: Color
    let birthday: Date
    let socials: [SocialAccount]
    let merchandiseURL: String?
    let parentIds: [Int]
}

extension Grandchild {
    static let mockList: [Grandchild] = {
        var cal = Calendar(identifier: .gregorian)
        func date(_ year: Int, _ month: Int, _ day: Int) -> Date {
            DateComponents(calendar: cal, year: year, month: month, day: day).date!
        }
        return [
            Grandchild(
                id: 1, name: "Emma", imageName: "child1",
                color: Color(red: 0.957, green: 0.561, blue: 0.694),
                birthday: date(2010, 2, 28),
                socials: [
                    SocialAccount(platform: .instagram, handle: "emma.gmmtv",  url: "https://instagram.com/emma.gmmtv"),
                    SocialAccount(platform: .twitter,   handle: "EMMA_GMMTV",  url: "https://twitter.com/EMMA_GMMTV"),
                    SocialAccount(platform: .tiktok,    handle: "emma.gmmtv",  url: "https://tiktok.com/@emma.gmmtv"),
                ],
                merchandiseURL: "https://example.com/emma-merch",
                parentIds: [1, 2]
            ),
            Grandchild(
                id: 2, name: "Liam", imageName: "child2",
                color: Color(red: 1.000, green: 0.800, blue: 0.502),
                birthday: date(2008, 5, 14),
                socials: [
                    SocialAccount(platform: .instagram, handle: "liam.gmmtv",  url: "https://instagram.com/liam.gmmtv"),
                    SocialAccount(platform: .tiktok,    handle: "liam.gmmtv",  url: "https://tiktok.com/@liam.gmmtv"),
                ],
                merchandiseURL: "https://example.com/liam-merch",
                parentIds: [1, 3]
            ),
            Grandchild(
                id: 3, name: "Olivia", imageName: "child3",
                color: Color(red: 1.000, green: 0.945, blue: 0.463),
                birthday: date(2011, 9, 3),
                socials: [
                    SocialAccount(platform: .instagram, handle: "olivia.gmmtv", url: "https://instagram.com/olivia.gmmtv"),
                    SocialAccount(platform: .twitter,   handle: "OLIVIA_GMMTV", url: "https://twitter.com/OLIVIA_GMMTV"),
                ],
                merchandiseURL: nil,
                parentIds: [2]
            ),
            Grandchild(
                id: 4, name: "Noah", imageName: "child4",
                color: Color(red: 0.682, green: 0.835, blue: 0.506),
                birthday: date(2009, 12, 20),
                socials: [
                    SocialAccount(platform: .instagram, handle: "noah.gmmtv",  url: "https://instagram.com/noah.gmmtv"),
                ],
                merchandiseURL: "https://example.com/noah-merch",
                parentIds: [3, 4]
            ),
            Grandchild(
                id: 5, name: "Ava", imageName: "child5",
                color: Color(red: 0.502, green: 0.871, blue: 0.918),
                birthday: date(2012, 7, 8),
                socials: [
                    SocialAccount(platform: .instagram, handle: "ava.gmmtv",   url: "https://instagram.com/ava.gmmtv"),
                    SocialAccount(platform: .tiktok,    handle: "ava.gmmtv",   url: "https://tiktok.com/@ava.gmmtv"),
                ],
                merchandiseURL: "https://example.com/ava-merch",
                parentIds: [4, 5]
            ),
            Grandchild(
                id: 6, name: "Ethan", imageName: "child6",
                color: Color(red: 0.624, green: 0.659, blue: 0.855),
                birthday: date(2007, 3, 15),
                socials: [
                    SocialAccount(platform: .instagram, handle: "ethan.gmmtv", url: "https://instagram.com/ethan.gmmtv"),
                    SocialAccount(platform: .twitter,   handle: "ETHAN_GMMTV", url: "https://twitter.com/ETHAN_GMMTV"),
                ],
                merchandiseURL: nil,
                parentIds: [5, 6]
            ),
            Grandchild(
                id: 7, name: "Sophia", imageName: "child7",
                color: Color(red: 0.808, green: 0.576, blue: 0.847),
                birthday: date(2010, 11, 22),
                socials: [
                    SocialAccount(platform: .instagram, handle: "sophia.gmmtv", url: "https://instagram.com/sophia.gmmtv"),
                ],
                merchandiseURL: "https://example.com/sophia-merch",
                parentIds: [6]
            ),
            Grandchild(
                id: 8, name: "Mason", imageName: "child8",
                color: Color(red: 0.957, green: 0.561, blue: 0.694),
                birthday: date(2009, 4, 1),
                socials: [
                    SocialAccount(platform: .instagram, handle: "mason.gmmtv",  url: "https://instagram.com/mason.gmmtv"),
                    SocialAccount(platform: .tiktok,    handle: "mason.gmmtv",  url: "https://tiktok.com/@mason.gmmtv"),
                ],
                merchandiseURL: "https://example.com/mason-merch",
                parentIds: [1, 7]
            ),
            Grandchild(
                id: 9, name: "Isabella", imageName: "child9",
                color: Color(red: 1.000, green: 0.800, blue: 0.502),
                birthday: date(2011, 6, 17),
                socials: [
                    SocialAccount(platform: .instagram, handle: "isabella.gmmtv", url: "https://instagram.com/isabella.gmmtv"),
                    SocialAccount(platform: .twitter,   handle: "ISABELLA_GMMTV", url: "https://twitter.com/ISABELLA_GMMTV"),
                ],
                merchandiseURL: nil,
                parentIds: [7, 8]
            ),
            Grandchild(
                id: 10, name: "Lucas", imageName: "child10",
                color: Color(red: 0.502, green: 0.871, blue: 0.918),
                birthday: date(2008, 8, 30),
                socials: [
                    SocialAccount(platform: .instagram, handle: "lucas.gmmtv",  url: "https://instagram.com/lucas.gmmtv"),
                ],
                merchandiseURL: "https://example.com/lucas-merch",
                parentIds: [8]
            ),
            Grandchild(
                id: 11, name: "Mia", imageName: "child11",
                color: Color(red: 0.682, green: 0.835, blue: 0.506),
                birthday: date(2012, 1, 5),
                socials: [
                    SocialAccount(platform: .instagram, handle: "mia.gmmtv",    url: "https://instagram.com/mia.gmmtv"),
                    SocialAccount(platform: .tiktok,    handle: "mia.gmmtv",    url: "https://tiktok.com/@mia.gmmtv"),
                ],
                merchandiseURL: "https://example.com/mia-merch",
                parentIds: [9, 10]
            ),
            Grandchild(
                id: 12, name: "Aiden", imageName: "child12",
                color: Color(red: 1.000, green: 0.945, blue: 0.463),
                birthday: date(2007, 10, 12),
                socials: [
                    SocialAccount(platform: .instagram, handle: "aiden.gmmtv",  url: "https://instagram.com/aiden.gmmtv"),
                    SocialAccount(platform: .twitter,   handle: "AIDEN_GMMTV",  url: "https://twitter.com/AIDEN_GMMTV"),
                ],
                merchandiseURL: "https://example.com/aiden-merch",
                parentIds: [10]
            ),
        ]
    }()
}
