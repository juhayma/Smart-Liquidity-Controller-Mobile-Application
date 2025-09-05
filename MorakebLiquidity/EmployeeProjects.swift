import SwiftUI

struct EmployeeProjectsView: View {
    var body: some View {
        NavigationView {
            ZStack {
                Color.black.ignoresSafeArea()
                
                ScrollView {
                    VStack(spacing: 20) {
                        ForEach(getSampleProjects(), id: \.name) { project in
                            ProjectCard(project: project)
                        }
                    }
                    .padding()
                }
            }
            .navigationTitle("المشاريع")
            .navigationBarTitleDisplayMode(.large)
        }
    }
    
    func getSampleProjects() -> [Project] {
        return [
            Project(name: "تطوير نظام المراقبة", status: "قيد التنفيذ", progress: 0.75, deadline: "30 أغسطس"),
            Project(name: "تحديث أنظمة الأمان", status: "مكتمل", progress: 1.0, deadline: "15 يوليو"),
            Project(name: "توسيع الفروع", status: "التخطيط", progress: 0.25, deadline: "30 سبتمبر")
        ]
    }
}

struct Project {
    let name: String
    let status: String
    let progress: Double
    let deadline: String
}

struct ProjectCard: View {
    let project: Project
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            HStack {
                Text(project.name)
                    .font(.headline)
                    .foregroundColor(.white)
                
                Spacer()
                
                Text(project.status)
                    .font(.caption)
                    .foregroundColor(statusColor)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 5)
                    .background(statusColor.opacity(0.2))
                    .cornerRadius(8)
            }
            
            ProgressView(value: project.progress)
                .progressViewStyle(LinearProgressViewStyle(tint: .white))
            
            HStack {
                Text("الموعد النهائي: \(project.deadline)")
                    .font(.caption)
                    .foregroundColor(.white.opacity(0.8))
                
                Spacer()
                
                Text("\(Int(project.progress * 100))%")
                    .font(.caption)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 15)
                .fill(Color.gray.opacity(0.1))
                .stroke(Color.white.opacity(0.2), lineWidth: 1)
        )
    }
    
    var statusColor: Color {
        switch project.status {
        case "مكتمل":
            return .green
        case "قيد التنفيذ":
            return .blue
        case "التخطيط":
            return .orange
        default:
            return .gray
        }
    }
}

