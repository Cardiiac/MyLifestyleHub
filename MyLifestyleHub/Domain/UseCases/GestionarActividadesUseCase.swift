//
//  GestionarActividadesUseCase.swift
//  MyLifestyleHub
//
//  CAPA DE DOMINIO: Caso de Uso que encapsula la lógica de negocio de Actividades
//

import Foundation

final class GestionarActividadesUseCase {
    private let repositorio: ActividadRepositoryProtocol

    init(repositorio: ActividadRepositoryProtocol) {
        self.repositorio = repositorio
    }

    func ejecutarObtener() throws -> [Actividad] {
        try repositorio.obtenerActividades()
    }

    func ejecutarCrear(titulo: String, descripcion: String, fecha: Date) throws {
        let actividad = Actividad(
            titulo: titulo.trimmingCharacters(in: .whitespacesAndNewlines),
            descripcion: descripcion.trimmingCharacters(in: .whitespacesAndNewlines),
            fecha: fecha,
            esCompletada: false
        )
        try repositorio.guardarActividad(actividad)
    }

    func ejecutarActualizar(_ actividad: Actividad) throws {
        try repositorio.guardarActividad(actividad)
    }

    func ejecutarEliminar(id: UUID) throws {
        try repositorio.eliminarActividad(id: id)
    }

    func ejecutarToggle(id: UUID) throws {
        try repositorio.alternarEstado(id: id)
    }
}
