//
//  ContentView.swift
//  LovelyGrandchildren
//
//  Created by Tho Sangsirakoup on 17/3/2569 BE.
//

import SwiftUI

struct IntroView: View {
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
    IntroView()
}
