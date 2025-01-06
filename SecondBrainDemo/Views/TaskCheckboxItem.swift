import SwiftUI

struct TaskCheckboxItem: View {
    @ObservedObject var task: Task
    let date: Date
    @EnvironmentObject var viewModel: TaskViewModel
    
    var body: some View {
        HStack {
            Button(action: { 
                viewModel.toggleTaskCompletion(task, date: date)
            }) {
                Image(systemName: task.isCompleted ? "checkmark.square.fill" : "square")
                    .foregroundColor(task.isCompleted ? .blue : .gray)
                    .imageScale(.large)
                    .contentShape(Rectangle())
                    .animation(.easeInOut, value: task.isCompleted)
            }
            .buttonStyle(PlainButtonStyle())
            
            Text(task.title)
                .strikethrough(task.isCompleted)
                .foregroundColor(task.isCompleted ? .gray : .primary)
            
            Spacer()
            
            Button(action: {
                let today = Date()
                viewModel.debugPrintTasks(date: today)
                let currentPriority = task.priority
                let allPriorities = Task.Priority.allCases
                if let currentIndex = allPriorities.firstIndex(of: currentPriority) {
                    let nextIndex = (currentIndex + 1) % allPriorities.count
                    let nextPriority = allPriorities[nextIndex]
                    viewModel.updateTaskPriority(task, priority: nextPriority, date: date)
                }
            }) {
                Text(task.tag.description)
                    .font(.caption)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(
                        task.priority == .high ? Color.red.opacity(0.2) :
                        task.priority == .medium ? Color.yellow.opacity(0.2) :
                        Color.green.opacity(0.2)
                    )
                    .cornerRadius(4)
            }
        }
        .padding(.vertical, 4)
    }
}
