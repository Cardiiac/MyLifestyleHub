//
//  InspiracionItem.swift
//  MyLifestyleHub
//
//  CAPA DE DOMINIO: Entidad para el Módulo de Datos Externos
//

import Foundation

struct InspiracionItem: Identifiable, Hashable {
    let id: Int
    let texto: String
    let autor: String

    init(id: Int, texto: String, autor: String) {
        self.id = id
        self.texto = texto
        self.autor = autor
    }
}
