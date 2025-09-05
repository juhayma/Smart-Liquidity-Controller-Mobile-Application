import Foundation
import UIKit

struct ValidationHelper {
    
    // MARK: - الهوية الوطنية السعودية
    static func isValidNationalID(_ id: String) -> Bool {
        // التحقق من الطول (10 أرقام)
        guard id.count == 10, id.allSatisfy({ $0.isNumber }) else {
            return false
        }
        
        // التحقق من الخوارزمية السعودية للهوية الوطنية
        let digits = id.compactMap { Int(String($0)) }
        var sum = 0
        
        for i in 0..<9 {
            if i % 2 == 0 {
                // الأرقام في المواضع الفردية (1، 3، 5، 7، 9)
                let doubled = digits[i] * 2
                sum += doubled > 9 ? doubled - 9 : doubled
            } else {
                // الأرقام في المواضع الزوجية (2، 4، 6، 8)
                sum += digits[i]
            }
        }
        
        let checkDigit = (10 - (sum % 10)) % 10
        return checkDigit == digits[9]
    }
    
    // MARK: - الرقم الوظيفي لبنك الإنماء
    static func isValidEmployeeID(_ id: String) -> Bool {
        // يجب أن يبدأ بـ "Alinma" ويكون طوله أكثر من 10 أحرف
        return id.hasPrefix("Alinma") && id.count >= 10 && id.count <= 20
    }
    
    // MARK: - رقم الجوال السعودي
    static func isValidSaudiPhoneNumber(_ phone: String) -> Bool {
        // إزالة المسافات والرموز
        let cleanPhone = phone.replacingOccurrences(of: " ", with: "")
            .replacingOccurrences(of: "-", with: "")
            .replacingOccurrences(of: "(", with: "")
            .replacingOccurrences(of: ")", with: "")
        
        // الأنماط المقبولة:
        // 05xxxxxxxx (10 أرقام)
        // +9665xxxxxxxx (13 رقم مع كود الدولة)
        // 00966xxxxxxxx (14 رقم مع كود الدولة)
        
        let patterns = [
            "^05[0-9]{8}$",                    // 05xxxxxxxx
            "^\\+9665[0-9]{8}$",              // +9665xxxxxxxx
            "^009665[0-9]{8}$",               // 009665xxxxxxxx
            "^9665[0-9]{8}$"                  // 9665xxxxxxxx
        ]
        
        for pattern in patterns {
            let regex = try? NSRegularExpression(pattern: pattern)
            let range = NSRange(location: 0, length: cleanPhone.count)
            if regex?.firstMatch(in: cleanPhone, options: [], range: range) != nil {
                return true
            }
        }
        
        return false
    }
    
    // MARK: - البريد الإلكتروني
    static func isValidEmail(_ email: String) -> Bool {
        let emailRegex = "^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}$"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }
    
    // MARK: - كلمة المرور
    static func isValidPassword(_ password: String) -> Bool {
        // كلمة المرور يجب أن تكون على الأقل 4 أحرف (للتجربة)
        // في الإنتاج: 8 أحرف على الأقل مع أحرف كبيرة وصغيرة ورقم
        return password.count >= 4
    }
    
    static func isStrongPassword(_ password: String) -> Bool {
        // كلمة مرور قوية: 8 أحرف على الأقل، حرف كبير، حرف صغير، رقم، رمز خاص
        let minLength = password.count >= 8
        let hasUppercase = password.rangeOfCharacter(from: CharacterSet.uppercaseLetters) != nil
        let hasLowercase = password.rangeOfCharacter(from: CharacterSet.lowercaseLetters) != nil
        let hasNumbers = password.rangeOfCharacter(from: CharacterSet.decimalDigits) != nil
        let hasSpecialCharacters = password.rangeOfCharacter(from: CharacterSet(charactersIn: "!@#$%^&*()_+-=[]{}|;:,.<>?")) != nil
        
        return minLength && hasUppercase && hasLowercase && hasNumbers && hasSpecialCharacters
    }
    
    // MARK: - المبالغ المالية
    static func isValidAmount(_ amount: String) -> Bool {
        guard let value = Double(amount), value > 0 else {
            return false
        }
        
        // التحقق من أن المبلغ ليس أكبر من حد معقول (مليار ريال)
        return value <= 1_000_000_000
    }
    
    static func isValidBudgetAmount(_ amount: String) -> Bool {
        guard let value = Double(amount), value >= 100 else {
            return false
        }
        
        // الحد الأدنى للميزانية: 100 ريال
        // الحد الأقصى: 10 مليون ريال
        return value >= 100 && value <= 10_000_000
    }
    
    // MARK: - رقم الحساب المصرفي السعودي (IBAN)
    static func isValidSaudiIBAN(_ iban: String) -> Bool {
        // إزالة المسافات
        let cleanIBAN = iban.replacingOccurrences(of: " ", with: "").uppercased()
        
        // التحقق من أن IBAN سعودي (يبدأ بـ SA ويتبعه 22 رقم)
        guard cleanIBAN.hasPrefix("SA") && cleanIBAN.count == 24 else {
            return false
        }
        
        // التحقق من صحة أرقام IBAN
        let numbers = String(cleanIBAN.dropFirst(2))
        return numbers.allSatisfy { $0.isNumber }
    }
    
    // MARK: - أرقام الحسابات المصرفية التقليدية
    static func isValidAccountNumber(_ accountNumber: String) -> Bool {
        // رقم حساب مصرفي: 10-16 رقم
        let cleanNumber = accountNumber.replacingOccurrences(of: " ", with: "")
        return cleanNumber.count >= 10 &&
               cleanNumber.count <= 16 &&
               cleanNumber.allSatisfy { $0.isNumber }
    }
    
    // MARK: - رمز التحقق
    static func isValidVerificationCode(_ code: String) -> Bool {
        // رمز التحقق: 4-6 أرقام
        return code.count >= 4 &&
               code.count <= 6 &&
               code.allSatisfy { $0.isNumber }
    }
    
    // MARK: - التواريخ
    static func isValidDate(_ date: Date) -> Bool {
        let now = Date()
        let calendar = Calendar.current
        
        // التحقق من أن التاريخ ليس في المستقبل البعيد (أكثر من سنة)
        let oneYearFromNow = calendar.date(byAdding: .year, value: 1, to: now) ?? now
        
        // التحقق من أن التاريخ ليس في الماضي البعيد (أكثر من 100 سنة)
        let hundredYearsAgo = calendar.date(byAdding: .year, value: -100, to: now) ?? now
        
        return date >= hundredYearsAgo && date <= oneYearFromNow
    }
    
    static func isValidBirthDate(_ date: Date) -> Bool {
        let now = Date()
        let calendar = Calendar.current
        
        // العمر يجب أن يكون بين 18-120 سنة
        let eighteenYearsAgo = calendar.date(byAdding: .year, value: -18, to: now) ?? now
        let hundredTwentyYearsAgo = calendar.date(byAdding: .year, value: -120, to: now) ?? now
        
        return date >= hundredTwentyYearsAgo && date <= eighteenYearsAgo
    }
    
    // MARK: - أسماء المستخدمين
    static func isValidUsername(_ username: String) -> Bool {
        // اسم المستخدم: 3-20 حرف، أحرف عربية أو إنجليزية أو أرقام
        let trimmedUsername = username.trimmingCharacters(in: .whitespacesAndNewlines)
        
        guard trimmedUsername.count >= 3 && trimmedUsername.count <= 20 else {
            return false
        }
        
        // السماح بالأحرف العربية والإنجليزية والأرقام والمسافات
        let allowedCharacters = CharacterSet.letters
            .union(CharacterSet.decimalDigits)
            .union(CharacterSet.whitespaces)
        
        return trimmedUsername.unicodeScalars.allSatisfy { allowedCharacters.contains($0) }
    }
    
    // MARK: - مدة الميزانية
    static func isValidBudgetDuration(_ months: Int) -> Bool {
        // مدة الميزانية: 1-12 شهر (حسب قيود الزكاة)
        return months >= 1 && months <= 12
    }
    
    // MARK: - فئات المصروفات
    static func isValidExpenseCategory(_ category: String) -> Bool {
        let validCategories = [
            "طعام", "مواصلات", "ترفيه", "تسوق", "صحة", "تعليم",
            "منزل", "فواتير", "سفر", "ملابس", "هدايا", "أخرى"
        ]
        
        return validCategories.contains(category)
    }
    
    // MARK: - مستويات المخاطر
    static func isValidRiskLevel(_ riskLevel: String) -> Bool {
        let validRiskLevels = ["منخفض", "متوسط", "مرتفع", "حرج"]
        return validRiskLevels.contains(riskLevel)
    }
    
    // MARK: - تنسيق العملة
    static func formatCurrency(_ amount: Double) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        formatter.locale = Locale(identifier: "ar_SA")
        
        guard let formattedAmount = formatter.string(from: NSNumber(value: amount)) else {
            return "0.00"
        }
        
        return "\(formattedAmount) ر.س"
    }
    
    static func formatCurrencyShort(_ amount: Double) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 0
        formatter.locale = Locale(identifier: "ar_SA")
        
        if amount >= 1_000_000 {
            let millions = amount / 1_000_000
            return String(format: "%.1f مليون ر.س", millions)
        } else if amount >= 1_000 {
            let thousands = amount / 1_000
            return String(format: "%.1f ألف ر.س", thousands)
        } else {
            return "\(Int(amount)) ر.س"
        }
    }
    
    // MARK: - تنسيق النسب المئوية
    static func formatPercentage(_ value: Double) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .percent
        formatter.minimumFractionDigits = 1
        formatter.maximumFractionDigits = 1
        formatter.locale = Locale(identifier: "ar_SA")
        
        return formatter.string(from: NSNumber(value: value)) ?? "0%"
    }
    
    // MARK: - تنظيف النصوص
    static func cleanText(_ text: String) -> String {
        return text.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    static func sanitizeInput(_ input: String) -> String {
        // إزالة الأحرف الضارة والرموز الخاصة
        let allowedCharacters = CharacterSet.letters
            .union(CharacterSet.decimalDigits)
            .union(CharacterSet.whitespaces)
            .union(CharacterSet(charactersIn: ".,@-_"))
        
        return String(input.unicodeScalars.filter { allowedCharacters.contains($0) })
    }
    
    // MARK: - رسائل الأخطاء
    static func getValidationErrorMessage(for field: ValidationField, value: String) -> String? {
        switch field {
        case .nationalID:
            if !isValidNationalID(value) {
                return "الهوية الوطنية يجب أن تكون 10 أرقام صحيحة"
            }
        case .employeeID:
            if !isValidEmployeeID(value) {
                return "الرقم الوظيفي غير صحيح"
            }
        case .email:
            if !isValidEmail(value) {
                return "البريد الإلكتروني غير صحيح"
            }
        case .phoneNumber:
            if !isValidSaudiPhoneNumber(value) {
                return "رقم الجوال غير صحيح"
            }
        case .password:
            if !isValidPassword(value) {
                return "كلمة المرور يجب أن تكون 4 أحرف على الأقل"
            }
        case .amount:
            if !isValidAmount(value) {
                return "المبلغ غير صحيح"
            }
        case .accountNumber:
            if !isValidAccountNumber(value) {
                return "رقم الحساب يجب أن يكون 10-16 رقم"
            }
        case .verificationCode:
            if !isValidVerificationCode(value) {
                return "رمز التحقق يجب أن يكون 4-6 أرقام"
            }
        case .username:
            if !isValidUsername(value) {
                return "اسم المستخدم يجب أن يكون 3-20 حرف"
            }
        }
        
        return nil
    }
    
    // MARK: - تحويل آمن للأرقام
    static func safeDoubleConversion(_ text: String) -> Double? {
        // إزالة الفواصل والرموز
        let cleanText = text.replacingOccurrences(of: ",", with: "")
            .replacingOccurrences(of: "ر.س", with: "")
            .replacingOccurrences(of: " ", with: "")
            .trimmingCharacters(in: .whitespacesAndNewlines)
        
        return Double(cleanText)
    }
    
    static func safeIntConversion(_ text: String) -> Int? {
        let cleanText = text.replacingOccurrences(of: ",", with: "")
            .replacingOccurrences(of: " ", with: "")
            .trimmingCharacters(in: .whitespacesAndNewlines)
        
        return Int(cleanText)
    }
    
    // MARK: - التحقق من الاتصال بالإنترنت (اختياري)
    static func isConnectedToNetwork() -> Bool {
        // يمكن تطويره لاحقاً للتحقق من الاتصال
        return true
    }
    
    // MARK: - التحقق من قوة كلمة المرور
    static func getPasswordStrength(_ password: String) -> PasswordStrength {
        if isStrongPassword(password) {
            return .strong
        } else if password.count >= 6 {
            return .medium
        } else if password.count >= 4 {
            return .weak
        } else {
            return .veryWeak
        }
    }
}

// MARK: - Enums مساعدة
enum ValidationField {
    case nationalID
    case employeeID
    case email
    case phoneNumber
    case password
    case amount
    case accountNumber
    case verificationCode
    case username
}

enum PasswordStrength {
    case veryWeak
    case weak
    case medium
    case strong
    
    var description: String {
        switch self {
        case .veryWeak:
            return "ضعيفة جداً"
        case .weak:
            return "ضعيفة"
        case .medium:
            return "متوسطة"
        case .strong:
            return "قوية"
        }
    }
    
    var color: UIColor {
        switch self {
        case .veryWeak:
            return .systemRed
        case .weak:
            return .systemOrange
        case .medium:
            return .systemYellow
        case .strong:
            return .systemGreen
        }
    }
}
