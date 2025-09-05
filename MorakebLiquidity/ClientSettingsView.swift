import SwiftUI

struct ClientSettingsView: View {
    var body: some View {
        NavigationView {
            ZStack {
                Color.black.ignoresSafeArea()
                
                List {
                    Section("الحساب") {
                        ClientSettingRow(title: "المعلومات الشخصية", subtitle: "تعديل", icon: "person.fill")
                        ClientSettingRow(title: "تغيير كلمة المرور", subtitle: "", icon: "lock.fill")
                    }
                    
                    Section("الميزانية") {
                        ClientSettingRow(title: "تنبيهات الميزانية", subtitle: "", icon: "bell.fill")
                    }
                    
                    Section("الدفع") {
                        ClientSettingRow(title: "طرق الدفع", subtitle: "", icon: "creditcard.fill")
                        ClientSettingRow(title: "إضافة طريقة دفع", subtitle: "", icon: "plus.circle.fill")
                        ClientSettingRow(title: "تعديل طريقة الدفع", subtitle: "", icon: "pencil.circle.fill")
                    }
                }
                .listStyle(InsetGroupedListStyle())
                .scrollContentBackground(.hidden)
            }
            .navigationTitle("الإعدادات")
            .navigationBarTitleDisplayMode(.large)
        }
    }
}

struct ClientSettingRow: View {
    let title: String
    let subtitle: String
    let icon: String
    
    var body: some View {
        HStack {
            Image(systemName: icon)
                .font(.title3)
                .foregroundColor(.white)
                .frame(width: 30)
            
            VStack(alignment: .leading, spacing: 2) {
                Text(title)
                    .font(.headline)
                    .foregroundColor(.white)
                
                if !subtitle.isEmpty {
                    Text(subtitle)
                        .font(.caption)
                        .foregroundColor(.white.opacity(0.6))
                }
            }
            
            Spacer()
            
            Image(systemName: "chevron.right")
                .font(.caption)
                .foregroundColor(.white.opacity(0.6))
        }
        .padding(.vertical, 5)
        .listRowBackground(Color.gray.opacity(0.1))
    }
}
