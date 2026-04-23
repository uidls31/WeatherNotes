import Foundation
import Combine

final class NotesViewModel: ObservableObject {
    @Published var notes: [WeatherNote] = WeatherNote.mockData

    func addNote(text: String) {
        let trimmedText = text.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmedText.isEmpty else { return }

        let newNote = WeatherNote(
            id: UUID(),
            text: trimmedText,
            date: Date(),
            temperature: "+20°C",
            weatherCondition: "Sunny",
            weatherIcon: "sun.max.fill",
            location: "Kyiv"
        )

        notes.insert(newNote, at: 0)
    }
}
