import SwiftUI

struct HomeView: View {
    let primaryPink = Color(red: 230/255, green: 103/255, blue: 199/255)
    let primaryBlue = Color(red: 126/255, green: 197/255, blue: 255/255)

    var body: some View {
        NavigationStack {
            ZStack {
                Image("bg")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                
                ScrollView(showsIndicators: false) {
                    VStack() {
                        Spacer()
                            .frame(height: 200)
                        
                        Text("Lovely")
                            .font(.custom("LilyScriptOne-Regular", size: 40))
                            .foregroundColor(primaryPink)
                        
                        Text("Grandchildren")
                            .font(.custom("IrishGrover-Regular", size: 32))
                            .foregroundColor(primaryPink)
                        
                        Image("flowers")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(height: 30)
                        
                        Spacer().frame(height: 20)

                        // Grandchildren Section
                        HStack {
                            HStack(spacing: 8) {
                                Image("flower")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(height: 30)
                                Text("Grandchildren")
                                    .font(.custom("Jua-Regular", size: 24))
                                    .foregroundColor(.black)
                            }.padding(.horizontal, 10)
                            Spacer()
                            NavigationLink(destination: GrandchildrenView()) {
                                Text("see all")
                                    .font(.custom("Jua-Regular", size: 20))
                                    .foregroundColor(.white)
                                    .padding(.horizontal, 16)
                                    .padding(.vertical, 6)
                                    .background(
                                        UnevenRoundedRectangle(
                                            topLeadingRadius: 14,
                                            bottomLeadingRadius: 14,
                                            bottomTrailingRadius: 0,
                                            topTrailingRadius: 0
                                        ).fill(primaryBlue)
                                    )
                            }
                        }

                        GrandchildBoxesSection()
                            .frame(height: 126)
                            .frame(maxWidth: UIScreen.main.bounds.width)

                        // Event Section
                        HStack {
                            HStack(spacing: 8) {
                                Image("flower")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(height: 30)
                                Text("Events")
                                    .font(.custom("Jua-Regular", size: 24))
                                    .foregroundColor(.black)
                            }.padding(.horizontal, 10)
                            Spacer()
                            NavigationLink(destination: EventsView()) {
                                Text("see all")
                                    .font(.custom("Jua-Regular", size: 20))
                                    .foregroundColor(.white)
                                    .padding(.horizontal, 16)
                                    .padding(.vertical, 6)
                                    .background(
                                        UnevenRoundedRectangle(
                                            topLeadingRadius: 14,
                                            bottomLeadingRadius: 14,
                                            bottomTrailingRadius: 0,
                                            topTrailingRadius: 0
                                        ).fill(primaryBlue)
                                    )
                            }
                        }.padding(.vertical, 12)

                        RecentEvents()
                            .padding(.horizontal, 8)

                        Spacer().frame(height: 40)
                    }
                }
            }
        }
    }
}

#Preview {
    HomeView()
}
