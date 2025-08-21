//
//  IntroducaoView.swift
//  Satiros
//
//  Created by Ana Margarida Diniz Silva Borges on 19/08/25.
//

import SwiftUI
import SwiftData

struct IntroducaoView: View {
	
	@Environment(\.modelContext) private var modelContext
	@Query var contexto: [ContextoSalvo]
	
	@State private var path: [ContextoSalvo] = []
	
	func continuarJogo() {
		path.append(contexto[0])
	}
	
	func iniciarJogo() {
		if !(contexto.isEmpty) {
			contexto[0].novoJogo = true
			path.append(contexto[0])
			return
		}
		var novoJogo = ContextoSalvo()
		modelContext.insert(novoJogo)
		do {
			try modelContext.save()
		} catch {
			print("Erro \(error)")
		}
		path.append(novoJogo)
	}
	
    var body: some View {
			NavigationStack (path: $path){
				VStack {
					Text("Forgive me, Father")
						.font(.VT323(size:60))
						.padding()
					if !(contexto.isEmpty) {
						Button(action: {continuarJogo()}) {
							Text("Continue")
								.font(.VT323(size:30))
						}
						.padding()
					}
					Button(action: {iniciarJogo()}) {
						Text("New Game")
							.font(.VT323(size:30))
					}
					.padding()
					BotoesTelaInicio(path: $path)
						.padding()
				}
				.navigationDestination(for: ContextoSalvo.self) { jogo in
					if jogo.novoJogo == true {
						ConfirmarNovoJogo(contexto: contexto[0], path: $path)
					}
					else if jogo.local == "tutorial" {
						TutorialView(contexto: contexto[0], path: $path)
					}
					else if jogo.local == "confessionario" {
						ConfessionarioView(contexto: contexto[0], path: $path)
					}
				}
			}
    }
}

#Preview {
    //IntroducaoView()
}
