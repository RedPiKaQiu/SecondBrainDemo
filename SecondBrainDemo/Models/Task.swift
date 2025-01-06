import Foundation

class Task: Identifiable, ObservableObject {
    let id: UUID
    var title: String
    var descriptionText: String
    var startDate: Date
    var lastTime: TimeInterval
    var reminderDate: Date
    @Published var isCompleted: Bool
    @Published var priority: Priority
    let tag: TaskTag
    
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
         startDate: Date = Date(),
         lastTime: TimeInterval = 3600,
         reminderDate: Date = Date(),
         isCompleted: Bool = false,
         priority: Priority = .low,
         tag: TaskTag = .routine) {
        self.id = id
        self.title = title
        self.descriptionText = descriptionText
        self.startDate = startDate
        self.lastTime = lastTime
        self.reminderDate = reminderDate
        self.isCompleted = isCompleted
        self.priority = priority
        self.tag = tag
    }
} 
