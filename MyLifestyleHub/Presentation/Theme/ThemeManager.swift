//
//  ThemeManager.swift
//  MyLifestyleHub
//
//  CAPA DE PRESENTACIÓN: Gestor de Personalización Visual (ColorPicker)
//

import SwiftUI
import Observation

@Observable
final class ThemeManager {
    // Color de acento de la app modificado con ColorPicker
    var colorTema: Color = Color.indigo

    // Paleta de colores predefinidos
    let coloresRapidos: [Color] = [
        .indigo, .blue, .purple, .pink, .red, .orange, .teal, .green
    ]
}
