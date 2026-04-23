import Foundation
import Combine

@MainActor
final class NotesViewModel: ObservableObject {
    private let weatherService: WeatherServiceProtocol = WeatherService()
    private let coreDataManager: CoreDataManager = .shared
    @Published var notes: [WeatherNote] = []
    @Published var showError: Bool = false
    @Published var errorMessage: String = ""

    init() {
        self.notes = coreDataManager.fetchNotes()
    }
    
    func addNote(title: String, text: String) {
        let trimmedTitle = title.trimmingCharacters(in: .whitespacesAndNewlines)
        let trimmedText = text.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmedTitle.isEmpty, !trimmedText.isEmpty else { return }
        
        Task {
            do {
                let weather = try await weatherService.fetchWeather(city: "Kyiv")
                let newNote = WeatherNote(
                    id: UUID(),
                    title: trimmedTitle,
                    text: trimmedText,
                    date: Date(),
                    temperature:  weather.temperature,
                    weatherCondition: weather.condition,
                    weatherIcon: weather.icon,
                    location: weather.location
                )
                
                notes.insert(newNote, at: 0)
                coreDataManager.saveNote(newNote)
            } catch {
                self.errorMessage = error.localizedDescription
                self.showError = true
                print("Failed to fetch weather: \(error.localizedDescription)")
            }
        }
    }

    func deleteNote(_ note: WeatherNote) {
        coreDataManager.deleteNote(with: note.id)
        notes.removeAll { $0.id == note.id }
    }
}
