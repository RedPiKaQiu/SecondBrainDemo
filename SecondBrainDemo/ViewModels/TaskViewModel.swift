import Foundation
import Combine

class TaskViewModel: ObservableObject {
    @Published var tasks: [Task] = []
    
    init() {
        // 添加一些测试数据
        tasks = [
            Task(title: "完成App开发", descriptionText: "开发一个日程管理应用", priority: 1),
            Task(title: "学习SwiftUI", descriptionText: "掌握SwiftUI基础知识", priority: 2),
            Task(title: "写技术文档", descriptionText: "编写开发文档", priority: 0)
        ]
    }
    
    func addTask(title: String, description: String = "", priority: Int = 0) {
        let task = Task(title: title, descriptionText: description, priority: priority)
        tasks.append(task)
    }
    
    func deleteTask(at indexSet: IndexSet) {
        tasks.remove(atOffsets: indexSet)
    }
} 