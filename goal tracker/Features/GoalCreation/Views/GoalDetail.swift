//
//  GoalDetail.swift
//  goal tracker
//
//  Created by Henrik Persson on 2025-03-06.
//

import SwiftUI
import SwiftData

struct GoalDetail: View {
    let goal: Goal
    @State private var showingEditSheet = false
    @Environment(\.modelContext) private var modelContext
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Text(goal.type)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.bottom)
                
                GroupBox("Goal Details") {
                    VStack(alignment: .leading, spacing: 12) {
                        DetailRow(label: "Target:", value: "\(Int(goal.targetValue))")
                        
                        let days = Int(goal.timeframe) / 86400
                        DetailRow(label: "Timeframe:", value: "\(days) days")
                        
                        let endDate = Calendar.current.date(byAdding: .second, value: Int(goal.timeframe), to: goal.createdDate)
                        if let endDate = endDate {
                            DetailRow(label: "End date:", value: endDate.formatted(date: .long, time: .omitted))
                        }
                    }
                    .padding(.vertical, 8)
                }
            }
        }
    }
}

struct DetailRow: View {
    var label: String
    var value: String
    
    var body: some View {
        HStack(alignment: .top) {
            Text(label)
                .font(.headline)
                .frame(width: 100, alignment: .leading)
            
            Text(value)
                .font(.body)
            
            Spacer()
        }
    }
}

#Preview {
    NavigationStack {
        GoalDetail(goal: Goal(type: "Push-ups", targetValue: 100, timeframe: 30 * 86400))
    }
    .modelContainer(for: [Goal.self])
}
