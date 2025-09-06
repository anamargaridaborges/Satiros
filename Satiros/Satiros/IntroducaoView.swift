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
	@Query var contexto: [ContextoConfessionario3.ContextoSalvo]
	@Query var bloco: [ContextoConfessionario3.Bloco]
	@State private var path: [String] = []
	@FocusState private var estaFocado: FocusKey?
	@State var clicaNotas: Bool = false
	
	func continuarJogo() {
		path.append(contexto[0].local)
	}
	
	func iniciarJogo() {
		let count1 = try? modelContext.fetchCount(FetchDescriptor<ContextoConfessionario3.ContextoSalvo>())
		let count2 = try? modelContext.fetchCount(FetchDescriptor<ContextoConfessionario3.ContextoConfessionario>())
		let count3 = try? modelContext.fetchCount(FetchDescriptor<ContextoConfessionario3.Bloco>())
		//print(count1, count2, count3)
		if !(count1 == 0 || count2 == 0 || count3 == 0) {
			path.append("novoJogo")
			return
		}
		for c in contexto {
			modelContext.delete(c)
		}
		for b in bloco {
			modelContext.delete(b)
		}
		var novoJogo = ContextoConfessionario3.ContextoSalvo()
		modelContext.insert(novoJogo)
		var bloco = ContextoConfessionario3.Bloco()
		modelContext.insert(bloco)
		do {
			try modelContext.save()
		} catch {
			print("Erro \(error)")
		}
		path.append("popUp")
	}
	
    var body: some View {
			NavigationStack (path: $path) {
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
							ConfirmarNovoJogo(contexto: contexto[0], path: $path, bloco: bloco[0])
						}
						else if local == "tutorial" {
							TutorialView(contexto: contexto[0], path: $path, bloco: bloco[0])
						}
						else if local == "confessionario" {
							ConfessionarioView(contexto: contexto[0], path: $path, estaFocado: _estaFocado, bloco: bloco[0], clicaNotas: $clicaNotas)
						}
						else if local == "confirmarSair" {
							ConfirmarSair(path: $path)
						}
						else if local == "options" {
							OptionsView(path: $path)
						}
						else if local == "cartas" {
							CartasView(contexto: contexto[0], path: $path, clicaBloco: $clicaNotas, bloco: bloco[0])
						}
						else if local == "menu" {
							IntroducaoView()
						}
						else if local == "popUp" {
							PopUpView(contexto: contexto[0], path: $path, bloco: bloco[0], estaFocado: _estaFocado)
						}
						else if local == "mapa" {
							MapaView(contexto: contexto[0], path: $path, bloco: bloco[0])
						}
						
						/*else if local == "notas" {
							BlocoView(path: $path, bloco: bloco[0])
						}*/
					}
					
				}
				
			}
	}
}

#Preview {
    //IntroducaoView()
}
