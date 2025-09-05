import SwiftUI

struct ClientIncomeView: View {
    let user: User
    @State private var salaryAmount = ""
    @State private var bonusAmount = ""
    @State private var governmentSupport = ""
    @State private var showingSuccess = false
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.black.ignoresSafeArea()
                
                ScrollView {
                    VStack(spacing: 25) {
                        Text("الإيرادات المتوقعة")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .padding(.top)
                        
                        IncomeForm(
                            salaryAmount: $salaryAmount,
                            bonusAmount: $bonusAmount,
                            governmentSupport: $governmentSupport,
                            showingSuccess: $showingSuccess
                        )
                        
                        IncomeProjectionCard()
                    }
                    .padding()
                }
            }
            .navigationTitle("الإيرادات")
            .navigationBarTitleDisplayMode(.large)
        }
        .alert("تم تحديث الإيرادات بنجاح!", isPresented: $showingSuccess) {
            Button("حسناً", role: .cancel) { }
        }
    }
}

struct IncomeForm: View {
    @Binding var salaryAmount: String
    @Binding var bonusAmount: String
    @Binding var governmentSupport: String
    @Binding var showingSuccess: Bool
    
    var body: some View {
        VStack(spacing: 20) {
            IncomeField(title: "راتب شهري", amount: $salaryAmount, icon: "banknote.fill")
            IncomeField(title: "مكافأة", amount: $bonusAmount, icon: "gift.fill")
            IncomeField(title: "دعم مالي حكومي", amount: $governmentSupport, icon: "building.columns.fill")
            
            Button(action: {
                showingSuccess = true
            }) {
                Text("حفظ التغييرات")
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

struct IncomeField: View {
    let title: String
    @Binding var amount: String
    let icon: String
    
    var body: some View {
        HStack {
            Image(systemName: icon)
                .font(.title2)
                .foregroundColor(.white)
                .frame(width: 30)
            
            Text(title)
                .font(.headline)
                .foregroundColor(.white)
            
            Spacer()
            
            TextField("0.00", text: $amount)
                .keyboardType(.decimalPad)
                .multilineTextAlignment(.trailing)
                .foregroundColor(.white)
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .fill(Color.gray.opacity(0.2))
                )
                .frame(width: 100)
        }
    }
}

struct IncomeProjectionCard: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("توقعات الدخل الشهري")
                .font(.headline)
                .foregroundColor(.white)
            
            VStack(spacing: 15) {
                ProjectionRow(title: "الراتب الأساسي", amount: "8,500.00")
                ProjectionRow(title: "المكافآت", amount: "1,200.00")
                ProjectionRow(title: "الدعم الحكومي", amount: "500.00")
                
                Divider()
                    .background(Color.white.opacity(0.3))
                
                HStack {
                    Text("إجمالي الدخل المتوقع")
                        .font(.headline)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                    
                    Spacer()
                    
                    Text("10,200.00 ر.س")
                        .font(.headline)
                        .fontWeight(.bold)
                        .foregroundColor(.green)
                }
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 15)
                .fill(Color.green.opacity(0.1))
                .stroke(Color.green.opacity(0.3), lineWidth: 1)
        )
    }
}

struct ProjectionRow: View {
    let title: String
    let amount: String
    
    var body: some View {
        HStack {
            Text(title)
                .font(.subheadline)
                .foregroundColor(.white.opacity(0.8))
            
            Spacer()
            
            Text("\(amount) ر.س")
                .font(.subheadline)
                .fontWeight(.semibold)
                .foregroundColor(.white)
        }
    }
}
