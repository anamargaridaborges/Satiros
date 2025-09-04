//
//  BlocoView.swift
//  Satiros
//
//  Created by Ana Margarida Diniz Silva Borges on 03/09/25.
//

import SwiftUI

struct BlocoView: View {
	
	@Binding var path: [String]
	@Bindable var bloco: ContextoConfessionario3.Bloco
	@AppStorage("selectedFont") private var selectedFont: String = "VT323"
	@Binding var clicaNotas: Bool
	
    var body: some View {
			GeometryReader { geo in
				ZStack {
					Image("Fundo preto")
						.opacity(0.5)
					
					ZStack {
						Image("BlocoGRANDAO")
							.position(x: geo.size.width * 1 / 2, y: geo.size.height * 1 / 2)
							Text("Dia 1")
								.foregroundColor(.black)
								.font(.appFont(selectedFont, size: 60))
								.position(x: geo.size.width * 1 / 2, y: geo.size.height * 2 / 7)
							Text(bloco.textoPorDia.isEmpty ? "" : bloco.textoPorDia[0])
								.foregroundColor(.black)
								.font(.appFont(selectedFont, size: 30))
								.position(x: geo.size.width * 1 / 2, y: geo.size.height * 1 / 2)
					}
					.frame(maxWidth: .infinity, maxHeight: .infinity)
					//.position(x: geo.size.width * 1 / 2, y: geo.size.height * 1 / 2)
					
					HStack {
						Button(action: {clicaNotas = false}) {
							Image("botaoFechar 1")
						}
						.buttonStyle(.plain)
					}
					.position(x: geo.size.width * 1 / 7, y: geo.size.height * 1.2 / 7)
					
				}
			}
			.frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview {
    //BlocoView()
}
