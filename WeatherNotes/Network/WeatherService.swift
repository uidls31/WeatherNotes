import Foundation

protocol WeatherServiceProtocol {
    func fetchWeather(city: String) async throws -> (
        temperature: String,
        condition: String,
        icon: String,
        location: String
    )
}

struct WeatherService: WeatherServiceProtocol {
    func fetchWeather(city: String) async throws -> (
        temperature: String,
        condition: String,
        icon: String,
        location: String
    ) {
        let urlString = "https://api.openweathermap.org/data/2.5/weather?q=\(city)&APPID=4386ffd0b2113971ba87a450acd9e3d4&units=metric"
        guard let encodedURLString = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
              let url = URL(string: encodedURLString) else {
            throw WeatherError.invalidURL
        }
        
        let data: Data
        let response: URLResponse
        do {
            (data, response) = try await URLSession.shared.data(from: url)
        } catch {
            throw WeatherError.networkError(error)
        }
        
        guard let httpResponse = response as? HTTPURLResponse,
              (200...299).contains(httpResponse.statusCode) else {
            throw WeatherError.invalidResponse
        }
        
        let weatherResponse: WeatherResponseModel
        do {
            weatherResponse = try JSONDecoder().decode(WeatherResponseModel.self, from: data)
        } catch {
            throw WeatherError.decodingError(error)
        }
        
        let mainInfo = weatherResponse.main
        let weatherInfo = weatherResponse.weather?.first
        
        let tempValue = mainInfo?.temp ?? 0.0
        let tempInt = Int(round(tempValue))
        let tempString = tempInt > 0 ? "+\(tempInt)°C" : "\(tempInt)°C"
        
        let condition = (weatherInfo?.main?.isEmpty ?? true)
        ? (weatherInfo?.description ?? "Unknown")
        : (weatherInfo?.main ?? "Unknown")
        
        return (
            temperature: tempString,
            condition: condition.capitalized,
            icon: mapIconCodeToSFSymbol(weatherInfo?.icon ?? ""),
            location: weatherResponse.name ?? city
        )
    }
    
    private func mapIconCodeToSFSymbol(_ code: String) -> String {
        switch code {
        case "01d":
            return "sun.max.fill"
        case "01n":
            return "moon.stars.fill"
        case "02d":
            return "cloud.sun.fill"
        case "02n":
            return "cloud.moon.fill"
        case "03d", "03n":
            return "cloud.fill"
        case "04d", "04n":
            return "smoke.fill"
        case "09d", "09n":
            return "cloud.drizzle.fill"
        case "10d", "10n":
            return "cloud.rain.fill"
        case "11d", "11n":
            return "cloud.bolt.rain.fill"
        case "13d", "13n":
            return "snow"
        case "50d", "50n":
            return "cloud.fog.fill"
        default:
            return "cloud.fill"
        }
    }
}
