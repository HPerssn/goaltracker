//
//  ContentView.swift
//  goal tracker
//
//  Created by Henrik Persson on 2025-02-25.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Query(sort: \Goal.timeframe) private var goals: [Goal]
    @State private var showingGoalCreation = false
    @Environment(\.modelContext) private var modelContext
    var body: some View {
        NavigationStack {
            Group {
                if goals.isEmpty {
                    VStack {
                        Text("No goals yet")
                            .font(.headline)
                        Text("Create your first goal to get started")
                            .foregroundColor(.secondary)
                        Button("Create goal") {
                            showingGoalCreation = true
                        }
                        .buttonStyle(.bordered)
                        .padding()
                    }
                } else {
                    List {
                        ForEach(goals) { goal in
                            NavigationLink(destination: Text("Detail view for \(goal.type)")) {
                                VStack(alignment: .leading) {
                                    Text(goal.type)
                                        .font(.headline)
                                    Text("Target: \(Int(goal.targetValue))")
                                        .foregroundColor(.secondary)
                                    }
                                }
                            }
                        .onDelete(perform: deleteGoals(indexes:))
                        }
                    }
                }
            .navigationTitle("My Goals")
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    EditButton()
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {
                        showingGoalCreation = true })
                    {
                        Label("Add Goal", systemImage: "plus")
                    }
                }
            }
        .sheet(isPresented: $showingGoalCreation) {
            GoalCreationView()
            }
        }
    }
    private func deleteGoals(indexes: IndexSet) {
            for index in indexes {
                    modelContext.delete(goals[index])
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: [Goal.self])
}
