//
//  MainTabView.swift
//  MyLifestyleHub
//
//  CAPA DE PRESENTACIÓN: Navegación modular con TabView que integra los 4 módulos
//

import SwiftUI

struct MainTabView: View {
    @State private var themeManager = ThemeManager()
    @State private var pestanaSeleccionada: Int = 0

    var body: some View {
        TabView(selection: $pestanaSeleccionada) {
            // MÓDULO 1: Actividades (CRUD + SwiftData + MVVM)
            ActividadesListView(colorTema: themeManager.colorTema)
                .tabItem {
                    Label("Actividades", systemImage: "checklist")
                }
                .tag(0)

            // MÓDULO 2: Multimedia (Audio, Video AVKit, PhotosPicker)
            MultimediaView(colorTema: themeManager.colorTema)
                .tabItem {
                    Label("Multimedia", systemImage: "play.rectangle.on.rectangle.fill")
                }
                .tag(1)

            // MÓDULO 4: Datos Externos (JSON Remoto + LazyVGrid)
            DatosExternosView(colorTema: themeManager.colorTema)
                .tabItem {
                    Label("Inspiración", systemImage: "globe.americas.fill")
                }
                .tag(2)

            // MÓDULO 3: Personalización (ColorPicker + DatePicker)
            PersonalizacionView(themeManager: themeManager)
                .tabItem {
                    Label("Tema", systemImage: "paintpalette.fill")
                }
                .tag(3)
        }
        // Aplica el color del tema seleccionado a todos los tabs y acentos globales
        .tint(themeManager.colorTema)
    }
}
