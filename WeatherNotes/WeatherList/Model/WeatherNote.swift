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

extension WeatherNote {
    static let mockData: [WeatherNote] = [
        WeatherNote(
            id: UUID(),
            text: "Morning run near the river felt refreshing today. Air was crisp and perfect for a long distance session.",
            date: Date().addingTimeInterval(-3600),
            temperature: "+14°C",
            weatherCondition: "Clear",
            weatherIcon: "sun.max.fill",
            location: "Kyiv, UA"
        ),
        WeatherNote(
            id: UUID(),
            text: "Light rain started during lunch. Great excuse to sit by the window with coffee and work on app ideas.",
            date: Date().addingTimeInterval(-21_600),
            temperature: "+11°C",
            weatherCondition: "Rain",
            weatherIcon: "cloud.rain.fill",
            location: "Lviv, UA"
        ),
        WeatherNote(
            id: UUID(),
            text: "Evening walk was windy but beautiful. Clouds moved quickly and sunset colors were dramatic.",
            date: Date().addingTimeInterval(-86_400),
            temperature: "+9°C",
            weatherCondition: "Windy",
            weatherIcon: "wind",
            location: "Odesa, UA"
        ),
        WeatherNote(
            id: UUID(),
            text: "Weekend trip started with soft fog in the hills. Visibility was low but the scenery still looked magical.",
            date: Date().addingTimeInterval(-172_800),
            temperature: "+7°C",
            weatherCondition: "Fog",
            weatherIcon: "cloud.fog.fill",
            location: "Yaremche, UA"
        )
    ]
}
