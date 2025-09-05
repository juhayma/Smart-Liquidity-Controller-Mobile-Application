import SwiftUI

struct EmployeeDashboardView: View {
    let user: User
    @Environment(\.dismiss) private var dismiss
    @State private var selectedTab = 0
    @State private var showingAdvancedAnalytics = false
    @State private var animateValues = false
    @State private var currentTime = Date()
    
    // Real-time data simulation
    @State private var loanRequests = 12
    @State private var withdrawalRate = 3.2
    @State private var majorTransfers = 8
    @State private var liquidityLevel = 125.5
    @State private var alertsCount = 3
    
    let timer = Timer.publish(every: 3, on: .main, in: .common).autoconnect()
    
    var body: some View {
        NavigationView {
            ZStack {
                // الخلفية الداكنة33
                LinearGradient(
                    gradient: Gradient(colors: [Color.black, Color.gray.opacity(0.9)]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()
                
                VStack(spacing: 0) {
                    ScrollView {
                        VStack(spacing: 20) {
                            // الهيدر
                            headerWithAnalyticsButton
                            
                            // البطاقات السريعة
                            quickStatsSection
                            
                            // المحتوى حسب التبويب المحدد
                            Group {
                                switch selectedTab {
                                case 0:
                                    dashboardOverviewSection
                                case 1:
                                    alertsAndPredictionsSection
                                case 2:
                                    loanRequestsSection
                                case 3:
                                    transactionsSection
                                case 4:
                                    InteractiveScenariosView()
                                case 5:
                                    tradingInvestmentSection
                                case 6:
                                    projectsSection
                                default:
                                    dashboardOverviewSection
                                }
                            }
                        }
                        .padding(.bottom, 80) // مساحة عشان التبويبات ما تغطي المحتوى
                        .padding(.top)
                    }
                    
                    // ✅ شريط التنقل في الأسفل
                    tabNavigationView
                        .padding(.bottom, 10)
                }
            }
            .environment(\.layoutDirection, .rightToLeft)
            .navigationBarHidden(true)
            .onReceive(timer) { _ in
                currentTime = Date()
                updateRealTimeData()
            }
            .onAppear {
                startAnimations()
            }
        }
        .fullScreenCover(isPresented: $showingAdvancedAnalytics) {
            AdvancedAnalyticsView(user: user)
        }
    }
    // MARK: - Header with Advanced Analytics Button
    var headerWithAnalyticsButton: some View {
        VStack(spacing: 15) {
            HStack {
                VStack(alignment: .leading) {
                    Text("سيولة البنوك")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                    
                    Text("مرحباً، \(user.fullName)")
                        .font(.subheadline)
                        .foregroundColor(.cyan)
                }
                
                Spacer()
                
                VStack {
                    Text(currentTime, style: .time)
                        .font(.headline)
                        .foregroundColor(.white)
                    
                    Text("الوقت الحالي")
                        .font(.caption)
                        .foregroundColor(.gray)
                }
            }
            
            // Advanced Analytics Button - This is the magic button!
            Button(action: {
                showingAdvancedAnalytics = true
            }) {
                HStack {
                    Image(systemName: "brain.head.profile")
                        .font(.title2)
                    
                    VStack(alignment: .leading) {
                        Text("التحليل المتقدم بالذكاء الاصطناعي")
                            .font(.headline)
                            .fontWeight(.bold)
                        Text(" • تحليل المخاطر • التنبؤات")
                            .font(.caption)
                    }
                    
                    Spacer()
                    
                    Image(systemName: "arrow.right.circle.fill")
                        .font(.title)
                        .scaleEffect(animateValues ? 1.1 : 1.0)
                }
                .foregroundColor(.white)
                .padding()
                .background(
                    LinearGradient(
                        gradient: Gradient(colors: [Color.cyan, Color.blue]),
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                )
                .cornerRadius(16)
                .shadow(color: .cyan.opacity(0.3), radius: 10)
            }
            
            HStack {
                Button(action: { dismiss() }) {
                    HStack {
                        Image(systemName: "rectangle.portrait.and.arrow.right")
                        Text("تسجيل خروج")
                    }
                    .foregroundColor(.white)
                    .font(.caption)
                }
                
                Spacer()
                
                // Status indicator
                HStack {
                    Circle()
                        .fill(Color.green)
                        .frame(width: 8, height: 8)
                        .scaleEffect(animateValues ? 1.2 : 1.0)
                    
                    Text("النظام نشط")
                        .font(.caption)
                        .foregroundColor(.green)
                }
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color.black.opacity(0.6))
        )
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
                Text(value)
                    .font(.title2)
                    .fontWeight(.bold)
            }
            .padding()
            .frame(width: 160, height: 120)
            .background(Color.white)
            .cornerRadius(12)
            .shadow(radius: 4)
        }
    }
    var quickStatsSection: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 15) {
                QuickStatCard(
                    title: "مستوى السيولة",
                    value: String(format: "%.1f%%", liquidityLevel),
                    icon: "drop.fill",  // ← أضفنا أيقونة مناسبة هنا
                    color: liquidityLevel > 120 ? .green : liquidityLevel > 100 ? .orange : .red
                )

                QuickStatCard(
                    title: "طلبات القروض",
                    value: "\(loanRequests)",
                    icon: "doc.text.fill",
                    color: .blue
                )

                QuickStatCard(
                    title: "معدل السحب",
                    value: String(format: "%.1f%%", withdrawalRate),
                    icon: "minus.circle.fill",
                    color: withdrawalRate > 5 ? .red : withdrawalRate > 3 ? .orange : .green
                )

                QuickStatCard(
                    title: "التحويلات الكبرى",
                    value: "\(majorTransfers)",
                    icon: "arrow.left.arrow.right.circle.fill",
                    color: .purple
                )

                QuickStatCard(
                    title: "التنبيهات",
                    value: "\(alertsCount)",
                    icon: "bell.badge.fill",
                    color: alertsCount > 5 ? .red : alertsCount > 2 ? .orange : .green
                )
            }
            .padding(.horizontal)
        }
    }
    // MARK: - Tab Navigation
    var tabNavigationView: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 5) {
                ForEach(0..<7) { index in
                    Button(action: { selectedTab = index }) {
                        VStack(spacing: 4) {
                            Image(systemName: tabIcon(for: index))
                                .font(.title3)
                            Text(tabTitle(for: index))
                                .font(.caption2)
                        }
                        .foregroundColor(selectedTab == index ? .black : .white)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 8)
                        .background(
                            selectedTab == index ? Color.cyan : Color.clear
                        )
                        .cornerRadius(20)
                    }
                }
            }
            .padding(.horizontal)
        }
        .padding(.vertical, 5)
        .background(
            RoundedRectangle(cornerRadius: 25)
                .fill(Color.black.opacity(0.4))
        )
    }
    
    // MARK: - Dashboard Overview Section
    var dashboardOverviewSection: some View {
        VStack(spacing: 15) {
            Text("نظرة عامة على النظام")
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(.white)
            
            // Live Chart Simulation
            VStack(alignment: .leading, spacing: 10) {
                Text("مؤشر السيولة المباشر")
                    .font(.headline)
                    .foregroundColor(.white)
                
                GeometryReader { geometry in
                    HStack(alignment: .bottom, spacing: 2) {
                        ForEach(0..<20) { i in
                            let height = CGFloat.random(in: 30...geometry.size.height)
                            
                            Rectangle()
                                .fill(height > geometry.size.height * 0.6 ? Color.green : Color.red)
                                .frame(
                                    width: geometry.size.width / 20 - 2,
                                    height: height
                                )
                                .animation(.easeInOut(duration: 2).delay(Double(i) * 0.1), value: animateValues)
                        }
                    }
                }
                .frame(height: 120)
                .background(Color.black.opacity(0.4))
                .cornerRadius(12)
            }

            // System Health
            SystemHealthCard(
                cpuUsage: 67,
                memoryUsage: 45,
                networkStatus: "مستقر",
                lastUpdate: "قبل دقيقتين"
            )
        }
    }
    
    // **MARK: - Alerts and Predictions Section**
    var alertsAndPredictionsSection: some View {
        VStack(spacing: 15) {
            Text("التنبيهات والتنبؤات")
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(.white)
            
            // Prediction Cards
            PredictionCard(
                title: "توقع السيولة - الأسبوع القادم",
                prediction: "انخفاض محتمل بنسبة 5%",
                confidence: 87,
                action: "مراقبة مشددة"
            )
            
            PredictionCard(
                title: "توقع طلبات القروض",
                prediction: "زيادة متوقعة 15%",
                confidence: 92,
                action: "تجهيز الموارد"
            )
            
            // AI Financial Monitor Chat Section
            FinancialMonitorChatSection()
            
            // Recent Alerts
            VStack(alignment: .leading, spacing: 10) {
                Text("آخر التنبيهات")
                    .font(.headline)
                    .foregroundColor(.white)
                
                AlertItemView(
                    title: "تحويل كبير غير اعتيادي",
                    description: "تحويل بقيمة 2.5 مليون ريال",
                    time: "قبل 15 دقيقة",
                    severity: .warning
                )
                
                AlertItemView(
                    title: "انخفاض في الودائع",
                    description: "انخفاض 3% في إجمالي الودائع",
                    time: "قبل ساعة",
                    severity: .critical
                )
                
                AlertItemView(
                    title: "النظام يعمل بشكل طبيعي",
                    description: "جميع المؤشرات ضمن المعدل",
                    time: "قبل ساعتين",
                    severity: .stable
                )
            }
        }
    }

    // **MARK: - Financial Monitor Chat Section**
    struct FinancialMonitorChatSection: View {
        @State private var isExpanded = false
        @State private var chatMessages: [ChatMessage] = [
            ChatMessage(id: UUID(), text: "مرحباً! أنا المراقب المالي الذكي. كيف يمكنني مساعدتك؟", isUser: false, timestamp: Date().addingTimeInterval(-300))
        ]
        @State private var currentMessage = ""
        @State private var isTyping = false
        
        var body: some View {
            VStack(spacing: 12) {
                // Header
                HStack {
                    Image(systemName: "brain.head.profile")
                        .foregroundColor(.blue)
                        .font(.title2)
                    
                    Text("المراقب المالي الذكي")
                        .font(.headline)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                    
                    Spacer()
                    
                    Button(action: {
                        withAnimation(.spring()) {
                            isExpanded.toggle()
                        }
                    }) {
                        Image(systemName: isExpanded ? "chevron.up" : "chevron.down")
                            .foregroundColor(.white)
                            .font(.caption)
                    }
                }
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 12)
                        .fill(Color.blue.opacity(0.2))
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(Color.blue.opacity(0.3), lineWidth: 1)
                        )
                )
                .onTapGesture {
                    withAnimation(.spring()) {
                        isExpanded.toggle()
                    }
                }
                
                // Chat Interface (Expandable)
                if isExpanded {
                    VStack(spacing: 0) {
                        // Chat Messages
                        ScrollView {
                            LazyVStack(spacing: 8) {
                                ForEach(chatMessages) { message in
                                    ChatBubble(message: message)
                                }
                                
                                if isTyping {
                                    TypingIndicator()
                                }
                            }
                            .padding(.horizontal)
                        }
                        .frame(height: 200)
                        .background(Color.black.opacity(0.2))
                        
                        // Input Field
                        HStack(spacing: 12) {
                            TextField("اسأل المراقب المالي...", text: $currentMessage)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .environment(\.layoutDirection, .rightToLeft)
                            
                            Button(action: sendMessage) {
                                Image(systemName: "paperplane.fill")
                                    .foregroundColor(.blue)
                                    .font(.system(size: 16))
                            }
                            .disabled(currentMessage.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
                        }
                        .padding()
                        .background(Color.gray.opacity(0.1))
                    }
                    .background(
                        RoundedRectangle(cornerRadius: 12)
                            .fill(Color.black.opacity(0.3))
                            .overlay(
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(Color.blue.opacity(0.2), lineWidth: 1)
                            )
                    )
                    .transition(.opacity.combined(with: .scale(scale: 0.95)))
                }
            }
        }
        
        private func sendMessage() {
            let userMessage = currentMessage.trimmingCharacters(in: .whitespacesAndNewlines)
            guard !userMessage.isEmpty else { return }
            
            // Add user message
            let newUserMessage = ChatMessage(id: UUID(), text: userMessage, isUser: true, timestamp: Date())
            chatMessages.append(newUserMessage)
            
            currentMessage = ""
            isTyping = true
            
            // Simulate AI response
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                isTyping = false
                let aiResponse = generateAIResponse(for: userMessage)
                let aiMessage = ChatMessage(id: UUID(), text: aiResponse, isUser: false, timestamp: Date())
                chatMessages.append(aiMessage)
            }
        }
        
        private func generateAIResponse(for message: String) -> String {
            let lowercasedMessage = message.lowercased()
            
            if lowercasedMessage.contains("سيولة") || lowercasedMessage.contains("نقدية") {
                return "وفقاً للبيانات الحالية، مستوى السيولة مستقر بنسبة 78%. أنصح بمراقبة التحويلات الكبيرة خلال الساعات القادمة."
            } else if lowercasedMessage.contains("قروض") || lowercasedMessage.contains("تمويل") {
                return "طلبات القروض في ازدياد بنسبة 12% هذا الأسبوع. يُنصح بمراجعة معايير الموافقة للحفاظ على التوازن."
            } else if lowercasedMessage.contains("تنبيه") || lowercasedMessage.contains("إنذار") {
                return "تم رصد 3 تنبيهات جديدة: تحويلان كبيران وانخفاض طفيف في الودائع. جميعها ضمن المعدلات المقبولة."
            } else if lowercasedMessage.contains("تحليل") || lowercasedMessage.contains("إحصائية") {
                return "التحليل الشامل يُظهر أداءً مستقراً مع نمو 2.5% في العمليات المصرفية مقارنة بالأسبوع الماضي."
            } else {
                return "فهمت استفسارك. دعني أحلل البيانات المالية الحالية وأقدم لك التوصيات المناسبة خلال لحظات."
            }
        }
    }

    // **MARK: - Chat Message Model**
    struct ChatMessage: Identifiable {
        let id: UUID
        let text: String
        let isUser: Bool
        let timestamp: Date
    }

    // **MARK: - Chat Bubble View**
    struct ChatBubble: View {
        let message: ChatMessage
        
        var body: some View {
            HStack {
                if message.isUser {
                    Spacer()
                    
                    VStack(alignment: .trailing, spacing: 4) {
                        Text(message.text)
                            .padding(.horizontal, 12)
                            .padding(.vertical, 8)
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(16)
                            .multilineTextAlignment(.trailing)
                        
                        Text(timeString(from: message.timestamp))
                            .font(.caption2)
                            .foregroundColor(.gray)
                    }
                } else {
                    VStack(alignment: .leading, spacing: 4) {
                        Text(message.text)
                            .padding(.horizontal, 12)
                            .padding(.vertical, 8)
                            .background(Color.gray.opacity(0.3))
                            .foregroundColor(.white)
                            .cornerRadius(16)
                            .multilineTextAlignment(.leading)
                        
                        Text(timeString(from: message.timestamp))
                            .font(.caption2)
                            .foregroundColor(.gray)
                    }
                    
                    Spacer()
                }
            }
            .environment(\.layoutDirection, .rightToLeft)
        }
        
        private func timeString(from date: Date) -> String {
            let formatter = DateFormatter()
            formatter.dateFormat = "HH:mm"
            formatter.locale = Locale(identifier: "ar")
            return formatter.string(from: date)
        }
    }

    // **MARK: - Typing Indicator**
    struct TypingIndicator: View {
        @State private var animationOffset: CGFloat = 0
        
        var body: some View {
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    HStack(spacing: 4) {
                        ForEach(0..<3) { index in
                            Circle()
                                .fill(Color.gray)
                                .frame(width: 8, height: 8)
                                .scaleEffect(animationOffset == CGFloat(index) ? 1.2 : 0.8)
                                .animation(
                                    Animation.easeInOut(duration: 0.6)
                                        .repeatForever()
                                        .delay(Double(index) * 0.2),
                                    value: animationOffset
                                )
                        }
                    }
                    .padding(.horizontal, 12)
                    .padding(.vertical, 8)
                    .background(Color.gray.opacity(0.3))
                    .cornerRadius(16)
                    
                    Text("يكتب...")
                        .font(.caption2)
                        .foregroundColor(.gray)
                }
                
                Spacer()
            }
            .onAppear {
                animationOffset = 2
            }
            .environment(\.layoutDirection, .rightToLeft)
        }
    }
    
    // MARK: - Loan Requests Section
    var loanRequestsSection: some View {
        VStack(spacing: 15) {
            HStack {
                Text("طلبات القروض")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                
                Spacer()
                
                Badge(text: "\(loanRequests) طلب", color: .blue)
            }
            
            // Loan Request Cards
            ForEach(1...3, id: \.self) { index in
                LoanRequestCard(
                    clientName: "عميل رقم \(1000 + index)",
                    amount: Double.random(in: 50000...500000),
                    type: index == 1 ? "شخصي" : index == 2 ? "عقاري" : "تجاري",
                    status: index == 1 ? "قيد المراجعة" : index == 2 ? "معتمد" : "مرفوض",
                    submissionDate: "2025/01/\(30 - index)"
                )
            }
            
            // Quick Actions
            HStack(spacing: 15) {
                Button("مراجعة الطلبات") {
                    // Action
                }
                .font(.caption)
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(20)
                
                Button("إنشاء تقرير") {
                    // Action
                }
                .font(.caption)
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
                .background(Color.gray.opacity(0.3))
                .foregroundColor(.white)
                .cornerRadius(20)
            }
        }
    }
    
    // MARK: - Transactions Section
    var transactionsSection: some View {
        VStack(spacing: 15) {
            Text("المعاملات والتحويلات")
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(.white)
            
            // Transaction Summary
            HStack(spacing: 20) {
                TransactionSummaryCard(
                    title: "إجمالي المعاملات اليوم",
                    count: 1247,
                    amount: 12.5,
                    color: .green
                )
                
                TransactionSummaryCard(
                    title: "التحويلات الكبرى",
                    count: majorTransfers,
                    amount: 45.2,
                    color: .orange
                )
            }
            
            // Major Transfers List
            VStack(alignment: .leading, spacing: 10) {
                Text("التحويلات الكبرى الأخيرة")
                    .font(.headline)
                    .foregroundColor(.white)
                
                ForEach(1...4, id: \.self) { index in
                    TransferItemView(
                        fromAccount: "حساب \(1000 + index)",
                        toAccount: "حساب \(2000 + index)",
                        amount: Double.random(in: 100000...1000000),
                        time: "\(index * 15) دقيقة مضت",
                        status: index <= 2 ? "مكتمل" : "قيد المعالجة"
                    )
                }
            }
        }
    }
    
    // MARK: - Scenarios Section
    var scenariosSection: some View {
        VStack(spacing: 15) {
            Text("تحليل السيناريوهات")
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(.white)
            
            ScenarioAnalysisCard(
                title: "سيناريو الضغط المعتدل",
                probability: 25,
                impact: "متوسط",
                description: "انخفاض الودائع بنسبة 15% خلال 30 يوم",
                recommendations: ["زيادة احتياطي السيولة", "مراقبة معدل السحب"],
                color: .orange
            )
            
            ScenarioAnalysisCard(
                title: "سيناريو الضغط الشديد",
                probability: 8,
                impact: "عالي",
                description: "هبوط حاد في السوق وسحوبات كثيفة",
                recommendations: ["إيقاف القروض الجديدة", "تفعيل خط الائتمان الطارئ"],
                color: .red
            )
            
            ScenarioAnalysisCard(
                title: "السيناريو المتفائل",
                probability: 67,
                impact: "إيجابي",
                description: "نمو مستقر في الودائع والاستثمارات",
                recommendations: ["توسيع المحفظة الاستثمارية", "إطلاق منتجات جديدة"],
                color: .green
            )
        }
    }
    
    // MARK: - Trading and Investment Section
    var tradingInvestmentSection: some View {
        VStack(spacing: 15) {
            Text("التداول والاستثمار")
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(.white)
            
            // Market Indicators
            HStack(spacing: 15) {
                MarketIndicatorCard(
                    title: "مؤشر السوق السعودي",
                    value: "11,247",
                    change: -2.3,
                    color: .red
                )
                
                MarketIndicatorCard(
                    title: "أسعار النفط",
                    value: "$78.45",
                    change: +1.8,
                    color: .green
                )
            }
            
            HStack(spacing: 15) {
                MarketIndicatorCard(
                    title: "سعر الصرف USD/SAR",
                    value: "3.751",
                    change: +0.12,
                    color: .green
                )
                
                MarketIndicatorCard(
                    title: "الذهب (أونصة)",
                    value: "$2,045",
                    change: -0.5,
                    color: .red
                )
            }
            
            // Investment Portfolio
            InvestmentPortfolioCard(
                totalValue: 156.7,
                dailyChange: +2.4,
                topHoldings: [
                    ("أرامكو", 35.2),
                    ("الراجحي", 28.1),
                    ("سابك", 15.6)
                ]
            )
        }
    }
    
    // MARK: - Projects Section
    var projectsSection: some View {
        VStack(spacing: 15) {
            Text("المشاريع الجارية")
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(.white)
            
            ProjectProgressCard(
                title: "تطوير نظام الإنذار المبكر",
                progress: 0.75,
                deadline: "15 يناير 2025",
                team: "فريق التطوير",
                priority: "عالي"
            )
            
            ProjectProgressCard(
                title: "تحديث أنظمة الأمان السيبراني",
                progress: 0.45,
                deadline: "28 فبراير 2025",
                team: "فريق الأمان",
                priority: "متوسط"
            )
            
            ProjectProgressCard(
                title: "دمج الذكاء الاصطناعي في التحليلات",
                progress: 0.90,
                deadline: "5 يناير 2025",
                team: "فريق الابتكار",
                priority: "عالي"
            )
            
            ProjectProgressCard(
                title: "تطوير تطبيق العملاء الجديد",
                progress: 0.30,
                deadline: "15 مارس 2025",
                team: "فريق UX/UI",
                priority: "منخفض"
            )
        }
    }
    
    // MARK: - Helper Functions
    func tabIcon(for index: Int) -> String {
        switch index {
        case 0: return "house.fill"
        case 1: return "exclamationmark.triangle.fill"
        case 2: return "doc.text.fill"
        case 3: return "arrow.left.arrow.right.circle"
        case 4: return "chart.bar.fill"
        case 5: return "chart.line.uptrend.xyaxis"
        case 6: return "folder.fill"
        default: return "circle"
        }
    }
    
    func tabTitle(for index: Int) -> String {
        switch index {
        case 0: return "الرئيسية"
        case 1: return "التنبيهات"
        case 2: return "القروض"
        case 3: return "المعاملات"
        case 4: return "السيناريوهات"
        case 5: return "التداول"
        case 6: return "المشاريع"
        default: return ""
        }
    }
    
    func startAnimations() {
        withAnimation(Animation.easeInOut(duration: 2).repeatForever()) {
            animateValues = true
        }
    }
    
    func updateRealTimeData() {
        withAnimation(.easeInOut(duration: 1)) {
            loanRequests += Int.random(in: -1...2)
            withdrawalRate += Double.random(in: -0.2...0.3)
            majorTransfers += Int.random(in: -1...2)
            liquidityLevel += Double.random(in: -1...2)
            alertsCount = max(0, alertsCount + Int.random(in: -1...1))
            
            // Keep values in realistic ranges
            loanRequests = max(5, min(20, loanRequests))
            withdrawalRate = max(1.0, min(8.0, withdrawalRate))
            majorTransfers = max(3, min(15, majorTransfers))
            liquidityLevel = max(90, min(150, liquidityLevel))
        }
    }
}

// MARK: - Supporting Views

struct DetailedStatCard: View {
    let title: String
    let value: String
    let icon: String
    let color: Color
    let trend: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Image(systemName: icon)
                    .foregroundColor(color)
                    .font(.title2)
                Spacer()
                Text(trend)
                    .font(.caption)
                    .fontWeight(.bold)
                    .foregroundColor(color)
            }
            
            Text(value)
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.white)
            
            Text(title)
                .font(.caption)
                .foregroundColor(.gray)
        }
        .padding()
        .frame(width: 140, height: 100)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.black.opacity(0.6))
        )
    }
}

struct SystemHealthCard: View {
    let cpuUsage: Int
    let memoryUsage: Int
    let networkStatus: String
    let lastUpdate: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("حالة النظام")
                .font(.headline)
                .foregroundColor(.white)
            
            HStack {
                VStack(alignment: .leading) {
                    Text("المعالج: \(cpuUsage)%")
                        .foregroundColor(.white)
                    ProgressView(value: Double(cpuUsage), total: 100)
                        .progressViewStyle(LinearProgressViewStyle(tint: cpuUsage > 80 ? .red : .green))
                }
                
                Spacer()
                
                VStack(alignment: .leading) {
                    Text("الذاكرة: \(memoryUsage)%")
                        .foregroundColor(.white)
                    ProgressView(value: Double(memoryUsage), total: 100)
                        .progressViewStyle(LinearProgressViewStyle(tint: memoryUsage > 80 ? .red : .green))
                }
            }
            
            HStack {
                Text("الشبكة: \(networkStatus)")
                    .foregroundColor(.green)
                Spacer()
                Text("آخر تحديث: \(lastUpdate)")
                    .font(.caption)
                    .foregroundColor(.gray)
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.black.opacity(0.4))
        )
    }
}

// Continue with more supporting views...
struct PredictionCard: View {
    let title: String
    let prediction: String
    let confidence: Int
    let action: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Image(systemName: "brain.head.profile")
                    .foregroundColor(.cyan)
                Text(title)
                    .font(.headline)
                    .foregroundColor(.white)
                Spacer()
                Text("\(confidence)%")
                    .font(.caption)
                    .fontWeight(.bold)
                    .foregroundColor(.cyan)
            }
            
            Text(prediction)
                .font(.subheadline)
                .foregroundColor(.white)
            
            Text("الإجراء المقترح: \(action)")
                .font(.caption)
                .foregroundColor(.orange)
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.black.opacity(0.4))
        )
    }
}

struct AlertItemView: View {
    let title: String
    let description: String
    let time: String
    let severity: AlertSeverity
    
    var body: some View {
        HStack {
            Rectangle()
                .fill(severity.color)
                .frame(width: 4)
            
            VStack(alignment: .leading, spacing: 4) {
                HStack {
                    Text(title)
                        .font(.headline)
                        .foregroundColor(.white)
                    Spacer()
                    Text(time)
                        .font(.caption)
                        .foregroundColor(.gray)
                }
                
                Text(description)
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            .padding(.leading, 8)
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 8)
                .fill(Color.black.opacity(0.3))
        )
    }
}

enum AlertSeverity {
    case critical, warning, stable
    
    var color: Color {
        switch self {
        case .critical: return .red
        case .warning: return .orange
        case .stable: return .green
        }
    }
}

struct Badge: View {
    let text: String
    let color: Color
    
    var body: some View {
        Text(text)
            .font(.caption)
            .fontWeight(.bold)
            .padding(.horizontal, 8)
            .padding(.vertical, 4)
            .background(color)
            .foregroundColor(.white)
            .cornerRadius(12)
    }
}

struct LoanRequestCard: View {
    let clientName: String
    let amount: Double
    let type: String
    let status: String
    let submissionDate: String
    
    var statusColor: Color {
        switch status {
        case "معتمد": return .green
        case "مرفوض": return .red
        default: return .orange
        }
    }
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text(clientName)
                    .font(.headline)
                    .foregroundColor(.white)
                
                Text("\(Int(amount/1000))K ريال - \(type)")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                
                Text("تاريخ التقديم: \(submissionDate)")
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            
            Spacer()
            
            Badge(text: status, color: statusColor)
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.black.opacity(0.4))
        )
    }
}

struct TransactionSummaryCard: View {
    let title: String
    let count: Int
    let amount: Double
    let color: Color
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.caption)
                .foregroundColor(.gray)
            
            Text("\(count)")
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(color)
            
            Text("\(amount, specifier: "%.1f")M ريال")
                .font(.caption)
                .foregroundColor(.white)
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.black.opacity(0.4))
        )
    }
}

struct TransferItemView: View {
    let fromAccount: String
    let toAccount: String
    let amount: Double
    let time: String
    let status: String
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text("من: \(fromAccount) → إلى: \(toAccount)")
                    .font(.headline)
                    .foregroundColor(.white)
                
                Text("\(Int(amount/1000))K ريال")
                    .font(.subheadline)
                    .foregroundColor(.cyan)
                
                Text(time)
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            
            Spacer()
            
            Badge(text: status, color: status == "مكتمل" ? .green : .orange)
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 8)
                .fill(Color.black.opacity(0.3))
        )
    }
}

struct ScenarioAnalysisCard: View {
    let title: String
    let probability: Int
    let impact: String
    let description: String
    let recommendations: [String]
    let color: Color
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Text(title)
                    .font(.headline)
                    .foregroundColor(.white)
                
                Spacer()
                
                Text("\(probability)%")
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundColor(color)
            }
            
            Text("التأثير: \(impact)")
                .font(.subheadline)
                .foregroundColor(color)
            
            Text(description)
                .font(.caption)
                .foregroundColor(.gray)
            
            VStack(alignment: .leading, spacing: 4) {
                Text("التوصيات:")
                    .font(.caption)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                
                ForEach(recommendations, id: \.self) { recommendation in
                    Text("• \(recommendation)")
                        .font(.caption2)
                        .foregroundColor(.gray)
                }
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.black.opacity(0.4))
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(color, lineWidth: 1)
                )
        )
    }
}

struct MarketIndicatorCard: View {
    let title: String
    let value: String
    let change: Double
    let color: Color
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.caption)
                .foregroundColor(.gray)
            
            Text(value)
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(.white)
            
            HStack {
                Image(systemName: change >= 0 ? "arrow.up" : "arrow.down")
                    .foregroundColor(color)
                    .font(.caption)
                
                Text(String(format: "%.1f%%", abs(change)))
                    .font(.caption)
                    .foregroundColor(color)
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.black.opacity(0.4))
        )
    }
}

struct InvestmentPortfolioCard: View {
    let totalValue: Double
    let dailyChange: Double
    let topHoldings: [(String, Double)]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Text("المحفظة الاستثمارية")
                    .font(.headline)
                    .foregroundColor(.white)
                
                Spacer()
                
                VStack(alignment: .trailing) {
                    Text("\(totalValue, specifier: "%.1f")M ريال")
                        .font(.title3)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                    
                    Text(String(format: "%+.1f%%", dailyChange))
                        .font(.caption)
                        .foregroundColor(dailyChange >= 0 ? .green : .red)
                }
            }
            
            VStack(alignment: .leading, spacing: 4) {
                Text("أكبر الاستثمارات:")
                    .font(.caption)
                    .foregroundColor(.gray)
                
                ForEach(topHoldings, id: \.0) { holding in
                    HStack {
                        Text(holding.0)
                            .font(.caption2)
                            .foregroundColor(.white)
                        
                        Spacer()
                        
                        Text("\(holding.1, specifier: "%.1f")M")
                            .font(.caption2)
                            .foregroundColor(.cyan)
                    }
                }
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.black.opacity(0.4))
        )
    }
}

struct ProjectProgressCard: View {
    let title: String
    let progress: Double
    let deadline: String
    let team: String
    let priority: String
    
    var priorityColor: Color {
        switch priority {
        case "عالي": return .red
        case "متوسط": return .orange
        case "منخفض": return .green
        default: return .gray
        }
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Text(title)
                    .font(.headline)
                    .foregroundColor(.white)
                
                Spacer()
                
                Badge(text: priority, color: priorityColor)
            }
            
            HStack {
                Text(team)
                    .font(.caption)
                    .foregroundColor(.gray)
                
                Spacer()
                
                Text("التسليم: \(deadline)")
                    .font(.caption)
                    .foregroundColor(.orange)
            }
            
            VStack(alignment: .leading, spacing: 4) {
                HStack {
                    Text("التقدم")
                        .font(.caption)
                        .foregroundColor(.white)
                    
                    Spacer()
                    
                    Text("\(Int(progress * 100))%")
                        .font(.caption)
                        .fontWeight(.bold)
                        .foregroundColor(.cyan)
                }
                
                ProgressView(value: progress)
                    .progressViewStyle(LinearProgressViewStyle(tint: .cyan))
                    .scaleEffect(y: 2)
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.black.opacity(0.4))
        )
    }
}
