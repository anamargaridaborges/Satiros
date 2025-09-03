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
	@Bindable var contexto: ContextoConfessionario3.ContextoSalvo
	@Binding var path: [String]
	@FocusState private var estaFocado: Bool
	@State var texto: String = ""
	//@State var idFala: Int = 0
	@State var opcoes: [String] = []
	@State var terminou: Bool = true
	@State private var tarefaOpcoes: Task<Void, Never>? = nil
	@Bindable var bloco: ContextoConfessionario3.Bloco
	
    var body: some View {
			VStack {
				Text(dialogos[contexto.idDialogo].personagem + ":")
					.font(.appFont(selectedFont, size:60))
				Text(texto)
					.font(.appFont(selectedFont, size:40))
				if (contexto.parteDialogo == dialogos[contexto.idDialogo].texto.count - 1 && dialogos[contexto.idDialogo].opcoes.count > 0) {
					// se é a última parte da fala
					ForEach(opcoes.indices, id: \.self) { index in
						if (opcoes[index] != ""){
							Button (action: {proximaFala(index: index); reiniciarOpcoes();
										terminou = true}) {
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
				if (contexto.parteDialogo < dialogos[contexto.idDialogo].texto.count - 1) {
					contexto.parteDialogo += 1
					reiniciarOpcoes()
					return .handled
				}
				if (terminou == false && !dialogos[contexto.idDialogo].opcoes.isEmpty) {
					carregaFalaToda()
					return .handled
				}
				proximaFala()
				reiniciarOpcoes()
				return .handled
				
			}
			.onAppear {
				estaFocado = true
				reiniciarOpcoes()
			}
			.onChange (of: contexto.idDialogo) {
				if (dialogos[contexto.idDialogo].resumo_notas != "") {
					if (bloco.textoPorDia.count < contexto.dia) {
						bloco.textoPorDia.append(dialogos[contexto.idDialogo].resumo_notas)
					}
					else {
						bloco.textoPorDia[contexto.dia - 1] += "\n"
						bloco.textoPorDia[contexto.dia - 1] += dialogos[contexto.idDialogo].resumo_notas
					}
				}
				if (contexto.idDialogo == 15) {
					contexto.horario = "confissao1"
					contexto.local = "confessionario"
					contexto.parteDialogo = 0
					path.append("confessionario")
				}
			}
			.frame(maxWidth: .infinity, maxHeight: .infinity)
			.navigationBarBackButtonHidden()
    }
	
	func reiniciarOpcoes() {
		opcoes.removeAll()
		for i in dialogos[contexto.idDialogo].opcoes {
			opcoes.append("")
		}
		animacaoOpcoes()
		return
	}
	
	func carregaFalaToda() {
		tarefaOpcoes?.cancel()
		Task {
			try? await Task.yield()
			texto = ""
			texto += dialogos[contexto.idDialogo].texto[contexto.parteDialogo]
			var cont: Int = 0
			for opc in dialogos[contexto.idDialogo].opcoes {
				opcoes[cont] = ""
				opcoes[cont] += String(cont+1)
				opcoes[cont] += ". "
				opcoes[cont] += opc
				cont += 1
			}
		}
		return
	}
	
	func proximaFala(index: Int = 0) {
		contexto.idDialogo = dialogos[contexto.idDialogo].id_que_opcao_leva[index]
		contexto.parteDialogo = 0
		return
	}
	
	func animacaoOpcoes() {
		// imprime a fala e as opcoes com animação
		//tarefaAtual?.cancel()
		tarefaOpcoes?.cancel()
		let opc = dialogos[contexto.idDialogo].opcoes
		let fala = dialogos[contexto.idDialogo].texto[contexto.parteDialogo]
		var cont: Int = 1
		tarefaOpcoes = Task {
			terminou = false
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
				opcoes[cont-1].append(".")
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
				cont += 1
			}
		}
	}
	
}

#Preview {
    //TutorialView()
}
