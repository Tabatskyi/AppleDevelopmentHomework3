import Foundation

struct Address: Codable {
    let street: String?
    let city: String?
    let postalCode: String?

}

class Student: Codable {
    let id: Int
    let name: String
    let age: Int?
    let subjects: [String]?
    let address: Address?
    let scores: [String: Int?]?
    let hasScholarship: Bool?
    let graduationYear: Int?

    func average() -> Double {
        let scores = self.scores ?? ["": nil]
        let marks = scores.values.map { $0 ?? 0 }
        let sum = marks.reduce(0, +)
        return Double(sum) / Double(marks.count)
    }
}

struct Students: Codable {
    var students: [Student]
}

class ModelParser {
    let students: [Student]
    init(path: String) throws {
        let url = URL(fileURLWithPath: path)
        do {
            let data = try Data(contentsOf: url)
            students = try JSONDecoder().decode(Students.self, from: data).students
        } catch {
            throw error
        }
    }
    func getStudents() -> [Student] {
        return students
    }
}
