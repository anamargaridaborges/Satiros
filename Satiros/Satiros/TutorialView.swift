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
	
    var body: some View {
			VStack {
				Text(dialogos[contexto.idDialogo ?? 0].personagem)
					.font(.appFont(selectedFont, size:60))
				Text(dialogos[contexto.idDialogo ?? 0].texto[0])
					.font(.appFont(selectedFont, size:40))
			}
			.padding()
			.focusable()
			.focusEffectDisabled()
			.focused($estaFocado)
			.onKeyPress(.return) {
				contexto.idDialogo = dialogos[contexto.idDialogo ?? 0].id_que_opcao_leva[0]
				return .handled
			}
			.onAppear {
				estaFocado = true
			}
			.frame(maxWidth: .infinity, maxHeight: .infinity)
			.navigationBarBackButtonHidden()
    }
}

#Preview {
    //TutorialView()
}
