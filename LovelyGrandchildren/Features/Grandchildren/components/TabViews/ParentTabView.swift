import SwiftUI

struct ParentTabView: View {
    let mascot: Mascot
    let primaryPink = Color(red: 230/255, green: 103/255, blue: 199/255)
    
    @StateObject private var service = FirestoreService()

    var body: some View {
        VStack(spacing: 12) {
            if service.parents.isEmpty && !hasFetched {
                VStack {
                    ProgressView()
                        .tint(primaryPink)
                    Text("Loading parents...")
                        .font(.custom("Jua-Regular", size: 14))
                        .foregroundColor(.gray)
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 50)
            } else if service.parents.isEmpty {
                VStack(spacing: 12) {
                    Image(systemName: "person.slash")
                        .font(.system(size: 50))
                        .foregroundColor(.gray.opacity(0.5))
                    Text("No parents found")
                        .font(.custom("Jua-Regular", size: 16))
                        .foregroundColor(.gray)
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 50)
            } else {
                ForEach(service.parents) { parent in
                    if let url = URL(string: "https://instagram.com/\(parent.ig_account)") {
                        Link(destination: url) {
                            ParentCard(parent: parent, primaryPink: primaryPink)
                        }
                    }
                }
            }
        }
        .onAppear {
            guard let mascotId = mascot.id else { return }
            service.fetchParents(for: mascotId)
        }
    }
    
    private var hasFetched: Bool {
        return false
    }
}

struct ParentCard: View {
    let parent: Parent
    let primaryPink: Color
    
    var body: some View {
        HStack(spacing: 14) {
            // Parent Image
            AsyncImage(url: URL(string: parent.parent_image)) { image in
                image.resizable()
                    .scaledToFill()
            } placeholder: {
                ZStack {
                    Color.gray.opacity(0.2)
                    Image(systemName: "person.circle.fill")
                        .font(.system(size: 40))
                        .foregroundColor(.gray)
                }
            }
            .frame(width: 70, height: 70)
            .clipShape(RoundedRectangle(cornerRadius: 12))

            VStack(alignment: .leading, spacing: 6) {
                Text(parent.parent_name)
                    .font(.custom("Jua-Regular", size: 18))
                    .foregroundColor(primaryPink)

                HStack(spacing: 6) {
                    Image(systemName: "camera.fill")
                        .font(.system(size: 14))
                        .foregroundColor(.gray)
                    Text("@\(parent.ig_account)")
                        .font(.custom("Jua-Regular", size: 14))
                        .foregroundColor(.gray)
                }
            }

            Spacer()

            Image(systemName: "arrow.up.right")
                .foregroundColor(.gray.opacity(0.5))
        }
        .padding(24)
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .shadow(color: .black.opacity(0.05), radius: 6, x: 0, y: 3)
    }
}

//    var body: some View {
//        VStack(spacing: 12) {
//            ForEach(parents) { parent in
//                Link(destination: URL(string: parent.instagramURL)!) {
//                    HStack(spacing: 14) {
//                        Image(parent.imageName)
//                            .resizable()
//                            .scaledToFill()
//                            .frame(width: 70, height: 70)
//                            .clipShape(RoundedRectangle(cornerRadius: 12))
//
//                        VStack(alignment: .leading, spacing: 6) {
//                            Text(parent.name)
//                                .font(.custom("Jua-Regular", size: 18))
//                                .foregroundColor(primaryPink)
//
//                            HStack(spacing: 6) {
//                                Image(systemName: "camera.fill")
//                                    .font(.system(size: 14))
//                                    .foregroundColor(.gray)
//                                Text(parent.instagramHandle)
//                                    .font(.custom("Jua-Regular", size: 14))
//                                    .foregroundColor(.gray)
//                            }
//                        }
//
//                        Spacer()
//
//                        Image(systemName: "arrow.up.right")
//                            .foregroundColor(.gray.opacity(0.5))
//                    }
//                    .padding(24)
//                    .background(.white)
//                    .clipShape(RoundedRectangle(cornerRadius: 16))
//                    .shadow(color: .black.opacity(0.05), radius: 6, x: 0, y: 3)
//                }
//            }
//        }
//    }
//}
