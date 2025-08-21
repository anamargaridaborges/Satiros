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
	
	@State private var path: [String] = []
	
	func continuarJogo() {
		path.append(contexto[0].local ?? "tutorial")
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
				VStack {
					Text("Forgive me, Father")
						.font(.appFont(size:60))
						.padding()
					if !(contexto.isEmpty) {
						Button(action: {continuarJogo()}) {
							Text("Continue")
								.font(.appFont(size:30))
						}
						.padding()
					}
					Button(action: {iniciarJogo()}) {
						Text("New Game")
							.font(.appFont(size:30))
					}
					.padding()
					BotoesTelaInicio(path: $path)
						.padding()
				}
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
				}
			}
    }
}

#Preview {
    //IntroducaoView()
}
