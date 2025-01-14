import SwiftUI

struct UserSettingsView: View {
    @Environment(\.dismiss) private var dismiss
    @ObservedObject private var userProfile = UserProfile.shared
    @State private var tempProfile: TempUserProfile
    
    init() {
        _tempProfile = State(initialValue: TempUserProfile(
            name: UserProfile.shared.name,
            email: UserProfile.shared.email,
            gender: UserProfile.shared.gender,
            age: UserProfile.shared.age,
            hasADHD: UserProfile.shared.hasADHD,
            occupation: UserProfile.shared.occupation,
            usageIntensity: UserProfile.shared.preferences.usageIntensity,
            enableReminders: UserProfile.shared.preferences.enableReminders
        ))
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("基本信息")) {
                    TextField("姓名", text: $tempProfile.name)
                    TextField("邮箱", text: $tempProfile.email)
                    Picker("性别", selection: $tempProfile.gender) {
                        Text("男").tag(UserProfile.Gender.male)
                        Text("女").tag(UserProfile.Gender.female)
                        Text("其他").tag(UserProfile.Gender.other)
                    }
                    Stepper("年龄: \(tempProfile.age)", value: $tempProfile.age, in: 1...120)
                }
                
                Section(header: Text("其他信息")) {
                    Picker("职业", selection: $tempProfile.occupation) {
                        Text("学生").tag(UserProfile.Occupation.student)
                        Text("工作党").tag(UserProfile.Occupation.worker)
                        Text("其他").tag(UserProfile.Occupation.other)
                    }
                    Toggle("ADHD", isOn: $tempProfile.hasADHD)
                }
                
                Section(header: Text("使用偏好")) {
                    Picker("使用强度", selection: $tempProfile.usageIntensity) {
                        Text("轻度").tag(UserProfile.UserPreferences.UsageIntensity.light)
                        Text("重度").tag(UserProfile.UserPreferences.UsageIntensity.heavy)
                    }
                    Toggle("开启提醒", isOn: $tempProfile.enableReminders)
                }
            }
            .navigationTitle("设置")
            .navigationBarItems(
                leading: Button(action: { dismiss() }) {
                    Text("back")
                        .foregroundColor(.white)
                        .padding()
                        .background(Color(red: 0.4, green: 0.4, blue: 1.0))
                        .cornerRadius(8)
                },
                trailing: Button(action: saveChanges) {
                    Text("保存")
                        .foregroundColor(.white)
                        .padding()
                        .background(Color(red: 0.4, green: 0.4, blue: 1.0))
                        .cornerRadius(8)
                }
            )
        }
    }
    
    private func saveChanges() {
        userProfile.name = tempProfile.name
        userProfile.email = tempProfile.email
        userProfile.gender = tempProfile.gender
        userProfile.age = tempProfile.age
        userProfile.hasADHD = tempProfile.hasADHD
        userProfile.occupation = tempProfile.occupation
        userProfile.preferences.usageIntensity = tempProfile.usageIntensity
        userProfile.preferences.enableReminders = tempProfile.enableReminders
        
        dismiss()
    }
}

private struct TempUserProfile {
    var name: String
    var email: String
    var gender: UserProfile.Gender
    var age: Int
    var hasADHD: Bool
    var occupation: UserProfile.Occupation
    var usageIntensity: UserProfile.UserPreferences.UsageIntensity
    var enableReminders: Bool
} 