import Foundation

class UserProfile: ObservableObject {
    static let shared = UserProfile()  // 单例对象
    
    let id: UUID
    @Published var name: String
    @Published var email: String
    @Published var gender: Gender
    @Published var birthDate: Date
    @Published var hasADHD: Bool
    @Published var occupation: Occupation
    @Published var isVIP: Bool
    @Published var preferences: UserPreferences
    
    // 性别枚举
    enum Gender: String {
        case male = "男"
        case female = "女"
        case other = "其他"
    }
    
    // 职业枚举
    enum Occupation: String {
        case student = "学生"
        case worker = "工作党"
        case other = "其他"
    }
    
    // 用户偏好设置
    class UserPreferences: ObservableObject {
        @Published var usageIntensity: UsageIntensity
        @Published var enableReminders: Bool
        
        enum UsageIntensity: String {
            case light = "轻度"
            case heavy = "重度"
        }
        
        init(usageIntensity: UsageIntensity, enableReminders: Bool) {
            self.usageIntensity = usageIntensity
            self.enableReminders = enableReminders
        }
    }
    
    // 私有初始化方法，确保只能通过shared访问
    private init() {
        // 初始化测试数据
        self.id = UUID()
        self.name = "Shell"
        self.email = "aab@gmail.com"
        self.gender = .female
        self.birthDate = Calendar.current.date(from: DateComponents(year: 1998, month: 1, day: 1)) ?? Date()
        self.hasADHD = true
        self.occupation = .worker
        self.isVIP = true
        self.preferences = UserPreferences(
            usageIntensity: .heavy,
            enableReminders: true
        )
    }
} 