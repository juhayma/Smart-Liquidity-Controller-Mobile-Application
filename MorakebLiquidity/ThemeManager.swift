import SwiftUI

class ThemeManager: ObservableObject {
    @Published var isDarkMode = true
    
    var backgroundColor: Color {
        isDarkMode ? Color.black : Color.white
    }
    
    var primaryTextColor: Color {
        isDarkMode ? Color.white : Color.black
    }
    
    var secondaryTextColor: Color {
        isDarkMode ? Color.white.opacity(0.8) : Color.black.opacity(0.6)
    }
    
    var cardBackgroundColor: Color {
        isDarkMode ? Color.gray.opacity(0.1) : Color.gray.opacity(0.05)
    }
    
    var borderColor: Color {
        isDarkMode ? Color.white.opacity(0.2) : Color.black.opacity(0.1)
    }
    
    var accentColor: Color {
        Color.white
    }
    
    var successColor: Color {
        Color.green
    }
    
    var warningColor: Color {
        Color.orange
    }
    
    var errorColor: Color {
        Color.red
    }
    
    var infoColor: Color {
        Color.blue
    }
    
    // ألوان خاصة ببنك الإنماء
    var alinmaPrimaryColor: Color {
        Color(red: 0.0, green: 0.2, blue: 0.4) // كحلي غامق
    }
    
    var alinmaSecondaryColor: Color {
        Color(red: 0.9, green: 0.9, blue: 0.9) // رمادي فاتح
    }
    
    var alinmaGoldColor: Color {
        Color(red: 0.8, green: 0.6, blue: 0.2) // ذهبي
    }
    
    // تدرجات الألوان
    var backgroundGradient: LinearGradient {
        LinearGradient(
            gradient: Gradient(colors: [Color.black, Color.gray.opacity(0.8)]),
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
    }
    
    var cardGradient: LinearGradient {
        LinearGradient(
            gradient: Gradient(colors: [Color.gray.opacity(0.1), Color.gray.opacity(0.05)]),
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
    }
    
    // أحجام الخطوط
    var largeTitleFont: Font {
        .system(size: 34, weight: .bold, design: .default)
    }
    
    var titleFont: Font {
        .system(size: 28, weight: .bold, design: .default)
    }
    
    var headlineFont: Font {
        .system(size: 17, weight: .semibold, design: .default)
    }
    
    var bodyFont: Font {
        .system(size: 17, weight: .regular, design: .default)
    }
    
    var captionFont: Font {
        .system(size: 12, weight: .regular, design: .default)
    }
    
    // الأبعاد والمسافات
    var cornerRadius: CGFloat {
        15
    }
    
    var smallCornerRadius: CGFloat {
        8
    }
    
    var buttonHeight: CGFloat {
        55
    }
    
    var cardPadding: CGFloat {
        20
    }
    
    var defaultSpacing: CGFloat {
        20
    }
    
    var smallSpacing: CGFloat {
        10
    }
    
    // الظلال
    var cardShadow: Color {
        isDarkMode ? Color.white.opacity(0.1) : Color.black.opacity(0.1)
    }
    
    var shadowRadius: CGFloat {
        5
    }
    
    // تبديل المظهر
    func toggleTheme() {
        withAnimation(.easeInOut(duration: 0.3)) {
            isDarkMode.toggle()
        }
    }
    
    // إعداد المظهر المظلم
    func setDarkMode() {
        withAnimation(.easeInOut(duration: 0.3)) {
            isDarkMode = true
        }
    }
    
    // إعداد المظهر الفاتح
    func setLightMode() {
        withAnimation(.easeInOut(duration: 0.3)) {
            isDarkMode = false
        }
    }
}
