import SwiftUI

struct SplashView: View {
    @State private var goToHome = false
    
    var body: some View {
        VStack {
            Image("start")
                .imageScale(.large)
                .foregroundStyle(.tint)
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                goToHome = true
            }
        }
        .fullScreenCover(isPresented: $goToHome) {
            HomeView()
        }
    }
}

#Preview {
    SplashView()
}
