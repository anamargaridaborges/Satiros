//
//  FalaView.swift
//  Satiros
//
//  Created by Jordana Lourenço Santos on 05/09/25.
//

import SwiftUI

struct FalaView: View {
	@AppStorage("selectedFont") private var selectedFont: String = "VT323"
	@Bindable var contexto: ContextoConfessionario3.ContextoSalvo
	@FocusState private var estaFocado: FocusKey?
	@State var texto: String = ""
	//@State var idFala: Int = 0
	@State var opcoes: [String] = []
	@State var terminou: Bool = true
	@State private var tarefaOpcoes: Task<Void, Never>? = nil
	@Bindable var bloco: ContextoConfessionario3.Bloco
	@State var passaNoBotao: [Bool] = [false, false, false]
	
    var body: some View {
			ZStack(alignment: .bottom) {
					Image("blocoFala")
						.frame(width: 1180, height: 310, alignment: .bottom)
						.clipped()
						.padding(.bottom, 50)
					
				VStack(alignment: .leading, spacing: 10) {
						Text(dialogos[contexto.idDialogo].personagem + ":")
							.font(.appFont(selectedFont, size:25))
						Text(texto)
							.font(.appFont(selectedFont, size:25))
						if (contexto.parteDialogo == dialogos[contexto.idDialogo].texto.count - 1 && dialogos[contexto.idDialogo].opcoes.count > 0) {
							// se é a última parte da fala
								ForEach(opcoes.indices, id: \.self) { index in
									if (opcoes[index] != ""){
										Button {
											selecionaOpcao(index: index)
										} label: {
											Text(opcoes[index])
												.foregroundColor(passaNoBotao[index] ? .white : .orange)
												.font(.appFont(selectedFont, size: 25))
												.scaleEffect(passaNoBotao[index] ? 1.1 : 1.0)
												.multilineTextAlignment(.leading)
												.lineLimit(nil)
												.fixedSize(horizontal: false, vertical: true)
												.frame(maxWidth: .infinity, alignment: .leading)
												.padding(.top, 10)
										}
										.buttonStyle(PlainButtonStyle())
										//.background(passaNoBotao[index] ? Color("Selecionado") : Color("Fundo"))
										//.cornerRadius(10)
										.onHover { over in
											passaNoBotao[index] = over
										}
									}
								}
						}
					}
					.padding(30)
					.frame(maxHeight: 280, alignment: .top)
					.frame(width: 1120, alignment: .bottomLeading)
					.offset(x: 0, y: 270)
				
					.focusable()
					.focusEffectDisabled()
					.focused($estaFocado, equals: .enter)
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
						estaFocado = .enter
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
							//path.append("confessionario")
						}
					}
					.frame(maxWidth: .infinity, maxHeight: .infinity)
					.navigationBarBackButtonHidden()
			}
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
	
	func selecionaOpcao (index: Int) {
			contexto.desconfianca += dialogos[contexto.idDialogo].impacto_opcao_desc[index]
			contexto.popularidade += dialogos[contexto.idDialogo].impacto_opcao_pop[index]
			//let inicio = opcoes[index].index(texto.startIndex, offsetBy: 3)
			/*let opcaoAtual = opcoes[index][inicio...]*/
			proximaFala(index: index)
			terminou = true
			return
	}
	
	func proximaFala(index: Int = 0) {
		contexto.idDialogo = dialogos[contexto.idDialogo].id_que_opcao_leva[index]
		contexto.parteDialogo = 0
		reiniciarOpcoes()
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
				try? await Task.sleep(nanoseconds: 30_000_000)
			}
			try? await Task.sleep(nanoseconds: 30_000_000)
			for opcao in opc {
				opcoes[cont-1].append(String(cont))
				if Task.isCancelled {
					return
				}
				try? await Task.sleep(nanoseconds: 30_000_000)
				opcoes[cont-1].append(".")
				if Task.isCancelled {
					return
				}
				try? await Task.sleep(nanoseconds: 30_000_000)
				opcoes[cont-1].append(" ")
				if Task.isCancelled {
					return
				}
				try? await Task.sleep(nanoseconds: 30_000_000)
				for c in opcao {
					opcoes[cont-1].append(c)
					if Task.isCancelled {
						return
					}
					try? await Task.sleep(nanoseconds: 30_000_000)
				}
				cont += 1
			}
		}
	}
	
}

//#Preview {
//    FalaView()
//}
