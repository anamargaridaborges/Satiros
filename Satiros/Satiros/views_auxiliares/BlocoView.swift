//
//  BlocoView.swift
//  Satiros
//
//  Created by Ana Margarida Diniz Silva Borges on 03/09/25.
//

import SwiftUI

struct BlocoView: View {
	
	@Binding var path: [Caminhos]
	@Bindable var bloco: ContextoConfessionario3.Bloco
	@AppStorage("selectedFont") private var selectedFont: String = "VT323"
	@Binding var clicaNotas: Bool
	
    var body: some View {
				ZStack {
					Image("Fundo preto")
						.opacity(0.5)
					
					ZStack {
						Image("BlocoGRANDAO")
							.position(x: 960, y: 600)
							Text("Day 1")
								.foregroundColor(.black)
								.font(.appFont(selectedFont, size: 60))
								.position(x: 960, y: 400)
						Text(bloco.textoPorDia.isEmpty ? "" : bloco.textoPorDia.joined())
								.foregroundColor(.black)
								.font(.appFont(selectedFont, size: 30))
								.position(x: 960, y: 600)
					}
					.frame(maxWidth: .infinity, maxHeight: .infinity)
					//.position(x: geo.size.width * 1 / 2, y: geo.size.height * 1 / 2)
					
					HStack {
						Button(action: {clicaNotas = false}) {
							Image("botaoFechar 1")
						}
						.buttonStyle(.plain)
					}
					.position(x: 329, y: 206)
					
				}
				.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
    }
}

#Preview {
    //BlocoView()
}
