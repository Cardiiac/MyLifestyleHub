//
//  ActividadRepositoryImpl.swift
//  MyLifestyleHub
//
//  CAPA DE DATOS: Implementación del Repositorio de Actividades con SwiftData
//

import Foundation
import SwiftData

final class ActividadRepositoryImpl: ActividadRepositoryProtocol {
    private let context: ModelContext

    init(context: ModelContext) {
        self.context = context
    }

    func obtenerActividades() throws -> [Actividad] {
        let descriptor = FetchDescriptor<ActividadEntity>(sortBy: [SortDescriptor(\.fecha, order: .forward)])
        let entities = try context.fetch(descriptor)
        return entities.map { $0.toDomain() }
    }

    func guardarActividad(_ actividad: Actividad) throws {
        let id = actividad.id
        let predicate = #Predicate<ActividadEntity> { $0.id == id }
        var descriptor = FetchDescriptor<ActividadEntity>(predicate: predicate)
        descriptor.fetchLimit = 1

        let existentes = try context.fetch(descriptor)
        if let existente = existentes.first {
            existente.update(from: actividad)
        } else {
            let nueva = ActividadEntity(
                id: actividad.id,
                titulo: actividad.titulo,
                descripcion: actividad.descripcion,
                fecha: actividad.fecha,
                esCompletada: actividad.esCompletada
            )
            context.insert(nueva)
        }
        try context.save()
    }

    func eliminarActividad(id: UUID) throws {
        let predicate = #Predicate<ActividadEntity> { $0.id == id }
        var descriptor = FetchDescriptor<ActividadEntity>(predicate: predicate)
        descriptor.fetchLimit = 1

        if let encontrada = try context.fetch(descriptor).first {
            context.delete(encontrada)
            try context.save()
        }
    }

    func alternarEstado(id: UUID) throws {
        let predicate = #Predicate<ActividadEntity> { $0.id == id }
        var descriptor = FetchDescriptor<ActividadEntity>(predicate: predicate)
        descriptor.fetchLimit = 1

        if let encontrada = try context.fetch(descriptor).first {
            encontrada.esCompletada.toggle()
            try context.save()
        }
    }
}
