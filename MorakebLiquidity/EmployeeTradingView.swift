import SwiftUI

struct EmployeeTradingView: View {
    @State private var sendingDepartment = ""
    @State private var receivingDepartment = ""
    @State private var amount = ""
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.black.ignoresSafeArea()
                
                ScrollView {
                    VStack(spacing: 25) {
                        Text("منصة التداول الداخلية")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .padding(.top)
                        
                        // الأرصدة المتاحة
                        AvailableBalancesCard()
                        
                        // طلب تداول
                        TradingRequestCard(
                            sendingDepartment: $sendingDepartment,
                            receivingDepartment: $receivingDepartment,
                            amount: $amount
                        )
                        
                        // سجل المعاملات السابقة
                        TransactionHistoryCard()
                    }
                    .padding()
                }
            }
            .navigationTitle("التداول")
            .navigationBarTitleDisplayMode(.large)
        }
    }
}

struct AvailableBalancesCard: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("الأرصدة المتاحة")
                .font(.headline)
                .foregroundColor(.white)
            
            VStack(spacing: 15) {
                BalanceRow(title: "الرصيد النقدي", amount: "2,500,000", currency: "ريال")
                BalanceRow(title: "الرصيد المحجوز", amount: "500,000", currency: "ريال")
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

struct BalanceRow: View {
    let title: String
    let amount: String
    let currency: String
    
    var body: some View {
        HStack {
            Text(title)
                .font(.subheadline)
                .foregroundColor(.white.opacity(0.8))
            
            Spacer()
            
            HStack {
                Text(amount)
                    .font(.headline)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                
                Text(currency)
                    .font(.subheadline)
                    .foregroundColor(.white.opacity(0.6))
            }
        }
    }
}

struct TradingRequestCard: View {
    @Binding var sendingDepartment: String
    @Binding var receivingDepartment: String
    @Binding var amount: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("طلب تداول")
                .font(.headline)
                .foregroundColor(.white)
            
            VStack(spacing: 15) {
                TextField("القسم المرسل", text: $sendingDepartment)
                    .textFieldStyle(CustomTextFieldStyle())
                
                TextField("القسم المستقبل", text: $receivingDepartment)
                    .textFieldStyle(CustomTextFieldStyle())
                
                TextField("المبلغ", text: $amount)
                    .textFieldStyle(CustomTextFieldStyle())
                    .keyboardType(.numberPad)
            }
            
            Button(action: {}) {
                Text("تأكيد الطلب")
                    .font(.headline)
                    .fontWeight(.semibold)
                    .foregroundColor(.black)
                    .frame(maxWidth: .infinity)
                    .frame(height: 50)
                    .background(Color.white)
                    .cornerRadius(12)
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

struct TransactionHistoryCard: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("سجل المعاملات السابقة")
                .font(.headline)
                .foregroundColor(.white)
            
            VStack(spacing: 15) {
                TransactionHistoryRow(
                    amount: "50,000",
                    description: "تحويل من قسم الخزينة إلى قسم الاستثمار"
                )
                
                TransactionHistoryRow(
                    amount: "25,000",
                    description: "تحويل من قسم التسويق إلى قسم الخزينة"
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

struct TransactionHistoryRow: View {
    let amount: String
    let description: String
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 5) {
                Text(description)
                    .font(.subheadline)
                    .foregroundColor(.white)
                    .multilineTextAlignment(.leading)
                
                Text("اليوم")
                    .font(.caption)
                    .foregroundColor(.white.opacity(0.6))
            }
            
            Spacer()
            
            Text("\(amount) ريال")
                .font(.headline)
                .fontWeight(.semibold)
                .foregroundColor(.white)
        }
    }
}


