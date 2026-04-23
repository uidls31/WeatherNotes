import Foundation
import Combine

@MainActor
final class NotesViewModel: ObservableObject {
    private let weatherService: WeatherServiceProtocol = WeatherService()
    @Published var notes: [WeatherNote] = []
    @Published var showError: Bool = false
    @Published var errorMessage: String = ""
    
    func addNote(text: String) {
        let trimmedText = text.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmedText.isEmpty else { return }
        
        Task {
            do {
                let weather = try await weatherService.fetchWeather(city: "Kyiv")
                let newNote = WeatherNote(
                    id: UUID(),
                    text: trimmedText,
                    date: Date(),
                    temperature:  weather.temperature,
                    weatherCondition: weather.condition,
                    weatherIcon: weather.icon,
                    location: weather.location
                )
                
                notes.insert(newNote, at: 0)
            } catch {
                self.errorMessage = error.localizedDescription
                self.showError = true
                print("Failed to fetch weather: \(error.localizedDescription)")
            }
        }
    }
}
