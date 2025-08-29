//
//  BotoesTelaInicio.swift
//  Satiros
//
//  Created by Ana Margarida Diniz Silva Borges on 21/08/25.
//

import SwiftUI
import SwiftData

struct BotoesTelaInicio: View {
	@AppStorage("selectedFont") private var selectedFont: String = "VT323"
	@Binding var path: [String]
	
    var body: some View {
			HStack {
				Button(action: {path.append("options")}) {
					Image("configuracoes")
							.resizable()
							.scaledToFit()
							.frame(width: 50, height: 50)
				}
				.buttonStyle(.plain)
				.padding()
				
				Button(action: {}) {
					Image("conquistas")
							.resizable()
							.scaledToFit()
							.frame(width: 50, height: 50)
				}
				.buttonStyle(.plain)
				.padding()
				
				Button(action: {path.append("confirmarSair")}) {
					Image("sair")
							.resizable()
							.scaledToFit()
							.frame(width: 50, height: 50)
				}
				.buttonStyle(.plain)
				.padding()
			}
    }
}

#Preview {
    //BotoesTelaInicio()
}
