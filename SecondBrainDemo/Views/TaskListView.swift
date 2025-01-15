import SwiftUI

struct TaskListView: View {
    @EnvironmentObject private var viewModel: TaskViewModel
    @StateObject private var userProfile = UserProfile.shared
    @State private var showingAddTask = false
    @State private var showingTaskControl = false
    @State private var showingPersonal = false
    @State private var showingChat = false
    @State private var selectedTab = 0
    @State private var tabOrder = ["Anytime", "Planned", "Done"]
    
    // 获取当前日期
    private var currentDate: Date {
        Calendar.current.startOfDay(for: Date())
    }
    
    // 格式化星期
    private var weekdayString: String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "zh_CN")
        formatter.dateFormat = "EEEE"
        return formatter.string(from: currentDate)
    }
    
    // 格式化日期
    private var dateString: String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "zh_CN")
        formatter.dateFormat = "MM月dd日, yyyy"
        return formatter.string(from: currentDate)
    }
    
    // 根据选中的标签获取对应的任务
    private var filteredTasks: [Task] {
        let tasks = viewModel.tasksForDate(currentDate)
        let tabType = tabOrder[selectedTab]
        switch tabType {
        case "Anytime":
            return tasks.filter { !$0.hasTime }
        case "Planned":
            return tasks.filter { $0.hasTime }
        case "Done":
            return tasks.filter { $0.isCompleted }
        default:
            return []
        }
    }
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                // 顶部导航栏
                HStack {
                    Button(action: { showingTaskControl = true }) {
                        Text("List")
                            .foregroundColor(.white)
                            .padding()
                            .background(Color(red: 0.4, green: 0.4, blue: 1.0))
                            .cornerRadius(8)
                    }
                    Spacer()
                    Button(action: { showingPersonal = true }) {
                        Text(userProfile.name)
                            .foregroundColor(.white)
                            .padding()
                            .background(Color(red: 0.4, green: 0.4, blue: 1.0))
                            .cornerRadius(8)
                    }
                }
                .padding()
                
                // 欢迎消息
                Text("I'm here for you!💝")
                    .padding()
                
                // 日期显示
                VStack {
                    Text(weekdayString)
                        .font(.title)
                        .bold()
                    Text(dateString)
                        .foregroundColor(.gray)
                }
                .padding()
                
                // 建议卡片
                VStack {
                    Text("建议接下来")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal)
                    
                    HStack {
                        Text("晒太阳☀️")
                        Spacer()
                        Button(action: {
                        }) {
                            Text("OK!")
                                .foregroundColor(.white)
                                .padding()
                                .background(Color(red: 0.4, green: 0.4, blue: 1.0))
                                .cornerRadius(8)
                        }
                    }
                    .padding()
                    .background(Color(uiColor: .systemBackground))
                    .cornerRadius(12)
                    .shadow(radius: 2)
                }
                .padding()
                
                // 底部标签栏
                HStack(spacing: 40) {
                    ForEach(0..<2) { index in
                        TabButton(
                            title: tabOrder[index],
                            icon: iconFor(tabOrder[index]),
                            isSelected: selectedTab == index
                        ) {
                            selectedTab = index
                        }
                        .gesture(
                            DragGesture()
                                .onChanged { _ in }
                                .onEnded { _ in
                                    if index == 0 || index == 1 {
                                        withAnimation {
                                            tabOrder.swapAt(0, 1)
                                        }
                                    }
                                }
                        )
                    }
                    
                    TabButton(
                        title: tabOrder[2],
                        icon: "checkmark",
                        isSelected: selectedTab == 2
                    ) {
                        selectedTab = 2
                    }
                }
                .padding()
                
                // 任务列表
                ScrollView {
                    VStack(spacing: 15) {
                        ForEach(filteredTasks) { task in
                            TaskCheckboxItem(task: task, date: currentDate)
                        }
                    }
                    .padding()
                }
                
                // 底部按钮
                HStack(spacing: 20) {
                    Button(action: { showingAddTask = true }) {
                        Text("Add")
                            .foregroundColor(.blue)
                            .padding()
                            .background(Color.blue.opacity(0.1))
                            .cornerRadius(8)
                    }
                    
                    Button(action: {}) {
                        Text("Voice")
                            .foregroundColor(.blue)
                            .padding()
                            .background(Color.blue.opacity(0.1))
                            .cornerRadius(8)
                    }
                    
                    Button(action: { showingChat = true }) {
                        Text("Chat")
                            .foregroundColor(.blue)
                            .padding()
                            .background(Color.blue.opacity(0.1))
                            .cornerRadius(8)
                    }
                }
                .padding()
            }
            .background(Color(uiColor: .systemGroupedBackground))
        }
        .sheet(isPresented: $showingAddTask) {
            AddTaskView()
                .environmentObject(viewModel)
        }
        .sheet(isPresented: $showingTaskControl) {
            TaskControlView()
                .environmentObject(viewModel)
        }
        .sheet(isPresented: $showingPersonal) {
            PersonalView()
        }
        .sheet(isPresented: $showingChat) {
            ChatView()
        }

    }
    
    private func iconFor(_ tab: String) -> String {
        switch tab {
        case "Anytime":
            return "cup.and.saucer.fill"
        case "Planned":
            return "hexagon"
        case "Done":
            return "checkmark"
        default:
            return ""
        }
    }
}

struct TaskListView_Previews: PreviewProvider {
    static var previews: some View {
        TaskListView()
            .environmentObject(TaskViewModel.shared)
    }
} 
