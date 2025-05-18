//
//  ToDoListView.swift
//  ToDo
//
//  Created by Luis Martinez on 04/04/2025.
//

import SwiftUI

struct ToDoListView: View {
    @State private var tasks: [String] = []
    @State private var newTask = ""
    
    var body: some View {
        ZStack {
            // Fondo degradado
            LinearGradient(gradient: Gradient(colors: [Color(red: 0.1, green: 0.5, blue: 0.3),
                Color(red: 0.1, green: 0.3, blue: 0.4)]),
                        startPoint: .top, endPoint: .bottom)
                        .ignoresSafeArea()
            VStack(spacing: 30) {
            HStack {
                TextField("Nueva tarea", text: $newTask)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                Button(action: addTask) {
                    Image(systemName: "plus.circle.fill")
                        .font(.title)
                }
            }
            .padding()
            
            List {
                ForEach(tasks, id: \.self) { task in
                    Text(task)
                }
                .onDelete(perform: deleteTask)
            }
        }
        .navigationTitle("Lista de Tareas")
    }
        
    }
    
    func addTask() {
        guard !newTask.isEmpty else { return }
        tasks.append(newTask)
        newTask = ""
    }
    
    func deleteTask(at offsets: IndexSet) {
        tasks.remove(atOffsets: offsets)
    }
}

struct ToDoListView_Previews: PreviewProvider {
    static var previews: some View {
        ToDoListView()
    }
}
