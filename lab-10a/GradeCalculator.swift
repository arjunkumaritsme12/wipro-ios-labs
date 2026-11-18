
import Foundation

struct GradeCalculator {

    static func calculateGrade(for score: Double) -> String? {

        guard (0...100).contains(score) else {
            return nil
        }

        switch score {
        case 90...100:
            return "A"
        case 80..<90:
            return "B"
        case 70..<80:
            return "C"
        case 60..<70:
            return "D"
        default:
            return "F"
        }
    }
}
