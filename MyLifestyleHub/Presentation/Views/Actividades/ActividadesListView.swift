//
//  ActividadesListView.swift
//  MyLifestyleHub
//
//  MÓDULO 1: CRUD Completo con Persistencia Local (SwiftData) y MVVM
//

import SwiftUI
import SwiftData

struct ActividadesListView: View {
    @Environment(\.modelContext) private var modelContext
    @State private var viewModel = ActividadesViewModel()
    var colorTema: Color

    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                // Selector de Filtro de Estado
                Picker("Filtro", selection: $viewModel.filtroEstado) {
                    Text("Todas").tag("Todas")
                    Text("Pendientes").tag("Pendientes")
                    Text("Completadas").tag("Completadas")
                }
                .pickerStyle(.segmented)
                .padding(.horizontal)
                .padding(.vertical, 8)

                if viewModel.actividadesFiltradas.isEmpty {
                    ContentUnavailableView {
                        Label(
                            viewModel.actividades.isEmpty ? "Sin actividades" : "Sin resultados",
                            systemImage: viewModel.actividades.isEmpty ? "checklist" : "magnifyingglass"
                        )
                    } description: {
                        Text(
                            viewModel.actividades.isEmpty
                            ? "Presiona el botón '+' para registrar tu primera actividad personal."
                            : "No se encontraron coincidencias para tu búsqueda."
                        )
                    } actions: {
                        if viewModel.actividades.isEmpty {
                            Button("Insertar Actividad de Prueba") {
                                viewModel.tituloForm = "Sesión de Yoga y Meditación"
                                viewModel.descripcionForm = "30 minutos de respiración y estiramiento en el jardín."
                                viewModel.fechaForm = Date().addingTimeInterval(3600 * 4)
                                viewModel.guardarActividad()
                            }
                            .buttonStyle(.borderedProminent)
                            .tint(colorTema)
                        }
                    }
                    .frame(maxHeight: .infinity)
                } else {
                    List {
                        ForEach(viewModel.actividadesFiltradas) { actividad in
                            ActividadRowView(actividad: actividad, colorTema: colorTema) {
                                viewModel.alternarCompletada(actividad: actividad)
                            }
                            .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                                Button(role: .destructive) {
                                    viewModel.eliminar(actividad: actividad)
                                } label: {
                                    Label("Eliminar", systemImage: "trash")
                                }
                            }
                            .swipeActions(edge: .leading) {
                                Button {
                                    viewModel.prepararEdicion(de: actividad)
                                } label: {
                                    Label("Editar", systemImage: "pencil")
                                }
                                .tint(.orange)
                            }
                        }
                    }
                    .listStyle(.insetGrouped)
                }
            }
            .navigationTitle("Actividades")
            .searchable(text: $viewModel.textoBusqueda, prompt: "Buscar actividad...")
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button {
                        viewModel.prepararNueva()
                    } label: {
                        Image(systemName: "plus.circle.fill")
                            .font(.title3)
                            .foregroundStyle(colorTema)
                    }
                }
            }
            .sheet(isPresented: $viewModel.mostrarFormulario) {
                ActividadFormSheet(viewModel: viewModel, colorTema: colorTema)
            }
            .onAppear {
                let repo = ActividadRepositoryImpl(context: modelContext)
                let useCase = GestionarActividadesUseCase(repositorio: repo)
                viewModel.configurar(useCase: useCase)
            }
        }
    }
}
