//
//  MenuzinhoView.swift
//  Satiros
//
//  Created by Ana Margarida Diniz Silva Borges on 02/09/25.
//

import SwiftUI

struct MenuzinhoView: View {
	
	@AppStorage("selectedFont") private var selectedFont: String = "VT323"
	@Bindable var contexto: ContextoConfessionario3.ContextoSalvo
	@Binding var path: [String]
	
    var body: some View {
			HStack(spacing: 150){
				Image("menu")
					.resizable()
					.clipped()
					.frame(width: 40, height: 40)
				
				VStack() {
					Text("Day \(contexto.dia)")
						.foregroundColor(.white)
						.font(.appFont(selectedFont, size: 30))
					Text("Morning")
						.foregroundColor(.white)
						.font(.appFont(selectedFont, size: 30))
				}
				Button (action: {path.append("options")}){
					Image("configuracoes")
						.resizable()
						.clipped()
						.frame(width: 35, height: 35)
				}
				.buttonStyle(.plain)
			}
    }
}

#Preview {
    //MenuzinhoView()
}
