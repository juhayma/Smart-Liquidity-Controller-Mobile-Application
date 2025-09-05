import SwiftUI

struct ClientBudgetView: View {
    let user: User
    @State private var budgetName = ""
    @State private var selectedDuration = "شهر"
    @State private var allocatedAmount = ""
    @State private var showingSuccess = false
    
    let durations = ["شهر", "شهرين", "ثلاث أشهر", "أربع أشهر", "خمس أشهر", "ست أشهر", "سبع أشهر", "ثمان أشهر"]
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.black.ignoresSafeArea()
                
                ScrollView {
                    VStack(spacing: 25) {
                        Text("إنشاء ميزانية")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .padding(.top)
                        
                        // نموذج إنشاء الميزانية
                        BudgetCreationForm(
                            budgetName: $budgetName,
                            selectedDuration: $selectedDuration,
                            allocatedAmount: $allocatedAmount,
                            durations: durations,
                            showingSuccess: $showingSuccess
                        )
                        
                        // رسالة التشجيع
                        MotivationMessage()
                        
                        // تنبيه الزكاة
                        ZakatWarning()
                        
                        // الميزانيات الحالية
                        CurrentBudgetsCard()
                    }
                    .padding()
                }
            }
            .navigationTitle("الميزانية")
            .navigationBarTitleDisplayMode(.large)
        }
        .alert("تم إنشاء الميزانية بنجاح!", isPresented: $showingSuccess) {
            Button("حسناً", role: .cancel) { }
        }
    }
}

struct BudgetCreationForm: View {
    @Binding var budgetName: String
    @Binding var selectedDuration: String
    @Binding var allocatedAmount: String
    let durations: [String]
    @Binding var showingSuccess: Bool
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            TextField("اسم الميزانية", text: $budgetName)
                .textFieldStyle(CustomTextFieldStyle())
            
            VStack(alignment: .leading, spacing: 10) {
                Text("المدة")
                    .font(.headline)
                    .foregroundColor(.white)
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 10) {
                        ForEach(durations, id: \.self) { duration in
                            Button(action: {
                                selectedDuration = duration
                            }) {
                                Text(duration)
                                    .font(.subheadline)
                                    .foregroundColor(selectedDuration == duration ? .black : .white)
                                    .padding(.horizontal, 15)
                                    .padding(.vertical, 8)
                                    .background(
                                        selectedDuration == duration ? Color.white : Color.clear
                                    )
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 8)
                                            .stroke(Color.white, lineWidth: 1)
                                    )
                                    .cornerRadius(8)
                            }
                        }
                    }
                    .padding(.horizontal)
                }
            }
            
            TextField("المبلغ المخصص", text: $allocatedAmount)
                .textFieldStyle(CustomTextFieldStyle())
                .keyboardType(.numberPad)
            
            Button(action: {
                showingSuccess = true
                // إنشاء الميزانية
                budgetName = ""
                allocatedAmount = ""
            }) {
                Text("إنشاء")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .foregroundColor(.black)
                    .frame(maxWidth: .infinity)
                    .frame(height: 55)
                    .background(Color.white)
                    .cornerRadius(15)
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 15)
                .fill(Color.gray.opacity(0.1))
                .stroke(Color.white.opacity(0.2), lineWidth: 1)
        )
    }
}

struct MotivationMessage: View {
    var body: some View {
        HStack {
            Text("لقد حققت 80% من هدفك! لقد اقتربت استمر")
                .font(.subheadline)
                .foregroundColor(.white.opacity(0.8))
            
            Text("✨")
                .font(.title2)
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.green.opacity(0.1))
                .stroke(Color.green.opacity(0.3), lineWidth: 1)
        )
    }
}

struct ZakatWarning: View {
    var body: some View {
        HStack {
            Text("💡")
                .font(.title2)
            
            Text("مدة الادخار داخل التطبيق لا يمكن أن تتجاوز سنة هجرية واحدة وذلك لتفادي الدخول في شروط الزكاة الشرعية.")
                .font(.caption)
                .foregroundColor(.white.opacity(0.7))
                .multilineTextAlignment(.leading)
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.blue.opacity(0.1))
                .stroke(Color.blue.opacity(0.3), lineWidth: 1)
        )
    }
}

struct CurrentBudgetsCard: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("الميزانيات الحالية")
                .font(.headline)
                .foregroundColor(.white)
            
            VStack(spacing: 15) {
                BudgetProgressRow(name: "ميزانية زواج", progress: 0.65, amount: "32,500", target: "50,000")
                BudgetProgressRow(name: "خطة سداد قرض", progress: 0.80, amount: "24,000", target: "30,000")
                BudgetProgressRow(name: "ميزانية طوارئ", progress: 0.45, amount: "6,750", target: "15,000")
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 15)
                .fill(Color.gray.opacity(0.1))
                .stroke(Color.white.opacity(0.2), lineWidth: 1)
        )
    }
}

struct BudgetProgressRow: View {
    let name: String
    let progress: Double
    let amount: String
    let target: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Text(name)
                    .font(.headline)
                    .foregroundColor(.white)
                
                Spacer()
                
                Text("\(amount) / \(target) ر.س")
                    .font(.subheadline)
                    .foregroundColor(.white.opacity(0.8))
            }
            
            ProgressView(value: progress)
                .progressViewStyle(LinearProgressViewStyle(tint: .white))
            
            Text("\(Int(progress * 100))% مكتمل")
                .font(.caption)
                .foregroundColor(.white.opacity(0.6))
        }
    }
}


