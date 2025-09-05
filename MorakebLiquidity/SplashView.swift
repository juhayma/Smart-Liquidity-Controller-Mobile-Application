import SwiftUI

struct SplashView: View {
    @State private var animate = false
    
    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()
            
            VStack(spacing: 30) {
                // شعار بنك الإنماء
                Image(systemName: "building.columns.fill")
                    .font(.system(size: 80))
                    .foregroundColor(.white)
                    .scaleEffect(animate ? 1.2 : 0.8)
                    .animation(.easeInOut(duration: 1.5).repeatForever(autoreverses: true), value: animate)
                
                Text("بنك الإنماء")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .opacity(animate ? 1 : 0.3)
                    .animation(.easeInOut(duration: 2), value: animate)
            }
        }
        .onAppear {
            animate = true
        }
    }
}
