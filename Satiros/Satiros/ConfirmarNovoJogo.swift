//
//  ConfirmarNovoJogo.swift
//  Satiros
//
//  Created by Ana Margarida Diniz Silva Borges on 20/08/25.
//

import SwiftUI
import SwiftData

struct ConfirmarNovoJogo: View {
	@AppStorage("selectedFont") private var selectedFont: String = "VT323"
	@Bindable var contexto: ContextoSalvo
	@Binding var path: [String]
	
	var body: some View {
		ZStack{
			Image("fundo pixel")
				.resizable()
				.clipped()
				.aspectRatio(16/10, contentMode: .fit)
			VStack {
				Text("Confirm new game?")
					.foregroundColor(.white)
					.font(.appFont(selectedFont, size:50))
					.padding()
				
				Text("All your progress in the current game will be lost.")
					.foregroundColor(.white)
					.font(.appFont(selectedFont, size:25))
					.padding()
				
				HStack {
					Button(action: {contexto.local = "confessionario"; contexto.idDialogo = retornaID(dia: 1, horario: "confissao1", local: "confessionario"); contexto.dia = 1; contexto.horario = "confissao1"; contexto.popularidade = 5; contexto.desconfianca = 5; path.append("confessionario")}) {
						ZStack {
							Image("botao continue")
								.resizable()
								.scaledToFit()
								.frame(width: 200, height: 100)
							
							Text("Yes, I confirm")
								.font(.appFont(selectedFont, size: 25))
								.foregroundColor(.white)
						}
					}
					.buttonStyle(.plain)
					.padding()
					
					Button(action: {path.removeAll()}) {
						ZStack {
							Image("botao continue")
								.resizable()
								.scaledToFit()
								.frame(width: 200, height: 100)
							
							Text("No, I decline")
								.font(.appFont(selectedFont, size: 25))
								.foregroundColor(.white)
						}
					}
					.buttonStyle(.plain)
					.padding()
					/*VStack {
						Text("Confirm new game?")
							.font(.appFont(selectedFont, size:50))
							.padding()
						Text("All your progress in the current game will be lost.")
							.font(.appFont(selectedFont, size:20))
							.padding()
						HStack {
							Button(action: {contexto.local = "confessionario"; contexto.idDialogo = retornaID(dia: 1, horario: "confissao1", local: "confessionario"); contexto.dia = 1; contexto.horario = "manha"; contexto.popularidade = 5; contexto.desconfianca = 5; path.append("confessionario")}) {
								Text("Yes, I confirm")
									.font(.appFont(selectedFont, size:30))
							}
						}
						.navigationBarBackButtonHidden()
						.frame(maxWidth: .infinity, maxHeight: .infinity)
					}*/
					
				}
			}
		}
		.navigationBarBackButtonHidden()
		.frame(maxWidth: .infinity, maxHeight: .infinity)
	}
}


#Preview {
   // ConfirmarNovoJogo()
}
