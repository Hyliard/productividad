//
//  CalendarView.swift
//  ToDo
//
//  Created by Luis Martinez on 04/04/2025.
//

import SwiftUI

struct CalendarView: View {
    @State private var selectedDate = Date()
    
    var body: some View {
        ZStack {
            // Fondo degradado
            LinearGradient(gradient: Gradient(colors: [Color(red: 0.1, green: 0.5, blue: 0.3),
                Color(red: 0.1, green: 0.3, blue: 0.4)]),
                        startPoint: .top, endPoint: .bottom)
                        .ignoresSafeArea()
        VStack {
            
            DatePicker(
                "Selecciona una fecha",
                selection: $selectedDate,
                displayedComponents: [.date]
            )
            .datePickerStyle(.graphical)
            .padding()
            
            // Aquí puedes agregar eventos o tareas para la fecha seleccionada
            Text("Eventos para \(selectedDate.formatted(date: .long, time: .omitted))")
                .font(.headline)
            
            // Lista de eventos (puedes implementarla similar a ToDoListView)
        }
        .navigationTitle("Calendario")
        
        
    }
}
}

struct CalendarView_Previews: PreviewProvider {
    static var previews: some View {
        CalendarView()
    }
}
