//
//  MultimediaView.swift
//  MyLifestyleHub
//
//  MÓDULO 2: Multimedia (Reproducción de Audio, Video con AVKit y PhotosPicker)
//

import SwiftUI
import AVKit
import PhotosUI

struct MultimediaView: View {
    @State private var viewModel = MultimediaViewModel()
    var colorTema: Color

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 24) {

                    // SECCIÓN 1: REPRODUCCIÓN DE AUDIO
                    VStack(alignment: .leading, spacing: 12) {
                        Label("Reproductor de Audio Relajante", systemImage: "headphones")
                            .font(.headline)
                            .foregroundStyle(colorTema)

                        HStack(spacing: 16) {
                            Button {
                                viewModel.alternarAudio()
                            } label: {
                                ZStack {
                                    Circle()
                                        .fill(colorTema)
                                        .frame(width: 54, height: 54)
                                    Image(systemName: viewModel.reproduciendoAudio ? "pause.fill" : "play.fill")
                                        .font(.title2)
                                        .foregroundStyle(.white)
                                }
                            }

                            VStack(alignment: .leading, spacing: 4) {
                                Text(viewModel.pistaActual)
                                    .font(.subheadline.bold())
                                    .lineLimit(1)

                                Text(viewModel.reproduciendoAudio ? "▶️ Reproduciendo audio en segundo plano..." : "⏸️ Pausado")
                                    .font(.caption)
                                    .foregroundStyle(viewModel.reproduciendoAudio ? .green : .secondary)
                            }

                            Spacer()
                        }
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 14)
                                .fill(Color(uiColor: .secondarySystemGroupedBackground))
                        )
                    }

                    // SECCIÓN 2: REPRODUCCIÓN DE VIDEO CON AVKIT
                    VStack(alignment: .leading, spacing: 12) {
                        Label("Reproductor de Video (AVKit)", systemImage: "video.fill")
                            .font(.headline)
                            .foregroundStyle(colorTema)

                        if let player = viewModel.reproductorVideo {
                            VideoPlayer(player: player)
                                .frame(height: 220)
                                .clipShape(RoundedRectangle(cornerRadius: 14))
                                .overlay(
                                    RoundedRectangle(cornerRadius: 14)
                                        .stroke(colorTema.opacity(0.3), lineWidth: 1.5)
                                )
                        }

                        Text("Video demostrativo de streaming en alta definición compatible con controles nativos de reproducción.")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    }

                    // SECCIÓN 3: SELECCIÓN DE IMAGEN CON PHOTOS PICKER
                    VStack(alignment: .leading, spacing: 12) {
                        Label("Galería Personal (PhotosPicker)", systemImage: "photo.badge.plus")
                            .font(.headline)
                            .foregroundStyle(colorTema)

                        if let data = viewModel.imagenDataSeleccionada, let uiImage = UIImage(data: data) {
                            ZStack(alignment: .topTrailing) {
                                Image(uiImage: uiImage)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(maxWidth: .infinity)
                                    .frame(height: 200)
                                    .clipped()
                                    .clipShape(RoundedRectangle(cornerRadius: 14))

                                Button {
                                    viewModel.eliminarFoto()
                                } label: {
                                    Image(systemName: "xmark.circle.fill")
                                        .font(.title2)
                                        .foregroundStyle(.white, .red)
                                        .padding(8)
                                }
                            }
                        } else {
                            ZStack {
                                RoundedRectangle(cornerRadius: 14)
                                    .fill(colorTema.opacity(0.08))
                                    .frame(height: 120)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 14)
                                            .strokeBorder(style: StrokeStyle(lineWidth: 1.5, dash: [6]))
                                            .foregroundStyle(colorTema.opacity(0.5))
                                    )

                                VStack(spacing: 6) {
                                    Image(systemName: "photo.on.rectangle.angled")
                                        .font(.largeTitle)
                                        .foregroundStyle(colorTema)
                                    Text("Ninguna imagen seleccionada")
                                        .font(.caption)
                                        .foregroundStyle(.secondary)
                                }
                            }
                        }

                        PhotosPicker(
                            selection: $viewModel.itemFotoSeleccionada,
                            matching: .images,
                            photoLibrary: .shared()
                        ) {
                            Label(
                                viewModel.imagenDataSeleccionada == nil ? "Elegir Foto desde la Biblioteca" : "Cambiar Foto",
                                systemImage: "photo.badge.plus"
                            )
                            .font(.subheadline.bold())
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 11)
                            .background(colorTema.opacity(0.15))
                            .foregroundStyle(colorTema)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                        }
                    }

                }
                .padding()
            }
            .navigationTitle("Multimedia")
        }
    }
}
