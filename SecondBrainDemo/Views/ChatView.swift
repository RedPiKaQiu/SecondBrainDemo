import SwiftUI

struct ChatView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var messageText = ""
    
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
                Button(action: {}) {
                    Text("herstory")
                        .foregroundColor(.white)
                        .padding()
                        .background(Color(red: 0.4, green: 0.4, blue: 1.0))
                        .cornerRadius(8)
                }
            }
            .padding()
            
            Spacer()
            
            // 聊天提示文本
            Text("Let's Chat !")
                .font(.title)
                .padding()
            
            Spacer()
            
            // 底部输入框和发送按钮
            HStack {
                TextField("", text: $messageText)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal)
                
                Button(action: {}) {
                    Text("send")
                        .foregroundColor(.white)
                        .padding()
                        .background(Color(red: 0.4, green: 0.4, blue: 1.0))
                        .cornerRadius(8)
                }
                .padding(.trailing)
            }
            .padding(.bottom)
        }
        .background(Color(uiColor: .systemGroupedBackground))
    }
} 