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
	@State var passaNoAsset: [Bool] = [false, false] //[notas, sair]
	@FocusState var estaFocado: FocusKey?
	
    var body: some View {
			HStack(spacing: 150){
				Image("notas")
					.resizable()
					.clipped()
					.frame(width: 50, height: 50)
					.scaleEffect(passaNoAsset[0] ? 1.1 : 1.0)
					.onHover {over in
						passaNoAsset[0] = over
					}
				
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
//				.onAppear{
//					estaFocado = FocusKey.escape
//				print("esta focado on appear " )
//				}
			}
    }
}

#Preview {
    //MenuzinhoView()
}
