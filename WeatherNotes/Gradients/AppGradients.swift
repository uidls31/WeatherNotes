import SwiftUI

enum AppGradients {
    static let aurora = LinearGradient(
        colors: [
            Color(red: 0.36, green: 0.54, blue: 0.98),
            Color(red: 0.53, green: 0.35, blue: 0.94),
            Color(red: 0.86, green: 0.39, blue: 0.86)
        ],
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )

    static let sunset = LinearGradient(
        colors: [
            Color(red: 0.98, green: 0.63, blue: 0.45),
            Color(red: 0.96, green: 0.44, blue: 0.53),
            Color(red: 0.67, green: 0.36, blue: 0.89)
        ],
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )
}

struct AppGradientBackground: View {
    var gradient: LinearGradient = AppGradients.aurora

    var body: some View {
        gradient
            .overlay(Color(uiColor: .systemBackground).opacity(0.42))
            .ignoresSafeArea()
    }
}
