//
//  GoalDetail.swift
//  goal tracker
//
//  Created by Henrik Persson on 2025-03-06.
//

import SwiftUI
import SwiftData

struct GoalDetail: View {
    @Bindable var goal: Goal
    @State private var showingEditSheet = false
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                HStack {
                    Spacer()
                    Text(goal.type)
                        .font(.title)
                        .fontWeight(.bold)
                    Spacer()
                }
                //Progress section
                VStack(spacing: 8) {
                    ZStack {
                      Circle()
                            .stroke(Color.gray.opacity(0.3), lineWidth: 10)
                            .frame(width: 120, height: 120)
                     Circle()
                            .trim(from: 0, to: progress)
                            .stroke(progressColor, style: StrokeStyle(lineWidth: 10, lineCap: .round))
                            .rotationEffect(.degrees(-90))
                            .frame(width: 120, height: 120)
                            .animation(.easeInOut(duration: 0.5), value: progress)
                        VStack {
                            Text("\(Int(progress * 100))%")
                                .font(.title)
                                .bold()
                            Text("Completed")
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }
                    }
                }
                //Details section
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
                //Edit section
                HStack {
                    Button("Edit goal") {
                        showingEditSheet = true
                    }
                    .buttonStyle(.bordered)
                    
                    Spacer()
                    
                    Button("delete goal") {
                        deleteGoal()
                    }
                    .buttonStyle(.borderedProminent)
                    
                }
            }
            .padding()
        }
        .sheet(isPresented: $showingEditSheet) {
            GoalEditView(goal: goal)
        }
    }
    
    
    private var progress: Double {
        let elapsed = Date().timeIntervalSince(goal.createdDate)
        return min(elapsed / goal.timeframe, 1.0)
    }
    private var progressColor: Color {
        switch progress {
        case 0..<0.3: return .red
        case 0.3..<0.7: return .orange
        default: return .green
        }
    }
    
    private func deleteGoal() {
        modelContext.delete(goal)
        dismiss()
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
