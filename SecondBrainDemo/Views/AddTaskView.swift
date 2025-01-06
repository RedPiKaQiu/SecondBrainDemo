import SwiftUI

struct AddTaskView: View {
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var viewModel: TaskViewModel
    
    @State private var title = ""
    @State private var description = ""
    @State private var priority = Task.Priority.low
    @State private var tag = Task.TaskTag.routine
    
    var body: some View {
        NavigationView {
            Form {
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
            .navigationTitle("添加任务")
            .navigationBarItems(
                leading: Button("取消") {
                    dismiss()
                },
                trailing: Button("保存") {
                    viewModel.addTask(
                        title: title,
                        description: description,
                        priority: priority,
                        tag: tag,
                        date: Date()
                    )
                    dismiss()
                }
                .disabled(title.isEmpty)
            )
        }
    }
} 
