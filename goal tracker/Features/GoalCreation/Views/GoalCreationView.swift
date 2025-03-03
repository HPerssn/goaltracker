//
//  GoalCreationView.swift
//  goal tracker
//
//  Created by Henrik Persson on 2025-03-02.
//

import SwiftUI

struct GoalCreationView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    @State private var goalType = ""
    @State private var targetValue = 100.0
    @State private var timeframeDays = 30.0
    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Goal details")) {
                    TextField("Goal Type( e.g., push-ups)", text: $goalType)
                    Stepper("Target: \(Int(targetValue))", value: $targetValue, in: 1...1000, step: 5)
                    Stepper("Timeframe: \(Int(timeframeDays)) days", value: $timeframeDays, in: 7...365)
                }
                Section {
                    Button("Create Goal") {
                        createGoal()
                    }
                    .disabled(goalType.isEmpty)
                }
            }
            .navigationTitle("New Goal")
        }
    }
    private func createGoal() {
        let newGoal = Goal(
            type: goalType,
            targetValue: targetValue,
            timeframe: timeframeDays * 86400
        )
        //Generate habit plan
        let habits = generateHabitPlan(for: newGoal)
        newGoal.habits = habits
        modelContext.insert(newGoal)
        dismiss()
    }
    private func generateHabitPlan(for goal: Goal) -> [Habit] {
        let days = Int(goal.timeframe)
        let startValue = 1.0
        let targetValue = goal.targetValue
        let growthRate = pow(targetValue / startValue, 1.0 / Double(days - 1))
        
        var habits = [Habit]()
        for day in 0..<days {
            let date = Calendar.current.date(byAdding: .day, value: day, to: Date()) ?? Date()
            let target = startValue * pow(growthRate, Double(day))
            let habit = Habit(date: date, targetValue: round(target))
            habits.append(habit)
        }
        return habits
    }
}

#Preview {
    GoalCreationView()
}
