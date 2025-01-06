import SwiftUI

struct TaskControlView: View {
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var viewModel: TaskViewModel
    @State private var selectedTab = 0
    
    // 获取当前日期
    private var currentDate: Date {
        Date()
    }
    
    // 根据选中的标签获取对应的任务
    private var filteredTasks: [Task] {
        let tasks = viewModel.tasksForDate(currentDate)
        switch selectedTab {
        case 0: // Routine
            return tasks.filter { $0.tag == .routine }
        case 1: // Activity
            return tasks.filter { $0.tag == .activity }
        case 2: // Parking lot
            return tasks.filter { $0.tag == .parking }
        default:
            return []
        }
    }
    
    var body: some View {
        VStack(spacing: 0) {
            // 顶部导航栏
            HStack {
                Button(action: { dismiss() }) {
                    Text("back")
                        .foregroundColor(.white)
                        .padding()
                        .background(Color(red: 0.4, green: 0.4, blue: 1.0))
                        .cornerRadius(8)
                }
                Spacer()
            }
            .padding()
            .background(Color(uiColor: .systemBackground))
            
            // 标签栏
            HStack(spacing: 20) {
                TabButton(title: "Routine", icon: "cup.and.saucer.fill", isSelected: selectedTab == 0) {
                    selectedTab = 0
                }
                TabButton(title: "Activity", icon: "hexagon", isSelected: selectedTab == 1) {
                    selectedTab = 1
                }
                TabButton(title: "Parking lot", icon: "hexagon", isSelected: selectedTab == 2) {
                    selectedTab = 2
                }
            }
            .padding(.vertical)
            
            // 任务列表
            ScrollView {
                VStack(spacing: 15) {
                    ForEach(filteredTasks) { task in
                        TaskCheckboxItem(task: task, date: currentDate)
                    }
                }
                .padding()
            }
            
            Spacer()
        }
        .background(Color(uiColor: .systemGroupedBackground))
    }
}

struct TabButton: View {
    let title: String
    let icon: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack(spacing: 4) {
                Image(systemName: icon)
                    .foregroundColor(isSelected ? .blue : .gray)
                Text(title)
                    .font(.caption)
                    .foregroundColor(isSelected ? .blue : .gray)
            }
        }
    }
}

struct TaskControlView_Previews: PreviewProvider {
    static var previews: some View {
        TaskControlView()
            .environmentObject(TaskViewModel.shared)
    }
}


