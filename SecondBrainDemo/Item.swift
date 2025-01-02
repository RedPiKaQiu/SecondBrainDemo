//
//  Item.swift
//  SecondBrainDemo
//
//  Created by pika on 2025/1/2.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
