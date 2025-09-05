import SwiftUI

struct ClientHomeView: View {
    let user: User
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.black.ignoresSafeArea()
                
                ScrollView {
                    VStack(spacing: 25) {
                        // ترحيب بالعميل
                        ClientWelcomeCard(user: user)
                        
                        // الرصيد الكلي
                        TotalBalanceCard(balance: user.totalBalance)
                        
                        // المصروفات الأخيرة
                        RecentExpensesCard()
                        
                        // التدفقات النقدية المتوقعة
                        ExpectedCashFlowCard()
                    }
                    .padding()
                }
            }
            .navigationTitle("الرئيسية")
            .navigationBarTitleDisplayMode(.large)
        }
    }
}

struct ClientWelcomeCard: View {
    let user: User
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 10) {
                Text("أهلاً وسهلاً")
                    .font(.title2)
                    .foregroundColor(.white.opacity(0.8))
                
                Text(user.fullName)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
            }
            
            Spacer()
            
            Image(systemName: "person.circle.fill")
                .font(.system(size: 60))
                .foregroundColor(.white.opacity(0.8))
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 15)
                .fill(Color.gray.opacity(0.1))
                .stroke(Color.white.opacity(0.2), lineWidth: 1)
        )
    }
}

struct TotalBalanceCard: View {
    let balance: Double
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            Text("الرصيد الكلي")
                .font(.headline)
                .foregroundColor(.white.opacity(0.8))
            
            HStack {
                Text(String(format: "%.2f", balance))
                    .font(.system(size: 36, weight: .bold))
                    .foregroundColor(.white)
                
                Text("ريال")
                    .font(.title2)
                    .foregroundColor(.white.opacity(0.6))
                
                Spacer()
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 15)
                .fill(Color.blue.opacity(0.1))
                .stroke(Color.blue.opacity(0.3), lineWidth: 1)
        )
    }
}

struct RecentExpensesCard: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("المصروفات الأخيرة")
                .font(.headline)
                .foregroundColor(.white)
            
            VStack(spacing: 15) {
                ExpenseRow(category: "تسوق", amount: "250.00", icon: "cart.fill")
                ExpenseRow(category: "عشاء", amount: "180.50", icon: "fork.knife")
                ExpenseRow(category: "ترفيه", amount: "320.00", icon: "gamecontroller.fill")
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

struct ExpenseRow: View {
    let category: String
    let amount: String
    let icon: String
    
    var body: some View {
        HStack {
            Image(systemName: icon)
                .font(.title3)
                .foregroundColor(.white)
                .frame(width: 30)
            
            Text(category)
                .font(.headline)
                .foregroundColor(.white)
            
            Spacer()
            
            Text("\(amount) ر.س")
                .font(.headline)
                .fontWeight(.semibold)
                .foregroundColor(.red)
        }
    }
}

struct ExpectedCashFlowCard: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("التدفقات النقدية المتوقعة")
                .font(.headline)
                .foregroundColor(.white)
            
            VStack(spacing: 15) {
                CashFlowRow(category: "الراتب", amount: "8,500.00", icon: "banknote.fill", isIncome: true)
                CashFlowRow(category: "المكافأة الشهرية", amount: "1,200.00", icon: "gift.fill", isIncome: true)
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

struct CashFlowRow: View {
    let category: String
    let amount: String
    let icon: String
    let isIncome: Bool
    
    var body: some View {
        HStack {
            Image(systemName: icon)
                .font(.title3)
                .foregroundColor(.white)
                .frame(width: 30)
            
            Text(category)
                .font(.headline)
                .foregroundColor(.white)
            
            Spacer()
            
            Text("\(amount) ر.س")
                .font(.headline)
                .fontWeight(.semibold)
                .foregroundColor(isIncome ? .green : .red)
        }
    }
}
