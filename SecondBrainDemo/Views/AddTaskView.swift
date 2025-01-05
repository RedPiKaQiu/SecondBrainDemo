import SwiftUI

struct AddTaskView: View {
    @Environment(\.dismiss) private var dismiss
    @ObservedObject var viewModel: TaskViewModel
    
    @State private var title = ""
    @State private var description = ""
    @State private var priority = 0
    
    var body: some View {
        NavigationView {
            Form {
                TextField("任务标题", text: $title)
                TextField("任务描述", text: $description)
                Picker("优先级", selection: $priority) {
                    Text("低").tag(0)
                    Text("中").tag(1)
                    Text("高").tag(2)
                }
            }
            .navigationTitle("添加任务")
            .navigationBarItems(
                leading: Button("取消") {
                    dismiss()
                },
                trailing: Button("保存") {
                    viewModel.addTask(title: title, description: description, priority: priority)
                    dismiss()
                }
                .disabled(title.isEmpty)
            )
        }
    }
} 