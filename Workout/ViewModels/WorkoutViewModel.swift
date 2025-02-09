import Foundation

class WorkoutViewModel: ObservableObject {
    @Published var workouts: [Workout] = []
    
    init() {
        loadSampleWorkouts()
    }
    
    private func loadSampleWorkouts() {
        workouts = [
            Workout(name: "Push Day", type: .push, exercises: [
                Exercise(name: "Bench Press", sets: 3, reps: 10, weight: 135),
                Exercise(name: "Shoulder Press", sets: 3, reps: 12, weight: 95)
            ]),
            Workout(name: "Pull Day", type: .pull, exercises: [
                Exercise(name: "Barbell Rows", sets: 3, reps: 10, weight: 125),
                Exercise(name: "Pull-ups", sets: 3, reps: 8)
            ]),
            Workout(name: "Leg Day", type: .legs, exercises: [
                Exercise(name: "Squats", sets: 3, reps: 10, weight: 185),
                Exercise(name: "Deadlifts", sets: 3, reps: 8, weight: 225)
            ])
        ]
    }
} 