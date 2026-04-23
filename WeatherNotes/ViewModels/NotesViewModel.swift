import Foundation
import Combine

@MainActor
final class NotesViewModel: ObservableObject {
    private let coreDataManager: CoreDataManager = .shared
    @Published var notes: [WeatherNote] = []

    init() {
        fetchNotes()
    }

    func fetchNotes() {
        notes = coreDataManager.fetchNotes()
    }
}
