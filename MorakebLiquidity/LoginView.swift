import SwiftUI

struct LoginView: View {
    @State private var selectedUserType: UserType = .employee
    @State private var employeeID = ""
    @State private var password = ""
    @State private var username = ""
    @State private var showingRegistration = false
    @State private var showingEmployeeDashboard = false
    @State private var showingClientDashboard = false
    @State private var currentUser: User?
    @State private var loginError = ""
    @State private var isLoading = false
    
    enum UserType: String, CaseIterable {
        case employee = "موظف"
        case client = "عميل"
    }
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            
            VStack(spacing: 30) {
                Text("تسجيل الدخول")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding(.top, 50)
                
                // اختيار نوع المستخدم
                VStack(spacing: 15) {
                    Text("نوع المستخدم")
                        .font(.headline)
                        .foregroundColor(.white)
                    
                    HStack(spacing: 20) {
                        ForEach(UserType.allCases, id: \.self) { userType in
                            Button(action: {
                                selectedUserType = userType
                                loginError = ""
                                clearFields()
                            }) {
                                Text(userType.rawValue)
                                    .font(.title3)
                                    .fontWeight(.medium)
                                    .foregroundColor(selectedUserType == userType ? .black : .white)
                                    .frame(maxWidth: .infinity)
                                    .frame(height: 50)
                                    .background(
                                        selectedUserType == userType ? Color.white : Color.clear
                                    )
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 12)
                                            .stroke(Color.white, lineWidth: 2)
                                    )
                                    .cornerRadius(12)
                            }
                        }
                    }
                    .padding(.horizontal)
                }
                
                // حقول تسجيل الدخول
                VStack(spacing: 20) {
                    if selectedUserType == .employee {
                        TextField("الرقم الوظيفي", text: $employeeID)
                            .textFieldStyle(CustomTextFieldStyle())
                            .disabled(isLoading)
                    } else {
                        TextField("الهوية الوطنية", text: $username)
                            .textFieldStyle(CustomTextFieldStyle())
                            .keyboardType(.numberPad)
                            .disabled(isLoading)
                    }
                    
                    SecureField("كلمة المرور", text: $password)
                        .textFieldStyle(CustomTextFieldStyle())
                        .disabled(isLoading)
                    
                    // رسالة الخطأ
                    if !loginError.isEmpty {
                        Text(loginError)
                            .font(.caption)
                            .foregroundColor(.red)
                            .padding(.horizontal)
                    }
                    
                    // التحقق عبر نفاذ
                    Button(action: {}) {
                        HStack {
                            Image(systemName: "checkmark.shield.fill")
                            Text("التحقق عبر نفاذ الوطني الموحد")
                        }
                        .font(.headline)
                        .foregroundColor(.black)
                        .frame(maxWidth: .infinity)
                        .frame(height: 50)
                        .background(Color.white)
                        .cornerRadius(12)
                    }
                    .padding(.horizontal)
                    .disabled(isLoading)
                    
                    if selectedUserType == .client {
                        Button(action: {}) {
                            HStack {
                                Image(systemName: "phone.fill")
                                Text("التحقق عبر الهاتف")
                            }
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .frame(height: 50)
                            .background(Color.clear)
                            .overlay(
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(Color.white, lineWidth: 2)
                            )
                            .cornerRadius(12)
                        }
                        .padding(.horizontal)
                        .disabled(isLoading)
                    }
                }
                
                // أزرار العمل
                VStack(spacing: 15) {
                    Button(action: login) {
                        HStack {
                            if isLoading {
                                ProgressView()
                                    .progressViewStyle(CircularProgressViewStyle(tint: .black))
                                    .scaleEffect(0.8)
                            }
                            Text(isLoading ? "جاري التحقق..." : "دخول")
                                .font(.title2)
                                .fontWeight(.semibold)
                        }
                        .foregroundColor(.black)
                        .frame(maxWidth: .infinity)
                        .frame(height: 55)
                        .background(isLoading ? Color.gray : Color.white)
                        .cornerRadius(15)
                    }
                    .padding(.horizontal)
                    .disabled(isLoading || (selectedUserType == .employee ? employeeID.isEmpty : username.isEmpty) || password.isEmpty)
                    
                    Button(action: {
                        showingRegistration = true
                    }) {
                        Text("إنشاء حساب")
                            .font(.caption)
                            .foregroundColor(.white.opacity(0.8))
                            .underline()
                    }
                    .disabled(isLoading)
                    
                    if selectedUserType == .client {
                        Button(action: loginAsGuest) {
                            Text("التسجيل كزائر")
                                .font(.caption)
                                .foregroundColor(.white.opacity(0.6))
                                .underline()
                        }
                        .disabled(isLoading)
                    }
                }
                
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
                .padding(.bottom)
            }
        }
        .environment(\.layoutDirection, .rightToLeft)
        .sheet(isPresented: $showingRegistration) {
            RegistrationView(userType: selectedUserType)
        }
        .fullScreenCover(isPresented: $showingEmployeeDashboard) {
            EmployeeDashboardView(user: currentUser ?? User.sampleEmployee)
        }
        .fullScreenCover(isPresented: $showingClientDashboard) {
            ClientDashboardView(user: currentUser ?? User.sampleClient)
        }
    }
    
    func clearFields() {
        employeeID = ""
        username = ""
        password = ""
        loginError = ""
    }

    func login() {
        hideKeyboard()
        isLoading = true
        loginError = ""
        
        let cleanEmployeeID = employeeID.trimmingCharacters(in: .whitespacesAndNewlines)
        let cleanUsername = username.trimmingCharacters(in: .whitespacesAndNewlines)
        let cleanPassword = password.trimmingCharacters(in: .whitespacesAndNewlines)
        
        print("🔐 محاولة تسجيل دخول:")
        print("نوع المستخدم: \(selectedUserType.rawValue)")
        if selectedUserType == .employee {
            print("الرقم الوظيفي: '\(cleanEmployeeID)'")
        } else {
            print("الهوية الوطنية: '\(cleanUsername)'")
        }
        print("كلمة المرور: '\(cleanPassword)'")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            if self.selectedUserType == .employee {
                // فحص بيانات الموظف الثابتة
                if cleanEmployeeID == "Alinma" && cleanPassword == "1120831134" {
                    print("✅ تم تسجيل دخول الموظف بنجاح!")
                    
                    // إنشاء بيانات الموظف
                    self.currentUser = User(from: [
                        "Role": "موظف",
                        "UserID": 1120831134,
                        "FullName": "رئيسة قسم المراقبة المالية الذكية",
                        "EmployeeID": "Alinma"
                    ])
                    self.isLoading = false
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                        print("🚀 الانتقال لشاشة الموظف...")
                        self.showingEmployeeDashboard = true
                    }
                } else {
                    print("❌ فشل تسجيل دخول الموظف - بيانات خاطئة")
                    self.isLoading = false
                    self.loginError = "الرقم الوظيفي: Alinma1000200030 وكلمة المرور: 123456"
                }
            } else {
                // للعملاء - يمكن قبول أي بيانات مؤقتاً
                if !cleanUsername.isEmpty && !cleanPassword.isEmpty {
                    print("✅ تم تسجيل دخول العميل بنجاح!")
                    
                    self.currentUser = User(from: [
                        "Role": "عميل",
                        "UserID": 0,
                        "FullName": "عميل تجريبي",
                        "NationalID": cleanUsername
                    ])
                    self.isLoading = false
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                        print("🚀 الانتقال لشاشة العميل...")
                        self.showingClientDashboard = true
                    }
                } else {
                    print("❌ فشل تسجيل دخول العميل")
                    self.isLoading = false
                    self.loginError = "يرجى إدخال الهوية الوطنية وكلمة المرور"
                }
            }
        }
    }

    func loginAsGuest() {
        hideKeyboard()
        isLoading = true
        
        print("🎭 تسجيل دخول كزائر...")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            self.currentUser = User(from: [
                "Role": "زائر",
                "UserID": 0,
                "FullName": "زائر",
                "NationalID": ""
            ])
            self.isLoading = false
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                print("🚀 الانتقال لشاشة العميل كزائر...")
                self.showingClientDashboard = true
            }
        }
    }

    private func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
