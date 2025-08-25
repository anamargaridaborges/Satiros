//
//  TutorialView.swift
//  Satiros
//
//  Created by Ana Margarida Diniz Silva Borges on 21/08/25.
//

import SwiftUI
import SwiftData

struct TutorialView: View {
	@AppStorage("selectedFont") private var selectedFont: String = "VT323"
	@Bindable var contexto: ContextoSalvo
	@Binding var path: [String]
	@FocusState private var estaFocado: Bool
	@State var texto: String = ""
	
    var body: some View {
			VStack {
				Text(dialogos[contexto.idDialogo ?? 0].personagem + ":")
					.font(.appFont(selectedFont, size:60))
				Text(texto)
					.font(.appFont(selectedFont, size:40))
			}
			.padding()
			.focusable()
			.focusEffectDisabled()
			.focused($estaFocado)
			.onKeyPress(.return) {
				contexto.idDialogo = dialogos[contexto.idDialogo ?? 0].id_que_opcao_leva[0]
				animacaoTexto()
				return .handled
			}
			.onAppear {
				estaFocado = true
				animacaoTexto()
			}
			.frame(maxWidth: .infinity, maxHeight: .infinity)
			.navigationBarBackButtonHidden()
    }
	
	func animacaoTexto(posicao: Int = 0) {
		if posicao == 0 {
			texto = ""
		}
		let fala = dialogos[contexto.idDialogo ?? 0].texto[0]
		Task {
			for c in fala {
				texto.append(c)
				try? await Task.sleep(nanoseconds: 50_000_000)
			}
		}
	}
	
}

#Preview {
    //TutorialView()
}
