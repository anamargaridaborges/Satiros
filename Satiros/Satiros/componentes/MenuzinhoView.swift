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
	@Binding var path: [String]
	@State var passaNoAsset: [Bool] = [false, false] //[notas, sair]
	@FocusState var estaFocado: FocusKey?
	@Binding var clicaBloco: Bool
	@State var mostrarBalao:  Bool = false
	
    var body: some View {
			HStack(spacing: 150){
				Button (action: {clicaBloco = true}) {
					Image("notas")
						.resizable()
						.clipped()
						.frame(width: 50, height: 50)
						.scaleEffect(passaNoAsset[0] ? 1.1 : 1.0)
						.onHover {over in
							passaNoAsset[0] = over
							mostrarBalao = over
						}
						.overlay(alignment: .leading) {
							if mostrarBalao {
								ZStack {
									Image("balaoAtributos")
											.resizable()
											.frame(width: 400, height: 100)
									Text("The notebook shows important findings. Check out what you have discovered so far!")
										.font(.appFont(selectedFont, size: 20))
											.foregroundColor(.black)
											.padding()
								}
								.offset(x: -430, y: 20)
								
								.transition(.opacity)
							}
						}
				}
				.buttonStyle(.plain)
				
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
// 					Button("toalha") {
// 							salvarImagemEscolhida("mural0")
// 					}
// 					Button("pixel") {
// 							salvarImagemEscolhida("mural1")
// 					}
					
				}
				
				Button (action: {path.removeAll()}){
					Image("sair")
						.resizable()
						.clipped()
						.frame(width: 45, height: 45)
						.scaleEffect(passaNoAsset[1] ? 1.1 : 1.0)
						.onHover {over in
							passaNoAsset[1] = over
						}
				}
				.buttonStyle(.plain)
				.focusable()
				.focusEffectDisabled()
				.focused($estaFocado, equals: FocusKey.escape)
				.onKeyPress(.escape) {
					path.removeAll()
					return .handled
				}
				.onChange(of: estaFocado) {
					estaFocado = FocusKey.escape
				}

			}
    }
	private func salvarImagemEscolhida(_ nome: String) {
		let defaults = UserDefaults(suiteName: "group.satiros.Satiros.MuralWidget")
		defaults?.set(nome, forKey: "widgetImage")
		
		WidgetCenter.shared.reloadTimelines(ofKind: "MuralWidget")
	}
}

#Preview {
    //MenuzinhoView()
}
