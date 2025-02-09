//
//  ContentView.swift
//  Workout
//
//  Created by Alex Clark on 2025-02-08.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = WorkoutViewModel()
    
    var body: some View {
        NavigationStack {
            List(viewModel.workouts) { workout in
                NavigationLink(destination: Text("Workout Detail View - Coming Soon")) {
                    VStack(alignment: .leading, spacing: 4) {
                        Text(workout.name)
                            .font(.headline)
                        Text("\(workout.exercises.count) exercises")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                    .padding(.vertical, 4)
                }
            }
            .navigationTitle("My Workouts")
            .toolbar {
                Button(action: {
                    // Add workout functionality coming soon
                }) {
                    Image(systemName: "plus")
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
