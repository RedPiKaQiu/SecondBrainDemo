import SwiftUI

struct TaskListView: View {
    @StateObject private var viewModel = TaskViewModel()
    @State private var showingAddTask = false
    @State private var showingTaskControl = false
    @State private var showingPersonal = false
    @State private var showingChat = false
    @State private var selectedTab = 0
    
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
                        Text("name")
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
                    Text("星期六")
                        .font(.title)
                        .bold()
                    Text("十二月 第21, 2024")
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
                        Button(action: {}) {
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
                    TabButton(title: "Anytime", icon: "cup.and.saucer.fill", isSelected: selectedTab == 0) {
                        selectedTab = 0
                    }
                    TabButton(title: "Planned", icon: "hexagon", isSelected: selectedTab == 1) {
                        selectedTab = 1
                    }
                    TabButton(title: "Done", icon: "checkmark", isSelected: selectedTab == 2) {
                        selectedTab = 2
                    }
                }
                .padding()
                
                // 任务列表
                ScrollView {
                    VStack(spacing: 15) {
                        TaskCheckboxItem(priority: 3, label: "!!! Checkbox")
                        TaskCheckboxItem(priority: 2, label: "!! Checkbox")
                        TaskCheckboxItem(priority: 1, label: "Checkbox")
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
            AddTaskView(viewModel: viewModel)
        }
        .sheet(isPresented: $showingTaskControl) {
            TaskControlView(viewModel: viewModel)
        }
        .sheet(isPresented: $showingPersonal) {
            PersonalView()
        }
        .sheet(isPresented: $showingChat) {
            ChatView()
        }
    }
}

struct TaskListView_Previews: PreviewProvider {
    static var previews: some View {
        TaskListView()
    }
} 
