//
//  ActividadEntity.swift
//  MyLifestyleHub
//
//  CAPA DE DATOS: Modelo Persistente de SwiftData
//

import Foundation
import SwiftData

@Model
final class ActividadEntity {
    @Attribute(.unique) var id: UUID
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

    // Mapeo a Entidad de Dominio
    func toDomain() -> Actividad {
        Actividad(
            id: id,
            titulo: titulo,
            descripcion: descripcion,
            fecha: fecha,
            esCompletada: esCompletada
        )
    }

    // Actualización desde Entidad de Dominio
    func update(from domain: Actividad) {
        self.titulo = domain.titulo
        self.descripcion = domain.descripcion
        self.fecha = domain.fecha
        self.esCompletada = domain.esCompletada
    }
}
