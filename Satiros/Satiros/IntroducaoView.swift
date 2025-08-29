//
//  IntroducaoView.swift
//  Satiros
//
//  Created by Ana Margarida Diniz Silva Borges on 19/08/25.
//

import SwiftUI
import SwiftData

struct IntroducaoView: View {
	@AppStorage("selectedFont") private var selectedFont: String = "VT323"
	@Environment(\.modelContext) private var modelContext
	@Query var contexto: [ContextoSalvo]
	
	@State private var path: [String] = []
	
	func continuarJogo() {
		path.append(contexto[0].local ?? "confessionario")
	}
	
	func iniciarJogo() {
		if !(contexto.isEmpty) {
			path.append("novoJogo")
			return
		}
		var novoJogo = ContextoSalvo()
		modelContext.insert(novoJogo)
		do {
			try modelContext.save()
		} catch {
			print("Erro \(error)")
		}
		path.append("tutorial")
	}
	
    var body: some View {
			NavigationStack (path: $path){
				ZStack{
					Image("menu inicial")
							.resizable()
							.clipped()
							.aspectRatio(16/10, contentMode: .fit)
					
					VStack {
						Spacer()
							if !(contexto.isEmpty) {
								Button(action: { continuarJogo() }) {
									ZStack {
										Image("botao continue")
												.resizable()
												.scaledToFit()
												.frame(width: 200, height: 60)
										Text("Continue")
											.font(.appFont(selectedFont, size: 25))
												.foregroundColor(.white)
									}
								}
								.buttonStyle(.plain)
								.padding()
							}

							Button(action: { iniciarJogo() }) {
								ZStack {
									Image("botao new game")
											.resizable()
											.scaledToFit()
											.frame(width: 150, height: 40)
									
									Text("New Game")
										.font(.appFont(selectedFont, size: 20))
											.foregroundColor(.white)
								}
							}
							.buttonStyle(.plain)
							.padding(.bottom, 80)
						
							BotoesTelaInicio(path: $path)
								.padding()
					}
					.padding(.bottom, 30)
					.navigationDestination(for: String.self) { local in
						if local == "novoJogo" {
							ConfirmarNovoJogo(contexto: contexto[0], path: $path)
						}
						else if local == "tutorial" {
							TutorialView(contexto: contexto[0], path: $path)
						}
						else if local == "confessionario" {
							ConfessionarioView(contexto: contexto[0], path: $path)
						}
						else if local == "confirmarSair" {
							ConfirmarSair(path: $path)
						}
						else if local == "options" {
							OptionsView(path: $path)
						}
						else if local == "cartas" {
							CartasView(contexto: contexto[0], path: $path)
						}
						else if local == "menu" {
							IntroducaoView()
						}
					}
					
				}
				
			}
	}
}

#Preview {
    //IntroducaoView()
}
