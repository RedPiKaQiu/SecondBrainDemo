import Foundation
import Combine

class TaskViewModel: ObservableObject {
    @Published var tasks: [Task] = []
    @Published var selectedTaskType: TaskType = .anytime
    
    enum TaskType {
        case anytime
        case planned
        case done
        case routine
        case activity
        case parkingLot
    }
    
    init() {
        // 添加一些测试数据
        tasks = [
            Task(title: "!!! Checkbox", descriptionText: "", priority: 3, tags: ["日常"]),
            Task(title: "!! Checkbox", descriptionText: "", priority: 2, tags: ["活动"]),
            Task(title: "Checkbox", descriptionText: "", priority: 1, tags: ["日常"])
        ]
    }
    
    func addTask(title: String, description: String = "", priority: Int = 0) {
        let task = Task(title: title, descriptionText: description, priority: priority)
        tasks.append(task)
    }
    
    func deleteTask(at indexSet: IndexSet) {
        tasks.remove(atOffsets: indexSet)
    }
    
    func toggleTaskCompletion(_ task: Task) {
        if let index = tasks.firstIndex(where: { $0.id == task.id }) {
            tasks[index].isCompleted.toggle()
        }
    }
} 