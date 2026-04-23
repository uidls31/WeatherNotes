import SwiftUI

struct NotesListView: View {
    @StateObject private var viewModel = NotesViewModel()
    @State private var isShowingAddNote = false

    var body: some View {
        NavigationStack {
            List(viewModel.notes) { note in
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
                        isShowingAddNote = true
                    } label: {
                        Image(systemName: "plus")
                    }
                    .accessibilityLabel("Add Note")
                }
            }
            .sheet(isPresented: $isShowingAddNote) {
                AddNoteView(viewModel: viewModel)
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
