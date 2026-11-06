//
//  MultimediaViewModel.swift
//  MyLifestyleHub
//
//  CAPA DE PRESENTACIÓN: ViewModel para el Módulo 2 (Audio, Video, PhotosPicker)
//

import Foundation
import SwiftUI
import AVKit
import AVFoundation
import PhotosUI
import Observation

@Observable
final class MultimediaViewModel {
    // MARK: - Estado de Reproducción de Audio
    var reproduciendoAudio: Bool = false
    var pistaActual: String = "Sonidos de Relajación y Meditación"
    private var reproductorAudio: AVPlayer?

    // MARK: - Estado de Reproducción de Video
    let videoURL = URL(string: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4")!
    var reproductorVideo: AVPlayer?

    // MARK: - Estado de FotosPicker
    var itemFotoSeleccionada: PhotosPickerItem? = nil {
        didSet {
            Task {
                await procesarFoto()
            }
        }
    }
    var imagenDataSeleccionada: Data? = nil

    init() {
        // Inicializa el reproductor de video
        self.reproductorVideo = AVPlayer(url: videoURL)

        // Inicializa audio relajante en streaming
        if let audioURL = URL(string: "https://actions.google.com/sounds/v1/nature/rain_heavy.ogg") {
            self.reproductorAudio = AVPlayer(url: audioURL)
        }
    }

    // MARK: - Control de Audio
    func alternarAudio() {
        if reproduciendoAudio {
            reproductorAudio?.pause()
            reproduciendoAudio = false
        } else {
            // Si el reproductor no está listo, intentamos reproducir
            if reproductorAudio == nil, let audioURL = URL(string: "https://actions.google.com/sounds/v1/nature/rain_heavy.ogg") {
                reproductorAudio = AVPlayer(url: audioURL)
            }
            reproductorAudio?.play()
            reproduciendoAudio = true
        }
    }

    func detenerAudio() {
        reproductorAudio?.pause()
        reproduciendoAudio = false
    }

    // MARK: - Control de Video
    func alternarVideo() {
        guard let reproductor = reproductorVideo else { return }
        if reproductor.timeControlStatus == .playing {
            reproductor.pause()
        } else {
            reproductor.play()
        }
    }

    // MARK: - Procesamiento de Imagen desde PhotosPicker
    @MainActor
    private func procesarFoto() async {
        guard let item = itemFotoSeleccionada else { return }
        do {
            if let data = try await item.loadTransferable(type: Data.self) {
                self.imagenDataSeleccionada = data
            }
        } catch {
            print("Error al cargar imagen: \(error.localizedDescription)")
        }
    }

    func eliminarFoto() {
        self.imagenDataSeleccionada = nil
        self.itemFotoSeleccionada = nil
    }
}
