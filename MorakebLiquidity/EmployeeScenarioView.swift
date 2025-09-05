import SwiftUI
import Charts

struct EmployeeScenarioView: View {
    @State private var selectedPercentage = "15%"
    @State private var selectedDuration = "سنة"
    @State private var showingResults = false
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.black.ignoresSafeArea()
                
                ScrollView {
                    VStack(spacing: 25) {
                        titleSection
                        controlsSection
                        if showingResults {
                            resultsSection
                        }
                    }
                    .padding()
                }
            }
            .navigationTitle("السيناريوهات")
            .navigationBarTitleDisplayMode(.large)
        }
    }
    
    private var titleSection: some View {
        Text("محرك السيناريوهات")
            .font(.largeTitle)
            .fontWeight(.bold)
            .foregroundColor(.white)
            .padding(.top)
    }
    
    private var controlsSection: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("تشغيل سيناريو")
                .font(.headline)
                .foregroundColor(.white)
            
            percentageButtons
            durationButtons
            runButton
        }
        .padding()
        .background(cardBackground)
    }
    
    private var percentageButtons: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("النسبة المئوية")
                .font(.subheadline)
                .foregroundColor(.white.opacity(0.8))
            
            HStack(spacing: 15) {
                percentageButton("15%")
                percentageButton("25%")
                percentageButton("30%")
            }
        }
    }
    
    private func percentageButton(_ percentage: String) -> some View {
        Button(action: {
            selectedPercentage = percentage
        }) {
            Text(percentage)
                .font(.headline)
                .foregroundColor(selectedPercentage == percentage ? .black : .white)
                .frame(width: 80, height: 40)
                .background(selectedPercentage == percentage ? Color.white : Color.clear)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.white, lineWidth: 1)
                )
                .cornerRadius(8)
        }
    }
    
    private var durationButtons: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("المدة الزمنية")
                .font(.subheadline)
                .foregroundColor(.white.opacity(0.8))
            
            HStack(spacing: 15) {
                durationButton("6 شهور")
                durationButton("سنة")
                durationButton("سنتين")
            }
        }
    }
    
    private func durationButton(_ duration: String) -> some View {
        Button(action: {
            selectedDuration = duration
        }) {
            Text(duration)
                .font(.headline)
                .foregroundColor(selectedDuration == duration ? .black : .white)
                .frame(height: 40)  // ← الحل
                .frame(minWidth: 80)  // ← منفصل
                .padding(.horizontal, 10)
                .background(selectedDuration == duration ? Color.white : Color.clear)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.white, lineWidth: 1)
                )
                .cornerRadius(8)
        }
    }
    
    private var runButton: some View {
        Button(action: {
            showingResults = true
        }) {
            Text("تشغيل السيناريو")
                .font(.title2)
                .fontWeight(.semibold)
                .foregroundColor(.black)
                .frame(maxWidth: .infinity)
                .frame(height: 55)
                .background(Color.white)
                .cornerRadius(15)
        }
    }
    
    private var resultsSection: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("النتائج")
                .font(.headline)
                .foregroundColor(.white)
            
            Text("تأثير انخفاض أسعار النفط -15%")
                .font(.title3)
                .fontWeight(.semibold)
                .foregroundColor(.red)
            
            chartView
        }
        .padding()
        .background(cardBackground)
    }
    
    private var chartView: some View {
        Group {
            if #available(iOS 16.0, *) {
                Chart {
                    ForEach(getScenarioData()) { data in
                        LineMark(
                            x: .value("الشهر", data.month),
                            y: .value("التأثير", data.impact)
                        )
                        .foregroundStyle(.red)
                        .lineStyle(StrokeStyle(lineWidth: 3))
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
    }
    
    private var cardBackground: some View {
        RoundedRectangle(cornerRadius: 15)
            .fill(Color.gray.opacity(0.1))
            .stroke(Color.white.opacity(0.2), lineWidth: 1)
    }
    
    private func getScenarioData() -> [ScenarioResult] {
        return [
            ScenarioResult(month: 1, impact: -2),
            ScenarioResult(month: 2, impact: -3),
            ScenarioResult(month: 3, impact: -4),
            ScenarioResult(month: 4, impact: -5),
            ScenarioResult(month: 5, impact: -4.5),
            ScenarioResult(month: 6, impact: -3.5),
            ScenarioResult(month: 7, impact: -3),
            ScenarioResult(month: 8, impact: -2.5),
            ScenarioResult(month: 9, impact: -2),
            ScenarioResult(month: 10, impact: -1.5),
            ScenarioResult(month: 11, impact: -1),
            ScenarioResult(month: 12, impact: -0.5)
        ]
    }
}
