//
//  DatosExternosView.swift
//  MyLifestyleHub
//
//  MÓDULO 4: Consumo de JSON Remoto mostrado mediante LazyVGrid Adaptativo
//

import SwiftUI

struct DatosExternosView: View {
    @State private var viewModel = DatosExternosViewModel()
    var colorTema: Color

    // REQUISITO MÓDULO 4: Cuadrícula adaptativa con LazyVGrid
    private let columnas = [
        GridItem(.adaptive(minimum: 155), spacing: 14)
    ]

    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                switch viewModel.estado {
                case .cargando:
                    VStack(spacing: 14) {
                        ProgressView()
                            .scaleEffect(1.2)
                        Text("Descargando inspiración y consejos...")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)

                case .error(let mensaje):
                    ContentUnavailableView {
                        Label("Error de Descarga", systemImage: "wifi.slash")
                    } description: {
                        Text(mensaje)
                    } actions: {
                        Button("Reintentar") {
                            Task {
                                await viewModel.cargarDatos()
                            }
                        }
                        .buttonStyle(.borderedProminent)
                        .tint(colorTema)
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)

                case .exitoso:
                    ScrollView {
                        LazyVGrid(columns: columnas, spacing: 14) {
                            ForEach(viewModel.itemsFiltrados) { item in
                                VStack(alignment: .leading, spacing: 10) {
                                    Image(systemName: "quote.opening")
                                        .font(.title3)
                                        .foregroundStyle(colorTema)

                                    Text("\"\(item.texto)\"")
                                        .font(.caption)
                                        .italic()
                                        .lineLimit(5)
                                        .foregroundStyle(.primary)

                                    Spacer(minLength: 4)

                                    HStack {
                                        Spacer()
                                        Text("— \(item.autor)")
                                            .font(.caption2.bold())
                                            .foregroundStyle(.secondary)
                                            .lineLimit(1)
                                    }
                                }
                                .padding()
                                .frame(height: 180)
                                .background(
                                    RoundedRectangle(cornerRadius: 14)
                                        .fill(Color(uiColor: .secondarySystemGroupedBackground))
                                        .shadow(color: Color.black.opacity(0.06), radius: 4, x: 0, y: 2)
                                )
                                .overlay(
                                    RoundedRectangle(cornerRadius: 14)
                                        .stroke(colorTema.opacity(0.2), lineWidth: 1)
                                )
                            }
                        }
                        .padding(.horizontal, 16)
                        .padding(.vertical, 12)
                    }
                }
            }
            .navigationTitle("Inspiración")
            .searchable(text: $viewModel.textoBusqueda, prompt: "Buscar por cita o autor...")
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button {
                        Task {
                            await viewModel.cargarDatos()
                        }
                    } label: {
                        Image(systemName: "arrow.clockwise")
                            .foregroundStyle(colorTema)
                    }
                }
            }
            .task {
                await viewModel.cargarDatos()
            }
            .refreshable {
                await viewModel.cargarDatos()
            }
        }
    }
}
