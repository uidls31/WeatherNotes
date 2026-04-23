import SwiftUI

struct NoteDetailView: View {
    @Environment(\.dismiss) private var dismiss
    @StateObject private var viewModel: NoteDetailViewModel

    init(note: WeatherNote) {
        _viewModel = StateObject(wrappedValue: NoteDetailViewModel(note: note))
    }

    var body: some View {
        ZStack {
            AppGradientBackground(gradient: AppGradients.aurora)

            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    weatherCard

                    VStack(alignment: .leading, spacing: 10) {
                        Text("Title")
                            .font(.headline)
                            .foregroundStyle(.secondary)

                        Text(viewModel.note.title)
                            .font(.title3.weight(.semibold))

                        Divider()

                        Text("Note")
                            .font(.headline)
                            .foregroundStyle(.secondary)

                        Text(viewModel.note.text)
                            .font(.body)
                            .fixedSize(horizontal: false, vertical: true)
                    }
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(.ultraThinMaterial)
                    .overlay {
                        RoundedRectangle(cornerRadius: 16, style: .continuous)
                            .stroke(Color.white.opacity(0.2), lineWidth: 1)
                    }
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                }
                .padding()
            }
        }
        .navigationTitle("Note Details")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    viewModel.deleteNote()
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
                Text(viewModel.note.temperature)
                    .font(.system(size: 42, weight: .bold, design: .rounded))

                Spacer()

                Image(systemName: viewModel.note.weatherIcon)
                    .font(.system(size: 44))
                    .foregroundStyle(.orange)
            }

            Text(viewModel.note.weatherCondition)
                .font(.title3.weight(.semibold))

            HStack {
                Label(viewModel.note.location, systemImage: "mappin.and.ellipse")
                Spacer()
                Text(viewModel.note.date.formatted(date: .abbreviated, time: .shortened))
            }
            .font(.subheadline)
            .foregroundStyle(.secondary)
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(
            AppGradients.sunset
                .opacity(0.35)
                .overlay(.thinMaterial)
        )
        .overlay {
            RoundedRectangle(cornerRadius: 18, style: .continuous)
                .stroke(Color.white.opacity(0.22), lineWidth: 1)
        }
        .clipShape(RoundedRectangle(cornerRadius: 18))
        .shadow(color: .black.opacity(0.15), radius: 14, x: 0, y: 8)
    }
}
