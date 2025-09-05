import SwiftUI

struct RegistrationView: View {
    let userType: LoginView.UserType
    @Environment(\.presentationMode) var presentationMode
    
    @State private var username = ""
    @State private var nationalID = ""
    @State private var accountNumber = ""
    @State private var email = ""
    @State private var verificationCode = ""
    @State private var agreeToTerms = false
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.black.ignoresSafeArea()
                
                ScrollView {
                    VStack(spacing: 25) {
                        Text("إنشاء حساب جديد")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .padding(.top, 50)
                        
                        VStack(spacing: 20) {
                            TextField("اسم المستخدم", text: $username)
                                .textFieldStyle(CustomTextFieldStyle())
                            
                            TextField("الهوية الوطنية", text: $nationalID)
                                .textFieldStyle(CustomTextFieldStyle())
                                .keyboardType(.numberPad)
                            
                            TextField("رقم الحساب المصرفي", text: $accountNumber)
                                .textFieldStyle(CustomTextFieldStyle())
                                .keyboardType(.numberPad)
                            
                            TextField("الإيميل", text: $email)
                                .textFieldStyle(CustomTextFieldStyle())
                                .keyboardType(.emailAddress)
                            
                            TextField("رمز التحقق", text: $verificationCode)
                                .textFieldStyle(CustomTextFieldStyle())
                                .keyboardType(.numberPad)
                        }
                        
                        // الموافقة على الشروط
                        HStack {
                            Button(action: {
                                agreeToTerms.toggle()
                            }) {
                                Image(systemName: agreeToTerms ? "checkmark.square.fill" : "square")
                                    .font(.title2)
                                    .foregroundColor(.white)
                            }
                            
                            Text("الموافقة على الخصوصية والأمان")
                                .font(.headline)
                                .foregroundColor(.white)
                            
                            Spacer()
                        }
                        .padding(.horizontal)
                        
                        Button(action: {
                            // إنشاء الحساب
                            presentationMode.wrappedValue.dismiss()
                        }) {
                            Text("إنشاء الحساب")
                                .font(.title2)
                                .fontWeight(.semibold)
                                .foregroundColor(.black)
                                .frame(maxWidth: .infinity)
                                .frame(height: 55)
                                .background(agreeToTerms ? Color.white : Color.gray)
                                .cornerRadius(15)
                        }
                        .disabled(!agreeToTerms)
                        .padding(.horizontal)
                        
                        Spacer()
                    }
                }
            }
        }
        .environment(\.layoutDirection, .rightToLeft)
        .navigationBarItems(
            leading: Button("إلغاء") {
                presentationMode.wrappedValue.dismiss()
            }
            .foregroundColor(.white)
        )
    }
}
