//
//  InspiracionRepositoryProtocol.swift
//  MyLifestyleHub
//
//  CAPA DE DOMINIO: Contrato para datos externos
//

import Foundation

protocol InspiracionRepositoryProtocol {
    func obtenerInspiraciones() async throws -> [InspiracionItem]
}
