import Foundation

struct Task: Identifiable {
    let id: UUID
    var title: String
    var descriptionText: String
    var startDate: Date
    var lastTime: TimeInterval
    var reminderDate: Date
    var isCompleted: Bool
    var priority: Int
    var tags: [String]
    
    init(id: UUID = UUID(), 
         title: String, 
         descriptionText: String = "",
         startDate: Date = Date(),
         lastTime: TimeInterval = 3600,
         reminderDate: Date = Date(),
         isCompleted: Bool = false,
         priority: Int = 0,
         tags: [String] = []) {
        self.id = id
        self.title = title
        self.descriptionText = descriptionText
        self.startDate = startDate
        self.lastTime = lastTime
        self.reminderDate = reminderDate
        self.isCompleted = isCompleted
        self.priority = priority
        self.tags = tags
    }
} 