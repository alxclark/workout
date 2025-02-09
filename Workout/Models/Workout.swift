import Foundation

struct Workout: Identifiable {
    let id: UUID
    var name: String
    var type: WorkoutType
    var exercises: [Exercise]
    
    init(id: UUID = UUID(), name: String, type: WorkoutType, exercises: [Exercise] = []) {
        self.id = id
        self.name = name
        self.type = type
        self.exercises = exercises
    }
}

enum WorkoutType: String, CaseIterable {
    case push = "Push"
    case pull = "Pull"
    case legs = "Legs"
    case fullBody = "Full Body"
    case cardio = "Cardio"
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