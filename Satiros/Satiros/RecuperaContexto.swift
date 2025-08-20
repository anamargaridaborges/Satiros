//
//  RecuperaContexto.swift
//  Satiros
//
//  Created by Ana Margarida Diniz Silva Borges on 20/08/25.
//

import SwiftUI
import SwiftData

struct RecuperaContexto: View {
	
	@Environment(\.modelContext) private var modelContext
	@Query var contexto: [ContextoSalvo]
	
    var body: some View {
        
			if contexto.isEmpty {
				IntroducaoView()
			}
			
			else {
				var contextoAtual = contexto[0]
				if contextoAtual.local == "confessionario" {
					ConfessionarioView(contexto: contextoAtual)
				}
				else {
					IntroducaoView()
				}
			}
			
    }
}

#Preview {
    RecuperaContexto()
}
