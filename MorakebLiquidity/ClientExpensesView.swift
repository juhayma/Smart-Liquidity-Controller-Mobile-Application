import SwiftUI

struct ClientExpensesView: View {
    let user: User
    @State private var category = ""
    @State private var amount = ""
    @State private var note = ""
    @State private var selectedDate = Date()
    @State private var showingSuccess = false
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.black.ignoresSafeArea()
                
                ScrollView {
                    VStack(spacing: 25) {
                        Text("تسجيل مصروفات")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .padding(.top)
                        
                        ExpenseForm(
                            category: $category,
                            amount: $amount,
                            note: $note,
                            selectedDate: $selectedDate,
                            showingSuccess: $showingSuccess
                        )
                        
                        RecentExpensesHistory()
                    }
                    .padding()
                }
            }
            .navigationTitle("المصروفات")
            .navigationBarTitleDisplayMode(.large)
        }
        .alert("تم تسجيل المصروف بنجاح!", isPresented: $showingSuccess) {
            Button("حسناً", role: .cancel) { }
        }
    }
}

struct ExpenseForm: View {
    @Binding var category: String
    @Binding var amount: String
    @Binding var note: String
    @Binding var selectedDate: Date
    @Binding var showingSuccess: Bool
    
    let categories = ["طعام", "مواصلات", "ترفيه", "تسوق", "صحة", "تعليم", "أخرى"]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            // فئة المصروف
            VStack(alignment: .leading, spacing: 10) {
                Text("التصنيف")
                    .font(.headline)
                    .foregroundColor(.white)
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 10) {
                        ForEach(categories, id: \.self) { cat in
                            Button(action: {
                                category = cat
                            }) {
                                Text(cat)
                                    .font(.subheadline)
                                    .foregroundColor(category == cat ? .black : .white)
                                    .padding(.horizontal, 15)
                                    .padding(.vertical, 8)
                                    .background(
                                        category == cat ? Color.white : Color.clear
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
            
            TextField("المبلغ", text: $amount)
                .textFieldStyle(CustomTextFieldStyle())
                .keyboardType(.decimalPad)
            
            TextField("ملاحظة", text: $note)
                .textFieldStyle(CustomTextFieldStyle())
            
            DatePicker("التاريخ", selection: $selectedDate, displayedComponents: .date)
                .foregroundColor(.white)
                .padding(.horizontal)
            
            Button(action: {
                showingSuccess = true
                // تسجيل المصروف
                category = ""
                amount = ""
                note = ""
            }) {
                Text("تسجيل")
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

struct RecentExpensesHistory: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("المصروفات الأخيرة")
                .font(.headline)
                .foregroundColor(.white)
            
            VStack(spacing: 15) {
                ExpenseHistoryRow(
                    category: "تسوق",
                    amount: "250.00",
                    note: "محل العثيم",
                    date: "اليوم"
                )
                
                ExpenseHistoryRow(
                    category: "عشاء",
                    amount: "180.50",
                    note: "مطعم البيك",
                    date: "أمس"
                )
                
                ExpenseHistoryRow(
                    category: "مواصلات",
                    amount: "45.00",
                    note: "أوبر",
                    date: "أمس"
                )
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

struct ExpenseHistoryRow: View {
    let category: String
    let amount: String
    let note: String
    let date: String
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 5) {
                Text(category)
                    .font(.headline)
                    .foregroundColor(.white)
                
                Text(note)
                    .font(.caption)
                    .foregroundColor(.white.opacity(0.7))
                
                Text(date)
                    .font(.caption)
                    .foregroundColor(.white.opacity(0.5))
            }
            
            Spacer()
            
            Text("\(amount) ر.س")
                .font(.headline)
                .fontWeight(.semibold)
                .foregroundColor(.red)
        }
    }
}

