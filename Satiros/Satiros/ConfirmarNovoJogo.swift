//
//  ConfirmarNovoJogo.swift
//  Satiros
//
//  Created by Ana Margarida Diniz Silva Borges on 20/08/25.
//

import SwiftUI
import SwiftData

struct ConfirmarNovoJogo: View {
	
	@Bindable var contexto: ContextoSalvo
	@Binding var path: [String]
	
    var body: some View {
			VStack {
				Text("Confirm new game?")
					.font(.VT323(size:50))
					.padding()
				Text("All your progress in the current game will be lost.")
					.font(.VT323(size:20))
					.padding()
				HStack {
					Button(action: {contexto.local = "tutorial"; contexto.idDialogo = 0; contexto.dia = 1; contexto.horario = "manha"; contexto.popularidade = 5; contexto.desconfianca = 5; path.append("tutorial")}) {
						Text("Yes, I confirm")
							.font(.VT323(size:30))
					}
					.padding()
					Button(action: {path.removeAll()}) {
						Text("No, I decline")
							.font(.VT323(size:30))
					}
					.padding()
				}
			}
			.navigationBarBackButtonHidden()
			.frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview {
   // ConfirmarNovoJogo()
}
