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
	@State private var tarefaOpcoes: Task<Void, Never>? = nil
	
    var body: some View {
			VStack {
				Text(dialogos[contexto.idDialogo ?? 0].personagem + ":")
					.font(.appFont(selectedFont, size:60))
				Text(texto)
					.font(.appFont(selectedFont, size:40))
				if (idFala == dialogos[contexto.idDialogo ?? 0].texto.count - 1 && dialogos[contexto.idDialogo ?? 0].opcoes.count > 0) {
					// se é a última parte da fala
					ForEach(opcoes.indices, id: \.self) { index in
						if (opcoes[index] != ""){
								Button (action: {contexto.idDialogo = dialogos[contexto.idDialogo ?? 0].id_que_opcao_leva[index]; idFala = 0;
									if (idFala == dialogos[contexto.idDialogo ?? 0].texto.count - 1 && dialogos[contexto.idDialogo ?? 0].opcoes.count > 0) {
										opcoes.removeAll()
										for i in dialogos[contexto.idDialogo ?? 0].opcoes {
											opcoes.append("")
										}
										animacaoOpcoes()
									}
									else {
										animacaoTexto()
									}
								}) {
							Text(opcoes[index])
								.font(.appFont(selectedFont, size:30))
						}
					}
					}
				}
			}
			.padding()
			.focusable()
			.focusEffectDisabled()
			.focused($estaFocado)
			.onKeyPress(.return) {
				if (idFala < dialogos[contexto.idDialogo ?? 0].texto.count - 1) {
					idFala += 1
					if (idFala == dialogos[contexto.idDialogo ?? 0].texto.count - 1 && dialogos[contexto.idDialogo ?? 0].opcoes.count > 0) {
						opcoes.removeAll()
						for i in dialogos[contexto.idDialogo ?? 0].opcoes {
							opcoes.append("")
						}
						animacaoOpcoes()
					}
					else {
						animacaoTexto()
					}
					return .handled
				}
				contexto.idDialogo = dialogos[contexto.idDialogo ?? 0].id_que_opcao_leva[0]
				idFala = 0
				if (idFala == dialogos[contexto.idDialogo ?? 0].texto.count - 1 && dialogos[contexto.idDialogo ?? 0].opcoes.count > 0) {
					opcoes.removeAll()
					for i in dialogos[contexto.idDialogo ?? 0].opcoes {
						opcoes.append("")
					}
					animacaoOpcoes()
				}
				else {
					animacaoTexto()
				}
				return .handled
				
			}
			.onAppear {
				estaFocado = true
				if (idFala == dialogos[contexto.idDialogo ?? 0].texto.count - 1 && dialogos[contexto.idDialogo ?? 0].opcoes.count > 0) {
					opcoes.removeAll()
					for i in dialogos[contexto.idDialogo ?? 0].opcoes {
						opcoes.append("")
					}
					animacaoOpcoes()
				}
				else {
					animacaoTexto()
				}
			}
			.frame(maxWidth: .infinity, maxHeight: .infinity)
			.navigationBarBackButtonHidden()
    }
	
	func animacaoTexto() {
		tarefaAtual?.cancel()
		tarefaOpcoes?.cancel()
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
	
	func animacaoOpcoes() {
		// imprime a fala e as opcoes com animação
		tarefaAtual?.cancel()
		tarefaOpcoes?.cancel()
		let opc = dialogos[contexto.idDialogo ?? 0].opcoes
		let fala = dialogos[contexto.idDialogo ?? 0].texto[idFala]
		var cont: Int = 1
		tarefaOpcoes = Task {
			try? await Task.yield()
			texto = ""
			for c in fala {
				texto.append(c)
				if Task.isCancelled {
					return
				}
				try? await Task.sleep(nanoseconds: 50_000_000)
			}
			try? await Task.sleep(nanoseconds: 50_000_000)
			for opcao in opc {
				opcoes[cont-1].append(String(cont))
				if Task.isCancelled {
					return
				}
				try? await Task.sleep(nanoseconds: 50_000_000)
				opcoes[cont-1].append(":")
				if Task.isCancelled {
					return
				}
				try? await Task.sleep(nanoseconds: 50_000_000)
				opcoes[cont-1].append(" ")
				if Task.isCancelled {
					return
				}
				try? await Task.sleep(nanoseconds: 50_000_000)
				for c in opcao {
					opcoes[cont-1].append(c)
					if Task.isCancelled {
						return
					}
					try? await Task.sleep(nanoseconds: 50_000_000)
				}
				opcoes[cont-1].append("\n")
				if Task.isCancelled {
					return
				}
				cont += 1
			}
		}
	}
	
}

#Preview {
    //TutorialView()
}
