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
            List(viewModel.programs[0].workouts) { workout in
                NavigationLink(destination: WorkoutDetailView(workout: workout)) {
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
        }
    }
}

#Preview {
    ContentView()
}
