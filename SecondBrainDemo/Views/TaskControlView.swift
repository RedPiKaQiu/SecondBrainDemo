import SwiftUI

struct TaskControlView: View {
    @Environment(\.dismiss) private var dismiss
    @ObservedObject var viewModel: TaskViewModel
    @State private var selectedTab = 0
    
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
                    TaskCheckboxItem(priority: 3, label: "!!! Checkbox")
                    TaskCheckboxItem(priority: 2, label: "!! Checkbox")
                    TaskCheckboxItem(priority: 1, label: "Checkbox")
                }
                .padding()
            }
            
            Spacer()
        }
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

struct TaskCheckboxItem: View {
    let priority: Int
    let label: String
    @State private var isChecked = false
    
    var body: some View {
        HStack {
            Button(action: { isChecked.toggle() }) {
                Image(systemName: isChecked ? "checkmark.square" : "square")
                    .foregroundColor(.gray)
            }
            Text(label)
            Spacer()
            Text(priority > 1 ? "日常" : "活动")
                .font(.caption)
                .padding(.horizontal, 8)
                .padding(.vertical, 4)
                .background(Color.gray.opacity(0.2))
                .cornerRadius(4)
        }
    }
} 