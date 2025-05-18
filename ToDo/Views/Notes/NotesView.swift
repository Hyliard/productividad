//
//  NotesView.swift
//  ToDo
//
//  Created by Luis Martinez on 04/04/2025.
//

import SwiftUI

// MARK: - Modelo
struct Note: Identifiable, Hashable {
    let id = UUID()
    var title: String
    var content: String
    var date = Date()
}

// MARK: - Vista principal
struct NotesView: View {
    @State private var notes: [Note] = []
    @State private var showingAddNote = false

    var body: some View {
        NavigationView {
            ZStack {
                // Fondo general
                Color(red: 0.98, green: 0.96, blue: 0.90)
                    .ignoresSafeArea()

                VStack {
                    if notes.isEmpty {
                        VStack(spacing: 12) {
                            Image(systemName: "note.text")
                                .font(.system(size: 48))
                                .foregroundColor(.gray)
                            Text("Sin notas aún")
                                .font(.title3)
                                .fontWeight(.semibold)
                            Text("Toca el botón '+' para agregar una nueva nota.")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                        .multilineTextAlignment(.center)
                        .padding()
                    } else {
                        List {
                            ForEach(notes) { note in
                                NavigationLink(destination: NoteDetailView(note: note)) {
                                    NoteCardView(note: note)
                                }
                            }
                            .onDelete(perform: deleteNote)
                        }
                        .listStyle(InsetGroupedListStyle())
                        .background(Color.clear)
                    }
                }

                // Título, botón "+", y hoja de agregar nota
                .navigationTitle("Notas")
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button(action: {
                            showingAddNote = true
                        }) {
                            Image(systemName: "plus")
                                .imageScale(.large)
                        }
                    }
                }
                .sheet(isPresented: $showingAddNote) {
                    AddNoteView(notes: $notes)
                }
            }
        }
    }

    func deleteNote(at offsets: IndexSet) {
        notes.remove(atOffsets: offsets)
    }
}

// MARK: - Vista de tarjeta de nota
struct NoteCardView: View {
    let note: Note

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(note.title)
                .font(.headline)
            Text(note.content.prefix(50) + (note.content.count > 50 ? "..." : ""))
                .font(.subheadline)
                .foregroundColor(.secondary)
            Text(note.date.formatted(date: .abbreviated, time: .shortened))
                .font(.caption)
                .foregroundColor(.gray)
        }
        .padding(10)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color(red: 1.0, green: 0.99, blue: 0.95)) // Fondo clarito para tarjetas
                .shadow(color: .gray.opacity(0.2), radius: 4, x: 0, y: 2)
        )
    }
}

// MARK: - Vista para agregar nota
struct AddNoteView: View {
    @Binding var notes: [Note]
    @State private var title = ""
    @State private var content = ""
    @Environment(\.dismiss) var dismiss

    var body: some View {
        NavigationView {
            ZStack {
                // Fondo de AddNoteView
                Color(red: 0.98, green: 0.96, blue: 0.90)
                    .ignoresSafeArea()

                Form {
                    Section(header: Text("Título")) {
                        TextField("Escribe un título", text: $title)
                    }

                    Section(header: Text("Contenido")) {
                        TextEditor(text: $content)
                            .frame(minHeight: 200)
                    }
                }
                .background(Color.clear)
            }
            .navigationTitle("Nueva Nota")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancelar") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Guardar") {
                        let newNote = Note(title: title, content: content)
                        notes.append(newNote)
                        dismiss()
                    }
                    .disabled(title.isEmpty)
                }
            }
        }
    }
}

// MARK: - Vista de detalle de nota
struct NoteDetailView: View {
    var note: Note

    var body: some View {
        ZStack {
            Color(red: 0.98, green: 0.96, blue: 0.90)
                .ignoresSafeArea()

            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    Text(note.title)
                        .font(.title)
                        .bold()
                    Text(note.content)
                        .font(.body)
                    Text(note.date.formatted(date: .long, time: .shortened))
                        .font(.caption)
                        .foregroundColor(.gray)
                }
                .padding()
            }
        }
        .navigationTitle("Detalle de Nota")
        .navigationBarTitleDisplayMode(.inline)
    }
}

// MARK: - Vista previa
struct NotesView_Previews: PreviewProvider {
    static var previews: some View {
        NotesView()
    }
}
