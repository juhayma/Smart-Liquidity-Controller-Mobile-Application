import SwiftUI
import Foundation

// MARK: - Color Extensions
extension Color {
    static let darkBackground = Color(red: 0.05, green: 0.05, blue: 0.05)
    static let cardBackground = Color(red: 0.1, green: 0.1, blue: 0.1)
    
    // ألوان بنك الإنماء
    static let alinmaDarkBlue = Color(red: 0.0, green: 0.2, blue: 0.4)
    static let alinmaLightGray = Color(red: 0.9, green: 0.9, blue: 0.9)
    static let alinmaGold = Color(red: 0.8, green: 0.6, blue: 0.2)
    
    // ألوان حالة المخاطر
    static let riskHigh = Color.red
    static let riskMedium = Color.orange
    static let riskLow = Color.yellow
    static let riskSafe = Color.green
    
    // إنشاء لون من Hex
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }

        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue:  Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}

// MARK: - DateFormatter Extensions
extension DateFormatter {
    static let arabicDate: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ar_SA")
        formatter.dateStyle = .medium
        return formatter
    }()
    
    static let shortArabicDate: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ar_SA")
        formatter.dateStyle = .short
        return formatter
    }()
    
    static let arabicTime: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ar_SA")
        formatter.timeStyle = .short
        return formatter
    }()
    
    static let arabicDateTime: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ar_SA")
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter
    }()
    
    static let monthYear: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ar_SA")
        formatter.dateFormat = "MMMM yyyy"
        return formatter
    }()
}

// MARK: - Double Extensions
extension Double {
    // تنسيق العملة السعودية
    func formattedCurrency() -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = Locale(identifier: "ar_SA")
        formatter.currencyCode = "SAR"
        formatter.currencySymbol = "ر.س"
        return formatter.string(from: NSNumber(value: self)) ?? "\(self) ر.س"
    }
    
    // تنسيق الأرقام مع الفواصل
    func formattedWithCommas() -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.locale = Locale(identifier: "ar_SA")
        return formatter.string(from: NSNumber(value: self)) ?? "\(self)"
    }
    
    // تنسيق النسبة المئوية
    func formattedPercentage() -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .percent
        formatter.locale = Locale(identifier: "ar_SA")
        formatter.minimumFractionDigits = 1
        formatter.maximumFractionDigits = 1
        return formatter.string(from: NSNumber(value: self)) ?? "\(Int(self * 100))%"
    }
    
    // تقريب لأقرب رقمين عشريين
    func rounded(toPlaces places: Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}

// MARK: - String Extensions
extension String {
    // التحقق من صحة الهوية الوطنية السعودية
    var isValidSaudiID: Bool {
        return self.count == 10 && self.allSatisfy { $0.isNumber }
    }
    
    // التحقق من صحة رقم الجوال السعودي
    var isValidSaudiPhone: Bool {
        let phoneRegex = "^(\\+966|0)?5[0-9]{8}$"
        let phonePredicate = NSPredicate(format: "SELF MATCHES %@", phoneRegex)
        return phonePredicate.evaluate(with: self)
    }
    
    // التحقق من صحة البريد الإلكتروني
    var isValidEmail: Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: self)
    }
    
    // إزالة المسافات الزائدة
    var trimmed: String {
        return self.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    // تحويل إلى رقم آمن
    var doubleValue: Double {
        return Double(self) ?? 0.0
    }
    
    var intValue: Int {
        return Int(self) ?? 0
    }
}

// MARK: - Date Extensions
extension Date {
    // الحصول على بداية اليوم
    var startOfDay: Date {
        return Calendar.current.startOfDay(for: self)
    }
    
    // الحصول على نهاية اليوم
    var endOfDay: Date {
        var components = DateComponents()
        components.day = 1
        components.second = -1
        return Calendar.current.date(byAdding: components, to: startOfDay) ?? self
    }
    
    // الحصول على بداية الشهر
    var startOfMonth: Date {
        let components = Calendar.current.dateComponents([.year, .month], from: self)
        return Calendar.current.date(from: components) ?? self
    }
    
    // الحصول على نهاية الشهر
    var endOfMonth: Date {
        var components = DateComponents()
        components.month = 1
        components.second = -1
        return Calendar.current.date(byAdding: components, to: startOfMonth) ?? self
    }
    
    // التحقق من كون التاريخ اليوم
    var isToday: Bool {
        return Calendar.current.isDateInToday(self)
    }
    
    // التحقق من كون التاريخ أمس
    var isYesterday: Bool {
        return Calendar.current.isDateInYesterday(self)
    }
    
    // الحصول على اسم الشهر بالعربية
    var arabicMonthName: String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ar_SA")
        formatter.dateFormat = "MMMM"
        return formatter.string(from: self)
    }
    
    // الحصول على اسم اليوم بالعربية
    var arabicDayName: String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ar_SA")
        formatter.dateFormat = "EEEE"
        return formatter.string(from: self)
    }
}

// MARK: - View Extensions
extension View {
    // إضافة حدود مخصصة
    func border(_ color: Color, width: CGFloat, cornerRadius: CGFloat) -> some View {
        self.overlay(
            RoundedRectangle(cornerRadius: cornerRadius)
                .stroke(color, lineWidth: width)
        )
    }
    
    // إضافة ظل مخصص
    func cardShadow() -> some View {
        self.shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
    }
    
    // إخفاء/إظهار بناءً على شرط
    @ViewBuilder
    func hidden(_ hidden: Bool) -> some View {
        if hidden {
            self.hidden()
        } else {
            self
        }
    }
    
    // تطبيق المظهر الكحلي الغامق
    func alinmaStyle() -> some View {
        self
            .foregroundColor(.white)
            .background(Color.black)
            .preferredColorScheme(.dark)
    }
}

// MARK: - Array Extensions
extension Array where Element == CashFlowData {
    // حساب أعلى قيمة
    var maxCashBalance: Double {
        return self.map { $0.cashBalance }.max() ?? 0
    }
    
    // حساب أقل قيمة
    var minCashBalance: Double {
        return self.map { $0.cashBalance }.min() ?? 0
    }
    
    // حساب المتوسط
    var averageCashBalance: Double {
        guard !self.isEmpty else { return 0 }
        let sum = self.map { $0.cashBalance }.reduce(0, +)
        return sum / Double(self.count)
    }
}

extension Array where Element == Budget {
    // حساب إجمالي المبالغ
    var totalAmount: Double {
        return self.map { $0.amount }.reduce(0, +)
    }
    
    // حساب متوسط التقدم
    var averageProgress: Double {
        guard !self.isEmpty else { return 0 }
        let sum = self.map { $0.progress }.reduce(0, +)
        return sum / Double(self.count)
    }
}

// MARK: - Notification Extensions
extension Notification.Name {
    static let userDidLogin = Notification.Name("userDidLogin")
    static let userDidLogout = Notification.Name("userDidLogout")
    static let budgetCreated = Notification.Name("budgetCreated")
    static let expenseAdded = Notification.Name("expenseAdded")
    static let alertReceived = Notification.Name("alertReceived")
}
