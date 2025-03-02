//
//  Habit.swift
//  goal tracker
//
//  Created by Henrik Persson on 2025-03-02.
//
import SwiftData
import Foundation

@Model
final class Habit {
    var date: Date
    var targetValue: Double
    var isCompleted: Bool
    var actualValue: Double?
    @Relationship(deleteRule: .cascade, inverse: \Goal.habits) var goal: Goal?
    
    init(date: Date, targetValue: Double) {
        self.date = date
        self.targetValue = targetValue
        self.isCompleted = false
    }
}
