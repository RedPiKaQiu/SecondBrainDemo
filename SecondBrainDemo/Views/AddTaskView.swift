import SwiftUI

struct AddTaskView: View {
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var viewModel: TaskViewModel
    
    @State private var title = ""
    @State private var description = ""
    @State private var priority = Task.Priority.low
    @State private var tag = Task.TaskTag.routine
    @State private var hasTime = false
    @State private var startTime = Date()
    @State private var lastTime: Double = 30 // 默认30分钟
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("基本信息")) {
                    TextField("任务标题", text: $title)
                    TextField("任务描述", text: $description)
                    Picker("优先级", selection: $priority) {
                        ForEach(Task.Priority.allCases, id: \.self) { priority in
                            Text(priority.description).tag(priority)
                        }
                    }
                    Picker("类型", selection: $tag) {
                        ForEach(Task.TaskTag.allCases, id: \.self) { tag in
                            Text(tag.description).tag(tag)
                        }
                    }
                }
                
                Section(header: Text("时间设置")) {
                    Toggle("设置时间", isOn: $hasTime)
                    
                    if hasTime {
                        DatePicker("开始时间",
                                 selection: $startTime,
                                 displayedComponents: [.date, .hourAndMinute])
                        
                        Stepper(value: $lastTime,
                               in: 5...240, // 5分钟到4小时
                               step: 5) {
                            Text("持续时间: \(Int(lastTime))分钟")
                        }
                    }
                }
            }
            .navigationTitle("添加任务")
            .navigationBarItems(
                leading: Button("取消") {
                    dismiss()
                },
                trailing: Button("保存") {
                    viewModel.addTask(
                        title: title,
                        description: description,
                        startTime: startTime,
                        lastTime: lastTime * 60, // 转换为秒
                        priority: priority,
                        tag: tag,
                        hasTime: hasTime,
                        date: Date()
                    )
                    dismiss()
                }
                .disabled(title.isEmpty)
            )
        }
    }
} 
