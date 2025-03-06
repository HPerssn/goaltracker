//
//  goal_trackerApp.swift
//  goal tracker
//
//  Created by Henrik Persson on 2025-02-25.
//

import SwiftUI
import SwiftData

@main
struct goal_trackerApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: [Goal.self])
    }
}
