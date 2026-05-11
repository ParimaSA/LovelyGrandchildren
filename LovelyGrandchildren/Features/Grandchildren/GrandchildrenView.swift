import SwiftUI

struct GrandchildrenView: View {
    let primaryPink = Color(red: 230/255, green: 103/255, blue: 199/255)
    let primaryBlue = Color(red: 126/255, green: 197/255, blue: 255/255)

    @State private var searchText: String = ""

    // firebase
    @StateObject private var service = FirestoreService()
    
    private var filtered: [Mascot] {
        if searchText.trimmingCharacters(in: .whitespaces).isEmpty {
            return service.mascots
        }
        return service.mascots.filter {
            $0.name.localizedCaseInsensitiveContains(searchText)
        }
    }
    
    var body: some View {
        ZStack {
            Image("bg")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
                .frame(maxWidth: .infinity, maxHeight: .infinity)

            VStack(spacing: 0) {
                Spacer()
                    .frame(height: 200)

                // Header
                Text("Grandchildren")
                    .font(.custom("IrishGrover-Regular", size: 32))
                    .foregroundColor(primaryPink)

                Image("flowers")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 30)

                Spacer().frame(height: 20)

                // Search bar
                HStack(spacing: 10) {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.gray)

                    TextField("Search by name...", text: $searchText)
                        .font(.custom("Jua-Regular", size: 16))
                        .autocorrectionDisabled()
                }
                    .padding(.horizontal, 14)
                    .padding(.vertical, 10)
                    .background(.white.opacity(0.85))
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                    .padding(.horizontal, 20)

                // Grid or empty state
                if filtered.isEmpty {
                    Spacer()
                    VStack(spacing: 6) {
                        Image(systemName: "magnifyingglass")
                            .font(.system(size: 48))
                            .foregroundColor(.gray.opacity(0.5))
                        Text("No grandchildren found")
                            .font(.custom("Jua-Regular", size: 18))
                            .foregroundColor(.gray)
                    }
                    Spacer()
                } else {
                    ScrollView {
                        LazyVGrid(
                            columns: [GridItem(.flexible()), GridItem(.flexible())],
                            spacing: 16
                        ) {
                            ForEach(filtered) { mascot in
                                NavigationLink(destination: GrandchildDetailView(mascot: mascot)) {
                                    GrandchildBox(mascot: mascot, boxSize: 150)
                                }
                                .buttonStyle(.plain)
                            }
                        }
                        .padding(.horizontal, 40)
                        .padding(.vertical, 16)
                        .padding(.bottom, 60)
                    }
                }
            }
        }
        .navigationTitle("")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            service.fetchMascots()
        }
    }
}

#Preview {
    NavigationStack {
        GrandchildrenView()
    }
}
