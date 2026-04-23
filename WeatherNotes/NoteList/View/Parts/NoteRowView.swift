import SwiftUI

struct NoteRowView: View {
    let note: WeatherNote

    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            Image(systemName: note.weatherIcon)
                .font(.title3)
                .foregroundStyle(.orange)
                .frame(width: 30)

            VStack(alignment: .leading, spacing: 6) {
                Text(note.title)
                    .font(.headline)
                    .lineLimit(1)

                Text(note.text)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                    .lineLimit(2)

                HStack(spacing: 8) {
                    Text(note.date.formatted(date: .abbreviated, time: .shortened))
                    Text("•")
                    Text(note.temperature)
                }
                .font(.caption)
                .foregroundStyle(.secondary)
            }
        }
        .padding(.vertical, 2)
    }
}
