import SwiftUI

struct NoteDetailView: View {
    @Environment(\.dismiss) private var dismiss
    let note: WeatherNote
    @ObservedObject var viewModel: NotesViewModel

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                weatherCard

                VStack(alignment: .leading, spacing: 10) {
                    Text("Title")
                        .font(.headline)
                        .foregroundStyle(.secondary)

                    Text(note.title)
                        .font(.title3.weight(.semibold))

                    Divider()

                    Text("Note")
                        .font(.headline)
                        .foregroundStyle(.secondary)

                    Text(note.text)
                        .font(.body)
                        .fixedSize(horizontal: false, vertical: true)
                }
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(Color(uiColor: .secondarySystemBackground))
                .clipShape(RoundedRectangle(cornerRadius: 16))
            }
            .padding()
        }
        .navigationTitle("Note Details")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    viewModel.deleteNote(note)
                    dismiss()
                } label: {
                    Image(systemName: "trash")
                }
                .tint(.red)
                .accessibilityLabel("Delete Note")
            }
        }
    }

    private var weatherCard: some View {
        VStack(alignment: .leading, spacing: 14) {
            HStack(alignment: .firstTextBaseline) {
                Text(note.temperature)
                    .font(.system(size: 42, weight: .bold, design: .rounded))

                Spacer()

                Image(systemName: note.weatherIcon)
                    .font(.system(size: 44))
                    .foregroundStyle(.orange)
            }

            Text(note.weatherCondition)
                .font(.title3.weight(.semibold))

            HStack {
                Label(note.location, systemImage: "mappin.and.ellipse")
                Spacer()
                Text(note.date.formatted(date: .abbreviated, time: .shortened))
            }
            .font(.subheadline)
            .foregroundStyle(.secondary)
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(
            LinearGradient(
                colors: [
                    Color(uiColor: .secondarySystemBackground),
                    Color(uiColor: .tertiarySystemBackground)
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        )
        .clipShape(RoundedRectangle(cornerRadius: 18))
    }
}
