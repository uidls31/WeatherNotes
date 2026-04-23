import SwiftUI

struct NoteRowView: View {
    let note: WeatherNote

    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            ZStack {
                RoundedRectangle(cornerRadius: 12, style: .continuous)
                    .fill(
                        LinearGradient(
                            colors: [
                                Color.orange.opacity(0.28),
                                Color.yellow.opacity(0.14)
                            ],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .frame(width: 40, height: 40)

                Image(systemName: note.weatherIcon)
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundStyle(.orange)
            }

            VStack(alignment: .leading, spacing: 6) {
                HStack(alignment: .top) {
                    Text(note.title)
                        .font(.headline)
                        .lineLimit(1)
                    Spacer(minLength: 8)
                    Text(note.temperature)
                        .font(.caption.weight(.semibold))
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .background(Color.blue.opacity(0.14))
                        .foregroundStyle(.blue)
                        .clipShape(Capsule())
                }

                Text(note.text)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                    .lineLimit(2)

                HStack(spacing: 8) {
                    Text(note.date.formatted(date: .abbreviated, time: .shortened))
                    Text("•")
                    Text(note.location)
                }
                .font(.caption)
                .foregroundStyle(.secondary)
            }
        }
        .padding(12)
        .background(.ultraThinMaterial)
        .overlay {
            RoundedRectangle(cornerRadius: 16, style: .continuous)
                .stroke(Color.white.opacity(0.22), lineWidth: 1)
        }
        .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
        .shadow(color: .black.opacity(0.08), radius: 10, x: 0, y: 4)
    }
}
