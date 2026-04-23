import SwiftUI

struct NotesListView: View {
    @State private var notes: [WeatherNote] = WeatherNote.mockData

    var body: some View {
        NavigationStack {
            List(notes) { note in
                NavigationLink {
                    NoteDetailView(note: note)
                } label: {
                    NoteRowView(note: note)
                }
                .listRowInsets(EdgeInsets(top: 10, leading: 16, bottom: 10, trailing: 16))
            }
            .listStyle(.plain)
            .navigationTitle("WeatherNotes")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        print("Add note tapped")
                    } label: {
                        Image(systemName: "plus")
                    }
                    .accessibilityLabel("Add Note")
                }
            }
        }
    }
}

private struct NoteRowView: View {
    let note: WeatherNote

    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            Image(systemName: note.weatherIcon)
                .font(.title3)
                .foregroundStyle(.orange)
                .frame(width: 30)

            VStack(alignment: .leading, spacing: 6) {
                Text(note.text)
                    .font(.body)
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

#Preview {
    NotesListView()
}
