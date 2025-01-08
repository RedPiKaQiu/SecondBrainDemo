import Foundation
import Combine

class TaskViewModel: ObservableObject {
    static let shared = TaskViewModel()
    
    @Published var tasks: [Date: [Task]] = [:]
    @Published var selectedTaskType: TaskType = .anytime
    
    enum TaskType {
        case anytime
        case planned
        case done
        case routine
        case activity
        case parkingLot
    }
    
    // 获取指定日期的任务
    func tasksForDate(_ date: Date) -> [Task] {
        let calendar = Calendar.current
        let filteredTasks = tasks.filter { taskDate, _ in
            calendar.isDate(taskDate, inSameDayAs: date)
        }
        return filteredTasks.flatMap { $0.value }
    }
    
    // 添加任务到指定日期
    func addTask(title: String, 
                description: String = "", 
                startTime: Date = Date(),
                lastTime: TimeInterval = 1800,
                priority: Task.Priority = .low, 
                tag: Task.TaskTag = .routine,
                hasTime: Bool = false,
                date: Date = Date()) {
        let calendar = Calendar.current
        let normalizedDate = calendar.startOfDay(for: date)
        
        let task = Task(
            title: title, 
            descriptionText: description, 
            startTime: startTime,
            lastTime: lastTime,
            priority: priority, 
            tag: tag,
            hasTime: hasTime
        )
        
        if tasks[normalizedDate] == nil {
            tasks[normalizedDate] = []
        }
        tasks[normalizedDate]?.append(task)
        objectWillChange.send()
    }
    
    // 删除指定日期的任务
    func deleteTask(_ task: Task, date: Date) {
        let normalizedDate = Calendar.current.startOfDay(for: date)
        tasks[normalizedDate]?.removeAll { $0.id == task.id }
        objectWillChange.send()
    }
    
    func toggleTaskCompletion(_ task: Task, date: Date) {
        let normalizedDate = Calendar.current.startOfDay(for: date)
        if let index = tasks[normalizedDate]?.firstIndex(where: { $0.id == task.id }) {
            tasks[normalizedDate]?[index].isCompleted.toggle()
            objectWillChange.send()
        }
    }
    
    // 更新任务优先级
    func updateTaskPriority(_ task: Task, priority: Task.Priority, date: Date) {
        let normalizedDate = Calendar.current.startOfDay(for: date)
        if let index = tasks[normalizedDate]?.firstIndex(where: { $0.id == task.id }) {
            tasks[normalizedDate]?[index].priority = priority
            objectWillChange.send()
        }
    }
    
    private init() {
        print("TaskViewModel initialized")
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: Date())
        
        // 创建一些测试数据
        let now = Date()
        tasks[today] = [
            // 有时间的任务
            Task(title: "计划任务A", 
                 startTime: now.addingTimeInterval(3600), // 1小时后
                 lastTime: 1800, // 30分钟
                 priority: .high,
                 tag: .routine,
                 hasTime: true),
             
            Task(title: "计划任务B",
                 startTime: now.addingTimeInterval(7200), // 2小时后
                 lastTime: 3600, // 1小时
                 priority: .medium,
                 tag: .activity,
                 hasTime: true),
                 
            // 无时间的任务
            Task(title: "随时任务A",
                 priority: .low,
                 tag: .routine,
                 hasTime: false),
                 
            Task(title: "随时任务B",
                 priority: .medium,
                 tag: .parking,
                 hasTime: false)
        ]
        
        print("初始化数据：")
        debugPrintTasks(date: today)
    }
    // 打印指定日期任务的调试函数
    func debugPrintTasks(date: Date) {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        print("\n=== \(formatter.string(from: date))的任务 ===")
        
        if let dateTasks = tasks[date] {
            print("任务数量: \(dateTasks.count)")
            for (index, task) in dateTasks.enumerated() {
                print("任务#\(index + 1): 标题[\(task.title)] 描述[\(task.descriptionText)] 优先级[\(task.priority.description)] 类型[\(task.tag.description)] 完成状态[\(task.isCompleted ? "是" : "否")]")
            }
        } else {
            print("该日期没有任务")
        }
        print("=== 打印结束 ===\n")
    }
} 
