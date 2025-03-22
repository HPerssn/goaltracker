//
//  GoalEditView.swift
//  goal tracker
//
//  Created by Henrik Persson on 2025-03-22.
//

import SwiftUI
import SwiftData

struct GoalEditView: View {
    @Bindable var goal: Goal
    @Environment(\.dismiss) private var dismiss
    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Edit Goal")) {
                    TextField("Goal Type", text: $goal.type)
                    
                    Stepper("Target: \(Int(goal.targetValue))", value: $goal.targetValue, in: 1...10000, step: 1)
                                        
                    Stepper("Timeframe: \(Int(goal.timeframe / 86400)) days",
                    value: $goal.timeframe, in: 1...365 * 86400, step: 86400)
                    }
                }
            .navigationTitle("Edit Goal")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        dismiss()
                    }
                }
            }
            }
        }
    }

#Preview {
    GoalEditView(goal: Goal(type: "Push-ups", targetValue: 100, timeframe: 30 * 86400))
}
