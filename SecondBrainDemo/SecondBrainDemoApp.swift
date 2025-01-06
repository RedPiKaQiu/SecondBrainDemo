//
//  SecondBrainDemoApp.swift
//  SecondBrainDemo
//
//  Created by pika on 2025/1/2.
//

import SwiftUI

@main
struct SecondBrainDemoApp: App {
    @StateObject private var taskViewModel = TaskViewModel.shared
    
    var body: some Scene {
        WindowGroup {
            TaskListView()
                .environmentObject(taskViewModel)
        }
    }
}
