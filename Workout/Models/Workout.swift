import Foundation

struct Program: Identifiable {
    let id: UUID
    var name: String
    var workouts: [Workout]
    
    init(id: UUID = UUID(), name: String, workouts: [Workout] = []) {
        self.id = id
        self.name = name
        self.workouts = workouts
    }
}

struct Workout: Identifiable {
    let id: UUID
    var name: String
    var exercises: [Exercise]
    
    init(id: UUID = UUID(), name: String, exercises: [Exercise] = []) {
        self.id = id
        self.name = name
        self.exercises = exercises
    }
}

struct Exercise: Identifiable {
    let id: UUID
    var name: String
    var sets: Int
    var reps: Int
    var weight: Double?
    
    init(id: UUID = UUID(), name: String, sets: Int, reps: Int, weight: Double? = nil) {
        self.id = id
        self.name = name
        self.sets = sets
        self.reps = reps
        self.weight = weight
    }
} 