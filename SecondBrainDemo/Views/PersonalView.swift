import SwiftUI

struct PersonalView: View {
    @Environment(\.dismiss) private var dismiss
    let userName = "Shell"
    let email = "aab@gmail.com"
    
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
                    Text("setting")
                        .foregroundColor(.white)
                        .padding()
                        .background(Color(red: 0.4, green: 0.4, blue: 1.0))
                        .cornerRadius(8)
                }
            }
            .padding()
            
            // 用户信息
            VStack(alignment: .leading, spacing: 8) {
                Text(userName)
                    .font(.title)
                    .bold()
                Text(email)
                    .foregroundColor(.gray)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding()
            
            // Recently 部分
            GroupBox(label: Text("Recently")) {
                VStack(alignment: .leading, spacing: 8) {
                    Text("项目结项")
                    Text("早睡早起")
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.vertical, 8)
            }
            .padding()
            
            // Long-term 部分
            GroupBox(label: Text("Long-term")) {
                VStack(alignment: .leading, spacing: 8) {
                    Text("陪伴猫咪")
                    Text("健康生活")
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.vertical, 8)
            }
            .padding()
            
            // 近期能量数据
            GroupBox(label: Text("近期能量数据")) {
                Rectangle()
                    .fill(Color.clear)
                    .frame(height: 200)
                    .overlay(
                        Text("数据图表区域")
                            .foregroundColor(.gray)
                    )
            }
            .padding()
            
            Spacer()
        }
        .background(Color(uiColor: .systemGroupedBackground))
    }
} 