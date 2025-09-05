import SwiftUI

struct EmployeeAlertsView: View {
    var body: some View {
        NavigationView {
            ZStack {
                Color.black.ignoresSafeArea()
                
                ScrollView {
                    VStack(spacing: 20) {
                        AlertCard(
                            riskLevel: "مرتفع",
                            title: "تحذير بانخفاض في السيولة",
                            color: .red
                        )
                        
                        AlertCard(
                            riskLevel: "متوسط",
                            title: "تغير في التوقعات المالية الكبيرة",
                            color: .orange
                        )
                        
                        AlertCard(
                            riskLevel: "منخفض",
                            title: "ارتفاع في حجم التدفقات الكلية",
                            color: .yellow
                        )
                        
                        AlertCard(
                            riskLevel: "متوسط",
                            title: "تغير في التوقعات المالية الكبيرة",
                            color: .orange
                        )
                        
                        AlertCard(
                            riskLevel: "منخفض",
                            title: "ارتفاع في حجم التدفقات الكلية",
                            color: .yellow
                        )
                    }
                    .padding()
                }
            }
            .navigationTitle("الإنذارات")
            .navigationBarTitleDisplayMode(.large)
        }
    }
}

struct AlertCard: View {
    let riskLevel: String
    let title: String
    let color: Color
    
    var body: some View {
        HStack {
            Image(systemName: "exclamationmark.triangle.fill")
                .font(.title2)
                .foregroundColor(color)
            
            VStack(alignment: .leading, spacing: 5) {
                Text("مستوى الخطر: \(riskLevel)")
                    .font(.caption)
                    .foregroundColor(.white.opacity(0.8))
                
                Text(title)
                    .font(.headline)
                    .foregroundColor(.white)
            }
            
            Spacer()
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 15)
                .fill(Color.gray.opacity(0.1))
                .stroke(color.opacity(0.3), lineWidth: 1)
        )
    }
}
