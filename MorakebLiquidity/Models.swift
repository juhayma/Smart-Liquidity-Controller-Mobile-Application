import SwiftUI

struct User: Identifiable {
    let id = UUID()
    let userID: Int
    let nationalID: String
    let fullName: String
    let role: String
    let employeeID: String?
    let isGuest: Bool
    let isVerifiedViaNafath: Bool
    let totalBalance: Double
    
    init(from dbResult: [String: Any]) {
        self.userID = dbResult["UserID"] as? Int ?? 0
        self.nationalID = dbResult["NationalID"] as? String ?? ""
        self.fullName = dbResult["FullName"] as? String ?? ""
        self.role = dbResult["Role"] as? String ?? ""
        self.employeeID = dbResult["EmployeeID"] as? String
        self.isGuest = dbResult["Role"] as? String == "زائر"
        self.isVerifiedViaNafath = dbResult["IsVerifiedViaNafath"] as? Int == 1
        self.totalBalance = dbResult["TotalBalance"] as? Double ?? Double.random(in: 1000...50000)
    }
    
    init(userID: Int, nationalID: String, fullName: String, role: String, employeeID: String?, isGuest: Bool, isVerifiedViaNafath: Bool, totalBalance: Double) {
        self.userID = userID
        self.nationalID = nationalID
        self.fullName = fullName
        self.role = role
        self.employeeID = employeeID
        self.isGuest = isGuest
        self.isVerifiedViaNafath = isVerifiedViaNafath
        self.totalBalance = totalBalance
    }
    
    static let sampleEmployee = User(
        userID: 5,
        nationalID: "1122334466",
        fullName: "فهد السبيعي",
        role: "موظف",
        employeeID: "Alinma1000200030",
        isGuest: false,
        isVerifiedViaNafath: true,
        totalBalance: 0
    )
    
    static let sampleClient = User(
        userID: 1,
        nationalID: "1120831134",
        fullName: "جهيما",
        role: "عميل",
        employeeID: nil,
        isGuest: false,
        isVerifiedViaNafath: false,
        totalBalance: 45230.50
    )
}

struct Alert: Identifiable {
    let id = UUID()
    let alertID: Int
    let userID: Int
    let alertType: String
    let riskLevel: String
    let message: String
    let createdAt: String
}

struct Budget: Identifiable {
    let id = UUID()
    let budgetID: Int
    let userID: Int
    let budgetName: String
    let duration: Int
    let amount: Double
    let createdAt: String
    let progress: Double
}

struct Transaction: Identifiable {
    let id = UUID()
    let amount: Double
    let description: String
    let category: String
    let date: Date
}

struct CashFlowData: Identifiable {
    let id = UUID()
    let month: Int
    let year: Int
    let cashBalance: Double
}

// فقط ScenarioResult واحد
struct ScenarioResult: Identifiable {
    let id = UUID()
    let month: Int
    let impact: Double
}
