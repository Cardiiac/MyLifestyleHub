//
//  ActividadesViewModel.swift
//  MyLifestyleHub
//
//  CAPA DE PRESENTACIÓN: ViewModel MVVM para el Módulo de Actividades
//

import Foundation
import SwiftUI
import Observation

@Observable
final class ActividadesViewModel {
    var actividades: [Actividad] = []
    var textoBusqueda: String = ""
    var filtroEstado: String = "Todas"

    // Formulario (Creación y Edición)
    var mostrarFormulario: Bool = false
    var actividadAEditar: Actividad? = nil
    var tituloForm: String = ""
    var descripcionForm: String = ""
    var fechaForm: Date = Date()

    private var useCase: GestionarActividadesUseCase?

    func configurar(useCase: GestionarActividadesUseCase) {
        self.useCase = useCase
        cargarActividades()
    }

    var actividadesFiltradas: [Actividad] {
        var resultado = actividades

        if filtroEstado == "Pendientes" {
            resultado = resultado.filter { !$0.esCompletada }
        } else if filtroEstado == "Completadas" {
            resultado = resultado.filter { $0.esCompletada }
        }

        let query = textoBusqueda.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
        if !query.isEmpty {
            resultado = resultado.filter {
                $0.titulo.lowercased().contains(query) ||
                $0.descripcion.lowercased().contains(query)
            }
        }

        return resultado.sorted { $0.fecha < $1.fecha }
    }

    var esFormularioValido: Bool {
        !tituloForm.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }

    func cargarActividades() {
        guard let useCase else { return }
        do {
            self.actividades = try useCase.ejecutarObtener()
        } catch {
            print("Error al cargar actividades: \(error)")
        }
    }

    func prepararNueva() {
        self.actividadAEditar = nil
        self.tituloForm = ""
        self.descripcionForm = ""
        self.fechaForm = Date()
        self.mostrarFormulario = true
    }

    func prepararEdicion(de actividad: Actividad) {
        self.actividadAEditar = actividad
        self.tituloForm = actividad.titulo
        self.descripcionForm = actividad.descripcion
        self.fechaForm = actividad.fecha
        self.mostrarFormulario = true
    }

    func guardarActividad() {
        guard let useCase, esFormularioValido else { return }
        do {
            if var existente = actividadAEditar {
                existente.titulo = tituloForm.trimmingCharacters(in: .whitespacesAndNewlines)
                existente.descripcion = descripcionForm.trimmingCharacters(in: .whitespacesAndNewlines)
                existente.fecha = fechaForm
                try useCase.ejecutarActualizar(existente)
            } else {
                try useCase.ejecutarCrear(
                    titulo: tituloForm,
                    descripcion: descripcionForm,
                    fecha: fechaForm
                )
            }
            cargarActividades()
            self.mostrarFormulario = false
        } catch {
            print("Error al guardar: \(error)")
        }
    }

    func eliminar(actividad: Actividad) {
        guard let useCase else { return }
        do {
            try useCase.ejecutarEliminar(id: actividad.id)
            cargarActividades()
        } catch {
            print("Error al eliminar: \(error)")
        }
    }

    func alternarCompletada(actividad: Actividad) {
        guard let useCase else { return }
        do {
            try useCase.ejecutarToggle(id: actividad.id)
            cargarActividades()
        } catch {
            print("Error al alternar estado: \(error)")
        }
    }
}
