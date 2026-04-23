import SwiftUI

struct AddNoteView: View {
    @Environment(\.dismiss) private var dismiss
    @ObservedObject var viewModel: NotesViewModel
    @State private var noteTitle = ""
    @State private var noteText = ""
    @FocusState private var isEditorFocused: Bool

    var body: some View {
        NavigationStack {
            ZStack {
                Color(uiColor: .systemGroupedBackground)
                    .ignoresSafeArea()

                VStack {
                    TextField("Title", text: $noteTitle)
                        .textFieldStyle(.plain)
                        .font(.headline)
                        .padding(.horizontal, 14)
                        .padding(.vertical, 12)
                        .background(Color(uiColor: .secondarySystemGroupedBackground))
                        .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                        .padding(.horizontal)
                        .padding(.top)

                    ZStack(alignment: .topLeading) {
                        if noteText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                            Text("What's on your mind?")
                                .foregroundStyle(.secondary)
                                .padding(.horizontal, 14)
                                .padding(.vertical, 16)
                        }

                        TextEditor(text: $noteText)
                            .focused($isEditorFocused)
                            .scrollContentBackground(.hidden)
                            .padding(.horizontal, 10)
                            .padding(.vertical, 8)
                    }
                    .frame(maxWidth: .infinity)
                    .frame(minHeight: 220, maxHeight: 320)
                    .background(Color(uiColor: .secondarySystemGroupedBackground))
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
                        viewModel.addNote(title: noteTitle, text: noteText)
                        dismiss()
                    }
                    .fontWeight(.bold)
                    .disabled(
                        noteTitle.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ||
                        noteText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
                    )
                }
            }
            .onAppear {
                isEditorFocused = true
            }
        }
    }
}

#Preview {
    AddNoteView(viewModel: NotesViewModel())
}
