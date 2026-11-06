//
//  ActividadRowView.swift
//  MyLifestyleHub
//
//  MÓDULO 1: Celda visual de Actividad con acción de marcar completada
//

import SwiftUI

struct ActividadRowView: View {
    let actividad: Actividad
    var colorTema: Color
    var onToggle: () -> Void

    var body: some View {
        HStack(spacing: 14) {
            // Botón interactivo de completada
            Button(action: onToggle) {
                Image(systemName: actividad.esCompletada ? "checkmark.circle.fill" : "circle")
                    .font(.title2)
                    .foregroundStyle(actividad.esCompletada ? colorTema : .secondary)
            }
            .buttonStyle(.plain)

            VStack(alignment: .leading, spacing: 4) {
                Text(actividad.titulo)
                    .font(.headline)
                    .strikethrough(actividad.esCompletada, color: .secondary)
                    .foregroundStyle(actividad.esCompletada ? .secondary : .primary)

                if !actividad.descripcion.isEmpty {
                    Text(actividad.descripcion)
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                        .lineLimit(1)
                }

                HStack(spacing: 4) {
                    Image(systemName: "calendar")
                        .font(.caption2)
                    Text(actividad.fechaFormateada)
                        .font(.caption)
                }
                .foregroundStyle(colorTema)
                .bold()
            }

            Spacer()
        }
        .padding(.vertical, 4)
    }
}
