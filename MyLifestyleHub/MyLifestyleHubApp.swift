//
//  MyLifestyleHubApp.swift
//  MyLifestyleHub
//
//  Created for Evaluación Continua PA3 - Pregunta 6 (Proyecto Integrador)
//

import SwiftUI
import SwiftData

@main
struct MyLifestyleHubApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: ActividadEntity.self)
    }
}
