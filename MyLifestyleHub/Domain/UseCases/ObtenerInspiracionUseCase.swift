//
//  ObtenerInspiracionUseCase.swift
//  MyLifestyleHub
//
//  CAPA DE DOMINIO: Caso de Uso para consultar información externa
//

import Foundation

final class ObtenerInspiracionUseCase {
    private let repositorio: InspiracionRepositoryProtocol

    init(repositorio: InspiracionRepositoryProtocol) {
        self.repositorio = repositorio
    }

    func ejecutar() async throws -> [InspiracionItem] {
        try await repositorio.obtenerInspiraciones()
    }
}
