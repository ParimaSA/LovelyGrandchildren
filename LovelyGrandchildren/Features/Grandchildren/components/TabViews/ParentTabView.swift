import SwiftUI

struct ParentTabView: View {
    let child: Grandchild
    let primaryPink = Color(red: 230/255, green: 103/255, blue: 199/255)

    private var parents: [Parent] {
        Parent.find(ids: child.parentIds)
    }

    var body: some View {
        VStack(spacing: 12) {
            ForEach(parents) { parent in
                Link(destination: URL(string: parent.instagramURL)!) {
                    HStack(spacing: 14) {
                        Image(parent.imageName)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 70, height: 70)
                            .clipShape(RoundedRectangle(cornerRadius: 12))

                        VStack(alignment: .leading, spacing: 6) {
                            Text(parent.name)
                                .font(.custom("Jua-Regular", size: 18))
                                .foregroundColor(primaryPink)

                            HStack(spacing: 6) {
                                Image(systemName: "camera.fill")
                                    .font(.system(size: 14))
                                    .foregroundColor(.gray)
                                Text(parent.instagramHandle)
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
        }
    }
}
