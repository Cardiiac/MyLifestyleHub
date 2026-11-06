//
//  InspiracionRepositoryImpl.swift
//  MyLifestyleHub
//
//  CAPA DE DATOS: Implementación del Repositorio de Datos Externos
//

import Foundation

final class InspiracionRepositoryImpl: InspiracionRepositoryProtocol {
    private let remoteDataSource: InspiracionRemoteDataSource

    init(remoteDataSource: InspiracionRemoteDataSource = InspiracionRemoteDataSource()) {
        self.remoteDataSource = remoteDataSource
    }

    func obtenerInspiraciones() async throws -> [InspiracionItem] {
        try await remoteDataSource.descargarInspiraciones()
    }
}
