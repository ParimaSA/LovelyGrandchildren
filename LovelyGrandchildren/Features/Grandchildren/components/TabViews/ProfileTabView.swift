import SwiftUI

struct ProfileTabView: View {
    let mascot: Mascot
    let primaryBlue   = Color(red: 126/255, green: 197/255, blue: 255/255)
    let primaryPink   = Color(red: 230/255, green: 103/255, blue: 199/255)
    let primaryPurple = Color(red: 234/255, green: 228/255, blue: 255/255)
    let secondBlue    = Color(red: 194/255, green: 238/255, blue: 255/255)

    var body: some View {
        VStack(spacing: 14) {
            HStack(alignment: .top, spacing: 10) {

                // SOCIAL ICONS
                VStack(alignment: .leading, spacing: 10) {
                    ForEach(mascot.socials) { social in
                        Link(destination: URL(string: social.url)!) {
                            HStack(spacing: 10) {
                                ZStack {
                                    RoundedRectangle(cornerRadius: 8)
                                        .fill(social.platform.color)
                                        .frame(width: 44, height: 44)
                                    Image(systemName: social.platform.icon)
                                        .font(.system(size: 16))
                                        .foregroundColor(.white)
                                }
                                Text(social.handle)
                                    .font(.custom("Jua-Regular", size: 14))
                                    .foregroundColor(Color(red: 135/255, green: 113/255, blue: 214/255))
                                    .lineLimit(1)
                                    .minimumScaleFactor(0.8)
                            }
                        }
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(14)
                .background(primaryPurple)
                .clipShape(RoundedRectangle(cornerRadius: 16))

                // BIRTHDAY BOX
                VStack(spacing: 4) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 16)
                            .fill(Color(red: 255/255, green: 212/255, blue: 226/255))

                        HStack(spacing: 6) {
                            Image("birthday")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 80, height: 100)

                            VStack(spacing: 0) {
                                Text(mascot.birthDay)
                                    .font(.custom("Jua-Regular", size: 28))
                                    .foregroundColor(primaryPink)
                                Text(mascot.birthMonth)
                                    .font(.custom("Jua-Regular", size: 14))
                                    .foregroundColor(primaryPink)
                            }
                        }
                        .padding(.horizontal, 10)
                    }
                    .frame(width: 140, height: 100)
                    .padding(.bottom, 35)

                    // Flowers image
                    Image("flowers")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 140, height: 30)
                }
                .frame(width: 140)
            }

            // Merchandise
            if let merch = mascot.merchandise_link,
               !merch.isEmpty,
               let url = URL(string: merch) {
                Link(destination: url) {
                    HStack(spacing: 12) {
                        Image("merch")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 60, height: 70)

                        ZStack {
                            RoundedRectangle(cornerRadius: 8)
                                .fill(secondBlue.opacity(0.3))
                                .frame(width: 60, height: 60)
                            Image(systemName: "cart.fill")
                                .foregroundColor(primaryBlue)
                                .font(.system(size: 30))
                        }
                        .frame(width: 60, height: 60)

                        VStack(alignment: .leading, spacing: 2) {
                            Text("Merchandise")
                                .font(.custom("Jua-Regular", size: 16))
                                .foregroundColor(primaryBlue)
                            Text("BUY NOW !!")
                                .font(.custom("Jua-Regular", size: 12))
                                .foregroundColor(primaryBlue)
                        }

                        Spacer()

                        Image(systemName: "arrow.up.right")
                            .foregroundColor(.gray)
                    }
                    .padding(14)
                    .background(secondBlue)
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                }
            }
        }
        .padding(.bottom, 20)
    }
}
