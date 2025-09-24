//
//  MenuzinhoView.swift
//  Satiros
//
//  Created by Ana Margarida Diniz Silva Borges on 02/09/25.
//

import SwiftUI
import WidgetKit

struct MenuzinhoView: View {
	
	@AppStorage("selectedFont") private var selectedFont: String = "VT323"
	@Bindable var contexto: ContextoConfessionario3.ContextoSalvo
	@Binding var path: [Caminhos]
	@Binding var clicaBloco: Bool
	
    var body: some View {
			HStack(spacing: 130){
				BotaoNotas(contexto: contexto, path: $path, clicaBloco: $clicaBloco)
				
				VStack() {
					Text("Day \(contexto.dia)")
						.foregroundColor(.white)
						.font(.appFont(selectedFont, size: 35))
						//.padding(.vertical, 5)
					
					if(contexto.horario == "confissao1"){
						Text("9:00")
							.foregroundColor(.white)
							.font(.appFont(selectedFont, size: 35))
					}else if (contexto.horario == "confissao2"){
						Text("10:00")
							.foregroundColor(.white)
							.font(.appFont(selectedFont, size: 35))
					}
				}
				
				BotaoSair(contexto: contexto, path: $path)

			}
    }
}

#Preview {
    //MenuzinhoView()
}
