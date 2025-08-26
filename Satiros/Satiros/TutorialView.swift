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
	@State var idFala: Int = 0
	@State var opcoes: [String] = []
	@State var terminou: Bool = true
	@State private var tarefaAtual: Task<Void, Never>? = nil
	
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
				if (idFala < dialogos[contexto.idDialogo ?? 0].texto.count - 1) {
					idFala += 1
					animacaoTexto()
					return .handled
				}
				contexto.idDialogo = dialogos[contexto.idDialogo ?? 0].id_que_opcao_leva[0]
				idFala = 0
				animacaoTexto()
				return .handled
				
			}
			.onAppear {
				estaFocado = true
				animacaoTexto()
				for i in dialogos[contexto.idDialogo ?? 0].opcoes {
					opcoes.append("")
				}
			}
			.onChange(of: idFala) {
				opcoes.removeAll()
				for i in dialogos[contexto.idDialogo ?? 0].opcoes {
					opcoes.append("")
				}
			}
			.frame(maxWidth: .infinity, maxHeight: .infinity)
			.navigationBarBackButtonHidden()
    }
	
	func animacaoTexto() {
		tarefaAtual?.cancel()
		let fala = dialogos[contexto.idDialogo ?? 0].texto[idFala]
		tarefaAtual = Task {
			try? await Task.yield()
			texto = ""
			for c in fala {
				texto.append(c)
				if Task.isCancelled {
					return
				}
				try? await Task.sleep(nanoseconds: 50_000_000)
			}
		}
	}
	
}

#Preview {
    //TutorialView()
}
