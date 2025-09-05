import SwiftUI
import Charts

struct EmployeeDashboardHomeView: View {
    let user: User
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.black.ignoresSafeArea()
                
                ScrollView {
                    VStack(spacing: 25) {
                        // حالة السيولة
                        LiquidityStatusCard()
                        
                        // إحصائيات سريعة
                        HStack(spacing: 15) {
                            QuickStatCard(
                                title: "السيولة",
                                value: "125%",
                                icon: "drop.fill",
                                color: .green
                            )

                            QuickStatCard(
                                title: "التقارير",
                                value: "جديدة",
                                icon: "doc.text.fill",
                                color: .blue
                            )

                            QuickStatCard(
                                title: "معدلات السحب",
                                value: "12%",
                                icon: "minus.circle.fill",
                                color: .orange
                            )

                            QuickStatCard(
                                title: "المعاملات",
                                value: "1247",
                                icon: "arrow.left.arrow.right.circle.fill",
                                color: .purple
                            )

                            QuickStatCard(
                                title: "التنبيهات",
                                value: "3",
                                icon: "bell.badge.fill",
                                color: .red
                            )
                        }

                        
                        // توصيات
                        RecommendationCard()
                        
                        // الرسم البياني للرصيد النقدي
                        CashBalanceChartView()
                    }
                    .padding()
                }
            }
            .navigationTitle("لوحة التحكم")
            .navigationBarTitleDisplayMode(.large)
        }
    }
}

struct LiquidityStatusCard: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            HStack {
                Text("حالة السيولة")
                    .font(.headline)
                    .foregroundColor(.white)
                
                Spacer()
                
                Image(systemName: "arrow.down.right")
                    .font(.title2)
                    .foregroundColor(.red)
            }
            
            Text("تحذير: انخفاض في مستوى السيولة")
                .font(.title3)
                .fontWeight(.semibold)
                .foregroundColor(.red)
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 15)
                .fill(Color.gray.opacity(0.1))
                .stroke(Color.white.opacity(0.2), lineWidth: 1)
        )
    }
}

struct QuickStatCard: View {
    let title: String
    let value: String
    let icon: String
    let color: Color

    var body: some View {
        VStack(spacing: 10) {
            Image(systemName: icon)
                .font(.system(size: 26))
                .foregroundColor(color)
            
            Text(title)
                .font(.headline)
                .foregroundColor(.black)         // ← هذا المطلوب
                .multilineTextAlignment(.center)
            
            Text(value)
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(color)
        }
        .padding()
        .frame(width: 160, height: 120)
        .background(Color.white)
        .cornerRadius(12)
        .shadow(radius: 4)
    }
}

struct RecommendationCard: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            Text("نوصي برفع الاحتياطي البنكي والتواصل مع البنك المركزي فوراً")
                .font(.headline)
                .foregroundColor(.white)
                .multilineTextAlignment(.leading)
            
            Button(action: {}) {
                HStack {
                    Text("عرض التوصيات كاملة")
                        .font(.headline)
                        .foregroundColor(.black)
                    
                    Image(systemName: "chart.line.uptrend.xyaxis")
                        .foregroundColor(.black)
                }
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

struct CashBalanceChartView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            Text("الرصيد النقدي بمرور الوقت")
                .font(.headline)
                .foregroundColor(.white)
            
            if #available(iOS 16.0, *) {
                Chart {
                    ForEach(getSampleCashData(), id: \.month) { data in
                        LineMark(
                            x: .value("الشهر", getMonthName(data.month)),
                            y: .value("الرصيد", data.cashBalance)
                        )
                        .foregroundStyle(.white)
                        .lineStyle(StrokeStyle(lineWidth: 3))
                        
                        AreaMark(
                            x: .value("الشهر", getMonthName(data.month)),
                            y: .value("الرصيد", data.cashBalance)
                        )
                        .foregroundStyle(.white.opacity(0.1))
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
    
    func getSampleCashData() -> [CashFlowData] {
        return [
            CashFlowData(month: 1, year: 2025, cashBalance: 150000),
            CashFlowData(month: 2, year: 2025, cashBalance: 145000),
            CashFlowData(month: 3, year: 2025, cashBalance: 140000),
            CashFlowData(month: 4, year: 2025, cashBalance: 135000),
            CashFlowData(month: 5, year: 2025, cashBalance: 130000),
            CashFlowData(month: 6, year: 2025, cashBalance: 125000),
            CashFlowData(month: 7, year: 2025, cashBalance: 120000)
        ]
    }
    
    func getMonthName(_ month: Int) -> String {
        let months = ["يناير", "فبراير", "مارس", "أبريل", "مايو", "يونيو",
                     "يوليو", "أغسطس", "سبتمبر", "أكتوبر", "نوفمبر", "ديسمبر"]
        return months[month - 1]
    }
}
