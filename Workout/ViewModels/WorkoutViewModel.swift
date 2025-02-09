import Foundation

class WorkoutViewModel: ObservableObject {
    @Published var programs: [Program] = []
    
    init() {
        loadSamplePrograms()
    }
    
    private func loadSamplePrograms() {
        programs = [
            Program(name: "Push, Pull, Legs", workouts: [
                Workout(name: "Push Day", exercises: [
                    Exercise(name: "Bench Press", sets: 3, reps: 10, weight: 135),
                    Exercise(name: "Shoulder Press", sets: 3, reps: 12, weight: 95)
                ]),
                Workout(name: "Pull Day", exercises: [
                    Exercise(name: "Barbell Rows", sets: 3, reps: 10, weight: 125),
                    Exercise(name: "Pull-ups", sets: 3, reps: 8)
                ]),
                Workout(name: "Leg Day", exercises: [
                    Exercise(name: "Squats", sets: 3, reps: 10, weight: 185),
                    Exercise(name: "Deadlifts", sets: 3, reps: 8, weight: 225)
                ])
            ])
        ]
    }
} 
