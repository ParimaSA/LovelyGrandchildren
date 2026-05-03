import SwiftUI

struct Parent: Identifiable {
    let id: Int
    let name: String
    let imageName: String
    let instagramHandle: String
    let instagramURL: String
}

extension Parent {
    static let mockList: [Parent] = [
        Parent(id: 1,  name: "OFF Jumpol",   imageName: "parent1",  instagramHandle: "tumcial",       instagramURL: "https://instagram.com/tumcial"),
        Parent(id: 2,  name: "GUN Atthapan", imageName: "parent2",  instagramHandle: "gun_atthapan",  instagramURL: "https://instagram.com/gun_atthapan"),
        Parent(id: 3,  name: "Earth Pirapat",imageName: "parent3",  instagramHandle: "earth_pirapat", instagramURL: "https://instagram.com/earth_pirapat"),
        Parent(id: 4,  name: "Mix Sahaphap", imageName: "parent4",  instagramHandle: "mix_sahaphap",  instagramURL: "https://instagram.com/mix_sahaphap"),
        Parent(id: 5,  name: "Khaotung",     imageName: "parent5",  instagramHandle: "khaotung_k",    instagramURL: "https://instagram.com/khaotung_k"),
        Parent(id: 6,  name: "Nano Tanutwo", imageName: "parent6",  instagramHandle: "nano_tanutwo",  instagramURL: "https://instagram.com/nano_tanutwo"),
        Parent(id: 7,  name: "First Kanaphan",imageName:"parent7",  instagramHandle: "firstkanaphan", instagramURL: "https://instagram.com/firstkanaphan"),
        Parent(id: 8,  name: "Krit Amnuaydechkorn",imageName:"parent8",instagramHandle:"krit.amnuay",instagramURL:"https://instagram.com/krit.amnuay"),
        Parent(id: 9,  name: "Joong Archen", imageName: "parent9",  instagramHandle: "joong_archen",  instagramURL: "https://instagram.com/joong_archen"),
        Parent(id: 10, name: "Dunk Natachai",imageName: "parent10", instagramHandle: "dunk_natachai", instagramURL: "https://instagram.com/dunk_natachai"),
    ]

    static func find(ids: [Int]) -> [Parent] {
        ids.compactMap { id in mockList.first { $0.id == id } }
    }
}
