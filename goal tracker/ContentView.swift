//
//  ContentView.swift
//  goal tracker
//
//  Created by Henrik Persson on 2025-02-25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            GoalListView()
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
