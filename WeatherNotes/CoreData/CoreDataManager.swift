import CoreData
import Foundation

final class CoreDataManager {
    static let shared = CoreDataManager()

    private let container: NSPersistentContainer

    private init() {
        container = NSPersistentContainer(name: "WeatherNotesCoreData")
        container.loadPersistentStores { _, error in
            if let error {
                print("Failed to load persistent stores: \(error.localizedDescription)")
            }
        }
    }

    private var context: NSManagedObjectContext {
        container.viewContext
    }

    func saveNote(_ note: WeatherNote) {
        context.performAndWait {
            let entity = WeatherCoreData(context: context)
            entity.id = note.id
            entity.text = note.text
            entity.date = note.date
            entity.temperature = note.temperature
            entity.weatherCondition = note.weatherCondition
            entity.weatherIcon = note.weatherIcon
            entity.location = note.location

            do {
                try context.save()
            } catch {
                print("Failed to save note: \(error.localizedDescription)")
            }
        }
    }

    func fetchNotes() -> [WeatherNote] {
        var mappedNotes: [WeatherNote] = []

        context.performAndWait {
            let request: NSFetchRequest<WeatherCoreData> = WeatherCoreData.fetchRequest()
            request.sortDescriptors = [NSSortDescriptor(key: "date", ascending: false)]

            do {
                let entities = try context.fetch(request)
                mappedNotes = entities.map { entity in
                    WeatherNote(
                        id: entity.id ?? UUID(),
                        text: entity.text ?? "",
                        date: entity.date ?? Date(),
                        temperature: entity.temperature ?? "",
                        weatherCondition: entity.weatherCondition ?? "",
                        weatherIcon: entity.weatherIcon ?? "cloud.fill",
                        location: entity.location ?? ""
                    )
                }
            } catch {
                print("Failed to fetch notes: \(error.localizedDescription)")
            }
        }

        return mappedNotes
    }

    func deleteNote(id: UUID) {
        context.performAndWait {
            let request: NSFetchRequest<WeatherCoreData> = WeatherCoreData.fetchRequest()
            request.predicate = NSPredicate(format: "id == %@", id as CVarArg)
            request.fetchLimit = 1

            do {
                if let entity = try context.fetch(request).first {
                    context.delete(entity)
                    try context.save()
                }
            } catch {
                print("Failed to delete note: \(error.localizedDescription)")
            }
        }
    }
}
