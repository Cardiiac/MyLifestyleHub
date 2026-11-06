//
//  PersonalizacionView.swift
//  MyLifestyleHub
//
//  MÓDULO 3: Personalización con ColorPicker de Tema Visual y DatePicker de Recordatorios
//

import SwiftUI

struct PersonalizacionView: View {
    @Bindable var themeManager: ThemeManager
    @State private var recordatorioHora: Date = Date()
    @State private var nombreRutina: String = "Rutina Matutina de Bienestar"

    var body: some View {
        NavigationStack {
            Form {
                // SECCIÓN 1: COLOR PICKER PARA MODIFICAR EL TEMA VISUAL
                Section("Tema Visual de la Aplicación") {
                    HStack {
                        Label("Color de Acento", systemImage: "paintpalette.fill")
                            .foregroundStyle(themeManager.colorTema)
                        Spacer()
                        // REQUISITO MÓDULO 3: ColorPicker nativo
                        ColorPicker("", selection: $themeManager.colorTema, supportsOpacity: false)
                            .labelsHidden()
                    }

                    // Paleta rápida de muestra
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 12) {
                            ForEach(themeManager.coloresRapidos, id: \.description) { color in
                                Circle()
                                    .fill(color)
                                    .frame(width: 32, height: 32)
                                    .overlay(
                                        Circle()
                                            .stroke(Color.primary.opacity(0.2), lineWidth: 1)
                                    )
                                    .overlay(
                                        Image(systemName: "checkmark")
                                            .font(.caption2.bold())
                                            .foregroundStyle(.white)
                                            .opacity(themeManager.colorTema == color ? 1 : 0)
                                    )
                                    .scaleEffect(themeManager.colorTema == color ? 1.15 : 1.0)
                                    .animation(.spring(response: 0.25), value: themeManager.colorTema)
                                    .onTapGesture {
                                        themeManager.colorTema = color
                                    }
                            }
                        }
                        .padding(.vertical, 4)
                    }
                }

                // SECCIÓN 2: DATE PICKER PARA PROGRAMAR UNA ACTIVIDAD
                Section("Programación de Rutina Diaria") {
                    TextField("Nombre de la rutina", text: $nombreRutina)

                    // REQUISITO MÓDULO 3: DatePicker
                    DatePicker(
                        "Hora de Inicio",
                        selection: $recordatorioHora,
                        displayedComponents: [.hourAndMinute]
                    )
                    .datePickerStyle(.compact)
                }

                // VISTA PREVIA DEL TEMA SELECCIONADO
                Section("Vista Previa del Tema") {
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Este tema personalizado modifica automáticamente los botones, barras de navegación, íconos y acentos en todos los módulos de la aplicación.")
                            .font(.caption)
                            .foregroundStyle(.secondary)

                        HStack {
                            Button("Botón Destacado") {}
                                .buttonStyle(.borderedProminent)
                                .tint(themeManager.colorTema)

                            Button("Botón Secundario") {}
                                .buttonStyle(.bordered)
                                .tint(themeManager.colorTema)
                        }
                    }
                    .padding(.vertical, 4)
                }
            }
            .navigationTitle("Personalización")
        }
    }
}
