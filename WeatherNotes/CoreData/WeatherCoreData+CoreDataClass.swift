public import Foundation
public import CoreData

public typealias WeatherCoreDataCoreDataClassSet = NSSet

@objc(WeatherCoreData)
public class WeatherCoreData: NSManagedObject {

}

extension WeatherCoreData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<WeatherCoreData> {
        return NSFetchRequest<WeatherCoreData>(entityName: "WeatherCoreData")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var text: String?
    @NSManaged public var date: Date?
    @NSManaged public var temperature: String?
    @NSManaged public var weatherCondition: String?
    @NSManaged public var weatherIcon: String?
    @NSManaged public var location: String?
    @NSManaged public var title: String?

}

extension WeatherCoreData : Identifiable {

}
