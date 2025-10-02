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
	@State private var path: [Caminhos] = []
	@FocusState private var estaFocado: FocusKey?
	@State var clicaNotas: Bool = false
	
	func continuarJogo() {
		path.append(contexto[0].local)
	}
	
	func iniciarJogo() {
		let count1 = try? modelContext.fetchCount(FetchDescriptor<ContextoConfessionario3.ContextoSalvo>())
		//let count2 = try? modelContext.fetchCount(FetchDescriptor<ContextoConfessionario3.ContextoConfessionario>())
		let count3 = try? modelContext.fetchCount(FetchDescriptor<ContextoConfessionario3.Bloco>())
		//print(count1, count2, count3)
		if !(count1 == 0 ||  count3 == 0) {
			path.append(.novoJogo)
			return
		}
		for c in contexto {
			modelContext.delete(c)
		}
		for b in bloco {
			modelContext.delete(b)
		}
		let novoJogo = ContextoConfessionario3.ContextoSalvo()
		modelContext.insert(novoJogo)
		let bloco = ContextoConfessionario3.Bloco()
		modelContext.insert(bloco)
		do {
			try modelContext.save()
		} catch {
			print("Erro \(error)")
		}
		path.append(.popUpIntro)
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
						if !(contexto.isEmpty) && !(bloco.isEmpty) {
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
					.navigationDestination(for: Caminhos.self) { local in
						local.view(
							contexto: contexto,
							path: $path,
							bloco: bloco,
							_estaFocado: _estaFocado,
							clicaNotas: $clicaNotas
						)
					}
					
				}
				
			}
	}
}

#Preview {
    //IntroducaoView()
}
