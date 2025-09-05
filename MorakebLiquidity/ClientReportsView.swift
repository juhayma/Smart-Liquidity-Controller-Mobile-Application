import SwiftUI
import Charts

struct ClientReportsView: View {
    let user: User
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.black.ignoresSafeArea()
                
                ScrollView {
                    VStack(spacing: 25) {
                        // الإنفاق بالمئات
                        SpendingOverviewCard()
                        
                        // الرسم البياني الشهري
                        MonthlySpendingChart()
                        
                        // تفاصيل المعاملات
                        TransactionDetailsCard()
                        
                        // المخططات
                        BudgetPlanCard()
                    }
                    .padding()
                }
            }
            .navigationTitle("التقارير")
            .navigationBarTitleDisplayMode(.large)
        }
    }
}

struct SpendingOverviewCard: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            HStack {
                Text("الإنفاق بالمئات")
                    .font(.headline)
                    .foregroundColor(.white)
                
                Spacer()
                
                Text("الشهر الحالي")
                    .font(.caption)
                    .foregroundColor(.white.opacity(0.6))
            }
            
            Text("المجموع: 12,500 ر.س")
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(.white)
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 15)
                .fill(Color.gray.opacity(0.1))
                .stroke(Color.white.opacity(0.2), lineWidth: 1)
        )
    }
}

struct MonthlySpendingChart: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("الإنفاق الشهري")
                .font(.headline)
                .foregroundColor(.white)
            
            if #available(iOS 16.0, *) {
                Chart {
                    ForEach(getMonthlySpendingData(), id: \.month) { data in
                        BarMark(
                            x: .value("الشهر", data.month),
                            y: .value("المبلغ", data.amount)
                        )
                        .foregroundStyle(.white)
                        .cornerRadius(4)
                    }
                }
                .frame(height: 200)
                .chartXAxis {
                    AxisMarks(values: .automatic) { _ in
                        AxisGridLine().foregroundStyle(.white.opacity(0.3))
                        AxisValueLabel().foregroundStyle(.white)
                    }
                }
                .chartYAxis {
                    AxisMarks(values: .automatic) { _ in
                        AxisGridLine().foregroundStyle(.white.opacity(0.3))
                        AxisValueLabel().foregroundStyle(.white)
                    }
                }
            } else {
                Text("الرسم البياني متاح في iOS 16+")
                    .foregroundColor(.white.opacity(0.6))
                    .frame(height: 200)
                    .frame(maxWidth: .infinity)
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 15)
                .fill(Color.gray.opacity(0.1))
                .stroke(Color.white.opacity(0.2), lineWidth: 1)
        )
    }
    
    func getMonthlySpendingData() -> [(month: String, amount: Double)] {
        return [
            (month: "يناير", amount: 10500),
            (month: "فبراير", amount: 11200),
            (month: "مارس", amount: 9800),
            (month: "أبريل", amount: 12000),
            (month: "مايو", amount: 11500),
            (month: "يونيو", amount: 13200),
            (month: "يوليو", amount: 12500)
        ]
    }
}

struct TransactionDetailsCard: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("تفاصيل المعاملات")
                .font(.headline)
                .foregroundColor(.white)
            
            VStack(spacing: 15) {
                TransactionCategoryRow(category: "المنزل", amount: "4,200", percentage: "34%")
                TransactionCategoryRow(category: "المواصلات", amount: "2,800", percentage: "22%")
                TransactionCategoryRow(category: "الترفيه", amount: "2,100", percentage: "17%")
                TransactionCategoryRow(category: "التعليم", amount: "1,900", percentage: "15%")
                TransactionCategoryRow(category: "أخرى", amount: "1,500", percentage: "12%")
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

struct TransactionCategoryRow: View {
    let category: String
    let amount: String
    let percentage: String
    
    var body: some View {
        HStack {
            Text(category)
                .font(.subheadline)
                .foregroundColor(.white)
            
            Spacer()
            
            VStack(alignment: .trailing, spacing: 2) {
                Text("\(amount) ر.س")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                
                Text(percentage)
                    .font(.caption)
                    .foregroundColor(.white.opacity(0.6))
            }
        }
    }
}

struct BudgetPlanCard: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("المخططات")
                .font(.headline)
                .foregroundColor(.white)
            
            VStack(spacing: 15) {
                BudgetPlanRow(category: "المنزل", allocated: "4,500", spent: "4,200", color: .green)
                BudgetPlanRow(category: "المواصلات", allocated: "3,000", spent: "2,800", color: .green)
                BudgetPlanRow(category: "الترفيه", allocated: "2,000", spent: "2,100", color: .red)
                BudgetPlanRow(category: "التعليم", allocated: "2,000", spent: "1,900", color: .green)
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

struct BudgetPlanRow: View {
    let category: String
    let allocated: String
    let spent: String
    let color: Color
    
    var body: some View {
        HStack {
            Text(category)
                .font(.subheadline)
                .foregroundColor(.white)
            
            Spacer()
            
            VStack(alignment: .trailing, spacing: 2) {
                Text("\(spent) / \(allocated) ر.س")
                    .font(.caption)
                    .foregroundColor(.white.opacity(0.8))
                
                Circle()
                    .fill(color)
                    .frame(width: 8, height: 8)
            }
        }
    }
}


