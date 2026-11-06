//
//  ActividadFormSheet.swift
//  MyLifestyleHub
//
//  MÓDULO 1 Y 3: Formulario con DatePicker para programar actividades
//

import SwiftUI

struct ActividadFormSheet: View {
    @Environment(\.dismiss) private var dismiss
    @Bindable var viewModel: ActividadesViewModel
    var colorTema: Color

    var esEdicion: Bool {
        viewModel.actividadAEditar != nil
    }

    var body: some View {
        NavigationStack {
            Form {
                Section("Detalles de la Actividad") {
                    TextField("Título de la actividad *", text: $viewModel.tituloForm)
                    TextField("Descripción o notas", text: $viewModel.descripcionForm, axis: .vertical)
                        .lineLimit(3...5)
                }

                // REQUISITO MÓDULO 3: DatePicker para programar una actividad
                Section("Programación de Fecha") {
                    DatePicker(
                        "Fecha y Hora",
                        selection: $viewModel.fechaForm,
                        displayedComponents: [.date, .hourAndMinute]
                    )
                    .datePickerStyle(.compact)
                }
            }
            .navigationTitle(esEdicion ? "Editar Actividad" : "Nueva Actividad")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancelar") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button(esEdicion ? "Actualizar" : "Guardar") {
                        viewModel.guardarActividad()
                        dismiss()
                    }
                    .bold()
                    .disabled(!viewModel.esFormularioValido)
                    .tint(colorTema)
                }
            }
        }
    }
}
