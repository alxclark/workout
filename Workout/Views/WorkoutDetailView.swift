//
//  WorkoutDetailView.swift
//  Workout
//
//  Created by Alex Clark on 2025-02-08.
//

import SwiftUI

struct WorkoutDetailView: View {
    let workout: Workout
    @Environment(\.dismiss) private var dismiss
    @State private var showingStartWorkout = false
    
    var body: some View {
        ScrollView() {
            VStack(alignment: .leading, spacing: 20) {
                // Header
                VStack(alignment: .leading, spacing: 8) {
                    Text(workout.name)
                        .font(.title)
                        .bold()
                    
                    HStack(spacing: 16) {
                        Label("\(workout.exercises.count) exercises", systemImage: "dumbbell.fill")
                        Label("~\(estimatedDuration) min", systemImage: "clock.fill")
                    }
                    .foregroundColor(.secondary)
                    .font(.subheadline)
                }
                
                // Exercise List
                VStack(alignment: .leading, spacing: 16) {
                    Text("Exercises")
                        .font(.headline)
                    
                    ForEach(workout.exercises) { exercise in
                        ExerciseRow(exercise: exercise)
                    }
                }
            }
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .navigationBarTitleDisplayMode(.inline)
        .sheet(isPresented: $showingStartWorkout) {
            Text("Workout Session View - Coming Soon")
                .presentationDetents([.large])
        }
    }
    
    private var estimatedDuration: Int {
        // Simple estimation: 2 minutes per set plus rest time
        workout.exercises.reduce(0) { total, exercise in
            total + (exercise.sets * 2)
        }
    }
}

struct ExerciseRow: View {
    let exercise: Exercise
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(exercise.name)
                .font(.headline)
            
            HStack(spacing: 16) {
                if let weight = exercise.weight {
                    Label("\(Int(weight))kg", systemImage: "scalemass.fill")
                }
                Label("\(exercise.sets) sets", systemImage: "repeat")
                Label("\(exercise.reps) reps", systemImage: "figure.run")
            }
            .font(.subheadline)
            .foregroundColor(.secondary)
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.secondary.opacity(0.1))
        .cornerRadius(10)
    }
}

#Preview {
    NavigationStack {
        WorkoutDetailView(workout: Seeds.programs[0].workouts[0])
    }
} 
