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
	
    var body: some View {
			Text("Introdução")
				.onAppear {
					if (contexto.isEmpty) {
						var novoJogo = ContextoSalvo(local: "introducao")
						modelContext.insert(novoJogo)
					}
				}
			Button ("Próximo") {
				if !contexto.isEmpty {
					var contextoAtual = contexto[0]
					contextoAtual.local = "confessionario"
				}
			}
    }
}

#Preview {
    //IntroducaoView()
}
