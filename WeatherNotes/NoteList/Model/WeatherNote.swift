import Foundation

struct WeatherNote: Identifiable {
    let id: UUID
    let text: String
    let date: Date
    let temperature: String
    let weatherCondition: String
    let weatherIcon: String
    let location: String
}
