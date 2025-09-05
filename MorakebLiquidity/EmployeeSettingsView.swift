import SwiftUI

struct EmployeeSettingsView: View {
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.black.ignoresSafeArea()
                
                List {
                    Section("الحساب") {
                        SettingRow(title: "الملف الشخصي", icon: "person.fill")
                        SettingRow(title: "الخصوصية والأمان", icon: "shield.fill")
                    }
                    
                    Section("التقارير") {
                        SettingRow(title: "إنشاء التقارير", icon: "doc.text.fill")
                        SettingRow(title: "طباعة", icon: "printer.fill")
                    }
                    
                    Section("المساعدة") {
                        SettingRow(title: "مساعدة ذكاء اصطناعي", icon: "message.fill")
                    }
                }
                .listStyle(InsetGroupedListStyle())
                .scrollContentBackground(.hidden)
            }
            .navigationTitle("الإعدادات")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(
                trailing: Button("إغلاق") {
                    presentationMode.wrappedValue.dismiss()
                }
                .foregroundColor(.white)
            )
        }
        .environment(\.layoutDirection, .rightToLeft)
    }
}

struct SettingRow: View {
    let title: String
    let icon: String
    
    var body: some View {
        HStack {
            Image(systemName: icon)
                .font(.title3)
                .foregroundColor(.white)
                .frame(width: 30)
            
            Text(title)
                .font(.headline)
                .foregroundColor(.white)
            
            Spacer()
            
            Image(systemName: "chevron.right")
                .font(.caption)
                .foregroundColor(.white.opacity(0.6))
        }
        .padding(.vertical, 5)
        .listRowBackground(Color.gray.opacity(0.1))
    }
}

