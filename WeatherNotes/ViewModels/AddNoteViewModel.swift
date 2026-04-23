import Foundation
import Combine

@MainActor
final class AddNoteViewModel: ObservableObject {
    @Published var noteTitle: String = ""
    @Published var noteText: String = ""
    @Published var isLoading: Bool = false
    @Published var showError: Bool = false
    @Published var errorMessage: String = ""

    private let weatherService: WeatherServiceProtocol = WeatherService()
    private let coreDataManager: CoreDataManager = .shared

    var canSave: Bool {
        !noteTitle.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty &&
        !noteText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty &&
        !isLoading
    }

    func saveNote() async -> Bool {
        let trimmedTitle = noteTitle.trimmingCharacters(in: .whitespacesAndNewlines)
        let trimmedText = noteText.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmedTitle.isEmpty, !trimmedText.isEmpty else { return false }

        isLoading = true
        defer { isLoading = false }

        do {
            let weather = try await weatherService.fetchWeather(city: "Kyiv")
            let note = WeatherNote(
                id: UUID(),
                title: trimmedTitle,
                text: trimmedText,
                date: Date(),
                temperature: weather.temperature,
                weatherCondition: weather.condition,
                weatherIcon: weather.icon,
                location: weather.location
            )
            try coreDataManager.saveNote(note)
            return true
        } catch {
            errorMessage = error.localizedDescription
            showError = true
            return false
        }
    }
}
