import SwiftUI

struct NotesListView: View {
    @StateObject private var viewModel = NotesViewModel()
    @State private var isShowingAddNote = false
    
    var body: some View {
        NavigationStack {
            Group {
                if viewModel.notes.isEmpty {
                    VStack(spacing: 14) {
                        Image(systemName: "note.text.badge.plus")
                            .font(.system(size: 54))
                            .symbolRenderingMode(.multicolor)
                        
                        Text("No Weather Notes Yet")
                            .font(.title3.weight(.semibold))
                        
                        Text("Tap the '+' button to record your first note with local weather.")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 28)
                    }
                } else {
                    List(viewModel.notes) { note in
                        NavigationLink {
                            NoteDetailView(note: note, viewModel: viewModel)
                        } label: {
                            NoteRowView(note: note)
                        }
                        .listRowInsets(EdgeInsets(top: 10, leading: 16, bottom: 10, trailing: 16))
                    }
                    .listStyle(.plain)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
            .navigationTitle("Weather Notes")
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
            .alert("Error", isPresented: $viewModel.showError) {
                Button("OK", role: .cancel) {}
            } message: {
                Text(viewModel.errorMessage)
            }
        }
    }
}

#Preview {
    NotesListView()
}
