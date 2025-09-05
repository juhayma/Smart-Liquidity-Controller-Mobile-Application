// Internationalization (i18n) Support for EXIT Platform

// Language data
const translations = {
    en: {
        // Navigation
        nav: {
            home: "Home",
            startups: "Startups",
            founders: "Founders", 
            events: "Events",
            program: "Program",
            submit: "Submit Startup",
            admin: "Admin"
        },
        
        // Homepage
        home: {
            title: "EXIT Platform",
            subtitle: "Startup Ecosystem",
            hero_title: "Welcome to EXIT Platform",
            hero_subtitle: "Your gateway to the startup ecosystem. Connect, grow, and succeed with the EXIT incubator program.",
            submit_btn: "Submit Your Startup",
            explore_btn: "Explore Startups",
            stats_title: "Platform Statistics",
            featured_startups: "Featured Startups",
            our_founders: "Our Founders",
            ready_to_join: "Ready to Join EXIT?",
            join_subtitle: "Submit your startup application and become part of our growing ecosystem",
            get_started: "Get Started"
        },
        
        // Submit form
        submit: {
            title: "Submit Your Startup",
            subtitle: "Join the EXIT ecosystem and accelerate your startup journey",
            company_name: "Company Name",
            description: "Description",
            description_placeholder: "Describe your startup, what problem you solve, and your solution...",
            sector: "Sector",
            select_sector: "Select Sector",
            stage: "Stage",
            select_stage: "Select Stage",
            country: "Country",
            select_country: "Select Country",
            website: "Website",
            website_placeholder: "https://yourcompany.com",
            contact_email: "Contact Email",
            founder_name: "Founder Name",
            founder_email: "Founder Email",
            submit_btn: "Submit Application",
            reset_btn: "Reset Form",
            success_title: "Application Submitted Successfully!",
            reference_label: "Your reference ID is:",
            success_subtitle: "We'll review your application and get back to you soon.",
            submit_another: "Submit Another",
            back_home: "Back to Home",
            error_title: "Submission Failed",
            error_subtitle: "Something went wrong. Please try again.",
            try_again: "Try Again"
        },
        
        // Events
        events: {
            title: "Upcoming Events",
            subtitle: "Join our startup community events, workshops, and networking sessions",
            all_events: "All Events",
            upcoming: "Upcoming",
            online: "Online", 
            in_person: "In-Person",
            rsvp: "RSVP",
            event_ended: "Event Ended",
            rsvp_title: "RSVP for Event",
            confirm_rsvp: "Confirm RSVP",
            rsvp_confirmed: "RSVP Confirmed!",
            download_ticket: "Download Ticket",
            full_name: "Full Name",
            phone_number: "Phone Number",
            company_startup: "Company/Startup",
            role: "Role",
            select_role: "Select Role",
            founder: "Founder",
            entrepreneur: "Entrepreneur",
            investor: "Investor",
            mentor: "Mentor",
            student: "Student",
            professional: "Professional",
            agree_terms: "I agree to the event terms and conditions",
            show_at_event: "Show this at the event",
            event_details: "Event Details",
            date: "Date",
            venue: "Venue",
            reference: "Reference",
            fill_required_fields: "Please fill in all required fields and agree to the terms",
            rsvp_error: "Error submitting RSVP. Please try again",
            ticket_download_soon: "Ticket download feature coming soon!",
            no_events: "No events available at the moment",
            past_event: "Past Event"
        },
        
        // Program
        program: {
            title: "EXIT Program Dashboard",
            subtitle: "Welcome to your startup journey with EXIT Incubator",
            demo_notice: "This is a demo version. Login system will be implemented with real data.",
            progress_title: "Program Progress",
            deliverables: "Deliverables",
            services: "Services",
            documents: "Documents",
            mentorship: "Mentorship",
            resources: "Resources",
            completed: "Completed",
            pending: "Pending",
            overdue: "Overdue",
            in_progress: "In Progress",
            
            // Milestones
            onboarding: "Onboarding",
            onboarding_desc: "Program orientation completed",
            business_model: "Business Model",
            business_model_desc: "Develop and refine your business model",
            team_building: "Team Building",
            team_building_desc: "Build and structure your team",
            market_validation: "Market Validation",
            market_validation_desc: "Test and validate your market fit",
            demo_day: "Demo Day",
            demo_day_desc: "Present your startup to investors",
            due: "Due",
            starts: "Starts",
            target: "Target",
            
            // Deliverables
            current_deliverables: "Current Deliverables",
            business_canvas: "Business Model Canvas",
            business_canvas_desc: "Create a comprehensive business model canvas for your startup",
            market_research: "Market Research Report",
            market_research_desc: "Conduct market research and competitive analysis",
            financial_projections: "Financial Projections",
            financial_projections_desc: "Prepare 3-year financial projections and funding requirements",
            submitted: "Submitted",
            days_remaining: "5 days remaining",
            days_overdue: "3 days overdue",
            upload_document: "Upload Document",
            get_help: "Get Help",
            upload_now: "Upload Now",
            request_extension: "Request Extension",
            view_submission: "View Submission",
            
            // Services
            available_services: "Available Services",
            services_desc: "Services provided by the EXIT program team",
            branding_design: "Branding & Design",
            branding_design_desc: "Logo design and brand identity creation",
            pitch_preparation: "Pitch Preparation",
            pitch_preparation_desc: "One-on-one pitch coaching and presentation skills",
            legal_consultation: "Legal Consultation",
            legal_consultation_desc: "Legal advice on incorporation and contracts",
            financial_modeling: "Financial Modeling",
            financial_modeling_desc: "Help with financial projections and fundraising",
            delivered: "Delivered",
            next_session: "Next session",
            available: "Available",
            book_when_ready: "Book when ready",
            view_assets: "View Assets",
            schedule_session: "Schedule Session",
            request_service: "Request Service",
            
            // Documents
            document_library: "Document Library",
            business_plan: "Business Plan v2.1",
            business_plan_desc: "Updated business plan with market analysis",
            pitch_deck: "Pitch Deck v1.0",
            pitch_deck_desc: "Investor presentation deck",
            uploaded: "Uploaded",
            preview: "Preview",
            
            // Mentorship
            your_mentors: "Your Mentors",
            mentors_desc: "Connect with industry experts assigned to guide your journey",
            fintech_expert: "FinTech Expert & Former Goldman Sachs VP",
            startup_founder: "Startup Founder & Tech Entrepreneur",
            sessions_completed: "2 sessions completed",
            session_completed: "1 session completed",
            next: "Next",
            available_on_demand: "Available on demand",
            schedule_meeting: "Schedule Meeting",
            send_message: "Send Message",
            
            // Resources
            learning_resources: "Learning Resources",
            learning_resources_desc: "Templates, guides, and educational materials",
            business_planning: "Business Planning",
            fundraising: "Fundraising",
            product_development: "Product Development",
            canvas_template: "Business Model Canvas Template",
            planning_workshop: "Business Planning Workshop",
            research_tools: "Market Research Tools",
            financial_template: "Financial Model Template",
            pitch_masterclass: "Investor Pitch Masterclass",
            term_sheet_guide: "Term Sheet Guide",
            mvp_guide: "MVP Development Guide",
            user_testing: "User Testing Workshop",
            design_tools: "Design Tools & Resources"
        },
        
        // Admin
        admin: {
            title: "Admin Dashboard",
            subtitle: "Manage startup submissions and platform data",
            submissions: "Submissions",
            startups: "Startups", 
            founders: "Founders",
            statistics: "Statistics",
            refresh: "Refresh",
            update_status: "Update Status",
            approve: "Approve",
            reject: "Reject"
        },
        
        // Common
        common: {
            loading: "Loading...",
            error: "Error",
            success: "Success",
            cancel: "Cancel",
            save: "Save",
            delete: "Delete",
            edit: "Edit",
            view: "View",
            download: "Download",
            upload: "Upload",
            close: "Close",
            required: "Required",
            optional: "Optional",
            demo_notice: "This is a demo version with sample data. Real data will be added soon.",
            processing: "Processing",
            try_again: "Try again",
            not_specified: "Not specified"
        },
        
        // Startup related
        startup: {
            founders: "founder(s)",
            joined: "Joined",
            no_startups: "No startups available yet. Be the first to submit your startup!"
        },
        
        // Founder related
        founder: {
            startups: "startup(s)",
            joined: "Joined",
            no_founders: "No founders available yet."
        },
        
        // Sectors
        sectors: {
            fintech: "FinTech",
            healthtech: "HealthTech", 
            edtech: "EdTech",
            ecommerce: "E-commerce",
            logistics: "Logistics",
            foodtech: "FoodTech",
            proptech: "PropTech",
            ai: "AI/ML",
            iot: "IoT",
            other: "Other"
        },
        
        // Stages
        stages: {
            idea: "Idea",
            prototype: "Prototype",
            mvp: "MVP",
            early_revenue: "Early Revenue",
            growth: "Growth",
            scale: "Scale"
        },
        
        // Countries
        countries: {
            saudi_arabia: "Saudi Arabia",
            uae: "UAE",
            kuwait: "Kuwait",
            qatar: "Qatar",
            bahrain: "Bahrain",
            oman: "Oman",
            egypt: "Egypt",
            jordan: "Jordan",
            lebanon: "Lebanon",
            other: "Other"
        },
        
        // Footer
        footer: {
            description: "Empowering startups to succeed",
            quick_links: "Quick Links",
            contact: "Contact",
            email: "Email: info@exitplatform.com",
            phone: "Phone: +966 XX XXX XXXX",
            copyright: "© 2025 EXIT Platform. All rights reserved."
        }
    },
    
    ar: {
        // Navigation
        nav: {
            home: "الرئيسية",
            startups: "الشركات الناشئة",
            founders: "المؤسسون",
            events: "الفعاليات", 
            program: "البرنامج",
            submit: "تقديم شركة ناشئة",
            admin: "لوحة التحكم"
        },
        
        // Homepage
        home: {
            title: "منصة EXIT",
            subtitle: "النظام البيئي للشركات الناشئة",
            hero_title: "مرحباً بكم في منصة EXIT",
            hero_subtitle: "بوابتكم إلى النظام البيئي للشركات الناشئة. تواصلوا، انموا، وانجحوا مع برنامج حاضنة EXIT.",
            submit_btn: "قدم شركتك الناشئة",
            explore_btn: "استكشف الشركات",
            stats_title: "إحصائيات المنصة",
            featured_startups: "الشركات الناشئة المميزة",
            our_founders: "مؤسسونا",
            ready_to_join: "مستعد للانضمام إلى EXIT؟",
            join_subtitle: "قدم طلب شركتك الناشئة وكن جزءاً من نظامنا البيئي المتنامي",
            get_started: "ابدأ الآن"
        },
        
        // Submit form
        submit: {
            title: "تقديم شركتك الناشئة",
            subtitle: "انضم إلى نظام EXIT البيئي وعجل رحلة شركتك الناشئة",
            company_name: "اسم الشركة",
            description: "الوصف",
            description_placeholder: "اوصف شركتك الناشئة، والمشكلة التي تحلها، والحل الذي تقدمه...",
            sector: "القطاع",
            select_sector: "اختر القطاع",
            stage: "المرحلة",
            select_stage: "اختر المرحلة",
            country: "البلد",
            select_country: "اختر البلد",
            website: "الموقع الإلكتروني",
            website_placeholder: "https://yourcompany.com",
            contact_email: "البريد الإلكتروني",
            founder_name: "اسم المؤسس",
            founder_email: "بريد المؤسس الإلكتروني",
            submit_btn: "إرسال الطلب",
            reset_btn: "إعادة تعيين",
            success_title: "تم إرسال الطلب بنجاح!",
            reference_label: "رقم المرجع الخاص بك هو:",
            success_subtitle: "سنقوم بمراجعة طلبكم والرد عليكم قريباً.",
            submit_another: "تقديم طلب آخر",
            back_home: "العودة للرئيسية",
            error_title: "فشل في الإرسال",
            error_subtitle: "حدث خطأ ما. يرجى المحاولة مرة أخرى.",
            try_again: "حاول مرة أخرى"
        },
        
        // Events
        events: {
            title: "الفعاليات القادمة",
            subtitle: "انضموا إلى فعاليات مجتمع الشركات الناشئة وورش العمل وجلسات التواصل",
            all_events: "جميع الفعاليات",
            upcoming: "القادمة",
            online: "عبر الإنترنت",
            in_person: "حضوري",
            rsvp: "تأكيد الحضور",
            event_ended: "انتهت الفعالية",
            rsvp_title: "تأكيد الحضور للفعالية",
            confirm_rsvp: "تأكيد الحضور",
            rsvp_confirmed: "تم تأكيد الحضور!",
            download_ticket: "تحميل التذكرة",
            full_name: "الاسم الكامل",
            phone_number: "رقم الهاتف",
            company_startup: "الشركة/الشركة الناشئة",
            role: "الدور",
            select_role: "اختر الدور",
            founder: "مؤسس",
            entrepreneur: "رائد أعمال",
            investor: "مستثمر",
            mentor: "مرشد",
            student: "طالب",
            professional: "محترف",
            agree_terms: "أوافق على شروط وأحكام الفعالية",
            show_at_event: "اعرض هذا في الفعالية",
            event_details: "تفاصيل الفعالية",
            date: "التاريخ",
            venue: "المكان",
            reference: "المرجع",
            fill_required_fields: "يرجى ملء جميع الحقول المطلوبة والموافقة على الشروط",
            rsvp_error: "خطأ في تأكيد الحضور. يرجى المحاولة مرة أخرى",
            ticket_download_soon: "ميزة تحميل التذكرة قريباً!",
            no_events: "لا توجد فعاليات متاحة في الوقت الحالي",
            past_event: "فعالية سابقة"
        },
        
        // Program
        program: {
            title: "لوحة تحكم برنامج EXIT",
            subtitle: "مرحباً بكم في رحلة شركتكم الناشئة مع حاضنة EXIT",
            demo_notice: "هذه نسخة تجريبية. سيتم تطبيق نظام تسجيل الدخول مع البيانات الحقيقية.",
            progress_title: "تقدم البرنامج",
            deliverables: "المخرجات",
            services: "الخدمات",
            documents: "المستندات",
            mentorship: "الإرشاد",
            resources: "الموارد",
            completed: "مكتمل",
            pending: "قيد الانتظار",
            overdue: "متأخر",
            in_progress: "قيد التنفيذ",
            
            // Milestones
            onboarding: "التأهيل",
            onboarding_desc: "تم إنجاز توجه البرنامج",
            business_model: "نموذج العمل",
            business_model_desc: "طوّر وحسّن نموذج عملك",
            team_building: "بناء الفريق",
            team_building_desc: "ابن وهيكل فريقك",
            market_validation: "التحقق من السوق",
            market_validation_desc: "اختبر وتحقق من ملاءمة السوق",
            demo_day: "يوم العرض",
            demo_day_desc: "اعرض شركتك الناشئة للمستثمرين",
            due: "الموعد النهائي",
            starts: "يبدأ",
            target: "الهدف",
            
            // Deliverables
            current_deliverables: "المخرجات الحالية",
            business_canvas: "لوحة نموذج العمل",
            business_canvas_desc: "إنشاء لوحة شاملة لنموذج عمل شركتك الناشئة",
            market_research: "تقرير بحث السوق",
            market_research_desc: "إجراء بحث السوق وتحليل المنافسة",
            financial_projections: "التوقعات المالية",
            financial_projections_desc: "إعداد توقعات مالية لـ3 سنوات ومتطلبات التمويل",
            submitted: "تم الإرسال",
            days_remaining: "5 أيام متبقية",
            days_overdue: "3 أيام متأخر",
            upload_document: "رفع مستند",
            get_help: "الحصول على مساعدة",
            upload_now: "رفع الآن",
            request_extension: "طلب تمديد",
            view_submission: "عرض الإرسال",
            
            // Services
            available_services: "الخدمات المتاحة",
            services_desc: "الخدمات المقدمة من فريق برنامج EXIT",
            branding_design: "العلامة التجارية والتصميم",
            branding_design_desc: "تصميم الشعار وإنشاء هوية العلامة التجارية",
            pitch_preparation: "إعداد العرض التقديمي",
            pitch_preparation_desc: "تدريب فردي على العرض ومهارات التقديم",
            legal_consultation: "الاستشارة القانونية",
            legal_consultation_desc: "المشورة القانونية حول التأسيس والعقود",
            financial_modeling: "النمذجة المالية",
            financial_modeling_desc: "المساعدة في التوقعات المالية وجمع التمويل",
            delivered: "تم التسليم",
            next_session: "الجلسة القادمة",
            available: "متاح",
            book_when_ready: "احجز عند الاستعداد",
            view_assets: "عرض الأصول",
            schedule_session: "جدولة جلسة",
            request_service: "طلب الخدمة",
            
            // Documents
            document_library: "مكتبة المستندات",
            business_plan: "خطة العمل v2.1",
            business_plan_desc: "خطة عمل محدثة مع تحليل السوق",
            pitch_deck: "عرض المستثمرين v1.0",
            pitch_deck_desc: "عرض تقديمي للمستثمرين",
            uploaded: "تم الرفع",
            preview: "معاينة",
            
            // Mentorship
            your_mentors: "مرشدوك",
            mentors_desc: "تواصل مع خبراء الصناعة المخصصين لتوجيه رحلتك",
            fintech_expert: "خبير التكنولوجيا المالية ونائب رئيس سابق في جولدمان ساكس",
            startup_founder: "مؤسس شركة ناشئة ورائد أعمال تقني",
            sessions_completed: "تم إنجاز جلستين",
            session_completed: "تم إنجاز جلسة واحدة",
            next: "التالي",
            available_on_demand: "متاح عند الطلب",
            schedule_meeting: "جدولة اجتماع",
            send_message: "إرسال رسالة",
            
            // Resources
            learning_resources: "موارد التعلم",
            learning_resources_desc: "قوالب وأدلة ومواد تعليمية",
            business_planning: "تخطيط الأعمال",
            fundraising: "جمع التمويل",
            product_development: "تطوير المنتج",
            canvas_template: "قالب لوحة نموذج العمل",
            planning_workshop: "ورشة تخطيط الأعمال",
            research_tools: "أدوات بحث السوق",
            financial_template: "قالب النموذج المالي",
            pitch_masterclass: "دورة إتقان عرض المستثمرين",
            term_sheet_guide: "دليل شروط الاستثمار",
            mvp_guide: "دليل تطوير المنتج الأولي",
            user_testing: "ورشة اختبار المستخدم",
            design_tools: "أدوات وموارد التصميم"
        },
        
        // Admin
        admin: {
            title: "لوحة تحكم الإدارة",
            subtitle: "إدارة طلبات الشركات الناشئة وبيانات المنصة",
            submissions: "الطلبات",
            startups: "الشركات الناشئة",
            founders: "المؤسسون",
            statistics: "الإحصائيات",
            refresh: "تحديث",
            update_status: "تحديث الحالة",
            approve: "موافقة",
            reject: "رفض"
        },
        
        // Common
        common: {
            loading: "جاري التحميل...",
            error: "خطأ",
            success: "نجح",
            cancel: "إلغاء",
            save: "حفظ",
            delete: "حذف",
            edit: "تحرير",
            view: "عرض",
            download: "تحميل",
            upload: "رفع",
            close: "إغلاق",
            required: "مطلوب",
            optional: "اختياري",
            demo_notice: "هذه نسخة تجريبية بيانات عينة. ستتم إضافة البيانات الحقيقية قريباً.",
            processing: "جاري المعالجة",
            try_again: "حاول مرة أخرى",
            not_specified: "غير محدد"
        },
        
        // Startup related
        startup: {
            founders: "مؤسس",
            joined: "انضم في",
            no_startups: "لا توجد شركات ناشئة متاحة بعد. كن أول من يقدم شركته الناشئة!"
        },
        
        // Founder related
        founder: {
            startups: "شركة ناشئة",
            joined: "انضم في",
            no_founders: "لا يوجد مؤسسون متاحون بعد."
        },
        
        // Sectors
        sectors: {
            fintech: "التكنولوجيا المالية",
            healthtech: "التكنولوجيا الصحية",
            edtech: "التكنولوجيا التعليمية",
            ecommerce: "التجارة الإلكترونية",
            logistics: "اللوجستيات",
            foodtech: "تكنولوجيا الطعام",
            proptech: "تكنولوجيا العقارات",
            ai: "الذكاء الاصطناعي",
            iot: "إنترنت الأشياء",
            other: "أخرى"
        },
        
        // Stages
        stages: {
            idea: "فكرة",
            prototype: "نموذج أولي",
            mvp: "المنتج الأولي",
            early_revenue: "إيرادات مبكرة",
            growth: "نمو",
            scale: "توسع"
        },
        
        // Countries
        countries: {
            saudi_arabia: "المملكة العربية السعودية",
            uae: "الإمارات العربية المتحدة",
            kuwait: "الكويت",
            qatar: "قطر",
            bahrain: "البحرين",
            oman: "عُمان",
            egypt: "مصر",
            jordan: "الأردن",
            lebanon: "لبنان",
            other: "أخرى"
        },
        
        // Footer
        footer: {
            description: "تمكين الشركات الناشئة للنجاح",
            quick_links: "روابط سريعة",
            contact: "تواصل معنا",
            email: "البريد الإلكتروني: info@exitplatform.com",
            phone: "الهاتف: +966 XX XXX XXXX",
            copyright: "© 2025 منصة EXIT. جميع الحقوق محفوظة."
        }
    }
};

// Language management
class LanguageManager {
    constructor() {
        this.currentLang = localStorage.getItem('language') || 'en';
        this.translations = translations;
        this.init();
    }
    
    init() {
        this.applyLanguage();
        this.updateLanguageToggle();
        this.setupLanguageToggle();
    }
    
    getCurrentLanguage() {
        return this.currentLang;
    }
    
    setLanguage(lang) {
        if (this.translations[lang]) {
            this.currentLang = lang;
            localStorage.setItem('language', lang);
            this.applyLanguage();
            this.updateLanguageToggle();
        }
    }
    
    translate(key) {
        const keys = key.split('.');
        let value = this.translations[this.currentLang];
        
        for (const k of keys) {
            if (value && value[k]) {
                value = value[k];
            } else {
                // Fallback to English
                value = this.translations.en;
                for (const k of keys) {
                    if (value && value[k]) {
                        value = value[k];
                    } else {
                        return key; // Return key if translation not found
                    }
                }
                break;
            }
        }
        
        return value || key;
    }
    
    applyLanguage() {
        // Set document direction
        document.documentElement.dir = this.currentLang === 'ar' ? 'rtl' : 'ltr';
        document.documentElement.lang = this.currentLang;
        
        // Apply translations to elements with data-i18n attribute
        document.querySelectorAll('[data-i18n]').forEach(element => {
            const key = element.getAttribute('data-i18n');
            const translation = this.translate(key);
            
            if (element.tagName === 'INPUT' && (element.type === 'submit' || element.type === 'button')) {
                element.value = translation;
            } else if (element.tagName === 'INPUT' && element.placeholder !== undefined) {
                element.placeholder = translation;
            } else {
                element.textContent = translation;
            }
        });
        
        // Apply translations to placeholders
        document.querySelectorAll('[data-i18n-placeholder]').forEach(element => {
            const key = element.getAttribute('data-i18n-placeholder');
            element.placeholder = this.translate(key);
        });
        
        // Apply translations to titles
        document.querySelectorAll('[data-i18n-title]').forEach(element => {
            const key = element.getAttribute('data-i18n-title');
            element.title = this.translate(key);
        });
        
        // Update page title if available
        const titleElement = document.querySelector('[data-i18n-page-title]');
        if (titleElement) {
            const key = titleElement.getAttribute('data-i18n-page-title');
            document.title = this.translate(key);
        }
    }
    
    updateLanguageToggle() {
        const toggles = document.querySelectorAll('.language-toggle');
        toggles.forEach(toggle => {
            const currentText = toggle.querySelector('.current-lang');
            const otherText = toggle.querySelector('.other-lang');
            
            if (currentText && otherText) {
                if (this.currentLang === 'ar') {
                    currentText.textContent = 'العربية';
                    otherText.textContent = 'English';
                } else {
                    currentText.textContent = 'English';
                    otherText.textContent = 'العربية';
                }
            }
        });
    }
    
    setupLanguageToggle() {
        document.querySelectorAll('.language-toggle').forEach(toggle => {
            toggle.addEventListener('click', () => {
                const newLang = this.currentLang === 'en' ? 'ar' : 'en';
                this.setLanguage(newLang);
                
                // Reload dynamic content
                this.reloadDynamicContent();
            });
        });
    }
    
    reloadDynamicContent() {
        // Reload startups and founders if functions exist
        if (typeof loadStartupsList === 'function') {
            loadStartupsList();
        }
        if (typeof loadFoundersList === 'function') {
            loadFoundersList();
        }
        if (typeof loadEvents === 'function') {
            loadEvents();
        }
    }
}

// Initialize language manager
const i18n = new LanguageManager();

// Global function to get translations
window.t = function(key) {
    return i18n.translate(key);
};

// Global function to change language
window.changeLanguage = function(lang) {
    i18n.setLanguage(lang);
};

// Export for use in other scripts
if (typeof module !== 'undefined' && module.exports) {
    module.exports = { LanguageManager, translations };
}