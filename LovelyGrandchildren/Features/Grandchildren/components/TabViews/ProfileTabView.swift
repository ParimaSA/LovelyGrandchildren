import SwiftUI

struct ProfileTabView: View {
    let mascot: Mascot
    let primaryBlue = Color(red: 126/255, green: 197/255, blue: 255/255)

//    private var formattedBirthday: String {
//        let f = DateFormatter()
//        f.dateFormat = "d MMMM yyyy"
//        f.calendar = Calendar(identifier: .gregorian)
//        f.locale = Locale(identifier: "en_GB")
//        return f.string(from: child.birthday)
//    }

    var body: some View {
        VStack(spacing: 14) {
            // Birthday
            HStack(spacing: 12) {
                Image(systemName: "birthday.cake.fill")
                    .foregroundColor(.pink)
                    .font(.system(size: 20))
                VStack(alignment: .leading, spacing: 2) {
                    Text("Birthday")
                        .font(.custom("Jua-Regular", size: 12))
                        .foregroundColor(.gray)
                    Text(mascot.birthDateFormatted)
                        .font(.custom("Jua-Regular", size: 16))
                        .foregroundColor(.black)
                }
                Spacer()
            }
            .padding(14)
            .background(.white)
            .clipShape(RoundedRectangle(cornerRadius: 16))

            // Socials
            VStack(alignment: .leading, spacing: 10) {
                Text("Official Accounts")
                    .font(.custom("Jua-Regular", size: 14))
                    .foregroundColor(.gray)

                ForEach(mascot.socials) { social in
                    Link(destination: URL(string: social.url)!) {
                        HStack(spacing: 12) {
                            ZStack {
                                Circle()
                                    .fill(social.platform.color)
                                    .frame(width: 36, height: 36)
                                Image(systemName: social.platform.icon)
                                    .font(.system(size: 16))
                                    .foregroundColor(.white)
                            }
                            VStack(alignment: .leading, spacing: 2) {
                                Text(social.platform.rawValue)
                                    .font(.custom("Jua-Regular", size: 12))
                                    .foregroundColor(.gray)
                                Text("@\(social.handle)")
                                    .font(.custom("Jua-Regular", size: 16))
                                    .foregroundColor(.black)
                            }
                            Spacer()
                            Image(systemName: "arrow.up.right")
                                .font(.system(size: 12))
                                .foregroundColor(.gray)
                        }
                        .padding(14)
                        .background(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                    }
                }
            }

            // Merchandise
            if let merch = mascot.merchandise_link, let url = URL(string: merch) {
                Link(destination: url) {
                    HStack(spacing: 12) {
                        Image(systemName: "cart.fill")
                            .font(.system(size: 20))
                            .foregroundColor(.white)
                        Text("Merchandise — BUY NOW !!")
                            .font(.custom("Jua-Regular", size: 16))
                            .foregroundColor(.white)
                        Spacer()
                        Image(systemName: "arrow.up.right")
                            .foregroundColor(.white.opacity(0.8))
                    }
                    .padding(16)
                    .background(primaryBlue)
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                }
            }
        }.padding(.bottom, 20)
    }
}
