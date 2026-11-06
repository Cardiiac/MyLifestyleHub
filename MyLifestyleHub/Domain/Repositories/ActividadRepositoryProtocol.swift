//
//  ActividadRepositoryProtocol.swift
//  MyLifestyleHub
//
//  CAPA DE DOMINIO: Contrato de Repositorio para Actividades
//

import Foundation

protocol ActividadRepositoryProtocol {
    func obtenerActividades() throws -> [Actividad]
    func guardarActividad(_ actividad: Actividad) throws
    func eliminarActividad(id: UUID) throws
    func alternarEstado(id: UUID) throws
}
