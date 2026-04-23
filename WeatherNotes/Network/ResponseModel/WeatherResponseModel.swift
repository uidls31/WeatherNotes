import Foundation

struct WeatherResponseModel: Decodable {
    let main: Main?
    let weather: [Weather]?
    let name: String?

    struct Main: Decodable {
        let temp: Double?
    }

    struct Weather: Decodable {
        let main: String?
        let description: String?
        let icon: String?
    }
}
