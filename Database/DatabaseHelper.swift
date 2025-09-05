import Foundation
import SQLite3

class DatabaseHelper {
    static let shared = DatabaseHelper()
    var db: OpaquePointer?

    private init() {
        openDatabase()
    }
    
    static func copyDatabaseIfNeeded() {
        let fileManager = FileManager.default
        let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        let destinationPath = "\(documentsPath)/LG.database.db"
        
        if !fileManager.fileExists(atPath: destinationPath) {
            if let bundlePath = Bundle.main.path(forResource: "LG.database", ofType: "db") {
                do {
                    try fileManager.copyItem(atPath: bundlePath, toPath: destinationPath)
                    print("✅ Database copied to Documents directory successfully.")
                } catch {
                    print("❌ Failed to copy database: \(error)")
                }
            } else {
                print("❌ Database file not found in bundle.")
            }
        } else {
            print("✅ Database already exists in Documents directory.")
        }
    }

    func openDatabase() {
        let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        let dbPath = "\(documentsPath)/LG.database.db"
        
        if sqlite3_open(dbPath, &db) != SQLITE_OK {
            print("❌ Failed to open database at: \(dbPath)")
            
            // محاولة فتح من Bundle كبديل
            if let bundlePath = Bundle.main.path(forResource: "LG.database", ofType: "db") {
                if sqlite3_open(bundlePath, &db) == SQLITE_OK {
                    print("✅ Database opened from bundle successfully.")
                } else {
                    print("❌ Failed to open database from bundle too.")
                }
            }
        } else {
            print("✅ Database opened from Documents directory successfully.")
        }
    }

    func loginUser(id: String, password: String, role: String) -> [String: Any]? {
        guard let database = db else {
            print("❌ Database is nil")
            return nil
        }
        
        print("🔍 البحث في قاعدة البيانات...")
        print("المعرف: '\(id)'")
        print("كلمة المرور: '\(password)'")
        print("الدور: '\(role)'")
        
        var query: String = ""
        if role == "موظف" {
            query = "SELECT UserID, FullName, Role, EmployeeID, NationalID, Password FROM Users WHERE EmployeeID = ? AND Password = ?"
        } else if role == "عميل" {
            query = "SELECT UserID, FullName, Role, EmployeeID, NationalID, Password FROM Users WHERE NationalID = ? AND Password = ?"
        } else {
            return ["Role": "زائر", "UserID": 0, "FullName": "زائر", "NationalID": ""]
        }
        
        print("🔍 الاستعلام: \(query)")
        
        var statement: OpaquePointer?
        
        if sqlite3_prepare_v2(database, query, -1, &statement, nil) == SQLITE_OK {
            print("✅ تم تحضير الاستعلام بنجاح")
            
            // ربط المعاملات
            sqlite3_bind_text(statement, 1, id, -1, nil)
            sqlite3_bind_text(statement, 2, password, -1, nil)
            
            print("✅ تم ربط المعاملات")
            
            if sqlite3_step(statement) == SQLITE_ROW {
                print("✅ تم العثور على نتيجة!")
                
                let userId = sqlite3_column_int(statement, 0)
                let fullName = String(cString: sqlite3_column_text(statement, 1))
                let userRole = String(cString: sqlite3_column_text(statement, 2))
                let employeeID = sqlite3_column_text(statement, 3) != nil ? String(cString: sqlite3_column_text(statement, 3)) : nil
                let nationalID = String(cString: sqlite3_column_text(statement, 4))
                
                print("📊 البيانات المُسترجعة:")
                print("UserID: \(userId)")
                print("FullName: \(fullName)")
                print("Role: \(userRole)")
                print("EmployeeID: \(employeeID ?? "nil")")
                print("NationalID: \(nationalID)")
                
                sqlite3_finalize(statement)
                
                return [
                    "UserID": Int(userId),
                    "FullName": fullName,
                    "Role": userRole,
                    "EmployeeID": employeeID as Any,
                    "NationalID": nationalID
                ]
            } else {
                print("❌ لم يتم العثور على نتائج")
                
                // طباعة جميع المستخدمين للتشخيص
                printAllUsers()
            }
        } else {
            print("❌ فشل في تحضير الاستعلام")
            let errorMessage = String(cString: sqlite3_errmsg(database))
            print("رسالة الخطأ: \(errorMessage)")
        }
        
        sqlite3_finalize(statement)
        return nil
    }
    
    // دالة مساعدة لطباعة جميع المستخدمين
    func printAllUsers() {
        guard let database = db else { return }
        
        print("🔍 طباعة جميع المستخدمين في قاعدة البيانات:")
        
        let query = "SELECT UserID, FullName, Role, EmployeeID, NationalID, Password FROM Users"
        var statement: OpaquePointer?
        
        if sqlite3_prepare_v2(database, query, -1, &statement, nil) == SQLITE_OK {
            var userCount = 0
            while sqlite3_step(statement) == SQLITE_ROW {
                userCount += 1
                let userId = sqlite3_column_int(statement, 0)
                let fullName = String(cString: sqlite3_column_text(statement, 1))
                let role = String(cString: sqlite3_column_text(statement, 2))
                let employeeID = sqlite3_column_text(statement, 3) != nil ? String(cString: sqlite3_column_text(statement, 3)) : "NULL"
                let nationalID = String(cString: sqlite3_column_text(statement, 4))
                let password = String(cString: sqlite3_column_text(statement, 5))
                
                print("👤 مستخدم #\(userCount):")
                print("   UserID: \(userId)")
                print("   FullName: \(fullName)")
                print("   Role: \(role)")
                print("   EmployeeID: \(employeeID)")
                print("   NationalID: \(nationalID)")
                print("   Password: \(password)")
                print("   ---")
            }
            
            if userCount == 0 {
                print("❌ لا توجد مستخدمين في قاعدة البيانات!")
            }
        } else {
            print("❌ فشل في استعلام المستخدمين")
        }
        
        sqlite3_finalize(statement)
    }
    
    // باقي الدوال...
    func getAlerts() -> [Alert] {
        var alerts: [Alert] = []
        guard let database = db else { return alerts }
        
        let query = "SELECT AlertID, UserID, AlertType, RiskLevel, Message, CreatedAt FROM Alerts"
        var statement: OpaquePointer?
        
        if sqlite3_prepare_v2(database, query, -1, &statement, nil) == SQLITE_OK {
            while sqlite3_step(statement) == SQLITE_ROW {
                let alert = Alert(
                    alertID: Int(sqlite3_column_int(statement, 0)),
                    userID: Int(sqlite3_column_int(statement, 1)),
                    alertType: String(cString: sqlite3_column_text(statement, 2)),
                    riskLevel: String(cString: sqlite3_column_text(statement, 3)),
                    message: String(cString: sqlite3_column_text(statement, 4)),
                    createdAt: sqlite3_column_text(statement, 5) != nil ? String(cString: sqlite3_column_text(statement, 5)) : ""
                )
                alerts.append(alert)
            }
        }
        sqlite3_finalize(statement)
        return alerts
    }
}
