import Foundation

enum WeatherError: Error, LocalizedError {
    case invalidURL
    case networkError(Error)
    case invalidResponse
    case decodingError(Error)

    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "The weather request URL is invalid."
        case .networkError(let error):
            return "Network request failed: \(error.localizedDescription)"
        case .invalidResponse:
            return "Received an invalid server response."
        case .decodingError(let error):
            return "Failed to decode weather response: \(error.localizedDescription)"
        }
    }
}
