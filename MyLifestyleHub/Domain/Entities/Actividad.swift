//
//  Actividad.swift
//  MyLifestyleHub
//
//  CAPA DE DOMINIO: Entidad de Negocio Pura (Agnóstica de SwiftData/UIKit)
//

import Foundation

struct Actividad: Identifiable, Hashable {
    let id: UUID
    var titulo: String
    var descripcion: String
    var fecha: Date
    var esCompletada: Bool

    init(
        id: UUID = UUID(),
        titulo: String,
        descripcion: String,
        fecha: Date = Date(),
        esCompletada: Bool = false
    ) {
        self.id = id
        self.titulo = titulo
        self.descripcion = descripcion
        self.fecha = fecha
        self.esCompletada = esCompletada
    }

    var fechaFormateada: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        formatter.locale = Locale(identifier: "es_PE")
        return formatter.string(from: fecha)
    }
}
