//
//  popUpMapa.swift
//  Satiros
//
//  Created by Jordana Lourenço Santos on 08/09/25.
//

import SwiftUI

struct PopUpMapa: View {
	@AppStorage("selectedFont") private var selectedFont: String = "VT323"
	@Bindable var contexto: ContextoConfessionario3.ContextoSalvo
	@Binding var path: [String]
	@Environment(\.modelContext) private var modelContext
	@Bindable var bloco: ContextoConfessionario3.Bloco
	@FocusState var estaFocado: FocusKey?
	
	var body: some View {
			ZStack {
				
					// Fundo clicável
					Button(action: { path.append("tutorial") }) {
						Image("fundo pixel")
							.resizable()
							.clipped()
							.aspectRatio(16/10, contentMode: .fit)
					}
					.buttonStyle(.plain)
					.focusable()
					.focusEffectDisabled()
					.focused($estaFocado, equals: FocusKey.enter)
					.onKeyPress(.return) {
						path.append("mapa")
						return .handled
					}
					.onAppear() {
						estaFocado = FocusKey.enter
					}
					
					// Popup com texto dentro
					ZStack(alignment: .topLeading) {
							Image("popupdeusporfavor")
									.frame(width: 700, height: 315)
									.clipped()
							
							VStack(alignment: .leading, spacing: 10) {
								Text("tool tip mapa")
									.font(.appFont(selectedFont, size: 30))
									.foregroundStyle(.white)
							}
							.padding(30)
							.frame(width: 680, alignment: .leading)
					}
			}
			.navigationBarBackButtonHidden()
			.frame(maxWidth: .infinity, maxHeight: .infinity)
	}

}

//#Preview {
//    PopUpView()
//}
