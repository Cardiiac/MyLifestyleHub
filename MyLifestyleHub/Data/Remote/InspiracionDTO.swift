//
//  InspiracionDTO.swift
//  MyLifestyleHub
//
//  CAPA DE DATOS: DTO para decodificar JSON remoto
//

import Foundation

struct QuotesResponseDTO: Codable {
    let quotes: [QuoteItemDTO]
}

struct QuoteItemDTO: Codable {
    let id: Int
    let quote: String
    let author: String

    func toDomain() -> InspiracionItem {
        InspiracionItem(
            id: id,
            texto: quote,
            autor: author
        )
    }
}
