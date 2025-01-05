import SwiftUI

struct TaskListView: View {
    @StateObject private var viewModel = TaskViewModel()
    @State private var showingAddTask = false
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.tasks) { task in
                    TaskRow(task: task)
                }
                .onDelete(perform: viewModel.deleteTask)
            }
            .navigationTitle("任务列表")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    HStack() {
                        Button(action: {  }) {
                            Text("list".uppercased()).foregroundColor(.white)
                                .padding()
                                .background(.blue)
                        }
                        Button(action: { showingAddTask = true }) {
                            Image(systemName: "plus")
                        }
                        
                    }
                }
            }
            .sheet(isPresented: $showingAddTask) {
                AddTaskView(viewModel: viewModel)
            }
        }
    }
}

struct TaskListView_Previews: PreviewProvider {
    static var previews: some View {
        TaskListView()
    }
} 
