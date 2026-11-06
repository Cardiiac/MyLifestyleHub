//
//  InspiracionRemoteDataSource.swift
//  MyLifestyleHub
//
//  CAPA DE DATOS: Cliente de Red HTTP con URLSession y Codable
//

import Foundation

final class InspiracionRemoteDataSource {
    private let url = URL(string: "https://dummyjson.com/quotes?limit=24")!

    func descargarInspiraciones() async throws -> [InspiracionItem] {
        let (data, response) = try await URLSession.shared.data(from: url)

        guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
            throw URLError(.badServerResponse)
        }

        let dto = try JSONDecoder().decode(QuotesResponseDTO.self, from: data)
        return dto.quotes.map { $0.toDomain() }
    }
}
