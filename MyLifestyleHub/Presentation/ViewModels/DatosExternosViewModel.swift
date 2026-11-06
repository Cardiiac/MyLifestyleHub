//
//  DatosExternosViewModel.swift
//  MyLifestyleHub
//
//  CAPA DE PRESENTACIÓN: ViewModel para el Módulo 4 (Consumo JSON Remoto)
//

import Foundation
import Observation

enum EstadoDatosExternos: Equatable {
    case cargando
    case exitoso([InspiracionItem])
    case error(mensaje: String)
}

@Observable
final class DatosExternosViewModel {
    var estado: EstadoDatosExternos = .cargando
    var textoBusqueda: String = ""

    private let useCase: ObtenerInspiracionUseCase

    init(useCase: ObtenerInspiracionUseCase = ObtenerInspiracionUseCase(repositorio: InspiracionRepositoryImpl())) {
        self.useCase = useCase
    }

    var itemsFiltrados: [InspiracionItem] {
        guard case .exitoso(let items) = estado else { return [] }
        let query = textoBusqueda.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
        if query.isEmpty {
            return items
        }
        return items.filter {
            $0.texto.lowercased().contains(query) ||
            $0.autor.lowercased().contains(query)
        }
    }

    @MainActor
    func cargarDatos() async {
        self.estado = .cargando
        do {
            let resultado = try await useCase.ejecutar()
            self.estado = .exitoso(resultado)
        } catch {
            self.estado = .error(mensaje: "No se pudieron descargar los datos remotos. Verifica tu conexión a internet.")
        }
    }
}
