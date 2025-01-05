import SwiftUI

struct TaskRow: View {
    let task: Task
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(task.title)
                .font(.headline)
            if !task.descriptionText.isEmpty {
                Text(task.descriptionText)
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            HStack {
                Image(systemName: "flag.fill")
                    .foregroundColor(priorityColor(task.priority))
                ForEach(task.tags, id: \.self) { tag in
                    Text(tag)
                        .font(.caption)
                        .padding(4)
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(4)
                }
            }
        }
        .padding(.vertical, 4)
    }
    
    private func priorityColor(_ priority: Int) -> Color {
        switch priority {
        case 0: return .gray
        case 1: return .yellow
        case 2: return .red
        default: return .gray
        }
    }
} 