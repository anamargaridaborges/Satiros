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
	@State private var fadeIn = false
	@State private var fadeOut = false
	
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
						contexto.local = "mapa"
						withAnimation { fadeOut = true }
						DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
								path.append("mapa")
						}
						return .handled
					}
					.onAppear() {
						withAnimation { fadeIn = true }
						estaFocado = FocusKey.enter
					}
					
					// Popup com texto dentro
					ZStack(alignment: .topLeading) {
							Image("popupdeusporfavor")
									.frame(width: 700, height: 315)
									.clipped()
							
							VStack(alignment: .leading, spacing: 10) {
								Text("Now that you listened to today's confessions, you may explore the church and the village during the afternoon.")
									.font(.appFont(selectedFont, size: 30))
									.foregroundStyle(.white)
									.padding()
							}
							.padding(60)
							.frame(width: 680, alignment: .leading)
					}
			}
			.opacity(fadeIn ? 1 : 0)
			.animation(.easeIn(duration: 1), value: fadeIn)
			.opacity(fadeOut ? 0 : 1)
			.animation(.easeOut(duration: 2), value: fadeOut)
			.navigationBarBackButtonHidden()
			.frame(maxWidth: .infinity, maxHeight: .infinity)
			.onAppear {
				withAnimation { fadeIn = true }
			}
	}

}

//#Preview {
//    PopUpView()
//}
