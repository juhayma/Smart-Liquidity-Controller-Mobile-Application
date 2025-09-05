import SwiftUI

struct ClientDashboardView: View {
    let user: User
    @State private var selectedTab = 0
    
    var body: some View {
        TabView(selection: $selectedTab) {
            ClientHomeView(user: user)
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("الرئيسية")
                }
                .tag(0)
            
            ClientBudgetView(user: user)
                .tabItem {
                    Image(systemName: "chart.pie.fill")
                    Text("الميزانية")
                }
                .tag(1)
            
            ClientExpensesView(user: user)
                .tabItem {
                    Image(systemName: "minus.circle.fill")
                    Text("المصروفات")
                }
                .tag(2)
            
            ClientIncomeView(user: user)
                .tabItem {
                    Image(systemName: "plus.circle.fill")
                    Text("الإيرادات")
                }
                .tag(3)
            
            ClientReportsView(user: user)
                .tabItem {
                    Image(systemName: "doc.text.fill")
                    Text("التقارير")
                }
                .tag(4)
            
            ClientSettingsView()
                .tabItem {
                    Image(systemName: "gearshape.fill")
                    Text("الإعدادات")
                }
                .tag(5)
        }
        .environment(\.layoutDirection, .rightToLeft)
        .preferredColorScheme(.dark)
    }
}

// Views موجودة في ملفات أخرى - لا نحتاج لإعادة تعريفها
