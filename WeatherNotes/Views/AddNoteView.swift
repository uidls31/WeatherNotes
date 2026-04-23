import SwiftUI

struct AddNoteView: View {
    @Environment(\.dismiss) private var dismiss
    @StateObject private var viewModel = AddNoteViewModel()
    let onSave: () -> Void
    @FocusState private var isEditorFocused: Bool

    var body: some View {
        NavigationStack {
            ZStack {
                AppGradientBackground(gradient: AppGradients.aurora)

                VStack {
                    TextField("Title", text: $viewModel.noteTitle)
                        .textFieldStyle(.plain)
                        .font(.headline)
                        .padding(.horizontal, 14)
                        .padding(.vertical, 12)
                        .background(.ultraThinMaterial)
                        .overlay {
                            RoundedRectangle(cornerRadius: 12, style: .continuous)
                                .stroke(Color.white.opacity(0.22), lineWidth: 1)
                        }
                        .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                        .padding(.horizontal)
                        .padding(.top)

                    ZStack(alignment: .topLeading) {
                        if viewModel.noteText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                            Text("What's on your mind?")
                                .foregroundStyle(.secondary)
                                .padding(.horizontal, 14)
                                .padding(.vertical, 16)
                        }

                        TextEditor(text: $viewModel.noteText)
                            .focused($isEditorFocused)
                            .scrollContentBackground(.hidden)
                            .padding(.horizontal, 10)
                            .padding(.vertical, 8)
                    }
                    .frame(maxWidth: .infinity)
                    .frame(minHeight: 220, maxHeight: 320)
                    .background(.ultraThinMaterial)
                    .overlay {
                        RoundedRectangle(cornerRadius: 12, style: .continuous)
                            .stroke(Color.white.opacity(0.22), lineWidth: 1)
                    }
                    .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                    .padding()

                    Spacer()
                }
            }
            .navigationTitle("New Note")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }

                ToolbarItem(placement: .topBarTrailing) {
                    Button("Save") {
                        Task {
                            let isSuccess = await viewModel.saveNote()
                            if isSuccess {
                                onSave()
                                dismiss()
                            }
                        }
                    }
                    .fontWeight(.bold)
                    .disabled(!viewModel.canSave)
                }
            }
            .onAppear {
                isEditorFocused = true
            }
            .alert("Error", isPresented: $viewModel.showError) {
                Button("OK", role: .cancel) {}
            } message: {
                Text(viewModel.errorMessage)
            }
        }
    }
}
