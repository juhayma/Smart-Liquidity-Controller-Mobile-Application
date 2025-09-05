import SwiftUI

struct WelcomeView: View {
    @State private var showingLogin = false
    
    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(
                    gradient: Gradient(colors: [Color.black, Color.gray.opacity(0.8)]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()
                
                VStack(spacing: 40) {
                    Spacer()
                    
                    // شعار بنك الإنماء
                    VStack(spacing: 20) {
                        Image(systemName: "building.columns.fill")
                            .font(.system(size: 100))
                            .foregroundColor(.white)
                        
                        Text("مرحباً بك")
                            .font(.system(size: 36, weight: .bold))
                            .foregroundColor(.white)
                        
                        Text("مراقبك الذكي لسيولة البنوك في السعودية")
                            .font(.system(size: 16))
                            .foregroundColor(.white.opacity(0.8))
                            .multilineTextAlignment(.center)
                            .padding(.horizontal)
                    }
                    
                    Spacer()
                    
                    // زر البدء
                    Button(action: {
                        showingLogin = true
                    }) {
                        Text("ابدأ الآن")
                            .font(.title2)
                            .fontWeight(.semibold)
                            .foregroundColor(.black)
                            .frame(maxWidth: .infinity)
                            .frame(height: 55)
                            .background(Color.white)
                            .cornerRadius(15)
                            .shadow(color: .white.opacity(0.3), radius: 10, x: 0, y: 5)
                    }
                    .padding(.horizontal, 30)
                    
                    Spacer()
                    
                    // أيقونات التواصل
                    HStack(spacing: 30) {
                        Image(systemName: "globe")
                            .font(.title2)
                            .foregroundColor(.white.opacity(0.7))
                        
                        Image(systemName: "envelope.fill")
                            .font(.title2)
                            .foregroundColor(.white.opacity(0.7))
                    }
                    .padding(.bottom, 50)
                }
            }
        }
        .environment(\.layoutDirection, .rightToLeft)
        .sheet(isPresented: $showingLogin) {
            LoginView()
        }
    }
}

