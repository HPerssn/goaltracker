//
//  GoalCreationView.swift
//  goal tracker
//
//  Created by Henrik Persson on 2025-03-02.
//

import SwiftData
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
                    TextField("Goal Type (e.g., push-ups)", text: $goalType)
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
        modelContext.insert(newGoal)
        dismiss()
    }
}

#Preview {
    GoalCreationView()
        .modelContainer(for: [Goal.self])
}
