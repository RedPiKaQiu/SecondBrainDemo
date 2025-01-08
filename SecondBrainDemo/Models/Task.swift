import Foundation

class Task: Identifiable, ObservableObject {
    let id: UUID
    var title: String
    var descriptionText: String
    var startTime: Date
    var lastTime: TimeInterval
    var reminderDate: Date
    @Published var isCompleted: Bool
    @Published var priority: Priority
    let tag: TaskTag
    let hasTime: Bool
    
    enum Priority: Int, CaseIterable {
        case low = 0
        case medium = 1
        case high = 2
        
        var description: String {
            switch self {
            case .low: return "低"
            case .medium: return "中"
            case .high: return "高"
            }
        }
    }
    
    enum TaskTag: String, CaseIterable {
        case routine = "日常"
        case activity = "活动"
        case parking = "待定"
        
        var description: String {
            self.rawValue
        }
    }
    
    init(id: UUID = UUID(), 
         title: String, 
         descriptionText: String = "",
         startTime: Date = Date(),
         lastTime: TimeInterval = 1800,
         reminderDate: Date = Date(),
         isCompleted: Bool = false,
         priority: Priority = .low,
         tag: TaskTag = .routine,
         hasTime: Bool = false) {
        self.id = id
        self.title = title
        self.descriptionText = descriptionText
        self.startTime = startTime
        self.lastTime = lastTime
        self.reminderDate = reminderDate
        self.isCompleted = isCompleted
        self.priority = priority
        self.tag = tag
        self.hasTime = hasTime
    }
} 
