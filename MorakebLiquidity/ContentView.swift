import SwiftUI

struct ContentView: View {
    @State private var showingSplash = true
    
    var body: some View {
        if showingSplash {
            SplashView()
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                        withAnimation(.easeInOut(duration: 0.5)) {
                            showingSplash = false
                        }
                    }
                }
        } else {
            WelcomeView()
        }
    }
}

