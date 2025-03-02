//
//  Goal.swift
//  goal tracker
//
//  Created by Henrik Persson on 2025-03-02.
//
import SwiftData
import Foundation

@Model
final class Goal {
    var type: String
    var targetValue: Double
    var timeFrame: TimeInterval
    var createdDate: Date
    @Relationship(deleteRule: .cascade) var habits: [Habit]?
    
    init(type: String, targetValue: Double, timeFrame: TimeInterval) {
        self.type = type
        self.targetValue = targetValue
        self.timeFrame = timeFrame
        self.createdDate = Date()
    }
}
