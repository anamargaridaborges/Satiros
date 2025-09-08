//
//  PopUpView.swift
//  Satiros
//
//  Created by Jordana Lourenço Santos on 04/09/25.
//

import SwiftUI

struct PopUpIntro: View {
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
						path.append("tutorial")
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
								Text("Tutorial")
									.font(.custom(selectedFont, size: 30))
									.foregroundColor(.white)
																
								HStack(alignment: .top, spacing: 25) { //linha 1
										Text("To move to the next line, press the return key.")
												.font(.custom(selectedFont, size: 25))
												.multilineTextAlignment(.leading)
												.padding(.top, 15)
												.foregroundColor(.white)
										
										Image("enter")
												.resizable()
												.scaledToFit()
												.frame(width: 120, height: 50)
								}
								HStack(alignment: .top, spacing: 60) { //linha 2
										Text("Popularity shows how much you’re liked and trusted. Don’t let it drop too low!")
												.font(.custom(selectedFont, size: 25))
												.multilineTextAlignment(.leading)
												.padding(.top, 15)
												.foregroundColor(.white)
										
										Image("popularidade10")
												.resizable()
												.scaledToFit()
												.frame(width: 120, height: 50)
								}
								HStack(alignment: .top, spacing: 70) { //linha 3
										Text("Distrust shows how much people doubt you. Don’t let it fill up!")
												.font(.custom(selectedFont, size: 25))
												.multilineTextAlignment(.leading)
												.padding(.top, 15)
												.foregroundColor(.white)
										
										Image("desconfianca10")
												.resizable()
												.scaledToFit()
												.frame(width: 120, height: 50)
								}
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
