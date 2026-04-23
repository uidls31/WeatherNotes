import Foundation
import Combine

@MainActor
final class NoteDetailViewModel: ObservableObject {
    let note: WeatherNote
    private let coreDataManager: CoreDataManager = .shared

    init(note: WeatherNote) {
        self.note = note
    }

    func deleteNote() {
        coreDataManager.deleteNote(id: note.id)
    }
}
