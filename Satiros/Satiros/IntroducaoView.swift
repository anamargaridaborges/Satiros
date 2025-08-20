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
	
	@State private var path: [Int] = []
	
	func continuarJogo() {
		path.append(1)
	}
	
	func iniciarJogo() {
		if !(contexto.isEmpty) {
			path.append(2)
			return
		}
		var novoJogo = ContextoSalvo()
		modelContext.insert(novoJogo)
		path.append(0)
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
				}
				.navigationDestination(for: Int.self) { value in
					if value == 2 {
						ConfirmarNovoJogo(path: $path)
					}
					else if value == 1 {
						ConfessionarioView(contexto: contexto[0], path: $path)
					}
				}
			}
    }
}

#Preview {
    //IntroducaoView()
}
